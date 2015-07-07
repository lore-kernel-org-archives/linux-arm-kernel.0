From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Jul 2015 14:45:03 +0100
Subject: [RESEND 09/10] regulator: pwm-regulator: Simplify voltage to
 duty-cycle call
In-Reply-To: <20150707133245.GM2887@sirena.org.uk>
References: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
 <1436173112-21397-10-git-send-email-lee.jones@linaro.org>
 <20150707133245.GM2887@sirena.org.uk>
Message-ID: <20150707134503.GG3182@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 07 Jul 2015, Mark Brown wrote:

> On Mon, Jul 06, 2015 at 09:58:31AM +0100, Lee Jones wrote:
> > If we reverse some of the logic and change the formula used,
> > we can simplify the function greatly.
> 
> > +static int pwm_voltage_to_duty_cycle(struct regulator_dev *rdev, int req_uV)
> >  {
> > -	struct pwm_regulator_data *drvdata = rdev_get_drvdata(rdev);
> 
> You just added this function in the previous patch?

You're right, it does look a little weird contained in a single
patch-set.  The submission in the previous patch is the tried and
tested (i.e. in real releases) method written by ST.  This patch
contains a simplification provided by me.  IMO it looks and performs
better, but doesn't have the same time-under-test that the original
method does.  I'm merely ensuring we keep some history in order so
provide and easy way back i.e. revert.

If I have any say at all, I'd really like to keep this piece of
history.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
