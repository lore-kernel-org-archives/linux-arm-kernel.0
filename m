From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Tue, 6 May 2014 21:15:45 +0200
Subject: [PATCH v3 1/2] ARM: dts: imx51-eukrea-mbimxsd51-baseboard: Add
 CAN support
In-Reply-To: <1399384466.762807575@f343.i.mail.ru>
References: <1399380998-4277-1-git-send-email-fabio.estevam@freescale.com>
 <1399384466.762807575@f343.i.mail.ru>
Message-ID: <20140506211545.37b92848@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le Tue, 06 May 2014 17:54:26 +0400,
Alexander Shiyan <shc_work@mail.ru> a ?crit :

> Tue, 6 May 2014 09:56:37 -0300 ?? Fabio Estevam <fabio.estevam@freescale.com>:
> > +&ecspi1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ecspi1>;
> > +	fsl,spi-num-chipselects = <1>;
> > +	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
> > +	status = "okay";
> > +
> > +	can0: can at 0 {
> > +		compatible = "microchip,mcp2515";
> > +		reg = <0>;
> > +		clocks = <&clks IMX5_CLK_OSC>;
> 
> I would recommend using a separate fixed clock for this, if not actually OSC
> frequency is used. Eric?
> 
true, the MCP is using its own 24MHz crystal and not the i.MX51's one.

Eric
