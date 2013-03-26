From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 26 Mar 2013 21:57:47 +0100
Subject: [PATCH] ARM: ux500: move PM-related PRCMU functions to machine
In-Reply-To: <1364312860-8179-1-git-send-email-linus.walleij@stericsson.com>
References: <1364312860-8179-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <51520BCB.4040401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 04:47 PM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> We are trying to decompose and decentralize the code in
> the DB8500 PRCMU out into subdrivers. The code moved in
> this patch concerns a group of functions used for
> decoupling and recoupling the IRQs from the GIC. During
> sleep and idle the Ux500 system will transfer all IRQ
> handling to the PRCMU using these functions.
> 
> Basically we are left with the two alternatives of code
> placement as:
> 
> - arch/arm/mach-ux500/pm.c - this because the code is
>   closely related to the GIC, and takes ownership of
>   some of the registers from the PRCMU related to this
>   PM functionality.
> 
> - drivers/mfd/db8500-prcmu-pm.c - because the code is
>   affecting stuff in the PRCMU register range. But then
>   this code needs to remap and handle GIC registers.
> 
> This patch implementation is taking the first approach.
> 
> Currently the cpuidle driver is the only piece of code
> using this set of functions, but it will later also be
> used by the suspend/resume code which is currently under
> review.
> 
> The header file is moved to:
> <linux/platform_data/arm-ux500-pm.h>
> The function prototypes need to be placed in a globally
> visible header since the CPUidle code is planned to move
> out to drivers/cpuidle.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rickard Andersson <rickard.andersson@stericsson.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> As things got silent in the last discussion thread I'm
> posting one solution to this dilemma. If you have better
> ideas, tell me.
> 
> Sam, I'm requesting an ACK for taking this through the
> ARM SoC tree.
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
