From: mgreer@animalcreek.com (Mark A. Greer)
Date: Mon, 28 Jan 2013 12:16:35 -0700
Subject: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
In-Reply-To: <20130117222728.GA32446@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com>
 <20130108203853.GB1876@animalcreek.com>
 <alpine.DEB.2.00.1301171904070.14118@utopia.booyaka.com>
 <20130117222728.GA32446@animalcreek.com>
Message-ID: <20130128191635.GA14158@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 03:27:28PM -0700, Mark A. Greer wrote:
> On Thu, Jan 17, 2013 at 07:13:36PM +0000, Paul Walmsley wrote:
> > Hi Mark,
> 
> Hi Paul.

Hi again, Paul.  Sorry for the delay, I've been under the weather.

> > I regret the delay,
> > 
> > On Tue, 8 Jan 2013, Mark A. Greer wrote:
> > 
> > > On Sun, Dec 23, 2012 at 08:40:43AM +0000, Paul Walmsley wrote:

> > What do you think about adding an am35xx_es11plus_hwmod_ocp_ifs[] array to 
> > omap_hwmod_3xxx_data.c for these secure hwmods?  That carries the implicit 
> > and possibly wrong assumption that it's likely to be ES1.0 devices that 
> > are missing the SHAM/AES, but it seems unlikely that TI would have 
> > multiple silicon revs running around claiming to be ES1.1?  Or maybe I'm 
> > just being na?ve.
> 
> Something like that makes sense to me.  I'll re-read my email, etc. and
> see if I can find something to help us figure it out.

I couldn't find any information that helped with this so AFAIK there is no
good way to tell if a particular am35xx has the crypto hardware available
or not.  At this point, I vote for moving 'omap3xxx_l4_core__sham' and
'omap3xxx_l4_core__aes' from omap3xxx_gp_hwmod_ocp_ifs[] and putting them
in omap34xx_hwmod_ocp_ifs[] and omap36xx_hwmod_ocp_ifs[].  That should be
safe in general and if someone with an am35xx wants to use those modules,
they can edit am35xx_hwmod_ocp_ifs[] locally.

What do you think?
