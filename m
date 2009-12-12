From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 12 Dec 2009 18:23:56 +0000
Subject: [PATCH 4/4] regulator: mc13783 change to platform_driver_register.
In-Reply-To: <1260637577.2054.43.camel@climbing-alby>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
	<1260636819.2054.33.camel@climbing-alby>
	<1260636976.2054.36.camel@climbing-alby>
	<1260637577.2054.43.camel@climbing-alby>
Message-ID: <20091212182356.GE3092@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2009 at 06:06:17PM +0100, Alberto Panizzo wrote:
> Change the instant when regulator driver is probed. 
> To have a correct regulators initialisation (enable, disable and voltages 
> selection), the driver must have access to mc13783 registers and so 
> mc13783-core must be loaded before this.
> 
> With this patch mc13783_regulator_probe is called when mc13783-core
> register the regulator subsystem.
> 
> Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I think this one ought to go into 2.6.33 as a fix.
