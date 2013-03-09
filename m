From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 09 Mar 2013 18:18:26 +0900
Subject: [PATCH v3 0/4] Initial Device Tree support for S3C64xx
In-Reply-To: <1361036261-8315-1-git-send-email-tomasz.figa@gmail.com>
References: <1361036261-8315-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <042b01ce1ca7$0e9ba2c0$2bd2e840$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> This series adds Device Tree support for Samsung S3C64xx SoC series.
> 
> It fixes several problems preventing from booting an S3C64xx-based system
> using Device Tree, adds all the infrastructure for Device Tree-based board
> support, including mach-s3c64xx-dt and dts include files for S3C64xx SoCs, and
> (very) basic device tree source for FriendlyARM Mini6410 board.
> 
> Current support is very limited and allows only basic bootup with UART and
> SDHCI, but should be fine as a start and will be extended in future, hopefully
> with help of S3C64xx board maintainers.
> 
> This series depends on my other series reworking samsung-time for
> multiplatform:
> [PATCH v2 00/12] ARM: samsung-time: Prepare for multiplatform support
> http://thread.gmane.org/gmane.linux.kernel.samsung-soc/16158
> 
Tomasz, can you address comments from ml for above patches? So that this could
be sent to upstream together :-)

- Kukjin

> Changes since v2:
>  - Updated timer node for next version of samsung-time patches
> 
> Changes since v1:
>  - Dropped two VIC-related patches that are no longer necessary
>  - Added Device Tree-based instantation of system timers
>  - Corrected VIC interrupt specifiers
>  - Adjusted CPU compatible values and dropped @id
> 
> Tomasz Figa (4):
>   ARM: common: vic: Parse interrupt and resume masks from device tree
>   ARM: s3c64xx: Add board file for boot using Device Tree
>   ARM: dts: Add basic dts include files for Samsung S3C64xx SoCs
>   ARM: dts: Add dts file for S3C6410-based Mini6410 board
> 
>  Documentation/devicetree/bindings/arm/vic.txt |   6 ++
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/s3c6400.dtsi                |  33 ++++++++
>  arch/arm/boot/dts/s3c6410-mini6410.dts        |  50 +++++++++++++
>  arch/arm/boot/dts/s3c6410.dtsi                |  33 ++++++++
>  arch/arm/boot/dts/s3c64xx.dtsi                | 104
++++++++++++++++++++++++++
>  arch/arm/common/vic.c                         |   7 +-
>  arch/arm/mach-s3c64xx/Kconfig                 |  14 ++++
>  arch/arm/mach-s3c64xx/Makefile                |   1 +
>  arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c       |  94 +++++++++++++++++++++++
>  10 files changed, 342 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/s3c6400.dtsi
>  create mode 100644 arch/arm/boot/dts/s3c6410-mini6410.dts
>  create mode 100644 arch/arm/boot/dts/s3c6410.dtsi
>  create mode 100644 arch/arm/boot/dts/s3c64xx.dtsi
>  create mode 100644 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
> 
> --
> 1.8.1.2
