From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 14 Nov 2013 19:07:08 +0800
Subject: [PATCH 0/2] Add monaural audio support for fsl_ssi.c
Message-ID: <1384427230-979-1-git-send-email-b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches need to be applied into one single tree because
the second patch depends on the first one. Without it, SSI would playback
constant noise to the right channel when playback monaural audio files on
i.MX6 Series board.

We might also need to apply the iomux change to the other i.MX platforms,
just currently I don't have those boards so I drop their changes for now.

Nicolin Chen (2):
  ARM: dts: imx: specify the value of audmux pinctrl instead of
    0x80000000
  ASoC: fsl_ssi: Add monaural audio support for non-ac97 interface

 arch/arm/boot/dts/imx6qdl.dtsi | 22 +++++++++++-----------
 sound/soc/fsl/fsl_ssi.c        | 22 +++++++++++++++++++---
 2 files changed, 30 insertions(+), 14 deletions(-)

-- 
1.8.4
