From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Mon, 22 Oct 2018 11:43:40 +0000
Subject: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
In-Reply-To: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <VI1PR04MB1038034CFABEE936C6892D7D99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Mark Brown

Complete patch series[1]
[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70210

--
Regards,
Yogesh Gaur

> -----Original Message-----
> From: Yogesh Narayan Gaur [mailto:yogeshnarayan.gaur at nxp.com]
> Sent: Thursday, October 11, 2018 4:30 PM
> To: linux-mtd at lists.infradead.org; boris.brezillon at bootlin.com;
> marek.vasut at gmail.com; linux-spi at vger.kernel.org;
> devicetree at vger.kernel.org
> Cc: robh at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org; linux-
> arm-kernel at lists.infradead.org; computersforpeace at gmail.com;
> frieder.schrempf at exceet.de; linux-kernel at vger.kernel.org; Yogesh Narayan
> Gaur <yogeshnarayan.gaur@nxp.com>
> Subject: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
> 
> - Add driver for NXP FlexSPI host controller
> 
>  FlexSPI is a flexsible SPI host controller [1], Chapter 30 page 1475,  which
> supports two SPI channels and up to 4 external devices.
>  Each channel supports Single/Dual/Quad/Octal mode data transfer (1/2/4/8
> bidirectional data lines)  i.e. FlexSPI acts as an interface to external devices,
> maximum 4, each with up to 8  bidirectional data lines.
> 
> - Tested this driver with mtd_debug(Erase/Write/Read) utility and JFFS2
> filesystem mounting and booting on NXP LX2160ARDB[2] and LX2160AQDS
> targets.
>  LX2160ARDB is having two NOR slave device connected on single bus A  i.e. A0
> and A1 (CS0 and CS1).
>  LX2160AQDS is having two NOR slave device connected on separate buses  one
> flash on A0 and second on B1 i.e. (CS0 and CS3).
>  Verified this driver on following SPI NOR flashes:
>    Micron, mt35xu512aba[3], [Read - 1 bit mode]
>    Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> 
> [1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
> [2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=26689
> [3] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=70179
> 
> Yogesh Gaur (5):
>   spi: spi-mem: Add driver for NXP FlexSPI controller
>   dt-bindings: spi: add binding file for NXP FlexSPI controller
>   arm64: dts: lx2160a: add FlexSPI node property
>   arm64: defconfig: enable NXP FlexSPI driver
>   MAINTAINERS: add maintainers for the NXP FlexSPI driver
> 
> Changes for v4:
> - Incorporated review comments for
>   patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> - Incorporated binding file review comments.
> Changes for v3:
> - Incorporated review comments for
>   patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> Changes for v2:
> - Incorporated Boris review comments and drop below patches as per the
> comments.
>  - Patch 'spi: add slave device size in spi_device struct'
>  - Patch 'spi: add flags for octal I/O data transfer'
> - Incorporated DTS and Binding file review comments of Shawn Guo and Rob
> Herring.
> 
>  .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   39 +
>  MAINTAINERS                                        |    6 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   22 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   12 +
>  arch/arm64/configs/defconfig                       |    1 +
>  drivers/spi/Kconfig                                |   10 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/spi-nxp-fspi.c                         | 1158 ++++++++++++++++++++
>  8 files changed, 1249 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
>  create mode 100644 drivers/spi/spi-nxp-fspi.c
> 
> --
> 2.7.4
