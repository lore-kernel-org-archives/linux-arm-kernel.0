From: alison.wang@nxp.com (Alison Wang)
Date: Fri, 1 Dec 2017 03:33:49 +0000
Subject: [PATCH] arm: kernel: utilize hrtimer based broadcast
In-Reply-To: <alpine.DEB.2.11.1601051039320.3689@nanos>
References: <1437124312-44700-1-git-send-email-b18965@freescale.com>
 <20151027081834.GB1425@svinekod>
 <DB3PR04MB07407D83CC5F8F5F19A7207F4FB0@DB3PR04MB074.eurprd04.prod.outlook.com>
 <4875455.lvoc6XpkZc@wuerfel> <alpine.DEB.2.11.1512291449380.28591@nanos>
 <20160102102955.GP8644@n2100.arm.linux.org.uk>
 <alpine.DEB.2.11.1601051039320.3689@nanos>
Message-ID: <VI1PR04MB3039EB80F5468E55263ABECBF4390@VI1PR04MB3039.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell,

> On Sat, 2 Jan 2016, Russell King - ARM Linux wrote:
> > On Tue, Dec 29, 2015 at 02:54:10PM +0100, Thomas Gleixner wrote:
> > > I have no real opinion about that patch. It does no harm to
> > > unconditionally setup the hrtimer based broadcast even if it's never
> used.
> > >
> > > Up to the arch maintainer to decide.
> >
> > That's really not fair to keep shovelling these kinds of decisions
> > onto architecture maintainers without any kind of explanation about
> > how an architecture maintainer should make such a decision.
> >
> > Do I roll a 6-face dice, and if it gives an odd number, I apply this
> > patch, otherwise I reject it?
> >
> > Is there a technical basis for making the decision?  If so, please
> > explain what the technical arguments are against having or not having
> > this change.
> 
> The hrtimer based broadcast device is used when you have per cpu timers
> which stop in deeper power states, but you have no other timer hardware on
> the chip which can backup the per cpu timer in deep power states. The
> trick is that it emulates a timer hardware via a hrtimer and then tells
> the cpu idle code not to go into deep power states on the cpu which owns
> that hrtimer. All other cpus can go as deep as they want and still get
> woken up.
> 
> The only downside of adding this unconditionally is extra code in case
> that it is not needed on a particular platform.
> 
> Hope that helps.
> 
[Alison Wang] What's your opinion about this explanation? Is this patch acceptable?

Best Regards,
Alison Wang
