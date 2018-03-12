From: ping.bai@nxp.com (Jacky Bai)
Date: Mon, 12 Mar 2018 04:43:07 +0000
Subject: [PATCH v4 1/2] ARM: dts: imx: Add basic dtsi file for imx6sll
In-Reply-To: <20180309233931.7xujvo4eg4g5ftri@rob-hp-laptop>
References: <1520503424-22985-1-git-send-email-ping.bai@nxp.com>
 <20180309233931.7xujvo4eg4g5ftri@rob-hp-laptop>
Message-ID: <HE1PR04MB3113DC090D0608077D396DCB87D30@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
> > +		spi3 = &ecspi3;
> > +		spi4 = &ecspi4;
> > +		usbphy0 = &usbphy1;
> > +		usbphy1 = &usbphy2;
> 
> Why do you need a alias for phys?

The alias of usbphy seems used by drivers/usb/phy/phy-mxs-usb.c. So we need to add alias for usbphy.

> 
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu0: cpu at 0 {
> > +			compatible = "arm,cortex-a9";
> > +			device_type = "cpu";
> > +			reg = <0>;
> > +			next-level-cache = <&L2>;
> > +			operating-points = <
> > +				/* kHz    uV */
> > +				996000  1225000
> > +				792000  1175000
> > +				396000  1075000
> > +				198000	975000
> > +			>;
> > +			fsl,soc-operating-points = <
> 
> This is not documented.

This is same as we used on other imx6 SOC. I don't know where to add doc for this property. Please give me some suggestion.

BR
Jacky Bai
> 
> > +				/* ARM kHz      SOC-PU uV */
> > +				996000          1225000
> > +				792000          1175000
> > +				396000          1175000
> > +				198000		1175000
> > +			>;
> > +			clock-latency = <61036>; /* two CLK32 periods */
> > +			fsl,low-power-run;
