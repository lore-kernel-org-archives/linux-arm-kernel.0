From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 Dec 2011 15:51:50 -0700 (MST)
Subject: [PATCH] ARM: OMAP3: hwmod data: disable multiblock reads on
 MMC1/2 on OMAP34xx/35xx <= ES2.1
In-Reply-To: <CAGDS+nnm_+9975aX9h7U7EUf6UDWiiqO8+yfG_zW1sCxhgrzQw@mail.gmail.com>
References: <alpine.DEB.2.00.1110061453540.4611@utopia.booyaka.com>
 <CAGDS+nnm_+9975aX9h7U7EUf6UDWiiqO8+yfG_zW1sCxhgrzQw@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1112081541170.6289@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Thu, 8 Dec 2011, Steve Sakoman wrote:

> On Thu, Oct 6, 2011 at 1:56 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > The HSMMC1/HSMMC2 host controllers on OMAP34xx and
> > OMAP3503/3515/3525/3530 chips at ES levels prior to 3.0 can't do multiple
> > block reads[1]. ?Mark the hwmod data appropriately.

...

> > This patch has a dependency on the "MMC: disable multiblock reads on
> > controllers that don't support them" series recently posted to
> > the linux-mmc list, so the application of this patch will probably be
> > delayed until the 3.3 merge window.
> 
> Since the above patch is now in mainline
> (2bf22b39823c1d173dda31111a4eb2ce36daaf39) this patch can go in.

Thanks for the reminder - I would have forgotten it otherwise.  

> Without it 35XXES2.1 systems have broken mmc.  Too late as a bug fix for 
> 3.2?

This never worked correctly in previous Linux releases, right?

My understanding -- possibly incorrect -- of Linus's policy is that the 
-rc cycle should primarily be for regressions.  So I think that the 3.3 
window is the right place for this patch.

But if you can get a special dispensation from the Linux popes, I don't 
have any objection to having it go in earlier ;-)

Anyway, queued here for 3.3.


- Paul
