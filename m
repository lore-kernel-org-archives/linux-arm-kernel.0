From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 03 Oct 2013 16:31:02 +0200
Subject: [PATCH 0/3] ARM: at91/tc/clocksource: various robustness
 improvements
In-Reply-To: <1380717265-6497-1-git-send-email-b.brezillon@overkiz.com>
References: <1380717265-6497-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <524D7FA6.9050402@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 02:34 PM, Boris BREZILLON wrote:
> Hello,
>
> This series include several improvements regarding the at91 tc clocksource
> driver:
>   - use clk_prepare/unprepare_enable/disable functions instead of the
>     clk_enable/disable functions to prepare the transition to the common clk
>     framework
>   - check several function return values instead of considering these functions
>     always suceed.
>   - remove the deprecated IRQF_DISABLED flag
>
> Best Regards,
>
> Boris
>
> Boris BREZILLON (3):
>    ARM: at91/tc/clocksource: replace clk_enable/disable with
>      clk_prepare_enable/disable_unprepare
>    ARM: at91/tc/clocksource: improve driver robustness
>    ARM: at91/tc/clocksource: remove IRQF_DISABLED
>
>   drivers/clocksource/tcb_clksrc.c |   61 +++++++++++++++++++++++++++++++-------
>   1 file changed, 50 insertions(+), 11 deletions(-)
>

Applied to my tree for 3.13 with the subsystem name and first letter 
capitalized fixed:

clocksource: tcb_clksrc: [A-Z]*

Thanks !
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
