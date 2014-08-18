From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:26:48 +0100
Subject: [PATCH v9] arm64: Add architectural support for PCIe
In-Reply-To: <1407860760-25252-2-git-send-email-Liviu.Dudau@arm.com>
References: <1407860760-25252-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860760-25252-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140818142648.GQ20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 05:26:00PM +0100, Liviu Dudau wrote:
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index e0ecdcf..dc34039 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -121,7 +121,8 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
>  /*
>   *  I/O port access primitives.
>   */
> -#define IO_SPACE_LIMIT		0xffff
> +#define arch_has_dev_port()	(1)
> +#define IO_SPACE_LIMIT		0x1ffffff

Minor thing, (SZ_32M - 1) may be easier in case we ever change this.

>  #define PCI_IOBASE		((void __iomem *)(MODULES_VADDR - SZ_32M))

-- 
Catalin
