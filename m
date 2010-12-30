From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Dec 2010 11:03:31 +0100
Subject: (arm-)global platform device registration functions
In-Reply-To: <20101229162512.GI14221@pengutronix.de>
References: <20101229162512.GI14221@pengutronix.de>
Message-ID: <201012301103.31085.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 December 2010 17:25:12 Uwe Kleine-K?nig wrote:
> some time ago I started to dynamically allocate platform_devices for
> arm/plat-mxc.  For that purpose I added many functions, see
> arch/arm/plat-mxc/include/mach/devices-common.h [1].  Now arm/arch-mxs
> want to do the same, so I wonder if it would be sensible to do something
> like this more globally (either for arm or better kernel global).

Adding platform devices dynamically is definitely the right way forward
for new platforms, as Greg explained recently. The imx_add_platform_device()
function you have defined looks useful for this, and I guess it could
be added globally, next to the existing platform_device_register_resndata,
platform_device_register_data and platform_device_register_simple functions
that we already have doing similar things.

I'm not convinced that the various wrappers you have on imx are the
best solution, though I have not come up with anything better either ;-)

This will also get a lot easier once we have the ability to define
devices in using dtc, because that takes care of the resources.

	Arnd
