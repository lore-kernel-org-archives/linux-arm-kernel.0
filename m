From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Nov 2014 13:57:31 +0100
Subject: [PATCH v3 4/5] arm64: Add support for Spreadtrum's Sharkl64
 Platform in Kconfig and defconfig
In-Reply-To: <1416917818-10506-5-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1416917818-10506-5-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <3490516.nCDXzA8J8x@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 November 2014 20:16:57 Chunyan Zhang wrote:
> 
> +menuconfig ARCH_SPRD
> +       bool "Spreadtrum SoC platform"
> +       depends on ARM64
> +       help
> +         Support for Spreadtrum ARM based SoCs
> +
> +if ARCH_SPRD
> +
> +config ARCH_SHARKL64
> +       bool "Sharkl64 SoC Platform"
> +       help
> +         Sharkl64 is a Spreadtrum's SoC Platform which is based
> +         on ARM 64-bit processor core including
> +           sc9836
> +
> +endif #ARCH_SPRD
> +

I don't think we need multiple levels here, it should be enough to
have either ARCH_SPRD or ARCH_SHARKL64, because all device drivers
are going to be optional anyway. Typically a Kconfig symbol covers
all SoCs that are related, so if you Spreadtrum are doing both
phone and server chips and these are designed independently, you
would have two symbols, but if you only expect to see phone chips
here that are all derived from the same product line, using ARCH_SPRD
to refer to all of them should be enough.

	Arnd
