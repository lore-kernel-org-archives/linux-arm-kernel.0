From: jonas@microbit.se (Jonas Andersson)
Date: Thu, 23 May 2013 10:08:59 +0200
Subject: imx53 cspi clock problem
In-Reply-To: <20130522164710.GE31135@pengutronix.de>
References: <519C6B3D.3030106@microbit.se>
 <20130522164710.GE31135@pengutronix.de>
Message-ID: <519DCE9B.2060909@microbit.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-05-22 18:47, Sascha Hauer wrote:
> On Wed, May 22, 2013 at 08:52:45AM +0200, Jonas Andersson wrote:
>> 	compatible = "fsl,imx53-cspi", "fsl,imx35-cspi";
>> 	reg = <0x63fc0000 0x4000>;
>> 	interrupts = <38>;
>> 	clocks = <&clks 55>, <&clks 0>;
> Unlike the eCSPI controller the CSPI controller seems to have only one
> clock. This should probably be
>
> 	clocks = <&clks 55>, <&clks 55>;
>
This works fine.

Is it the right solution to define both clocks to the same in all the 
imx*.dtsi files? imx25.dtsi defines only one clock "ipg" so 
spi_imx_probe() will probably fail.

Jonas
