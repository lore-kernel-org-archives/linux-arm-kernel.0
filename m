From: premi@ti.com (Premi, Sanjeev)
Date: Mon, 27 Jun 2011 17:42:36 +0530
Subject: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
In-Reply-To: <20110627111556.GM23145@atomide.com>
References: <1309171009-8075-1-git-send-email-premi@ti.com>
	<20110627111556.GM23145@atomide.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D7933C0@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com] 
> Sent: Monday, June 27, 2011 4:46 PM
> To: Premi, Sanjeev
> Cc: linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org; Gregoire Gentil; 
> Bhandiwad, Hrishikesh; Jason Lam; Thomas Weber
> Subject: Re: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
> 
> * Sanjeev Premi <premi@ti.com> [110627 03:33]:
> > From: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
> > 
> > Present current selection of the GPTIMER on Beagleboard
> > was result of a hardware issue in early versions of the
> > Beagleboards (Ax and B1 thru B4). [1][2]
> > 
> > Its been long since the hardware issue has been fixed.
> > This patch uses GPTIMER 1 for all newer board revisions
> > incl. Beagleboard XM.
> > 
> > Also, the clock source for GPTIMER12 is much less frequency
> > stable than clock sources for GPTIMER1. Using GPTIMER12 can
> > result in major time skew over a fairly short interval.
> 
> I don't think omap3_beagle_init_rev is even called when
> the timer is set?

[sp] I verified the patch based on the print indicating that
     GPTIMER1 being used as clockevent source.
     http://marc.info/?l=linux-omap&m=130893319726456&w=2

> 
> But even if it was, this is not a good fix because of the
> dependency issues it causes to mux and gpio framework in
> omap3_beagle_rev_init.
> 
> The best way to fix this is to set a separate machine ID
> for the working beagle boards like I commented earlier.
> It allows just setting the .timer based on that, the rest
> of the code can be shared.

[sp] Sorry missed reading your comment. I wasn't checking
     mails while sending the updated patch.

> 
> Regards,
> 
> Tony
> 
