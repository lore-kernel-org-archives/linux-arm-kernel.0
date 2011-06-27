From: premi@ti.com (Premi, Sanjeev)
Date: Mon, 27 Jun 2011 18:58:54 +0530
Subject: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
In-Reply-To: <20110627123140.GP23145@atomide.com>
References: <1309171009-8075-1-git-send-email-premi@ti.com>
	<20110627111556.GM23145@atomide.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D7933C0@dbde02.ent.ti.com>
	<20110627123140.GP23145@atomide.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D793464@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com] 
> Sent: Monday, June 27, 2011 6:02 PM
> To: Premi, Sanjeev
> Cc: linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org; Gregoire Gentil; 
> Bhandiwad, Hrishikesh; Jason Lam; Thomas Weber
> Subject: Re: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
> 
> * Premi, Sanjeev <premi@ti.com> [110627 05:08]:
> > > From: Tony Lindgren [mailto:tony at atomide.com] 
> > > 
> > > I don't think omap3_beagle_init_rev is even called when
> > > the timer is set?
> > 
> > [sp] I verified the patch based on the print indicating that
> >      GPTIMER1 being used as clockevent source.
> >      http://marc.info/?l=linux-omap&m=130893319726456&w=2
> 
> I suspect the test always fails though, so it probably never
> gets set to gptimer12 on any board :)
>

[sp] While I take my time understanding things on devel-timer;
     I had a quick question - at risk of being flamed.

     Adding a new machine ID would trickle to u-boot and same
     uImage (default) may not work across board revisions.

     How does this scheme look like:
     - GPTIMER1 is used as default - as it works for most boards.
     - GPTIMER12 is used based on a static config option OR a
       board specific bootarg

     I know both these options aren't general practice. Still
     wanted to know your views in the current context.

~sanjeev

> Tony
>
