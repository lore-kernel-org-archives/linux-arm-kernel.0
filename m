From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Wed, 13 Dec 2017 13:34:06 +0100
Subject: [PATCH 0/2] sunxi: Add Capture support for sun8i-a33
Message-ID: <20171213123408.10422-1-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

Here is a first series to add support for the capture for
Allwinner Sun8I-A33 SoC (sun8i-codec).
These patches have been tested on Sun8i-r16 parrot board and
the two microphones are working well.

Noticed that the DAPM route is not correct: "Right/Left Digital
ADC Mixer" widgets should be after the "Right ADC" (according to what I
understood from the datasheet). This is currently not the case but when
I tried to update it, I got an error about "failing to add routes".
I will investigate why in next weeks (and send a V2) but as it
can take time, I think it is better to send a V1 and got reviews
(because it is the first time I am implementing such features).

Thank you in advance,
Best regards,
Myl?ne

Myl?ne Josserand (2):
  ASoC: sun8i-codec: Add ADC support for a33
  ARM: dts: sun8i: Add ADC routing

 arch/arm/boot/dts/sun8i-a33.dtsi | 10 ++++-
 sound/soc/sunxi/sun8i-codec.c    | 82 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 3 deletions(-)

-- 
2.11.0
