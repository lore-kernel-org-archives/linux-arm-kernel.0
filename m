From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Feb 2017 09:38:04 +0100
Subject: [PATCH v2 1/4] ARM: pwm: sun4i: unification of register
 operations for support sun6i.
In-Reply-To: <CAKNVLfaYoPf-b-mGc0eSmmAk0QPhMCRt5aT5Z3JBcfKhridWDA@mail.gmail.com>
References: <1486489846-662-1-git-send-email-lis8215@gmail.com>
 <1486489846-662-2-git-send-email-lis8215@gmail.com>
 <20170208075219.oo234d5zartzmzsg@lukather>
 <CAKNVLfaYoPf-b-mGc0eSmmAk0QPhMCRt5aT5Z3JBcfKhridWDA@mail.gmail.com>
Message-ID: <20170210083804.woe3bbc6b6c3vsp3@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 08, 2017 at 07:41:55PM +0300, ?????? ?????? wrote:
> Hello all,
> 
> >> This patch not introduce new features, just prepare code for
> >> adding sun6i PWM driver in next commits.
> >>
> >> A31 SoC have a different map of PWM registers than others ASoCs,
> >> but register bits purposes are very similar.
> >>
> >> This patch introduce set of register access routines, which
> >> are common for existing in driver ASoCs:
> >>  - ctl_rdy   - checks the ready bit of specified PWM channel,
> >>  - ctl_read  - reads value from control register of specified PWM
> channel,
> >>  - ctl_write - writes significant bits to control register of specified
> PWM channel,
> >>  - prd_read  - reads value from period register of specified PWM channel,
> >>  - prd_write - writes value to period register of specified PWM channel.
> >> Driver code redesigned to use the new routines.
> >
> > Why don't you use regmap for that?
> 
> First of all, i'm newbie and its my first patchset. I just remake
> what i see in the driver. I even don't suspect about use regmap
> here.

Don't worry, a review is here to point where things could be better,
which doesn't mean that you did wrong :)

> Second thing - i can't test these driver on all existing sunxi SoCs,
> i have only A31 and A20 based boards where only pwm0 is
> accessible. Huge redesign cause bigger chance to make a mistake.

Don't worry about that either. We have a good number of platforms
using the PWMs already. If there's something broken at some point,
we'll catch it as well.

> If you think regmap solution is a must, then i will do that. This
> will be a good experience for me.

Yes, this really should cover what you're trying to do here,
especially reg_field.

You can have a look at drivers/reset/sti/reset-syscfg.c if you want to
have a look at a rather simple driver using it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/12cba1ce/attachment.sig>
