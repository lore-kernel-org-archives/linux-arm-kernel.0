From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Jun 2013 23:17:06 +0900
Subject: [PATCH 0/7] Common Clock Framework support for Samsung S3C64xx
In-Reply-To: <1370476651-6743-1-git-send-email-tomasz.figa@gmail.com>
References: <1370476651-6743-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <51C1BD62.8050007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/13 08:57, Tomasz Figa wrote:
> This series is an attempt to move clock support on Samsung S3C64xx SoCs
> to Common Clock Framework.
>
Looks good :)

> First, support for PLL types present on S3C64xx SoCs is added to Samsung
> Common Clock Framework driver. Then the main clock driver for mentioned
> SoCs is introduced. Further patches contain fixes for drivers to make them
> compliant with CCF semantics, migration of platform code to use the new
> clock driver and removal of old clock management code.
>
> Depends on:
>   - [PATCH 0/6] Samsung watchdog support clean-up
>     http://thread.gmane.org/gmane.linux.kernel.samsung-soc/18736/focus=18989
>   - [PATCH 00/15] Final Samsung PWM support cleanup
>     http://www.spinics.net/lists/arm-kernel/msg248725.html

BTW, Tomasz, so how was going on above PWM patches?

>
> On S3C6410-based Tiny6410 board (Mini6410-compatible):
>
> Tested-by: Tomasz Figa<tomasz.figa@gmail.com>
>
> Tomasz Figa (7):
>    clk: samsung: pll: Add support for PLL6552 and PLL6553
>    clk: samsung: Add clock driver for S3C64xx SoCs
>    ARM: SAMSUNG: Add soc_is_s3c6400/s3c6410 macros
>    ARM: s3c64xx: dma: Use clk_prepare_enable/clk_disable_unprepare
>    usb: host: ohci-s3c2410 Use clk_prepare_enable/clk_disable_unprepare
>    ARM: s3c64xx: Migrate clock handling to Common Clock Framework
>    ARM: s3c64xx: Remove old clock management code
