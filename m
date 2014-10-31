From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 31 Oct 2014 14:07:35 +0100
Subject: [PATCH v2 0/4] Make Armada 375 use the reference clock when
 possible
In-Reply-To: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141031140735.76d46212@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Sat, 25 Oct 2014 11:48:38 -0300, Ezequiel Garcia wrote:

> Ezequiel Garcia (4):
>   clocksource: armada-370-xp: Add missing clock enable
>   watchdog: orion: Use the reference clock on Armada 375 SoC
>   clocksource: armada-370-xp: Use the reference clock on A375 SoC
>   ARM: mvebu: Enable the reference clock for timer and watchdog on
>     Armada 375 SoC
> 
>  .../bindings/timer/marvell,armada-370-xp-timer.txt |  9 +++--
>  .../devicetree/bindings/watchdog/marvel.txt        | 13 +++++++
>  arch/arm/boot/dts/armada-375.dtsi                  | 12 +++++--
>  drivers/clocksource/time-armada-370-xp.c           | 30 ++++++++++++++++
>  drivers/watchdog/orion_wdt.c                       | 40 +++++++++++++++++++++-
>  5 files changed, 98 insertions(+), 6 deletions(-)

For the entire series:

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I've tested on an Armada 375 A0 platform. Before this series, due to
the SSCG, I had a lot of drift in the system time. With this series,
the platform now uses the 25 Mhz timer not affected by the SSCG, and
I'm no longer experiencing any drift.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
