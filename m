From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 30 Jan 2015 09:52:08 +0100
Subject: 3.19 on Nokia n900: audio quality awful
In-Reply-To: <201501300916.22364@pali>
References: <20150106170433.GA5408@amd> <54CA173F.1070301@ti.com>
 <20150129204218.GC3962@amd> <201501300916.22364@pali>
Message-ID: <20150130085208.GA12212@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> > > index 04896d6252a2..7f299357c2d2 100644
> > > --- a/sound/soc/omap/rx51.c
> > > +++ b/sound/soc/omap/rx51.c
> > > @@ -250,14 +250,14 @@ static const struct snd_soc_dapm_route
> > > audio_map[] = {
> > > 
> > >  	{"FM Transmitter", NULL, "LLOUT"},
> > >  	{"FM Transmitter", NULL, "RLOUT"},
> > > 
> > > -	{"DMic Rate 64", NULL, "Mic Bias"},
> > > -	{"Mic Bias", NULL, "DMic"},
> > > +	{"DMic Rate 64", NULL, "DMic"},
> > > +	{"DMic", NULL, "Mic Bias"},
> > > 
> > >  	{"b LINE2R", NULL, "MONO_LOUT"},
> > >  	{"Earphone", NULL, "b HPLOUT"},
> > > 
> > > -	{"LINE1L", NULL, "b Mic Bias"},
> > > -	{"b Mic Bias", NULL, "HS Mic"}
> > > +	{"LINE1L", NULL, "HS Mic"},
> > > +	{"HS Mic", NULL, "b Mic Bias"},
> > > 
> > >  };
> > >  
> > >  static const char * const spk_function[] = {"Off", "On"};
> 
> Can you try DT and non-DT boot of 3.19? If there is difference?

Audio recording now works for me. No, I could not get non-DT boot of
3.19 to work :-(.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
