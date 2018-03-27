From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Mar 2018 15:23:49 -0700
Subject: [PATCH 4/6] pwm: pwm-omap-dmtimer: Fix frequency when using
 prescaler
In-Reply-To: <20180327221401.GD28163@mithrandir>
References: <20180223101254.GA5746@lenoch> <20180223101553.GE5746@lenoch>
 <20180327215332.GC28163@mithrandir>
 <20180327221401.GD28163@mithrandir>
Message-ID: <20180327222349.GK5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thierry Reding <thierry.reding@gmail.com> [180327 22:15]:
> On Tue, Mar 27, 2018 at 11:53:33PM +0200, Thierry Reding wrote:
> > On Fri, Feb 23, 2018 at 11:15:53AM +0100, Ladislav Michl wrote:
> > > Prescaler setting is currently not taken into account.
> > > Fix that by introducing freq member variable and initialize
> > > it at device probe time. This also avoids frequency
> > > recomputing at each pwm configure time.
> > > 
> > > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > > ---
> > >  drivers/pwm/pwm-omap-dmtimer.c | 93 +++++++++++++++++++++++++-----------------
> > >  1 file changed, 55 insertions(+), 38 deletions(-)
> > 
> > Applied, thanks.
> 
> Actually, that was a little premature. It seems like this conflicts with
> a patch series by Keerthy that Tony merged into his tree and that you've
> based this on.
> 
> I think it'd be easiest if Tony merged this through the TI tree, or we
> wait until v4.17-rc1 to resolve the dependency. Given how late we are in
> the release cycle, I think it'd have to be the latter.

Sorry about the extra hassle caused by the timer move to drivers.

> Tony, if you think you can find a way to still take this in for
> v4.17-rc1, feel free to do so:
> 
> Acked-by: Thierry Reding <thierry.reding@gmail.com>

I pretty much only apply fixes after -rc6. So let's wait for the
dependencies to clear at this point. This seems like a "fix for
a feature that never worked" so might be hard to justify it as
a fix :)

Ladis, can you please resend the pending patches again to
Thierry after v4.17-rc? Then Thierry can queue it as a fix or
for v4.18.

Regards,

Tony
