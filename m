From: ayaka@soulik.info (Randy Li)
Date: Sun, 28 Aug 2016 19:21:05 +0800
Subject: [PATCH 0/4 v3] Add a new board TOPEET iTOP for exynos 4412
In-Reply-To: <CAL_JsqKY=VEZ+U11kY+XbMWuXhaFDr6GpnR3AXKd1U=9_=8fgA@mail.gmail.com>
References: <CAL_JsqKY=VEZ+U11kY+XbMWuXhaFDr6GpnR3AXKd1U=9_=8fgA@mail.gmail.com>
Message-ID: <1472383269-3126-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The added the audio codec seems work now, but the audio sounds
still a little different to the original. But I didn't hear the sound
in the Android, I don't know whether it is qualified.

Also it lacks of full pinctrl for the sleep state.

Changelog:
 - v3:
   - fixing the rtc clock, using clock source from PMIC
   - enable the tmu
   - enable the fimc for elite board
   - suuport the audio codec at elite board
   - fixing minor bugs in the last commit
 - v2:
   - removing rtc node
     the clock source driver is not done yet.
   - adding exynos-bus
   - fixing the MFC

Randy Li (4):
  ARM: dts: Add TOPEET itop core board SCP package version
  ARM: dts: add TOPEET itop elite based board
  ARM: dts: add fimc support in exynos4412 TOPEET iTop Elite board
  ARM: dts: samsung: add analog audio codec on TOPEET iTop 4412 Elite

 .../bindings/arm/samsung/samsung-boards.txt        |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos4412-itop-elite.dts        | 241 ++++++++++
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    | 489 +++++++++++++++++++++
 4 files changed, 734 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4412-itop-elite.dts
 create mode 100644 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi

-- 
2.7.4
