From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 19 Aug 2013 13:27:38 -0300
Subject: [PATCH 0/4] Armada XP clocks for timer
Message-ID: <1376929658-9953-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the recent discussion on the device tree binding for the Armada 370/XP
clocksource driver, Stephen Warren, Tomasz Figa and others suggested
that the reference 25 MHz fixed-clock (aka refclk) should have a proper
device tree representation.

(Although that's still debatable, given the 25 MHz fixed-clock seems to be
used only by the timer/watchdog IP block.)

In addition to that and to be accurate, both timer clock inputs: nbclk and
refclk should be exposed in the DT node for the Armada XP timer.

Following an excellent suggestion from Sebastian Hesselbarth, here's a
patchset to accurately model the clock inputs for the timer.

Considering this is very minor improvemente from my previous patchset [1],
I dare ask about v3.12 inclusion. On the other side, maybe it's too late already
and it's best to keep it for v3.13.

Patches 1 and 2 apply on v3.11-rc4 plus the commit:
"ARM: mvebu: Fix the Armada 370/XP timer compatible strings"
that's already in mvebu/dt.

Patch 3 and 4 applies on tip/timers/core plus the recent series [1].

[1] http://comments.gmane.org/gmane.linux.ports.arm.kernel/260179

Ezequiel Garcia (4):
  ARM: mvebu: Add the reference 25 MHz fixed-clock to Armada XP
  ARM: mvebu: Add clock properties to Armada XP timer node
  clocksource: armada-370-xp: Get reference fixed-clock by name
  clocksource: armada-370-xp: Fix clock input in devicetree binding

 .../devicetree/bindings/timer/marvell,armada-370-xp-timer.txt |  5 +++--
 arch/arm/boot/dts/armada-xp.dtsi                              | 11 +++++++++++
 drivers/clocksource/time-armada-370-xp.c                      |  7 +++++--
 3 files changed, 19 insertions(+), 4 deletions(-)

-- 
1.8.1.5
