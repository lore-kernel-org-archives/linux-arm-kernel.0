From: l.majewski@samsung.com (Lukasz Majewski)
Date: Fri, 07 Nov 2014 10:15:50 +0100
Subject: [PATCH 02/21] thermal: of: Extend of-thermal.c to provide check if
 trip point is enabled
In-Reply-To: <20141107013727.GC10180@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-3-git-send-email-l.majewski@samsung.com>
 <20141107013727.GC10180@developer>
Message-ID: <20141107101550.60a57067@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

> Hello Lukasz,
> 
> On Thu, Oct 09, 2014 at 06:38:38PM +0200, Lukasz Majewski wrote:
> > This patch extends the of-thermal.c to provide check if trip point
> > is enabled.
> > 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> >  drivers/thermal/of-thermal.c   | 9 +++++++++
> >  drivers/thermal/thermal_core.h | 5 +++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/drivers/thermal/of-thermal.c
> > b/drivers/thermal/of-thermal.c index b2390d9..23c8d6c 100644
> > --- a/drivers/thermal/of-thermal.c
> > +++ b/drivers/thermal/of-thermal.c
> > @@ -119,6 +119,15 @@ int of_thermal_get_ntrips(struct
> > thermal_zone_device *tz) return data->ntrips;
> >  }
> >  
> > +int of_thermal_is_trip_en(struct thermal_zone_device *tz, int trip)
> > +{
> > +	struct __thermal_zone *data = tz->devdata;
> > +
> > +	if (trip >= data->ntrips || trip < 0)
> > +		return 0;
> > +	return 1;
> 
> might be worth using 'true' and 'false', just for the sake of code
> readability.
> 
> > +}
> > +
> 
> 
> I am not against this addition. I just request you to document it
> accordingly.
> 
> 
> >  static int of_thermal_get_trend(struct thermal_zone_device *tz,
> > int trip, enum thermal_trend *trend)
> >  {
> > diff --git a/drivers/thermal/thermal_core.h
> > b/drivers/thermal/thermal_core.h index 587ca5c..ed8ff05 100644
> > --- a/drivers/thermal/thermal_core.h
> > +++ b/drivers/thermal/thermal_core.h
> > @@ -82,6 +82,7 @@ static inline void
> > thermal_gov_user_space_unregister(void) {} int
> > of_parse_thermal_zones(void); void of_thermal_destroy_zones(void);
> >  int of_thermal_get_ntrips(struct thermal_zone_device *);
> > +int of_thermal_is_trip_en(struct thermal_zone_device *, int);
> >  #else
> >  static inline int of_parse_thermal_zones(void) { return 0; }
> >  static inline void of_thermal_destroy_zones(void) { }
> > @@ -89,6 +90,10 @@ static inline int of_thermal_get_ntrips(struct
> > thermal_zone_device *) {
> >  	return 0;
> >  }
> > +int of_thermal_is_trip_en(struct thermal_zone_device *, int)
> this is supposed to be static inline.
> 
> > +{
> > +	return 0;
> > +}
> >  #endif
> >  
> >  #endif /* __THERMAL_CORE_H__ */
> > -- 
> > 2.0.0.rc2
> > 

I will prepare proper description for the code.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
