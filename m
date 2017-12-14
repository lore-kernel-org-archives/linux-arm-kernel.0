From: chris.paterson2@renesas.com (Chris Paterson)
Date: Thu, 14 Dec 2017 09:08:38 +0000
Subject: [PATCH 0/3] Correct R-Car Gen2 critical CPU temperature
Message-ID: <1513242521-11236-1-git-send-email-chris.paterson2@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current R-Car Gen2 device trees define the CPU critical
temperature as 115?C.

The R-Car hardware manuals state that Tc = ?40?C to +105?C. The
thermal sensor has an accuracy of ?5?C and there can be a temperature
difference of 1 or 2 degrees between Tjmax and the thermal sensor due
to the location of the latter.

This means that 95?C is a safer value to use.

This value should also apply to r8a7792 but thermal sensor support has
not been added yet.

Chris Paterson (3):
  ARM: dts: r8a7790: Correct critical CPU temperature
  ARM: dts: r8a7791: Correct critical CPU temperature
  ARM: dts: r8a7793: Correct critical CPU temperature

 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 arch/arm/boot/dts/r8a7793.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1
