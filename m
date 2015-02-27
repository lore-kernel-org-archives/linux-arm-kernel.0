From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 27 Feb 2015 23:18:46 +0100
Subject: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
In-Reply-To: <54F0A04F.20706@linaro.org>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com>
 <4892716.Bf612zPN6E@vostro.rjw.lan> <54F0A04F.20706@linaro.org>
Message-ID: <1559887.83x0eLBBFx@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 27, 2015 05:50:23 PM Daniel Lezcano wrote:
> On 02/26/2015 10:55 PM, Rafael J. Wysocki wrote:
> > On Thursday, February 26, 2015 06:20:48 PM Gregory CLEMENT wrote:
> >> As stated in kernel/cpu_pm.c, "Platform is responsible for ensuring
> >> that cpu_pm_enter is not called twice on the same CPU before
> >> cpu_pm_exit is called.". In the current code in case of failure when
> >> calling mvebu_v7_cpu_suspend, the function cpu_pm_exit() is never
> >> called whereas cpu_pm_enter() was called just before.
> >>
> >> This patch moves the cpu_pm_exit() in order to balance the
> >> cpu_pm_enter() calls.
> >>
> >> Reported-by: Fulvio Benini <fbf@libero.it>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >
> > Should that go to "stable" too?  Which "stable" series it should go to if so?
> 
> Hi Rafael,
> 
> do you mind if I take this fix in my tree ?

Not at all, please go ahead.

> There is the same issue for cpuidle-arm64.c I fixed.

OK


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
