From: robh@kernel.org (Rob Herring)
Date: Wed, 30 Nov 2016 15:30:06 -0600
Subject: [PATCH] dt-bindings: document how to setup rockchip timers as
 clocksource
In-Reply-To: <1480025536-6837-1-git-send-email-al.kochet@gmail.com>
References: <1480025536-6837-1-git-send-email-al.kochet@gmail.com>
Message-ID: <20161130213006.p6totahjga7546s6@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 01:12:16AM +0300, Alexander Kochetkov wrote:
> The patch describes how to setup rockchip timers in device tree
> so they can be used as clocksource.
> 
> I'm going to implement this feature.
> 
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  .../bindings/timer/rockchip,rk-timer.txt           |   35 +++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
> index 7bc9691..15f8fed 100644
> --- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
> @@ -16,7 +16,18 @@ Required properties:
>  - clock-names : must include the following entries:
>    "timer", "pclk"
>  
> -Example:
> +Note:
> +If device tree contain only one timer, than the timer will be intialized
> +as clockevent provider. If device tree contain two timers, than first timer
> +will be initialized as clockevent provider and second one as clocksource.

1st and 2nd are ambiguous. Plus this is an OS implementation detail that 
doesn't belong in the binding.

> +If you want to bind specific timer as clockevent (i.e. one from alive subsystem)
> +and specific timer as clocksource, you can number the timers in "aliases" node.

No. 

Use and/or describe what are the features of a timer to make the 
decision. There has to be some reason you care which one. One has an 
interrupt and the other doesn't. One is always on. Etc.

Rob
