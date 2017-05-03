From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Wed,  3 May 2017 15:56:15 +0200
Subject: [PATCH 0/2] ASoC: sunxi: Add ADC support for A33
Message-ID: <20170503135617.25193-1-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

This is a first version of a serie to add ADC support
for Sun8i-A33.
Based on asoc/for-next branch, last commit:
20d5c84bef067b7e804a163e2abca16c47125bad.

The first patch adds the support of ADC and microphones in the digital
part (driver sun8i-codec).
The second one adds the route between analog (sun8i-codec-analog) and
digital (sun8i-codec) parts to have a functional ADC route on Sun8i-A33
device tree.

Tested on Allwinner R16 Parrot board with microphone 1 (external) and
microphone 2 (headset).

I am not sure about the bias handling so if you have any comments on it,
do not hesitate.

Thank you in advance!

Best regards,

Myl?ne Josserand (2):
  ASoC: sun8i-codec: Add ADC support for a33
  ARM: dts: sun8i: Add ADC routing

 arch/arm/boot/dts/sun8i-a33.dtsi | 10 ++++-
 sound/soc/sunxi/sun8i-codec.c    | 80 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 3 deletions(-)

-- 
2.11.0
