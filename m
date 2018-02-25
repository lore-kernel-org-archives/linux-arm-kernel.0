From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 25 Feb 2018 10:00:26 +0000
Subject: [PATCH v2 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <1519400704.8609.1.camel@pengutronix.de>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-3-l.stach@pengutronix.de>
 <20180223150352.GU3217@dragon> <1519400704.8609.1.camel@pengutronix.de>
Message-ID: <AM3PR04MB3060B34988452406147628480C20@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Lucas Stach [mailto:l.stach at pengutronix.de]
> Sent: Friday, February 23, 2018 11:45 PM
> To: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Catalin Marinas <catalin.marinas@arm.com>; Will
> Deacon <will.deacon@arm.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> dl-linux-imx <linux-imx@nxp.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; kernel at pengutronix.de; patchwork-
> lst at pengutronix.de; A.s. Dong <aisheng.dong@nxp.com>; Baruch Siach
> <baruch@tkos.co.il>
> Subject: Re: [PATCH v2 3/4] arm64: add support for i.MX8M EVK board
> 
> Am Freitag, den 23.02.2018, 23:03 +0800 schrieb Shawn Guo:
> > On Thu, Feb 01, 2018 at 07:31:25PM +0100, Lucas Stach wrote:
> > > +&usdhc1 {
> > > +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > > +	pinctrl-0 = <&pinctrl_usdhc1_cd_reset>,
> > > <&pinctrl_usdhc1_clk_strobe>,
> > > +	????????????<&pinctrl_usdhc1_data>;
> > > +	pinctrl-1 = <&pinctrl_usdhc1_cd_reset>,
> > > +	????????????<&pinctrl_usdhc1_clk_strobe_100mhz>,
> > > +	????????????<&pinctrl_usdhc1_data_100mhz>;
> > > +	pinctrl-2 = <&pinctrl_usdhc1_cd_reset>,
> > > +	????????????<&pinctrl_usdhc1_clk_strobe_200mhz>,
> > > +	????????????<&pinctrl_usdhc1_data_200mhz>;
> > > +	vqmmc-supply = <&sw4_reg>;
> > > +	bus-width = <8>;
> > > +	non-removable;
> > > +	no-sd;
> > > +	no-sdio;
> > > +	status = "okay";
> > > +};
> >
> > I'm not sure it can be enabled right now.??Per my testing, eMMC is not
> > working yet.
> >
> > [????0.879756] mmc0: Switching to 3.3V signalling voltage failed [
> > 0.913587] mmc0: SDHCI controller on 30b40000.usdhc [30b40000.usdhc]
> > using ADMA ...
> > [????1.007628] mmc0: switch to high-speed from hs200 failed, err:-110
> > [????1.013873] mmc0: error -110 whilst initialising MMC card [
> > 1.020639] mmc0: Switching to 3.3V signalling voltage failed ...
> > [????1.132462] mmc0: switch to high-speed from hs200 failed, err:-110
> > [????1.138674] mmc0: error -110 whilst initialising MMC card [
> > 1.145394] mmc0: Switching to 3.3V signalling voltage failed [
> > 1.268367] mmc0: switch to high-speed from hs200 failed, err:-110 [
> > 1.274576] mmc0: error -110 whilst initialising MMC card [????1.281291]
> > mmc0: Switching to 3.3V signalling voltage failed [????1.440708] mmc0:
> > switch to high-speed from hs200 failed, err:-110 [????1.446919] mmc0:
> > error -110 whilst initialising MMC card
> >
> > Or am I missing anything?
> 
> This is something I need to look into. The HS200 switching sequence seems to
> try to switch to 3.3V HS mode intermediately, which doesn't work. 

The switching to 3.3v seems to happen in mmc_power_up.
As mx8mq evk board eMMC is fixed to 1.8V, I guess this probably will not
cause any real issue rather than a WARNING.

> Despite
> the error messages eMMC works fine in my testing.

It's strange that It did not work at Shawn's and my side.

Regards
Dong Aisheng

> 
> Regards,
> Lucas
