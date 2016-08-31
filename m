From: yao.yuan@nxp.com (Yao Yuan)
Date: Wed, 31 Aug 2016 04:17:34 +0000
Subject: [PATCH v1 4/5] ARM: dts: ls1043a: add qDMA node
In-Reply-To: <3583547.0zriK9IoAs@ws-stein>
References: <1471502328-28305-1-git-send-email-yao.yuan@freescale.com>
 <1471502328-28305-5-git-send-email-yao.yuan@freescale.com>
 <3583547.0zriK9IoAs@ws-stein>
Message-ID: <DB6PR0401MB24074D504D53B4D64CD4723989E30@DB6PR0401MB2407.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 29 August 2016 03:34:47, : Alexander Stein  wrote:
> On Thursday 18 August 2016 14:38:47, Yuan Yao wrote:
> > From: Yuan Yao <yao.yuan@nxp.com>
> >
> > Add the QDMA node for ls1043a platform to support QDMA driver.
> >
> > Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi index
> > e8e4c3e..e463074
> > 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > @@ -467,6 +467,16 @@
> >  				 <&clockgen 4 0>;
> >  		};
> >
> > +		qdma: qdma at 8390000 {
> > +			compatible = "fsl,ls1021a-qdma", "fsl,ls1043a-qdma";
> 
> This doesn't match the order of your binding in Patch 2/5:
> > +- compatible :
> > +       - "fsl,ls1021a-qdma",
> > +       Or "fsl,ls1043a-qdma" followed by "fsl,ls1021a-qdma",
> 
> It should be the other way around.

Thanks for your review.
It should be compatible = "fsl,ls1043a-qspi", "fsl,ls1021a-qspi";
 I will update it in the next version.
Thanks.
