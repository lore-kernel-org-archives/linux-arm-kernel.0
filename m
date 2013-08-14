From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 14 Aug 2013 10:19:09 +0200
Subject: [PATCH V4 1/4] ARM: dts: exynos5420: add i2s controllers
In-Reply-To: <CAAgF-BcXDeLiOMA-S-TSNEGG1hMyCyNTJCyEwmb=SO5waOsu5A@mail.gmail.com>
References: <1376302070-1877-1-git-send-email-padma.v@samsung.com>
 <1427610.pB8BGbMKTL@flatron>
 <CAAgF-BcXDeLiOMA-S-TSNEGG1hMyCyNTJCyEwmb=SO5waOsu5A@mail.gmail.com>
Message-ID: <5056552.LsEgxFsAhy@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 of August 2013 11:21:40 Padma Venkat wrote:
> Hi Tomasz,
> 
> On Mon, Aug 12, 2013 at 10:32 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > On Monday 12 of August 2013 14:12:36 Mark Brown wrote:
> >> On Mon, Aug 12, 2013 at 01:41:23PM +0200, Tomasz Figa wrote:
> >> > On Monday 12 of August 2013 12:34:48 Mark Brown wrote:
> >> > > I'd expect that to interact badly with the pinmuxing - unless the
> >> > > device is disabled it'll try to grab its pins on probe which is
> >> > > not
> >> > > going to be a good idea unless it is actually wired up for use in
> >> > > the system.  Or is there some other mechanism for handling that?
> >> > 
> >> > Ah, good point. Now I wonder whether pinctrl nodes shouldn't be
> >> > considered board-specific and specified in board-level dts instead?
> >> 
> >> It seems a bit cleaner to use the current mechanism in that it stops
> >> the device appearing at all and hence repeated efforts to probe,
> >> plus a simple enable is less error prone, the way these SoCs are
> >> designed you don't have to pick which pinmux is in use for most of
> >> the IPs.  Where there are multiple options it does seem like a good
> >> approach though.
> >> 
> >> Tastes may differ though.
> > 
> > Right, if this SoC has only one pinmux setting for this IP, then it's
> > fine.
> 
> Yes. This IP has only default pin configuration.
> 
> > Padmavathi, this was the only issue I spotted, so have my:
> > 
> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 
> Thanks for your review.

You're welcome.

Thanks for keeping up with this series and addressing all the comments. :)

Best regards,
Tomasz
