From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 9 Jul 2015 15:14:29 +0200
Subject: [PATCH v2 0/9] regulator: pwm-regulator: Introduce continuous-mode
In-Reply-To: <20150709115158.GA3445@x1>
References: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
 <20150709083041.3b203eb1@bbrezillon> <20150709115158.GA3445@x1>
Message-ID: <20150709151429.6daf8fcb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, 9 Jul 2015 12:51:58 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Thu, 09 Jul 2015, Boris Brezillon wrote:
> > I'm interested in this feature (so as Doug is), could you add us in Cc
> > of your next submission ?
> 
> There won't be a subsequent submission, as this has already been
> accepted.

Oh, I must have overlooked Mark's answer saying that he is accepting it.

> 
> > On Tue,  7 Jul 2015 16:06:44 +0100
> > Lee Jones <lee.jones@linaro.org> wrote:
> > 
> > > This patch-set has been rebased on to topic/pwm.
> > >   
> > > Continuous mode uses the PWM regulator's maximum and minimum supplied
> > > voltages specified in the regulator-{min,max}-microvolt properties to
> > > calculate appropriate duty-cycle values.  This allows for a much more
> > > fine grained solution when compared with voltage-table mode, which
> > > this driver already supports.  This solution does make an assumption
> > > that a %50 duty-cycle value will cause the regulator voltage to run
> > > at half way between the supplied max_uV and min_uV values.
> > 
> > Well, I'm not sure this assumption works for all pwm driven regulators.
> > What if your regulator does not react linearly to the PWM duty-cycle
> > config ?
> > 
> > How about addressing that by using all the entries of the
> > voltage<->duty table association and doing the linear interpolation
> > between the provided points instead of doing it on the min -> max
> > range ?
> 
> If you wish to add a 3rd mode, then I'm sure Mark will accept
> submissions, but I think what you are suggesting would be pretty
> complex and out-of-scope of what this patch-set is trying to achieve.

Okay, still don't get the need to add a new mode which is almost doing
the same thing when we could have implemented it in a generic way in the
first place. But if your version has already been accepted then I think
I'll have to propose a new mode :-/.

> 
> As a side note, then if the voltage isn't directly proportional to the
> duty cycle on a large scale i.e. max => min, then it will not likely
> be very accurate between say table entries 1 => 2, or 4 => 5, etc.
> 
> What I suggest you do in your case is provide a larger table with all
> of the values you find interesting, as it sounds like your PWM
> regulator isn't doing what one would normally expect.

Well, I do not exactly agree here. Yes if you want to have a precise
mapping you'll have to add more entries in your voltage table, but
using linear interpolation between two points can be precise enough on
some ranges and prevent one to define a complete voltage table in the
DT.

Doug, could give more details about the regulator used on the veyron
board ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
