From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 28 Dec 2014 21:46:20 +0000
Subject: [PATCH] clocksource: =?UTF-8?Q?arch=5Ftimer=3A=20Fix=20arm=36?=
 =?UTF-8?Q?=34=20platforms=20not=20booting?=
In-Reply-To: <1419776431-26217-1-git-send-email-christoffer.dall@linaro.org>
References: <1419776431-26217-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <71346397bb3c0e654aa5b634328ae29c@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-12-28 14:20, Christoffer Dall wrote:
> Commit 0b46b8a718c6e ("clocksource: arch_timer: Fix code to...") 
> fixes
> timer issues with certain ARMv7 platforms, but unfortunately breaks
> arm64 platforms with hyp mode (EL2) enabled.
>
> The commit only sets arch_timer_use_virtual to false under 
> CONFIG_ARM,
> but forgets that the config variable is also set in other code paths
> (actually, right underneath the check in the patch) with detrimental
> consequences as we've now introduced a direct early call to BUG() on
> practically all arm64 platforms.
>
> One could argue that this code could be refactored to use different
> variables for checking which *timer* to use and which *counter* to 
> use,
> which seems to be the desired difference between ARM and arm64 in 
> this
> case, but this approach fixes an urgent issue for now.
>
> Cc: Sonny Rao <sonnyrao@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> This was apparently already discovered by Yingjoe Chen in this thread
> https://lkml.org/lkml/2014/11/24/41 and Catalin recommended a similar
> fix.

I'm increasingly worried about the time it takes to get such critical
fixes into the tree (arm64 is *dead* without it).

What is holding this patch which, as far as I remember, has been posted
by Catalin almost three weeks ago?

Daniel?

         M.
-- 
Fast, cheap, reliable. Pick two.
