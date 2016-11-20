From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 20 Nov 2016 21:24:50 +0200
Subject: [RFT v2 0/5] ASoC: samsung: Minor cleanup for old machines
Message-ID: <1479669895-19124-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,


Few patches removing dead code (machines not supported).


Changes since v1:
1. Squash two smdk_wm8580 changes into patch #2.  Now num_dai_links
   is always equal to two, so remove also SEC_PLAYBACK dai_link.
   (suggested by Lars-Peter Clausen).


The second patch ([RFT v2 2/5] ASoC: samsung: smdk_wm8580: Remove old platforms and
drop mach-types usage) requires testing. I hope I understood the code
correctly.

The last ARM patch is independent. I will take it through samsung-soc
tree. I put it here for reference.


Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  ASoC: samsung: Remove non-existing MACH dependencies
  ASoC: samsung: smdk_wm8580: Remove old platforms and drop mach-types
    usage
  ASoC: samsung: Enable COMPILE_TEST for SmartQ and WM8580
  ASoC: samsung: Enable COMPILE_TEST for entire Samsung ASoc
  ARM: s5pv210_defconfig: Remove old MACHs

 arch/arm/configs/s5pv210_defconfig |  4 ----
 sound/soc/samsung/Kconfig          |  8 +++++---
 sound/soc/samsung/smdk_wm8580.c    | 28 ++--------------------------
 3 files changed, 7 insertions(+), 33 deletions(-)

-- 
2.7.4
