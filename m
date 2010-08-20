From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 20 Aug 2010 11:34:00 +0200
Subject: [PATCH] ARM: COLIBRI PXA320: fix UCB1400 irq autoprobing
In-Reply-To: <AANLkTiktCBNjwN6gfLMv6=BQnGvujbdGPZKk+o+yXqah@mail.gmail.com>
References: <AANLkTinxeEbZqwdB=bzC=ZZFqk1iR28yv=ECYRFNeUE=@mail.gmail.com>
	<20100818115008.GI17833@buzzloop.caiaq.de>
	<AANLkTiktCBNjwN6gfLMv6=BQnGvujbdGPZKk+o+yXqah@mail.gmail.com>
Message-ID: <201008201134.01180.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 20. srpna 2010 10:34:35 Yuri Ludkevich napsal(a):
> 2010/8/18 Daniel Mack <daniel@caiaq.de>
> 
> > On Wed, Aug 11, 2010 at 11:26:20PM +0200, Marek Vasut wrote:
> > > Dne St 11. srpna 2010 16:33:45 Daniel Mack napsal(a):
> > > > Hi Yuri,
> > > > 
> > > > thanks for the patch.
> > > > 
> > > > On Wed, Aug 11, 2010 at 04:54:13PM +0400, Yuri Ludkevich wrote:
> > > > > Ads properly initialization to GPIO4 ( alt. fn. #1, nCS3; because
> > 
> > GPIO4
> > 
> > > > > and GPIO4_2 cannot be
> > > > > configured as GPIO simultaneously ) so GPIO4_2 which used as irq
> > > > > line from UCB1400 may be
> > > > > detected while irq autoprobing routine.
> > > > 
> > > > This looks fine to me, but Marek wanted to rework the board support
> > > > in order to unify the GPIO configs for better readability. Marek, is
> > > > there any tree which contains your changes already?
> > > 
> > > I hope there will be tomorrow ...
> > 
> > Yuri, could you check out Marek's tree from
> > 
> >  git://git.kernel.org/pub/scm/linux/kernel/git/marex/pxa-linux-2.6.gitwor
> >  k
> > 
> > (not that "work" ist the branch you'll need to work on).
> > 
> > You'll see that colibri-pxa320.c looks a lot different now, so your
> > patch should be a one-liner now.
> > 
> > Also, more testing of this code is certainly appreciated :)
> 
> I have looked at code and I have couple of questions about colibri-pxa320.c
> and colibri-evalboard.c:
> Why colibri_pxa320_evalboard_pin_config[] placed in colibri-pxa320.c, not
> in evalboard?

I was unable to figure out how to mix pxa2xx and pxa3xx MFPs.

> Why there is no defconfig for colibri pxa320?

Defconfigs are done for.
> 
> BTW: we have our own board which very similar to colibri evalboard - same
> RTC, UCB1400 as sound and touch controller. But we have USB hub onboard, do
> not use FFUART and use 800x600 screen - so we make our own file with board
> init stuff. May be colibri_pxa320_evalboard_pin_config[] and
> pxafb_mode_info/pxa_fb_mach info structures also can be moved to evalboard
> file?

See above.

Cheers
