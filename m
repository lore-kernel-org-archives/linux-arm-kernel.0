From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 13 Dec 2009 21:05:09 +0100
Subject: [PATCH 4/4] regulator: mc13783 change to platform_driver_register.
In-Reply-To: <1260637577.2054.43.camel@climbing-alby>
References: <1260635829.2054.16.camel@climbing-alby>
	<1260636523.2054.28.camel@climbing-alby>
	<1260636819.2054.33.camel@climbing-alby>
	<1260636976.2054.36.camel@climbing-alby>
	<1260637577.2054.43.camel@climbing-alby>
Message-ID: <20091213200509.GD14024@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

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
I think the change is OK, the commit log isn't optimal though.

You might want to point out that the problem only occurs if the driver
is built-in and that mc13783_regulator_probe doesn't need to be changed
as it already lives in .devinit.text

As if mc13783-regulator is built-in mc13783-core is built-in, too, the
wording isn't good.  The problem is (I suppose) that regulators are
linked first and so mc13783-core isn't *probed* early enough and so the
mc13783-regulator device isn't available at mc13783-regulator probing
time.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
