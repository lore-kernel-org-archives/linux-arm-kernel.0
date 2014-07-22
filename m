From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 13:13:06 +0100
Subject: [PATCH 01/19] mfd: max77686: Fix 'line over 80 chars' warning
In-Reply-To: <CAMf-jSn4y40p+tpUNMnCMMmAEQbjXBqbfgPy3zWrTs_b85uvxg@mail.gmail.com>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
 <1406027485-15657-2-git-send-email-lee.jones@linaro.org>
 <CAMf-jSn4y40p+tpUNMnCMMmAEQbjXBqbfgPy3zWrTs_b85uvxg@mail.gmail.com>
Message-ID: <20140722121306.GB16065@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Jul 2014, pramod gurav wrote:

> On Tue, Jul 22, 2014 at 4:41 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > This is part of an effort to clean-up the MFD subsystem.
> >
> <snip>
> >         max77686->rtc_regmap = devm_regmap_init_i2c(max77686->rtc,
> Which kernel are you on? Because 3.16.rc6 does not match with these
> lines. Its something like this:
>           'max77686->regmap = devm_regmap_init_i2c(i2c,
> &max77686_regmap_config);'
> 
> Sorry if I am missing something.

It's based on the most recent MFD for-mfd-next branch.

You're missing the following patches:

  mfd: max77686: Remove unneeded OOM error message
  mfd: max77686: Make error checking consistent
  mfd: max77686: Return correct error when pdata isn't found
  mfd: max77686: Make platform data over-rule DT
  mfd: max77686: Don't define dummy function if OF isn't enabled
  mfd: max77686: Add power management support
  mfd: max77686: Convert to use regmap_irq

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
