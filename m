From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Thu,  9 Mar 2017 10:55:59 +0100
Subject: [PATCH v2 0/3] ASoC: sun8i-codec: Clean-up
Message-ID: <20170309095602.13809-1-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

Thanks to Chen-Yu's review [1], a first version of this patchset to
clean-up my sun8i A33 audio driver has been sent and merged.
One patch [2] needs a rework so this cover-letter is for its V2.

Changes with v1:
	- Remove patches 01, 02 and 03 as they are merged in asoc/for-next.
	- Added a patch to fix an error on an widget name
	- Split the patch 04 into two patches to separate the device tree
	modifications with the codec driver's one.

Patches tested on asoc/for-next branch, last commit: 698b3eb9af.

Patch 1: Fix a dapm routing error because of an unwanted space.
Patch 2: Convert SND_SOC_DAPM_DAC to SND_SOC_DAPM_AIF_IN definition.
The AIF interfaces are renamed to be more precise.
Patch 3: Update the audio-routing's device tree to use the AIF interfaces
renamed in patch 01.

After this series, amixer commands to test an audio file:
	amixer set 'Headphone' 75%
   	amixer set 'Headphone' on
	amixer set 'DAC' on
	amixer set 'AIF1 Slot 0 Digital DAC' on

[1] https://lkml.org/lkml/2017/2/7/103
[2] https://patchwork.kernel.org/patch/9566325/

Thank you in advance,
Best regards,

Myl?ne Josserand (3):
  ASoC: sun8i-codec: Fix space on audio-routing widget
  ASoC: sun8i-codec: Convert to use SND_SOC_DAPM_AIF_IN
  ARM: dts: sun8i: Update audio-routing with renamed widgets

 arch/arm/boot/dts/sun8i-a33.dtsi |  4 ++--
 sound/soc/sunxi/sun8i-codec.c    | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.11.0
