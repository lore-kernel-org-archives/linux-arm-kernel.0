From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 13 Mar 2015 20:40:25 +0100
Subject: [PATCHv2] thermal: add omap3 support
In-Reply-To: <20150313050300.GA30104@developer>
References: <20150103111146.GB7065@amd> <20150118202824.GB29014@amd>
 <20150313050300.GA30104@developer>
Message-ID: <20150313194025.GA22182@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > @@ -384,25 +385,10 @@ int ti_bandgap_set_sensor_data(struct ti_bandgap *bgp, int id, void *data);
> >  void *ti_bandgap_get_sensor_data(struct ti_bandgap *bgp, int id);
> >  int ti_bandgap_get_trend(struct ti_bandgap *bgp, int id, int *trend);
> >  
> > -#ifdef CONFIG_OMAP4_THERMAL
> > +extern const struct ti_bandgap_data omap34xx_data;
> >  extern const struct ti_bandgap_data omap4430_data;
> >  extern const struct ti_bandgap_data omap4460_data;
> >  extern const struct ti_bandgap_data omap4470_data;
> > -#else
> > -#define omap4430_data					NULL
> > -#define omap4460_data					NULL
> > -#define omap4470_data					NULL
> > -#endif
> > -
> > -#ifdef CONFIG_OMAP5_THERMAL
> >  extern const struct ti_bandgap_data omap5430_data;
> > -#else
> > -#define omap5430_data					NULL
> > -#endif
> > -
> > -#ifdef CONFIG_DRA752_THERMAL
> >  extern const struct ti_bandgap_data dra752_data;
> > -#else
> > -#define dra752_data					NULL
> > -#endif
> 
> Pavel,
> 
> Why do we need to remove the existing symbols for other chips in this file to get OMAP3 support in?
> 

No, I don't need to remove this, and you can safely drop this hunk.

OTOH those ifdefs are unneccessary and eye-sore: extern symbol
declarations do not really hurt, and .c files already contain enough
#ifdefs for other reasons that the symbols will not be needed when it
is not configured.

Try it, it should work ok.

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
