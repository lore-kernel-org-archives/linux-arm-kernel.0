From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri, 10 Feb 2017 10:41:29 +0100
Subject: [PATCH 0/4] ASoC: sun8i-codec: Clean-up
Message-ID: <20170210094133.11382-1-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Thanks to Chen-Yu's review [1], here are some patches to clean-up
my sun8i A33 audio driver.

Patches tested on asoc/for-next branch with additionnal patches
to apply before:
https://patchwork.kernel.org/patch/9447631/
https://patchwork.kernel.org/patch/9423999/
https://patchwork.kernel.org/patch/9521121/
https://www.spinics.net/lists/arm-kernel/msg560091.html

Patch 1: Removes the HP widget which is available in the analog part.

Patch 2: Update the driver to use SOC_DAPM_DOUBLE and rename the
controls accordingly.

Patch 3: Convert SND_SOC_DAPM_MIXER to SOC_MIXER_ARRAY.

Patch 3: Convert SND_SOC_DAPM_DAC to SND_SOC_DAPM_AIF_IN definition.

The last Chen Yu's comments are still in progress (ie use of
set_pll and set_sysclk and reworking the audio route).

After this series, amixer commands to test an audio file:
	amixer set 'Headphone' 75%
	amixer set 'Headphone' on
	amixer set 'DAC' on
	amixer set 'AIF1 Slot 0 Digital DAC' on

[1] https://lkml.org/lkml/2017/2/7/103

Thank you in advance,
Best regards,

Myl?ne Josserand (4):
  ASoC: sun8i-codec: Remove analog "HP" widget
  ASoC: sun8i-codec: Update mixer to use SOC_DAPM_DOUBLE
  ASoC: sun8i-codec: Convert to SOC_MIXER_ARRAY
  ASoC: sun8i-codec: Convert to use SND_SOC_DAPM_AIF_IN

 arch/arm/boot/dts/sun8i-a33.dtsi |  4 +--
 sound/soc/sunxi/sun8i-codec.c    | 65 +++++++++++++++++-----------------------
 2 files changed, 30 insertions(+), 39 deletions(-)

-- 
2.11.0
