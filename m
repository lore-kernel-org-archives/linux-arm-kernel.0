From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 25 Jan 2013 20:09:44 +0100
Subject: [PATCH 0/6] Initial Device Tree support for S3C64xx
In-Reply-To: <1358039458-31960-1-git-send-email-tomasz.figa@gmail.com>
References: <1358039458-31960-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1689405.9Ne2g34LZt@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 of January 2013 02:10:52 Tomasz Figa wrote:
> This series is adds Device Tree support for Samsung S3C64xx SoC series.
> 
> It fixes several problems preventing from booting an S3C64xx-based
> system using Device Tree, adds all the infrastructure for Device
> Tree-based board support, including mach-s3c64xx-dt and dts include
> files for S3C64xx SoCs, and (very) basic device tree source for
> FriendlyARM Mini6410 board.
> 
> Current support is very limited and allows only basic bootup with UART
> and SDHCI, but should be fine as a start and will be extended in
> future, hopefully with help of S3C64xx board maintainers.
> 
> Tomasz Figa (6):
>   ARM: common: vic: Parse interrupt and resume masks from device tree
>   ARM: common: vic: Fix invalid first IRQ number in OF-based
>     registration
>   ARM: s3c64xx: Add support for OF-based VIC initialization
>   ARM: s3c64xx: Add board file for boot using Device Tree
>   ARM: dts: Add basic dts include files for Samsung S3C64xx SoCs
>   ARM: dts: Add dts file for S3C6410-based Mini6410 board
> 
>  Documentation/devicetree/bindings/arm/vic.txt |  6 ++
>  arch/arm/boot/dts/Makefile                    |  1 +
>  arch/arm/boot/dts/s3c6400.dtsi                | 33 +++++++++
>  arch/arm/boot/dts/s3c6410-mini6410.dts        | 50 ++++++++++++++
>  arch/arm/boot/dts/s3c6410.dtsi                | 33 +++++++++
>  arch/arm/boot/dts/s3c64xx.dtsi                | 97
> +++++++++++++++++++++++++++ arch/arm/common/vic.c                      
>   |  9 ++-
>  arch/arm/mach-s3c64xx/Kconfig                 | 13 ++++
>  arch/arm/mach-s3c64xx/Makefile                |  1 +
>  arch/arm/mach-s3c64xx/common.c                | 16 +++++
>  arch/arm/mach-s3c64xx/common.h                |  4 ++
>  arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c       | 84
> +++++++++++++++++++++++ 12 files changed, 345 insertions(+), 2
> deletions(-)
>  create mode 100644 arch/arm/boot/dts/s3c6400.dtsi
>  create mode 100644 arch/arm/boot/dts/s3c6410-mini6410.dts
>  create mode 100644 arch/arm/boot/dts/s3c6410.dtsi
>  create mode 100644 arch/arm/boot/dts/s3c64xx.dtsi
>  create mode 100644 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c

Any other comments on this series?

Best regards,
Tomasz
