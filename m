From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 23 Feb 2018 16:46:09 +0100
Subject: [PATCH v2 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <201802231630.45460.jbe@pengutronix.de>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-3-l.stach@pengutronix.de>
 <20180223150352.GU3217@dragon> <201802231630.45460.jbe@pengutronix.de>
Message-ID: <1519400769.8609.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 23.02.2018, 16:30 +0100 schrieb Juergen Borleis:
> On Friday 23 February 2018 16:03:53 Shawn Guo wrote:
> > On Thu, Feb 01, 2018 at 07:31:25PM +0100, Lucas Stach wrote:
> > > +&usdhc1 {
> > > +???pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > > +???pinctrl-0 = <&pinctrl_usdhc1_cd_reset>,
> <&pinctrl_usdhc1_clk_strobe>,
> > > +?????????????? <&pinctrl_usdhc1_data>;
> > > +???pinctrl-1 = <&pinctrl_usdhc1_cd_reset>,
> > > +?????????????? <&pinctrl_usdhc1_clk_strobe_100mhz>,
> > > +?????????????? <&pinctrl_usdhc1_data_100mhz>;
> > > +???pinctrl-2 = <&pinctrl_usdhc1_cd_reset>,
> > > +?????????????? <&pinctrl_usdhc1_clk_strobe_200mhz>,
> > > +?????????????? <&pinctrl_usdhc1_data_200mhz>;
> > > +???vqmmc-supply = <&sw4_reg>;
> > > +???bus-width = <8>;
> > > +???non-removable;
> > > +???no-sd;
> > > +???no-sdio;
> > > +???status = "okay";
> > > +};
> >
> > I'm not sure it can be enabled right now.? Per my testing, eMMC is
> not
> > working yet.
> >
> > [??? 0.879756] mmc0: Switching to 3.3V signalling voltage failed
> > [??? 0.913587] mmc0: SDHCI controller on 30b40000.usdhc
> [30b40000.usdhc]
> > using ADMA ...
> > [??? 1.007628] mmc0: switch to high-speed from hs200 failed, err:-
> 110
> > [??? 1.013873] mmc0: error -110 whilst initialising MMC card
> > [??? 1.020639] mmc0: Switching to 3.3V signalling voltage failed
> > ...
> > [??? 1.132462] mmc0: switch to high-speed from hs200 failed, err:-
> 110
> > [??? 1.138674] mmc0: error -110 whilst initialising MMC card
> > [??? 1.145394] mmc0: Switching to 3.3V signalling voltage failed
> > [??? 1.268367] mmc0: switch to high-speed from hs200 failed, err:-
> 110
> > [??? 1.274576] mmc0: error -110 whilst initialising MMC card
> > [??? 1.281291] mmc0: Switching to 3.3V signalling voltage failed
> > [??? 1.440708] mmc0: switch to high-speed from hs200 failed, err:-
> 110
> > [??? 1.446919] mmc0: error -110 whilst initialising MMC card
> >
> > Or am I missing anything?
> 
> Property "no-1-8-v;" if no 1.8 V is available?

The issue is the other way around: the eMMC is hardwired to 1.8V IO
voltage (which is fine per eMMC spec), so it can't switch to 3.3V mode.

Regards,
Lucas
