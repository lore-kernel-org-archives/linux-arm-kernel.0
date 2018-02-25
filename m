From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 25 Feb 2018 10:17:53 +0000
Subject: [PATCH v2 1/4] arm64: add basic Kconfig symbols for i.MX8
In-Reply-To: <20180223145625.GT3217@dragon>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180223145625.GT3217@dragon>
Message-ID: <AM3PR04MB306E3ADB5A7C0DE0C470C3980C20@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Friday, February 23, 2018 10:56 PM
> To: Lucas Stach <l.stach@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Catalin Marinas <catalin.marinas@arm.com>; Will
> Deacon <will.deacon@arm.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> dl-linux-imx <linux-imx@nxp.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; kernel at pengutronix.de; patchwork-
> lst at pengutronix.de; A.s. Dong <aisheng.dong@nxp.com>; Baruch Siach
> <baruch@tkos.co.il>
> Subject: Re: [PATCH v2 1/4] arm64: add basic Kconfig symbols for i.MX8
> 
> On Thu, Feb 01, 2018 at 07:31:23PM +0100, Lucas Stach wrote:
> > Add basic Kconfig symbols to make the MXC architecture available in
> > the ARM64 world.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> > ---
> > v2: fix "enabled" typo.
> > ---
> >  arch/arm64/Kconfig.platforms |  6 ++++++
> >  drivers/soc/imx/Kconfig      | 12 ++++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig.platforms
> > b/arch/arm64/Kconfig.platforms index 2401373565ff..ae3be0d2cdb5
> 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -131,6 +131,12 @@ config ARCH_MVEBU
> >  	   - Armada 7K SoC Family
> >  	   - Armada 8K SoC Family
> >
> > +config ARCH_MXC
> > +	bool "ARMv8 based NXP i.MX SoC family"
> > +	help
> > +	  This enables support for the ARMv8 based SoCs in the
> > +	  NXP i.MX family.

We select nothing here?

> > +
> >  config ARCH_QCOM
> >  	bool "Qualcomm Platforms"
> >  	select GPIOLIB
> > diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig index
> > a5b86a28f343..8c9f04440896 100644
> > --- a/drivers/soc/imx/Kconfig
> > +++ b/drivers/soc/imx/Kconfig
> > @@ -8,3 +8,15 @@ config IMX7_PM_DOMAINS
> >  	default y if SOC_IMX7D
> >
> >  endmenu
> > +
> > +if ARCH_MXC
> > +
> > +if ARM64
> > +
> > +config SOC_IMX8MQ
> > +	bool "i.MX8MQ support"
> > +	help
> > +	  This enables support for the i.MX8MQ SoC.
> > +endif
> > +
> > +endif
> 
> I do not feel it's so idiomatic to select a platform SoC in drivers/soc folder.
> The options in this folder are used to select SoC level drivers not the SoC
> itself.  Can we just use ARCH_MXC for all IMX ARMv8 SoCs?
> Or if we really want individual SoC option, can we do something similar to
> Renesas platform, having sub-select under "ARMv8 based NXP i.MX SoC
> family"?
> 

+1
It looks a bit weird to enable a SoC under drivers/soc.
Currently we still can't see a requirement to support individual SoC option,
So probably, just like other SoC Vendor does, use ARCH_MXC for all IMX V8
SoCs.

Regards
Dong Aisheng

> Shawn
