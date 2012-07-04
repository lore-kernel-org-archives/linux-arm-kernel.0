From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Jul 2012 13:05:09 -0600 (MDT)
Subject: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <4FF468DF.10108@ti.com>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com>
 <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com>
 <4FDA45F5.9090300@ti.com>
 <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com>
 <4FDB387C.7030003@ti.com>
 <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com>
 <4FF468DF.10108@ti.com>
Message-ID: <alpine.DEB.2.00.1207041302401.6760@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t

On Wed, 4 Jul 2012, Benoit Cousson wrote:

> > From: Paul Walmsley <paul@pwsan.com>
> > Date: Wed, 4 Jul 2012 05:22:53 -0600
> > Subject: [PATCH] ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sync timer
> 
> [...]
> 
> > @@ -1208,8 +1219,13 @@ static void _idle_sysc(struct omap_hwmod *oh)
> >  	sf = oh->class->sysc->sysc_flags;
> >  
> >  	if (sf & SYSC_HAS_SIDLEMODE) {
> > -		idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
> > -			HWMOD_IDLEMODE_FORCE : HWMOD_IDLEMODE_SMART;
> > +		/* XXX What about HWMOD_IDLEMODE_SMART_WKUP? */
> 
> What do you mean here?

We're not programming IP block target idle modes to smart idle + wakeup on 
OMAP4.  We're only programming them to smart idle :-(


- Paul
