From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 11 Jul 2016 09:20:24 +0200
Subject: [PATCH v3 12/14] regulator: pwm: Retrieve correct voltage
In-Reply-To: <20160711070251.GA5823@ulmo.ba.sec>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465895602-31008-13-git-send-email-boris.brezillon@free-electrons.com>
 <20160708154302.GC1151@ulmo.ba.sec>
 <20160709094718.GB6247@sirena.org.uk>
 <20160711070251.GA5823@ulmo.ba.sec>
Message-ID: <20160711092024.6cbd1c88@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jul 2016 09:02:51 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Sat, Jul 09, 2016 at 11:47:18AM +0200, Mark Brown wrote:
> > On Fri, Jul 08, 2016 at 05:43:02PM +0200, Thierry Reding wrote:
> >   
> > > Mark, do you want me to provide a stable branch with the PWM regulator
> > > patches and resolve that conflict in your tree? Or would you rather take
> > > the whole set based on a stable branch from the PWM tree? Or maybe yet
> > > another possibility would be to base the PWM tree on a stable branch
> > > from the regulator tree containing the above commit.  
> > 
> > Probably easiest to use this signed tag and resolve it in your tree:
> > 
> > The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> > 
> >   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/pwm-modernization
> > 
> > for you to fetch changes up to c2588393e6315ab68207323d37d2a73713d6bc81:
> > 
> >   regulator: pwm: Fix regulator ramp delay for continuous mode (2016-07-07 11:45:06 +0200)
> > 
> > ----------------------------------------------------------------
> > regulator: Provide a branch for moderninzation of the PWM code
> > 
> > There's a new, improved PWM API which allows a lot of improvements in
> > the PWM regulator driver.  Since the bulk of the changes are in the PWM
> > API this is being managed in the PWM tree, merge pending regulator API
> > changes to allow this to be resolved more easily.
> > 
> > ----------------------------------------------------------------
> > Alexandre Courbot (1):
> >       regulator: pwm: Support for enable GPIO
> > 
> > Boris Brezillon (1):
> >       regulator: pwm: Drop unneeded pwm_enable() call
> > 
> > Douglas Anderson (1):
> >       regulator: pwm: Fix regulator ramp delay for continuous mode
> > 
> >  .../bindings/regulator/pwm-regulator.txt           |  7 +++-
> >  drivers/regulator/pwm-regulator.c                  | 40 ++++++++++++++++++----
> >  2 files changed, 39 insertions(+), 8 deletions(-)  
> 
> Merged into for-4.8/regulator of the PWM tree and rebased Boris'
> pwm-regulator patches on top.
> 
> Boris, everything looks right to me, but can you take a quick look to
> see if it all matches up with what you expect?

It looks good, but I won't be able to test it on real hardware until
next week.
Heiko, Brian, can you try this pwm/for-4.8/regulator branch?

Thanks,

Boris
