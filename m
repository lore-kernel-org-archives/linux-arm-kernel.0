From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 Aug 2013 10:09:35 -0400
Subject: [PATCH v2 5/6] clocksource: armada-370-xp: Fix device-tree binding
In-Reply-To: <1375961552-12967-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375961552-12967-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1375961552-12967-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130808140935.GG8204@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 08:32:31AM -0300, Ezequiel Garcia wrote:
> This commit fixes the DT binding for the Armada 370/XP SoC timer.
> The old "marvell,armada-370-xp-timer" compatible is marked deprecated and
> new compatible strings: "marvell,armada-xp-timer" and "marvell,armada-370-timer"
> are added instead.

I'd add a note in here explaining how this makes the property,
"marvell,timer-25MHz" unnecessary.

> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../bindings/timer/marvell,armada-370-xp-timer.txt | 29 +++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
> index 3638112..d6aeb5b 100644
> --- a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
...
> @@ -11,5 +13,26 @@ Required properties:
>  - clocks: clock driving the timer hardware
>  
>  Optional properties:
> -- marvell,timer-25Mhz: Tells whether the Global timer supports the 25
> -  Mhz fixed mode (available on Armada XP and not on Armada 370)
> +- marvell,timer-25Mhz [DEPRECATED]:
> +  Tells whether the Global timer supports the 25 Mhz fixed mode
> +  (available on Armada XP and not on Armada 370).

Are there any vendors shipping Armada platforms with DT support out of
the box?  If not, I'm inclined to just drop this, but I'll defer to the
DT maintainers opinion.

thx,

Jason.
