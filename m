From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 Feb 2015 17:41:34 +0100
Subject: [PATCH v3 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <20150216172753.5e92739a@free-electrons.com>
References: <1424091072-7738-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424091072-7738-2-git-send-email-maxime.ripard@free-electrons.com>
 <20150216172753.5e92739a@free-electrons.com>
Message-ID: <20150216164134.GE25269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 16, 2015 at 05:27:53PM +0100, Thomas Petazzoni wrote:
> Dear Maxime Ripard,
> 
> On Mon, 16 Feb 2015 13:51:11 +0100, Maxime Ripard wrote:
> 
> > +		while (index < (len * 4)) {
> > +			u32 timeout;
> > +
> > +			__raw_readsl(info->mmio_base + NDDB, data + index, 8);
> 
> Are you guaranteed that 'len' is a multiple of 32 bytes?

I don't know if you're guaranteed of anything, but the controller
supports only 512, 2k, 4k and 8k pages, which are all mutiples of 32
bytes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150216/0183dd62/attachment.sig>
