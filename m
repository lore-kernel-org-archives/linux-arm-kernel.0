From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 8 Oct 2013 10:46:04 +0800
Subject: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
In-Reply-To: <CAMj5BkgqBCh0316NmoP_XMXvJTVQxxvUvs63wZfS_TvNLdqAfg@mail.gmail.com>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
 <20130828095706.GH4086@katana>
 <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
 <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
 <20130830054858.GR7656@atomide.com>
 <CAMj5BkiDExikXi3JcVhO7RN8_82eGYhq3i6oPf5Wbipy=N+iHQ@mail.gmail.com>
 <20130830082712.GT7656@atomide.com>
 <CAMj5BkgqBCh0316NmoP_XMXvJTVQxxvUvs63wZfS_TvNLdqAfg@mail.gmail.com>
Message-ID: <CAMj5Bki+BS=3sWCRdrDOEKpt6Bj+4vm0zKCJ4YBAudcqbAZySw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 9:12 AM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> On Fri, Aug 30, 2013 at 4:27 PM, Tony Lindgren <tony@atomide.com> wrote:
>> * zhangfei gao <zhangfei.gao@gmail.com> [130829 23:36]:
>>> What about concerns from Wolfram:
>>> " Other people might be
>>> depending on subsys_initcall to get I2C active before they want to
>>> activate, say, PMICs. So, I fear regressions, since deferred probing
>>> might not be available in the needed places to avoid these regressions."
>>
>> There should not be any reason to get a PMIC activated
>> early on. The system should be booting already at that point,
>> and the PMIC related init can be done later on.
>>
>>> Is it too late using module_init for PMIC?
>>
>> You can probably do it as a fix early on during the -rc
>> cycle too. Of course it needs to be verified to work first :)
>>
>
> Dear Wolfram
>
> What's your suggestion about this issue.
> Use subsys_initcall, deferred probing still exist if base on pin control driver.
>
> Thanks

Dear Wolfram

Any plan about the patch?

On one hand, module_X_driver is trend to replace subsys_initcall

Refer from Mark
"We're trying to move away from needing to do this and to using deferred
probing to resolve init ordering issues.  Should we not be able to
convert the drivers to module_X_driver()?"

On the other hand, subsys_initcall still been defered if pin
controller driver been relied on.

Thanks
