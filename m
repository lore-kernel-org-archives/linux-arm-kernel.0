From: drake@endlessm.com (Daniel Drake)
Date: Tue, 14 Oct 2014 16:37:51 -0600
Subject: [PATCH 3.17-rc4 v7 0/6] arm: Implement
 arch_trigger_all_cpu_backtrace
In-Reply-To: <1410970218-28847-1-git-send-email-daniel.thompson@linaro.org>
References: <1410970218-28847-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <CAD8Lp44gPOBh_q1zDy3y1GkrRVAvix5YaNr-+E92+g8Q7fLKJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks a lot for working on this!

On Wed, Sep 17, 2014 at 10:10 AM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> Changes *before* v1:
>
> * This patchset is a hugely cut-down successor to "[PATCH v11 00/19]
>   arm: KGDB NMI/FIQ support". Thanks to Thomas Gleixner for suggesting
>   the new structure. For historic details see:
>         https://lkml.org/lkml/2014/9/2/227

What's the right way to extend your work in order to get a NMI-like
watchdog hard lockup detector similar to the one on x86?

I'm testing your patches on Exynos4412 and I guess in their current
state they don't go quite this deep, as the only callers of
trigger_all_cpu_backtrace() are sysrq, hung_task and spinlock debug
code - none of which seem as fail-safe as a trigger like a
pre-programmed watchdog NMI interrupt would be.

Do I need to find a way to get CONFIG_FIQ available on this platform
first? and/or CONFIG_HARDLOCKUP_DETECTOR?

Thanks
Daniel
