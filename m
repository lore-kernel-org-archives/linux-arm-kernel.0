From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 9 Jan 2015 10:42:57 -0800
Subject: [PATCH v2 1/9] Input: sun4i-ts: Add thermal zone sensor support
In-Reply-To: <20150109183313.GA24190@developer>
References: <1420798676-22856-1-git-send-email-wens@csie.org>
 <1420798676-22856-2-git-send-email-wens@csie.org>
 <20150109172318.GA39037@dtor-ws> <20150109183313.GA24190@developer>
Message-ID: <20150109184257.GB39037@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 02:33:15PM -0400, Eduardo Valentin wrote:
> Dmitry,
> 
> On Fri, Jan 09, 2015 at 09:23:18AM -0800, Dmitry Torokhov wrote:
> > On Fri, Jan 09, 2015 at 06:17:48PM +0800, Chen-Yu Tsai wrote:
> > > The touchscreen controller has a temperature sensor embedded in the SoC,
> > > which already has hwmon support in the driver.
> > > 
> > > Add DT thermal zone support so we can use it with cpufreq for thermal
> > > throttling.
> > > 
> > > This also adds a comment stating that we do not know the actual formula
> > > for calculating the temperature.
> > > 
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> > 
> > 
> >   CC [M]  drivers/input/touchscreen/sun4i-ts.o
> > drivers/input/touchscreen/sun4i-ts.c:208:15: error: variable
> > ?sun4i_ts_tz_ops? has initializer but incomplete type
> >  static struct thermal_zone_of_device_ops sun4i_ts_tz_ops = {
> >                ^
> > drivers/input/touchscreen/sun4i-ts.c:209:2: error: unknown field
> > ?get_temp? specified in initializer
> >   .get_temp = get_temp,
> >   ^
> > drivers/input/touchscreen/sun4i-ts.c:209:2: warning: excess elements in
> > struct initializer [enabled by default]
> > drivers/input/touchscreen/sun4i-ts.c:209:2: warning: (near
> > initialization for ?sun4i_ts_tz_ops?) [enabled by default]
> > drivers/input/touchscreen/sun4i-ts.c: In function ?sun4i_ts_probe?:
> > drivers/input/touchscreen/sun4i-ts.c:331:8: warning: passing argument 4
> > of ?thermal_zone_of_sensor_register? from incompatible pointer type
> > [enabled by default]
> >         &sun4i_ts_tz_ops);
> >         ^
> > In file included from drivers/input/touchscreen/sun4i-ts.c:37:0:
> > include/linux/thermal.h:302:1: note: expected ?int (*)(void *, long int
> > *)? but argument is of type ?struct thermal_zone_of_device_ops *?
> >  thermal_zone_of_sensor_register(struct device *dev, int id,
> >  ^
> > drivers/input/touchscreen/sun4i-ts.c:331:8: error: too few arguments to
> > function ?thermal_zone_of_sensor_register?
> >         &sun4i_ts_tz_ops);
> >         ^
> > In file included from drivers/input/touchscreen/sun4i-ts.c:37:0:
> > include/linux/thermal.h:302:1: note: declared here
> >  thermal_zone_of_sensor_register(struct device *dev, int id,
> >  ^
> > make[1]: *** [drivers/input/touchscreen/sun4i-ts.o] Error 1
> > make: *** [drivers/input/touchscreen/sun4i-ts.o] Error 2
> > 
> 
> What kernel version are you using?
> 
> It looks like you are missing the of thermal ops commit.

Ah, OK, I have not uprevved my branches with 3.19 stuff yet.

-- 
Dmitry
