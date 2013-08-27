From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 27 Aug 2013 23:17:38 +0200
Subject: [PATCH 3/5] drivers: thermal: make usage of CONFIG_THERMAL_HWMON
 optional
In-Reply-To: <521CEF61.6040504@ti.com>
References: <1377295396-17289-1-git-send-email-eduardo.valentin@ti.com>
 <4832825.8PCMQe7StP@vostro.rjw.lan> <521CEF61.6040504@ti.com>
Message-ID: <8131326.8QGX41MW6c@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 27, 2013 02:26:41 PM Eduardo Valentin wrote:
> On 23-08-2013 19:08, Rafael J. Wysocki wrote:
> > On Friday, August 23, 2013 06:03:14 PM Eduardo Valentin wrote:
> >> When registering a new thermal_device, the thermal framework
> >> will always add a hwmon sysfs interface.
> >>
> >> This patch adds a flag to make this behavior optional. Now
> >> when registering a new thermal device, the caller needs
> >> to say if the hwmon interface is required.
> >>
> >> In order to keep same behavior as of today, all current
> >> calls will by default create the hwmon interface.
> > 
> > Well, instead of modifying all of the callers this way, why don't
> > you add new versions taking the additional argument as, for example,
> > 
> > thermal_zone_device_register_full()
> > 
> > and redefine the old ones as static inline wrappers, for example
> > 
> > static inline struct thermal_zone_device *thermal_zone_device_register(args)
> > {
> > 	return thermal_zone_device_register_full(args, true);
> > }
> > 
> > ?
> 
> Yeah, that is another way to go and I thought of doing it like that. I
> just could not come out with a good API naming:
> 
> thermal_zone_device_register_full(all args)
> 
> thermal_zone_device_register(args) /* on hwmon == true */
> thermal_zone_device_register_no_hwmon(args) /* on hwmon == false */
> 
> Would this sound reasonable naming?

Yeah, sounds good to me.

Thanks,
Rafael
