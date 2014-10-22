From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Oct 2014 17:11:55 +0100
Subject: [PATCH] ARM: supplementing IO accessors with 64 bit capability
In-Reply-To: <1413993983-17310-1-git-send-email-mathieu.poirier@linaro.org>
References: <1413993983-17310-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20141022161155.GB27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 10:06:23AM -0600, mathieu.poirier at linaro.org wrote:
> @@ -306,10 +324,13 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>  					__raw_readw(c)); __r; })
>  #define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
>  					__raw_readl(c)); __r; })
> +#define readq_relaxed(c) ({ u64 __r = le64_to_cpu((__force __le64) \
> +					__raw_readq(c)); __r; })
>  
>  #define writeb_relaxed(v,c)	__raw_writeb(v,c)
>  #define writew_relaxed(v,c)	__raw_writew((__force u16) cpu_to_le16(v),c)
>  #define writel_relaxed(v,c)	__raw_writel((__force u32) cpu_to_le32(v),c)
> +#define writeq_relaxed(v,c)	__raw_writeq((__force u64) cpu_to_le64(v),c)

You should only define these if we have the corresponding __raw_ versions
too.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
