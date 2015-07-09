From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 9 Jul 2015 16:44:30 +0100
Subject: [PATCH v2 0/9] regulator: pwm-regulator: Introduce continuous-mode
In-Reply-To: <20150709151429.6daf8fcb@bbrezillon>
References: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
 <20150709083041.3b203eb1@bbrezillon> <20150709115158.GA3445@x1>
 <20150709151429.6daf8fcb@bbrezillon>
Message-ID: <20150709154430.GC3445@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > Lee Jones <lee.jones@linaro.org> wrote:
> > > 
> > > > This patch-set has been rebased on to topic/pwm.
> > > >   
> > > > Continuous mode uses the PWM regulator's maximum and minimum supplied
> > > > voltages specified in the regulator-{min,max}-microvolt properties to
> > > > calculate appropriate duty-cycle values.  This allows for a much more
> > > > fine grained solution when compared with voltage-table mode, which
> > > > this driver already supports.  This solution does make an assumption
> > > > that a %50 duty-cycle value will cause the regulator voltage to run
> > > > at half way between the supplied max_uV and min_uV values.
> > > 
> > > Well, I'm not sure this assumption works for all pwm driven regulators.
> > > What if your regulator does not react linearly to the PWM duty-cycle
> > > config ?
> > > 
> > > How about addressing that by using all the entries of the
> > > voltage<->duty table association and doing the linear interpolation
> > > between the provided points instead of doing it on the min -> max
> > > range ?
> > 
> > If you wish to add a 3rd mode, then I'm sure Mark will accept
> > submissions, but I think what you are suggesting would be pretty
> > complex and out-of-scope of what this patch-set is trying to achieve.
> 
> Okay, still don't get the need to add a new mode which is almost doing
> the same thing when we could have implemented it in a generic way in the
> first place. But if your version has already been accepted then I think
> I'll have to propose a new mode :-/.

This solution is very generic.  What you're suggesting is pretty
non-standard I think.  This solution specifically doesn't account for
wonky/non-linear PWM regulators -- that's why I made the effort to
write it as an explicit assumption.

FYI, I just sent a patch amending the binding documentation.  It
should prevent any further confusion.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
