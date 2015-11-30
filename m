From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 30 Nov 2015 11:16:59 +0100
Subject: [PATCH 1/2] ARM: dts: imx6: Add support for Toradex Apalis SoM
In-Reply-To: <ecfde8366160cb17f7b1e571f81488de@agner.ch>
References: <1447935900-13635-1-git-send-email-ynezz@true.cz>
 <1447935900-13635-2-git-send-email-ynezz@true.cz>
 <1447942325.3144.86.camel@pengutronix.de>
 <ecfde8366160cb17f7b1e571f81488de@agner.ch>
Message-ID: <1448878619.8275.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 27.11.2015, 11:38 -0800 schrieb Stefan Agner:
> Hi Petr,
> 
> Thanks for pushing this! It is on my todo list, but never came around...
> [I do work for Toradex]
> 
> And thanks Lucas for reviewing it!
> 
> 
> On 2015-11-19 06:12, Lucas Stach wrote:
> > Hi Petr,
> > 
> > Am Donnerstag, den 19.11.2015, 13:24 +0100 schrieb Petr ?tetiar:
> >> Signed-off-by: Petr ?tetiar <ynezz@true.cz>
> >> ---
[...]
> >> +&uart1 {
> >> +	pinctrl-names = "default";
> >> +#ifndef USE_UART_IN_DCE_MODE
> >> +	pinctrl-0 = <&pinctrl_uart1_dte &pinctrl_uart1_ctrl>;
> >> +	fsl,dte-mode;
> >> +	fsl,uart-has-rtscts;
> >> +#else
> >> +	pinctrl-0 = <&pinctrl_uart1_dce>;
> >> +#endif
> >> +	status = "disabled";
> >> +};
> >> +
> >> +&uart2 {
> >> +	pinctrl-names = "default";
> >> +#ifndef USE_UART_IN_DCE_MODE
> >> +	pinctrl-0 = <&pinctrl_uart2_dte>;
> >> +	fsl,dte-mode;
> >> +	fsl,uart-has-rtscts;
> >> +#else
> >> +	pinctrl-0 = <&pinctrl_uart2_dce>;
> >> +#endif
> >> +	status = "disabled";
> >> +};
> >> +
> >> +&uart4 {
> >> +	pinctrl-names = "default";
> >> +#ifndef USE_UART_IN_DCE_MODE
> >> +	pinctrl-0 = <&pinctrl_uart4_dte>;
> >> +	fsl,dte-mode;
> >> +#else
> >> +	pinctrl-0 = <&pinctrl_uart4_dce>;
> >> +#endif
> >> +	status = "disabled";
> >> +};
> >> +
> >> +&uart5 {
> >> +	pinctrl-names = "default";
> >> +#ifndef USE_UART_IN_DCE_MODE
> >> +	pinctrl-0 = <&pinctrl_uart5_dte>;
> >> +	fsl,dte-mode;
> >> +#else
> >> +	pinctrl-0 = <&pinctrl_uart5_dce>;
> >> +#endif
> >> +	status = "disabled";
> >> +};
> > 
> > Urgh, those ifdefs are really ugly, but probably nothing you can do
> > about that. Maybe you can just override the pinctrl from the top level
> > DT...
> > 
> > Were v1.0 modules sold to customers? If not the value of having those
> > supported by mainline is really limited.
> 
> Some have been made it to customers as early samples, however not that
> many.
> 
> I am inclined to say lets not support them. They anyway lead to
> headaches since you need to use a different U-Boot binary too...
> 
> Petr, do you happen to have one of them?
> 
> Otherwise I like the approach by overriding the pinctrl property in a 
> arch/arm/boot/dts/imx6qdl-apalis_v1_0.dtsi...
> 
> Can we set fsl,dte-mode to false?

You can remove those bool properties by using /delete-property/ in the
overriding DT.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
