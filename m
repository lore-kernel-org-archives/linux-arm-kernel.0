From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Apr 2014 16:52:28 -0500
Subject: [PATCH V2 05/19] bus: omap_l3_noc: switch over to relaxed
 variants of readl/writel
In-Reply-To: <1397767775-10965-6-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
 <1397767775-10965-6-git-send-email-nm@ti.com>
Message-ID: <20140417215228.GD8504@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 17, 2014 at 03:49:21PM -0500, Nishanth Menon wrote:
> Currently we use __raw_readl and writel in this driver, however, there

__raw_* and *_relaxed variants are the same, just have a look <asm/io.h>

297 #define readb_relaxed(c) ({ u8  __r = __raw_readb(c); __r; })
298 #define readw_relaxed(c) ({ u16 __r = le16_to_cpu((__force __le16) \
299                                         __raw_readw(c)); __r; })
300 #define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
301                                         __raw_readl(c)); __r; })
302 
303 #define writeb_relaxed(v,c)     __raw_writeb(v,c)
304 #define writew_relaxed(v,c)     __raw_writew((__force u16) cpu_to_le16(v),c)
305 #define writel_relaxed(v,c)     __raw_writel((__force u32) cpu_to_le32(v),c)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140417/b242d210/attachment.sig>
