From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Aug 2013 19:51:29 +0800
Subject: pinctrl-mxs fails to parse function definitions from different
 .dts files
In-Reply-To: <20130830092725.GG24802@pengutronix.de>
References: <20130830092725.GG24802@pengutronix.de>
Message-ID: <20130830115127.GP18729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Fri, Aug 30, 2013 at 11:27:25AM +0200, Uwe Kleine-K?nig wrote:
> while when I move the definition of i2c1 at 1 into imx28.dtsi after i2c1 at 0
> i2c1 probes just fine and also the pinmux-functions look right:
> 	
> 	# grep i2c1 /sys/kernel/debug/pinctrl/80018000.pinctrl/pinmux-functions
> 	function: i2c1, groups = [ i2c1.0 i2c1.1 ]
> 
> This is not intended, is it?

Sorry.  I should have documented it somewhere, but this is intended.
The driver requires all the pin groups for given function be sorted
together in 'reg'.

Shawn
