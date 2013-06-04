From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 3 Jun 2013 18:04:05 -0700
Subject: [PATCH] clocksource: armada-xp: always register local_timer_ops
In-Reply-To: <3039627.dHjlxm4JCV@wuerfel>
References: <3039627.dHjlxm4JCV@wuerfel>
Message-ID: <20130604010405.GJ599@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04, Arnd Bergmann wrote:
> The call to local_timer_register is hidden behind an #ifdef, which
> turns the armada_370_xp_local_timer_ops into a potentially unused
> variable, causing this warning:
> 
> time-armada-370-xp.c:208:31: warning: 'armada_370_xp_local_timer_ops' defined but not used [-Wunused-variable]
>  static struct local_timer_ops armada_370_xp_local_timer_ops __cpuinitdata = {
>                                ^
> 
> Since local_timer_register() itself doesn't do anything, just removing
> the #ifdef makes the code look nicer and gets rid of the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> ---
> 
> Please apply for 3.11
> 

This will conflict slightly with my series[1]. If this is targeted
for 3.11 it may be better to just drop this patch and let my
series remove the ops structure entirely.

[1] https://lkml.org/lkml/2013/6/3/583

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
