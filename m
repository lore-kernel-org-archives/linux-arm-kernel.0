From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Mon, 22 Oct 2018 11:51:14 +0000
Subject: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
In-Reply-To: <20181022135015.1b13cdbd@bbrezillon>
References: <1539255519-1408-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <VI1PR04MB1038034CFABEE936C6892D7D99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181022135015.1b13cdbd@bbrezillon>
Message-ID: <VI1PR04MB1038664FB0B2AF911593137099F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon at bootlin.com]
> Sent: Monday, October 22, 2018 5:20 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd at lists.infradead.org; marek.vasut at gmail.com; linux-
> spi at vger.kernel.org; devicetree at vger.kernel.org; Mark Brown
> <broonie@kernel.org>; robh at kernel.org; mark.rutland at arm.com;
> shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org;
> computersforpeace at gmail.com; frieder.schrempf at exceet.de; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI controller
> 
> On Mon, 22 Oct 2018 11:43:40 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
> > + Mark Brown
> >
> > Complete patch series[1]
> > [1]
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> > chwork.ozlabs.org%2Fproject%2Flinux-
> mtd%2Flist%2F%3Fseries%3D70210&amp
> > ;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C97207a816c9049d3d
> 49b08d
> >
> 638148f67%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636758058
> 298796
> >
> 837&amp;sdata=bRHDHAFzwrbeATicJUpv2WpFnxaeAD%2BnVHLAmsXKbKI%3D
> &amp;res
> > erved=0
> 
> Please resend the patch series with a "PATCH RESEND v4" prefix and explain why
> you resend it in the cover letter.
> 
Ok, sure.

Thanks

> >
> > --
> > Regards,
> > Yogesh Gaur
> >
> > > -----Original Message-----
> > > From: Yogesh Narayan Gaur [mailto:yogeshnarayan.gaur at nxp.com]
> > > Sent: Thursday, October 11, 2018 4:30 PM
> > > To: linux-mtd at lists.infradead.org; boris.brezillon at bootlin.com;
> > > marek.vasut at gmail.com; linux-spi at vger.kernel.org;
> > > devicetree at vger.kernel.org
> > > Cc: robh at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org;
> > > linux- arm-kernel at lists.infradead.org; computersforpeace at gmail.com;
> > > frieder.schrempf at exceet.de; linux-kernel at vger.kernel.org; Yogesh
> > > Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Subject: [PATCH v4 0/5] spi: spi-mem: Add driver for NXP FlexSPI
> > > controller
> > >
> > > - Add driver for NXP FlexSPI host controller
> > >
> > >  FlexSPI is a flexsible SPI host controller [1], Chapter 30 page
> > > 1475,  which supports two SPI channels and up to 4 external devices.
> > >  Each channel supports Single/Dual/Quad/Octal mode data transfer
> > > (1/2/4/8 bidirectional data lines)  i.e. FlexSPI acts as an
> > > interface to external devices, maximum 4, each with up to 8  bidirectional
> data lines.
> > >
> > > - Tested this driver with mtd_debug(Erase/Write/Read) utility and
> > > JFFS2 filesystem mounting and booting on NXP LX2160ARDB[2] and
> > > LX2160AQDS targets.
> > >  LX2160ARDB is having two NOR slave device connected on single bus A
> > > i.e. A0 and A1 (CS0 and CS1).
> > >  LX2160AQDS is having two NOR slave device connected on separate
> > > buses  one flash on A0 and second on B1 i.e. (CS0 and CS3).
> > >  Verified this driver on following SPI NOR flashes:
> > >    Micron, mt35xu512aba[3], [Read - 1 bit mode]
> > >    Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> > >
> > > [1]
> > > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fw
> > > ww.nxp.com%2Fdocs%2Fen%2Freference-
> manual%2FIMXRT1050RM.pdf&amp;data
> > >
> =02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C97207a816c9049d3d49b08
> d638
> > >
> 148f67%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636758058298
> 8068
> > >
> 45&amp;sdata=HpuTjqfMqDvobNPD5Ww3zIaotrBXFKgOIh2%2BQ%2BGSE1o%3
> D&amp;
> > > reserved=0 [2]
> > > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fp
> > > atchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Flist%2F%3Fseries%
> > >
> 3D26689&amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C97207a
> 816c
> > >
> 9049d3d49b08d638148f67%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C
> > >
> 636758058298806845&amp;sdata=v1d%2Fe91xeDzhAUvz8X5ousbEPwwgMFxY1
> CBkc
> > > Dpuf70%3D&amp;reserved=0 [3]
> > > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fp
> > > atchwork.ozlabs.org%2Fproject%2Flinux-mtd%2Flist%2F%3Fseries%3D70179
> > >
> &amp;data=02%7C01%7Cyogeshnarayan.gaur%40nxp.com%7C97207a816c904
> 9d3d
> > >
> 49b08d638148f67%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636
> 7580
> > >
> 58298806845&amp;sdata=vE%2FRQW9B4dU9rJqY2RZlNB1uH8smVKsCrGyEOs7
> 50Yk%
> > > 3D&amp;reserved=0
> > >
> > > Yogesh Gaur (5):
> > >   spi: spi-mem: Add driver for NXP FlexSPI controller
> > >   dt-bindings: spi: add binding file for NXP FlexSPI controller
> > >   arm64: dts: lx2160a: add FlexSPI node property
> > >   arm64: defconfig: enable NXP FlexSPI driver
> > >   MAINTAINERS: add maintainers for the NXP FlexSPI driver
> > >
> > > Changes for v4:
> > > - Incorporated review comments for
> > >   patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > > - Incorporated binding file review comments.
> > > Changes for v3:
> > > - Incorporated review comments for
> > >   patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > > Changes for v2:
> > > - Incorporated Boris review comments and drop below patches as per
> > > the comments.
> > >  - Patch 'spi: add slave device size in spi_device struct'
> > >  - Patch 'spi: add flags for octal I/O data transfer'
> > > - Incorporated DTS and Binding file review comments of Shawn Guo and
> > > Rob Herring.
> > >
> > >  .../devicetree/bindings/spi/spi-nxp-fspi.txt       |   39 +
> > >  MAINTAINERS                                        |    6 +
> > >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |   22 +
> > >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   12 +
> > >  arch/arm64/configs/defconfig                       |    1 +
> > >  drivers/spi/Kconfig                                |   10 +
> > >  drivers/spi/Makefile                               |    1 +
> > >  drivers/spi/spi-nxp-fspi.c                         | 1158 ++++++++++++++++++++
> > >  8 files changed, 1249 insertions(+)  create mode 100644
> > > Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
> > >  create mode 100644 drivers/spi/spi-nxp-fspi.c
> > >
> > > --
> > > 2.7.4
> >
