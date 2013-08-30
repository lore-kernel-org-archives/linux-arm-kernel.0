From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Aug 2013 01:27:13 -0700
Subject: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
In-Reply-To: <CAMj5BkiDExikXi3JcVhO7RN8_82eGYhq3i6oPf5Wbipy=N+iHQ@mail.gmail.com>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
 <20130828095706.GH4086@katana>
 <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
 <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
 <20130830054858.GR7656@atomide.com>
 <CAMj5BkiDExikXi3JcVhO7RN8_82eGYhq3i6oPf5Wbipy=N+iHQ@mail.gmail.com>
Message-ID: <20130830082712.GT7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* zhangfei gao <zhangfei.gao@gmail.com> [130829 23:36]:
> What about concerns from Wolfram:
> " Other people might be
> depending on subsys_initcall to get I2C active before they want to
> activate, say, PMICs. So, I fear regressions, since deferred probing
> might not be available in the needed places to avoid these regressions."

There should not be any reason to get a PMIC activated
early on. The system should be booting already at that point,
and the PMIC related init can be done later on.
 
> Is it too late using module_init for PMIC?

You can probably do it as a fix early on during the -rc
cycle too. Of course it needs to be verified to work first :)
 
> Besides, the deferred probing still there if depend on late registered
> pin control driver.

At least for omaps we have things working just fine with
pinctrl-single and a PMIC on I2C controller.

Regards,

Tony
