From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 15 Oct 2012 08:03:02 +0200
Subject: [PATCH 5/5] ARM: AT91: Add AT91RM9200 device tree
In-Reply-To: <1350251199-28065-6-git-send-email-manabian@gmail.com>
References: <1350251199-28065-1-git-send-email-manabian@gmail.com>
 <1350251199-28065-6-git-send-email-manabian@gmail.com>
Message-ID: <20121015060302.GT12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 +
> +			pinctrl at fffff400 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
> +				ranges = <0xfffff400 0xfffff400 0x800>;
> +
> +				atmel,mux-mask = <
> +					/*    A         B     */
> +					 0xffffffff 0xffffffff  /* pioA */
> +					 0xffffffff 0x083fffff  /* pioB */
> +					 0xffff3fff 0x00000000  /* pioC */
> +					 0x03ff87ff 0x0fffff80  /* pioD */
> +					>;
> +
> +				/* shared pinctrl settings */
> +				dbgu {
> +					pinctrl_dbgu: dbgu-0 {
> +						atmel,pins =
> +							<0 30 0x1 0x0	/* PA30 periph A */
> +							 0 31 0x1 0x1>;	/* PA31 periph with pullup */
> +					};
> +				};
> +
> +				uart0 {
> +					pinctrl_uart0: uart0-0 {
> +						atmel,pins =
> +							<0 17 0x1 0x0	/* PA17 periph A */
> +							 0 18 0x1 0x0>;	/* PA18 periph A */
> +					};
> +
> +					pinctrl_uart0_rts_cts: uart0_rts_cts-0 {
> +						atmel,pins =
> +							<0 20 0x1 0x0	/* PA20 periph A */
> +							 0 21 0x1 0x0>;	/* PA21 periph A */
> +					};
> +				};
> +
> +				uart1 {
> +					pinctrl_uart1: uart1-0 {
> +						atmel,pins =
> +							<1 20 0x1 0x1	/* PB20 periph A with pullup */
> +							 1 21 0x1 0x0>;	/* PB21 periph A */
> +					};
> +
> +					pinctrl_uart1_rts_cts: uart1_rts_cts-0 {
> +						atmel,pins =
> +							<1 24 0x1 0x0	/* PB24 periph A */
> +							 1 26 0x1 0x0>;	/* PB26 periph A */
> +					};
> +
> +					pinctrl_uart1_dtr_dsr: uart1_dtr_dsr-0 {
> +						atmel,pins =
> +							<1 19 0x1 0x0	/* PB19 periph A */
> +							 1 25 0x1 0x0>;	/* PB25 periph A */
> +					};
> +
> +					pinctrl_uart1_dcd: uart1_dcd-0 {
> +						atmel,pins =
> +							<1 23 0x1 0x0>;	/* PB23 periph A */
> +					};
> +
> +					pinctrl_uart1_ri: uart1_ri-0 {
> +						atmel,pins =
> +							<1 18 0x1 0x0>;	/* PB18 periph A */
> +					};
> +				};
> +
> +				uart2 {
> +					pinctrl_uart2: uart2-0 {
> +						atmel,pins =
> +							<0 22 0x1 0x0	/* PA22 periph A */
> +							 0 23 0x1 0x1>;	/* PA23 periph A with pullup */
> +					};
> +
> +					pinctrl_uart2_rts_cts: uart2_rts_cts-0 {
> +						atmel,pins =
> +							<0 30 0x2 0x0	/* PA30 periph B */
> +							 0 31 0x2 0x0>;	/* PA31 periph B */
> +					};
> +				};
> +
> +				uart3 {
> +					pinctrl_uart3: uart3-0 {
> +						atmel,pins =
> +							<0 5 0x2 0x1	/* PA5 periph B with pullup */
> +							 0 6 0x2 0x0>;	/* PA6 periph B */
> +					};
> +
> +					pinctrl_uart3_rts_cts: uart3_rts_cts-0 {
> +						atmel,pins =
> +							<1 0 0x2 0x0	/* PB0 periph B */
> +							 1 1 0x2 0x0>;	/* PB1 periph B */
> +					};
> +				};
> +
> +				nand {
> +					pinctrl_nand: nand-0 {
> +						atmel,pins =
> +							<2 2 0x0 0x1	/* PC2 gpio RDY pin pull_up */
> +							 1 1 0x0 0x1>;	/* PB1 gpio CD pin pull_up */
> +					};
I do not yet check the pin I'll do it later

but look ok

please a board so we can test it the rm9200ek at least

Best Regards,
J.
