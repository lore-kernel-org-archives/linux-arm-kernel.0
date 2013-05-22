From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 22 May 2013 18:47:10 +0200
Subject: imx53 cspi clock problem
In-Reply-To: <519C6B3D.3030106@microbit.se>
References: <519C6B3D.3030106@microbit.se>
Message-ID: <20130522164710.GE31135@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 08:52:45AM +0200, Jonas Andersson wrote:
> Hi,
> 
> i have found a problem when using the cspi port in a imx53 soc. I am
> using kernel 3.10-rc2. This is the dts defenition:
> 
> cspi: cspi at 63fc0000 {
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	compatible = "fsl,imx53-cspi", "fsl,imx35-cspi";
> 	reg = <0x63fc0000 0x4000>;
> 	interrupts = <38>;
> 	clocks = <&clks 55>, <&clks 0>;

Unlike the eCSPI controller the CSPI controller seems to have only one
clock. This should probably be

	clocks = <&clks 55>, <&clks 55>;

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
