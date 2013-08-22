From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 22 Aug 2013 10:07:26 +0200
Subject: [PATCH v3 0/5] Armada XP clocks for timer
In-Reply-To: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <5215C6BE.3040301@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/2013 17:45, Ezequiel Garcia wrote:
> After the recent discussion on the device tree binding for the Armada 370/XP
> clocksource driver, Stephen Warren, Tomasz Figa and others suggested
> that the reference 25 MHz fixed-clock (aka refclk) should have a proper
> device tree representation.
> 
> (Although that's still debatable, given the 25 MHz fixed-clock seems to be
> used only by the timer/watchdog IP block.)
> 
> In addition to that and to be accurate, both timer clock inputs: nbclk and
> refclk should be exposed in the DT node for the Armada XP timer.
> 
> Following an excellent suggestion from Sebastian Hesselbarth, here's a
> patchset to accurately model the clock inputs for the timer.
> 
> Considering this is very minor improvemente from my previous patchset [1],
> I dare ask about v3.12 inclusion. On the other side, maybe it's too late already
> and it's best to keep it for v3.13.
> 
> Patches 1 and 2 apply on v3.11-rc4 plus the commit:
> "ARM: mvebu: Fix the Armada 370/XP timer compatible strings"
> that's already in mvebu/dt.
> 
> Patch 3, 4 and 5 applies on tip/timers/core plus the recent series [1].
> 
> [1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/260179
> 
> Changes from v2:
> 
>   * Replace WARN_ON with BUG_ON. As noted in the patch, it's wrong
>     to only WARN() as the kernel cannot keep going without a working timer.
> 
> Changes from v1:
> 
>   * Improve the devicetree binding as the requirements were very
>     badly stated.
> 
> Ezequiel Garcia (5):
>   ARM: mvebu: Add the reference 25 MHz fixed-clock to Armada XP
>   ARM: mvebu: Add clock properties to Armada XP timer node
>   clocksource: armada-370-xp: Replace WARN_ON with BUG_ON
>   clocksource: armada-370-xp: Get reference fixed-clock by name
>   clocksource: armada-370-xp: Add detailed clock requirements in
>     devicetree binding

For the whole series you can add my

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

> 
>  .../bindings/timer/marvell,armada-370-xp-timer.txt          | 13 +++++++++++--
>  arch/arm/boot/dts/armada-xp.dtsi                            | 11 +++++++++++
>  drivers/clocksource/time-armada-370-xp.c                    |  9 ++++++---
>  3 files changed, 28 insertions(+), 5 deletions(-)
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
