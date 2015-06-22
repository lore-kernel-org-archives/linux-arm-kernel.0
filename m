From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 22 Jun 2015 08:38:32 +0200
Subject: [PATCH v4] Thermal cleanups and hardware trip points
In-Reply-To: <20150608065657.GL26575@pengutronix.de>
References: <1432128046-12921-1-git-send-email-s.hauer@pengutronix.de>
 <20150608065657.GL26575@pengutronix.de>
Message-ID: <20150622063832.GS26575@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eduardo, Rui,

Is there anything I can do to get this series forward? Should I split it
up more into separate topics? Is there anything that I should drop from
this series to get at least the rest mainline?

Sascha

On Mon, Jun 08, 2015 at 08:56:57AM +0200, Sascha Hauer wrote:
> Eduardo, Rui,
> 
> Any feedback to this series?
> 
> Thanks
>   Sascha
> 
> On Wed, May 20, 2015 at 03:20:30PM +0200, Sascha Hauer wrote:
> > This series adds support for hardware trip points. It picks up earlier
> > work from Mikko Perttunen. Mikko implemented hardware trip points as part
> > of the device tree support. It was suggested back then to move the
> > functionality to the thermal core instead of putting more code into the
> > device tree support. This series does exactly that.
> > 
> > The majority of the patches are cleanups and fixes. Patch 11 introduces
> > hardware tracked trip points and finally a driver for the Mediatek
> > thermal controller is introduced as the first user.
> > 
> > All comments welcome
> > 
> > Changes since v3:
> > - Fix some missing function type changes in int3400_thermal.c,
> >   processor_thermal_device.c, kirkwood_thermal.c and exynos_tmu.c
> > - Add better description for set_trips callback
> > - update the interrupt triggers also when the trip points change
> > - Add missing MODULE_* tags
> > - Broaden temperature range in the Mediatek driver so that we can be sure
> >   the measured temperatures are really out of the desired range
> > 
> > Changes since v2:
> > - Add Mediatek thermal controller driver as first user for hardware trip
> >   points
> > 
> > Changes since v1:
> > - Use int instead of unsigned long consistently for temperatures
> > - Instead of misfixing the emulation code add a comment how the
> >   code is meant
> > - Add doc entry for .set_trips callback
> > - initialize prev_low_trip/prev_high_trip properly
> > - get tz->lock before calling thermal_zone_set_trips()
> > 
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
