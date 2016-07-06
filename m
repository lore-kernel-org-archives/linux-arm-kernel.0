From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 6 Jul 2016 14:41:38 +0800
Subject: [PATCH 0/3] arm: dts: berlin: enable all dw_wdt nodes unconditionally
Message-ID: <1467787301-3728-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we add watchdog dt nodes into berlin dtsi, the dw_wdt driver can't
support multiple variants, so we have to keep one enabled and others
disabled. After commit f29a72c24ad4 ("watchdog: dw_wdt: Convert to use
watchdog infrastructure"), the dw_wdt driver can support multiple
variants, so we can unconditionally enable all dw_wdt nodes now.

Jisheng Zhang (3):
  arm: dts: berlin2: enable all wdt nodes unconditionally
  arm: dts: berlin2q: enable all wdt nodes unconditionally
  arm64: dts: berlin4ct: enable all wdt nodes unconditionally

 arch/arm/boot/dts/berlin2.dtsi             | 2 --
 arch/arm/boot/dts/berlin2q.dtsi            | 2 --
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 2 --
 3 files changed, 6 deletions(-)

-- 
2.8.1
