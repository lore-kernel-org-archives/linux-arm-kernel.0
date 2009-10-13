From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Oct 2009 10:54:17 +0100
Subject: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare
	I2C clock source
In-Reply-To: <4AD3EB09.8050304@necel.com>
References: <4AD3E974.8080200@necel.com> <4AD3EB09.8050304@necel.com>
Message-ID: <20091013095417.GB1230@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 11:50:49AM +0900, Shinya Kuribayashi wrote:
> This driver is originally prepared for the ARM kernel where rich and
> well-maintained "clkdev" clock framework is available, and clock name
> might not be strictly required.  ARM's clkdev does slightly fuzzy
> matching where it basically gives preference to "struct device" mathing
> over "clock id".  As long as used for ARM machines, there's no problem.

> However, all users of this driver necessarily don't have the same clk
> framework with ARM's, as the clk I/F implementation varies depending on
> ARCHs and machines.

> This patch adds a clock name so that other users with simple/minimum/
> limited clk support could make use of the driver.

This seems like something that it'd be better to fix in the relevant
clock frameworks in order to try to keep the API consistently usable
between platforms.  The clkdev matching library that most of the ARM
platforms use should be generic enough to be usable elsewhere, there
is regular discussion of moving it somewhere more generic.
