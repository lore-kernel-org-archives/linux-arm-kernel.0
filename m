From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 12 Dec 2013 14:31:35 +0100
Subject: [PATCH 0/3] ARM: ux500: Fixup signal voltage regulator for SD card
Message-ID: <1386855098-14272-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SD card signal voltage regulator are configured from DT as a gpio regulator.
Some configurations were missing and some were wrong, so let's fix it.

Ulf Hansson (3):
  ARM: ux500: Refactor common DT configs for sdi[n] devices
  ARM: ux500: Configure regulator for I/O voltage for SD-card slot
  ARM: ux500: regulators: Remove dead code for SD-card regulator

 arch/arm/boot/dts/ste-href.dtsi               |    2 --
 arch/arm/boot/dts/ste-hrefprev60.dtsi         |    7 +++--
 arch/arm/boot/dts/ste-hrefv60plus.dtsi        |   40 ++-----------------------
 arch/arm/boot/dts/ste-snowball.dts            |    6 ++--
 arch/arm/mach-ux500/board-mop500-regulators.c |   14 ---------
 5 files changed, 10 insertions(+), 59 deletions(-)

-- 
1.7.9.5
