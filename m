From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 28 Oct 2016 18:11:51 +0800
Subject: [PATCH 0/3] ARM: dts: sun9i: Enable SDIO-based WiFi
Message-ID: <20161028101154.7350-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Now that we have support for both PMICs, we can turn on the
regulators needed for the onboard WiFi chips.

This is a fairly simple series. The WiFi chips themselves are
supported by the brcmfmac driver, but the user needs to get an
nvram.txt file and put it in their firmware directory, in
addition to the firmware file in linux-firmware. Otherwise we
just need to enable the mmc controller and supply the vmmc and
vqmmc regulators.


Regards
ChenYu

Chen-Yu Tsai (3):
  ARM: dts: sun9i: Add mmc1 pinmux setting
  ARM: dts: sun9i: a80-optimus: Enable AP6330 WiFi
  ARM: dts: sun9i: cubieboard4: Enable AP6330 WiFi

 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 32 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/sun9i-a80-optimus.dts     | 30 +++++++++++++++++++++++++++
 arch/arm/boot/dts/sun9i-a80.dtsi            |  8 ++++++++
 3 files changed, 70 insertions(+)

-- 
2.9.3
