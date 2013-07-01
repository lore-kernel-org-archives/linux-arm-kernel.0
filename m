From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Jul 2013 16:16:07 +0800
Subject: [PATCH 0/4] Fix mxs audio regressions
Message-ID: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs audio got terribly broken during 3.11 development cycle due to
the following two commits.

  af8ee11 ASoC: sgtl5000: Fix driver probe after reset
  9e13f34 ASoC: sgtl5000: Let the codec acquire its clock

The series fixes the regressions and bring mxs audio back to work.

Mark,

Please consider to take the whole series as fixes through your tree
during 3.11-rc, so that we do not get a regression in the final v3.11
release.

Shawn

Shawn Guo (4):
  ASoC: sgtl5000: give it a ramping time before writting
  ASoC: sgtl5000: defer the probe if clock is not found
  ASoC: mxs: register saif mclk to clock framework
  ARM: mxs: saif0 is the clock provider to sgtl5000

 arch/arm/boot/dts/imx28-apx4devkit.dts |    2 +-
 arch/arm/boot/dts/imx28-evk.dts        |    2 +-
 arch/arm/boot/dts/imx28-m28evk.dts     |    2 +-
 arch/arm/boot/dts/imx28.dtsi           |    1 +
 sound/soc/codecs/sgtl5000.c            |   10 ++++++++-
 sound/soc/mxs/mxs-saif.c               |   35 ++++++++++++++++++++++++++++++++
 6 files changed, 48 insertions(+), 4 deletions(-)

-- 
1.7.9.5
