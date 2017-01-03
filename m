From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue,  3 Jan 2017 12:22:45 +0100
Subject: [PATCH 0/2] ARM: dts: boundary: fix sgtl5000 pinctrl init
Message-ID: <20170103112247.4563-1-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn, all,

While testing other features, I realized that the sound card wouldn't
probe on Nitrogen6_MAX. This is because the pinctrl node was under the
sound driver node whereas it should be under the codec one.

This caused GPIO_0 not to be set as CLKO1 and therefore the codec probing
was failing. The pinctrl node is just moved around to fix it.

Also making the same patch for our SOM2 although it was working, the
reason is that U-Boot is setting GPIO_0 in U-Boot for SOM2 and not MAX.

Regards,
Gary

Gary Bisson (2):
  ARM: dts: imx6qdl-nitrogen6_max: fix sgtl5000 pinctrl init
  ARM: dts: imx6qdl-nitrogen6_som2: fix sgtl5000 pinctrl init

 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi  | 4 ++--
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.11.0
