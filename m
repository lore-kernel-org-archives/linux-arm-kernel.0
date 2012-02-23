From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 23 Feb 2012 09:14:59 +0100
Subject: [PATCH v3 06/10] pwm: Add NVIDIA Tegra SoC support
In-Reply-To: <4F459A94.4030104@gmail.com>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-7-git-send-email-thierry.reding@avionic-design.de>
 <4F459A94.4030104@gmail.com>
Message-ID: <20120223081459.GD8621@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ryan Mallon wrote:
> On 23/02/12 02:17, Thierry Reding wrote:
> 
> > This commit adds a generic PWM framework driver for the PWFM controller
> > found on NVIDIA Tegra SoCs. The driver is based on code from the
> > Chromium kernel tree and was originally written by Gary King (NVIDIA)
> > and later modified by Simon Que (Chromium).
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> 
> <snip>
> 
> > +
> > +	pwm->chip.dev = &pdev->dev;
> > +	pwm->chip.ops = &tegra_pwm_ops;
> > +	pwm->chip.base = -1;
> > +	pwm->chip.npwm = NUM_PWM;
> 
> > +
> > +	ret = pwmchip_add(&pwm->chip);
> 
> 
> If a driver fails to initialise the pwm_chip structure correctly it can
> cause problems in the pwm core. For example, if the dev field doesn't
> get set, then you will get an oops if you try to cat the pwm debugfs file.
> 
> pwmchip_add should probably verify that the initialisation of the
> pwm_chip structure is sane to avoid problems like this.

Absolutely. What would be the best response to an invalid struct pwm_chip? I
suppose at least returning -EINVAL, perhaps complemented with WARN_ON?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/9a5b0415/attachment.sig>
