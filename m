From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Dec 2013 16:01:35 +0800
Subject: [PATCH] ARM: dts: vf610: make pinctrl nodes board specific
In-Reply-To: <c605b6ebe1df4c79a9cbce61e9e0c96a@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1386571837-16299-1-git-send-email-shawn.guo@linaro.org>
 <c605b6ebe1df4c79a9cbce61e9e0c96a@BLUPR03MB373.namprd03.prod.outlook.com>
Message-ID: <20131209080133.GK825@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 07:10:34AM +0000, fugang.duan at freescale.com wrote:
> >@@ -36,12 +36,24 @@
> > &fec1 {
> > 	phy-mode = "rmii";
> > 	pinctrl-names = "default";
> >-	pinctrl-0 = <&pinctrl_fec1_1>;
> >+	pinctrl-0 = <&pinctrl_fec1>;
> > 	status = "okay";
> > };
> >
> >+&iomuxc {
> >+	vf610-cosmic {
> >+		pinctrl_fec1: fec1grp {
> >+			fsl,pins = <VF610_FEC1_PINGRP1>;
> >+		};
> >+
> >+		pinctrl_uart1: uart1grp {
> >+			fsl,pins = <VF610_UART1_PINGRP1>;
> >+		};
> >+	};
> >+};
> >+
> Keep things in alphabetical order...

Hmm, what is not in alphabetic order?

Shawn

> 
> > &uart1 {
> > 	pinctrl-names = "default";
> >-	pinctrl-0 = <&pinctrl_uart1_1>;
> >+	pinctrl-0 = <&pinctrl_uart1>;
> > 	status = "okay";
> > };
