From: tony@atomide.com (Tony Lindgren)
Date: Wed, 29 Jun 2016 21:49:59 -0700
Subject: [RESEND PATCH v2 1/5] ir-rx51: Fix build after multiarch changes
 broke it
In-Reply-To: <57716E27.2040702@gmail.com>
References: <1466623341-30130-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1466623341-30130-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201606231948.51640@pali> <57716E27.2040702@gmail.com>
Message-ID: <20160630044959.GL28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160627 11:22]:
> On 23.06.2016 20:48, Pali Roh?r wrote:
> > On Wednesday 22 June 2016 21:22:17 Ivaylo Dimitrov wrote:
> > > The ir-rx51 driver for n900 has been disabled since the multiarch
> > > changes as plat include directory no longer is SoC specific.
> > > 
> > > Let's fix it with minimal changes to pass the dmtimer calls in
> > > pdata. Then the following changes can be done while things can
> > > be tested to be working for each change:
> > > 
> > > 1. Change the non-pwm dmtimer to use just hrtimer if possible
> > > 
> > > 2. Change the pwm dmtimer to use Linux PWM API with the new
> > >     drivers/pwm/pwm-omap-dmtimer.c and remove the direct calls
> > >     to dmtimer functions
> > > 
> > > 3. Parse configuration from device tree and drop the pdata
> > > 
> > > Note compilation of this depends on the previous patch
> > > "ARM: OMAP2+: Add more functions to pwm pdata for ir-rx51".
> > 
> > I think that this extensive description is not needed for commit
> > message. Just for email discussion.
> > 
> 
> I guess Tony can strip the description a bit before applying.

OK I'll leave out the last paragraph as that already got merged
earlier.

Tony
