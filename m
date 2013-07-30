From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 Jul 2013 06:55:27 -0700
Subject: [PATCH v2 1/8] ARM: DRA7: id: Add cpu detection support for
 DRA7xx based SoCs'
In-Reply-To: <20130730131837.GB28162@radagast>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-2-git-send-email-rnayak@ti.com>
 <20130730131009.GA28162@radagast> <20130730131837.GB28162@radagast>
Message-ID: <20130730135527.GM7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [130730 06:25]:
> On Tue, Jul 30, 2013 at 04:10:09PM +0300, Felipe Balbi wrote:
> > Hi,
> > 
> > On Tue, Jul 30, 2013 at 04:55:39PM +0530, Rajendra Nayak wrote:
> > > @@ -379,6 +407,13 @@ IS_OMAP_TYPE(3430, 0x3430)
> > >  # define soc_is_omap543x()		is_omap543x()
> > >  #endif
> > >  
> > > +# if defined(CONFIG_SOC_DRA7XX)
> > > +# undef soc_is_dra7xx
> > > +# undef soc_is_dra75x
> > > +# define soc_is_dra7xx()		is_dra7xx()
> > > +# define soc_is_dra75x()		is_dra75x()
> > 
> > since this platform is DT-only, couldn't we just believe DT-data to be
> > correct of_machine_is_compatible() ? 2/3 of this patch would be removed.
> 
> s/correct of_/correct and use of_

Makes sense to me. AFAIK we no longer need to initialize much
anything super early.

Regards,

Tony
