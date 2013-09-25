From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Sep 2013 23:19:04 +0200
Subject: [PATCH] clocksource: em_sti: Set cpu_possible_mask to fix SMP
 broadcast
In-Reply-To: <1379534476-10901-2-git-send-email-horms+renesas@verge.net.au>
References: <1379534476-10901-1-git-send-email-horms+renesas@verge.net.au>
 <1379534476-10901-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <52435348.30008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 10:01 PM, Simon Horman wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the STI driver by setting cpu_possible_mask to make EMEV2
> SMP work as expected together with the ARM broadcast timer.
> 
> This breakage was introduced by:
> 
> f7db706 ARM: 7674/1: smp: Avoid dummy clockevent being preferred over real hardware clock-event
> 
> Without this fix SMP operation is broken on EMEV2 since no
> broadcast timer interrupts trigger on the secondary CPU cores.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Tested-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---

Thanks ! Applied to my tree as 3.12 fix.

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
