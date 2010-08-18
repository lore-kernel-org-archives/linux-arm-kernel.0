From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 18 Aug 2010 13:50:08 +0200
Subject: [PATCH] ARM: COLIBRI PXA320: fix UCB1400 irq autoprobing
In-Reply-To: <201008112326.20098.marek.vasut@gmail.com>
References: <AANLkTinxeEbZqwdB=bzC=ZZFqk1iR28yv=ECYRFNeUE=@mail.gmail.com>
	<20100811143345.GU17833@buzzloop.caiaq.de>
	<201008112326.20098.marek.vasut@gmail.com>
Message-ID: <20100818115008.GI17833@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 11:26:20PM +0200, Marek Vasut wrote:
> Dne St 11. srpna 2010 16:33:45 Daniel Mack napsal(a):
> > Hi Yuri,
> > 
> > thanks for the patch.
> > 
> > On Wed, Aug 11, 2010 at 04:54:13PM +0400, Yuri Ludkevich wrote:
> > > Ads properly initialization to GPIO4 ( alt. fn. #1, nCS3; because GPIO4
> > > and GPIO4_2 cannot be
> > > configured as GPIO simultaneously ) so GPIO4_2 which used as irq line
> > > from UCB1400 may be
> > > detected while irq autoprobing routine.
> > 
> > This looks fine to me, but Marek wanted to rework the board support in
> > order to unify the GPIO configs for better readability. Marek, is there
> > any tree which contains your changes already?
> > 
> I hope there will be tomorrow ...

Yuri, could you check out Marek's tree from

  git://git.kernel.org/pub/scm/linux/kernel/git/marex/pxa-linux-2.6.git work

(not that "work" ist the branch you'll need to work on).

You'll see that colibri-pxa320.c looks a lot different now, so your
patch should be a one-liner now.

Also, more testing of this code is certainly appreciated :)

Thanks,
Daniel
