From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 8 Aug 2013 06:44:37 -0400
Subject: [PATCH 4/5] clocksource: armada-370-xp: Fix device-tree binding
In-Reply-To: <1375919556-24104-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1375919556-24104-5-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130808104437.GE8204@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ devicetree ml

On Wed, Aug 07, 2013 at 08:52:35PM -0300, Ezequiel Garcia wrote:
> This commit fixes the DT binding for the Armada 370/XP SoC timer.
> The old "marvell,armada-370-xp-timer" compatible is marked deprecated and
> new compatible strings: "marvell,armada-xp-timer" and "marvell,armada-370-timer"
> are added instead.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../bindings/timer/marvell,armada-370-xp-timer.txt | 29 +++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
> index 3638112..d6aeb5b 100644
> --- a/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
> @@ -2,7 +2,9 @@ Marvell Armada 370 and Armada XP Timers
>  ---------------------------------------
>  
>  Required properties:
> -- compatible: Should be "marvell,armada-370-xp-timer"
> +- compatible: Should be either "marvell,armada-370-timer" or
> +  "marvell,armada-xp-timer" as appropriate.
> +  The older "marvell,armada-370-xp-timer" is DEPRECATED and shouldn't be used.
>  - interrupts: Should contain the list of Global Timer interrupts and
>    then local timer interrupts
>  - reg: Should contain location and length for timers register. First
> @@ -11,5 +13,26 @@ Required properties:
>  - clocks: clock driving the timer hardware
>  
>  Optional properties:
> -- marvell,timer-25Mhz: Tells whether the Global timer supports the 25
> -  Mhz fixed mode (available on Armada XP and not on Armada 370)
> +- marvell,timer-25Mhz [DEPRECATED]:
> +  Tells whether the Global timer supports the 25 Mhz fixed mode
> +  (available on Armada XP and not on Armada 370).
> +
> +Examples:
> +
> +- Armada 370:
> +
> +	timer {
> +		compatible = "marvell,armada-370-timer";
> +		reg = <0x20300 0x30>, <0x21040 0x30>;
> +		interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
> +		clocks = <&coreclk 2>;
> +	};
> +
> +- Armada XP:
> +
> +	timer {
> +		compatible = "marvell,armada-xp-timer";
> +		reg = <0x20300 0x30>, <0x21040 0x30>;
> +		interrupts = <37>, <38>, <39>, <40>, <5>, <6>;
> +		clocks = <&coreclk 2>;
> +	};
> -- 
> 1.8.1.5
> 
