From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Sep 2012 10:40:32 +0000
Subject: [PATCH V3 3/5] ARM: bcm2708: add system timer
In-Reply-To: <1347423509-30647-3-git-send-email-swarren@wwwdotorg.org>
References: <1347423509-30647-1-git-send-email-swarren@wwwdotorg.org>
 <1347423509-30647-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201209121040.32600.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 September 2012, Stephen Warren wrote:
> From: Simon Arlott <simon@fire.lp0.eu>
> 
> The System Timer peripheral provides four 32-bit timer channels and a
> single 64-bit free running counter. Each channel has an output compare
> register, which is compared against the 32 least significant bits of the
> free running counter values, and generates an interrupt.
> 
> Timer 3 is used as the Linux timer.
> 
> The BCM2708 also contains an SP804-based timer module. However, it
> apparently has significant differences from the standard SP804 IP block,
> and Broadcom's documentation recommends using the system timer instead.
> 
> This patch was extracted from git://github.com/lp0/linux.git branch
> rpi-split as of 2012/09/08, and modified as follows:
> 
> * Moved struct sys_timer bcm2708_timer into time.c to encapsulate it more.
> * Added DT binding docs.
> * Moved to drivers/clocksource/. This looks like the desired location for
>   such code now.
> * Simplified bcm2708_time_init() to find one matching node and operate on
>   it, rather than looping over all matching nodes. This seems more
>   consistent with other clocksource code.
> * Renamed struct bcm2708_timer.index to match_mask to better represent its
>   purpose.
> * s/printk(PR_INFO/pr_info(/
> 
> Signed-off-by: Chris Boot <bootc@bootc.net>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Dom Cobley <dc4@broadcom.com>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me, but I think the use of of_iomap() would be a good
simplification of the init function.

	Arnd
