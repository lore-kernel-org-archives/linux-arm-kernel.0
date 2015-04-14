From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 13:19:17 +0200
Subject: [GIT PULL v2 1/2] ARM: tegra: Core code changes for v4.1-rc1
In-Reply-To: <20150414111425.GB15878@ulmo.nvidia.com>
References: <1427710333-13472-1-git-send-email-thierry.reding@gmail.com>
 <2204375.plVGQ25v9Q@wuerfel> <20150414111425.GB15878@ulmo.nvidia.com>
Message-ID: <2194010.F30DzOWOvR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 13:14:26 Thierry Reding wrote:
> On Tue, Apr 14, 2015 at 10:30:30AM +0200, Arnd Bergmann wrote:
> > On Tuesday 14 April 2015 09:06:50 Thierry Reding wrote:
> > > On Tue, Apr 14, 2015 at 01:09:56AM +0200, Arnd Bergmann wrote:
> > > > On Saturday 11 April 2015, Michael Turquette wrote:
> > > > > > Tomeu Vizoso (8):
> > > > > >       of: Document long-ram-code property in nvidia,tegra20-apbmisc
> > > > > >       of: Document timings subnode of nvidia,tegra-mc
> > > > > >       memory: tegra: Disable ARBITRATION_EMEM interrupt
> > > > > >       of: document new emc-timings subnode in nvidia,tegra124-car
> > > > > >       of: document external-memory-controller property in tegra124-car
> > > > > >       clk: Expose clk_hw_reparent() to providers
> > > > > 
> > > > > ... this patch! I'd prefer to not do this. Let's see if
> > > > > .set_rate_and_parent solve the problem for you.
> > > > 
> > > > Not pulling this for 4.1 then. Even without the objections, it was basically
> > > > too late for the amount of changes now.
> > > 
> > > For my education, when do you expect pull requests with "this amount of
> > > changes" to be sent?
> > 
> > Generally speaking, we want large patch series to come early after -rc1,
> > followed by smaller subsequent updates. We often don't get around to
> > applying stuff before -rc3, which is a problem on our side, but it helps
> > to have patches available by then.
> > 
> > Also, if you have a large series (100+ patches) early on, we'd be more
> > likely to take a 20-patch series later than if the 20-patch series comes
> > at rc6 and is the first thing we see from you: after around rc5 or rc6,
> > what we want to see are mostly patches that directly result from work
> > that we merged earlier for the same merge window, like regression fixes
> > or wrapping up a larger series that was started but incomplete at -rc2.
> 
> That's not generally what we've done on Tegra. We usually keep things in
> linux-next until around -rc6 to make sure whatever gets pulled into the
> arm-soc tree is stable.
> 
> With what you said above I'm pretty much forced to either send you pulls
> that aren't well tested (linux-next isn't supposed to get new code until
> after -rc1) or I have to plan for an extra release cycle for anything
> that is "big", which would mean that many new features would potentially
> take 6 months to get merged.
> 
> I don't like either of those choices.

Waiting for -rc6 is generally risky, because it means that if we find
something seriously wrong with a few of the patches, it can happen that
you don't get anything in at all.

For most maintainers it seems to work out well enough that they send us
whatever they are comfortable with early, but hold back some other
changes. Most of the per-soc trees are also part of linux-next themselves,
but generally speaking if you consider things ready for linux-next,
you should be able to send them to us, possibly after waiting for a
few days to look for regressions in linux-next.

	Arnd
