From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Tue, 25 Apr 2017 09:01:28 +0000
Subject: [PATCH 0/3] Add eSDHC UHS-I/HS200 mode support for
 ls1012a/ls1046a/ls208xa
In-Reply-To: <CAPDyKFp_TWSj7FH6KagU4gz+A9CR-thwU9b1WaSEgupZMBAyaQ@mail.gmail.com>
References: <1492746756-12024-1-git-send-email-yangbo.lu@nxp.com>
 <CAPDyKFp_TWSj7FH6KagU4gz+A9CR-thwU9b1WaSEgupZMBAyaQ@mail.gmail.com>
Message-ID: <DB6PR0401MB253641C6AB25737F9F57EE8DF81E0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson at linaro.org]
> Sent: Tuesday, April 25, 2017 4:17 AM
> To: Y.B. Lu
> Cc: linux-arm-kernel at lists.infradead.org; Shawn Guo; Catalin Marinas;
> Xiaobo Xie
> Subject: Re: [PATCH 0/3] Add eSDHC UHS-I/HS200 mode support for
> ls1012a/ls1046a/ls208xa
> 
> On 21 April 2017 at 05:52, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> > This patch is to add eSDHC UHS-I/HS200 mode support for
> ls1012a/ls1046a/ls208xa.
> > Because eSDHC is not a standard SD controller, the specific speed mode
> > support depends on board's peripheral circuit for eSDHC. So, we have
> > to add these speed modes support on board dts file.
> >
> > In additon, these dts patches depends on esdhc driver patches which
> > just had been merged on mmc.git. Otherwise, the UHS-I SD card and eMMC
> > HS200 card would fail to be initialized, but other cards still could
> work fine.
> > https://patchwork.kernel.org/patch/9689875/
> > https://patchwork.kernel.org/patch/9689877/
> > https://patchwork.kernel.org/patch/9689879/
> > https://patchwork.kernel.org/patch/9689887/
> > https://patchwork.kernel.org/patch/9689885/
> >
> > Yangbo Lu (3):
> >   arm64: dts: ls1046a: support SD UHS-I and eMMC HS200 on RDB
> >   arm64: dts: ls208xa: support SD UHS-I on RDB and eMMC HS200 on QDS
> >   arm64: dts: ls1012a: add eSDHC nodes
> >
> >  arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |  8 +++++++
> > arch/arm64/boot/dts/freescale/fsl-ls1012a-rdb.dts  | 13 +++++++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     | 25
> ++++++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  |  8 +++++++
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  4 ++--
> >  arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi |  1 +
> > arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi |  4 ++++
> >  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  2 +-
> >  8 files changed, 62 insertions(+), 3 deletions(-)
> >
> > --
> > 2.1.0.27.g96db324
> >
> 
> By curiosity I tried applying these to my mmc tree, but they don't apply.
> So I can pick them, even with acks.
> Also it's too difficult for me to host an immutable branch with the
> relevant sdhci-esdc changes, because of additional sdhci dependencies.
> 
> Perhaps just easier to pick this for 4.13 or 4.12 rc2.

[Lu Yangbo-B47093] Hi Uffe, I agree.
These patches are based on Shawn's tree which has the latest layerscape board dts.
Actually I'm not sure which git tree I should send these patches to according to MAINTAINERS, but I saw Shawn had merged some layerscape board dts before.

Hi Shawn,
Am I right to send these patches to you for reviewing? Which git tree do you recommend I should send these patches to?

Thanks.

> 
> Kind regards
> Uffe
