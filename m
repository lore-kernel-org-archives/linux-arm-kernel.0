From: andrew@ncrmnt.org (Andrew Andrianov)
Date: Tue, 30 Jun 2015 18:15:02 +0300
Subject: [PATCH v2 0/5] [New SoC] Add support for RC Module's K1879XB1YA
In-Reply-To: <CAL_JsqKTUM8-ufR8gGJBsNtbc94LyS7o-7v=R2Fit3+0=-SofA@mail.gmail.com>
Message-ID: <1435677307-6526-1-git-send-email-andrew@ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob, Russel, thanks for your reviews, I'm now sending in the fixed patchset. 
Everything's now ARCH_MULTI_V6-friendly, the config is updated as well. 

Since I got no feedback on how to properly implement that i2c workaround it 
remains as is, I only rewrote the code to take the fixup-id and adresses from 
devicetree instead.

The only alternative to this workaround I see - would be implementing a 
'proxy' irqchip that will take care of clearing the relevant bits. But it 
looks way more messy. I'm open to suggestions here.

The patchset has been tested to compile and boot against v4.1 tag  

Andrew Andrianov (5):
  ARM: rcm-k1879xb1: Add support for K1879XB1 SoC
  of: Add vendor prefix for RC Module
  ARM: dts: rcm-k1879xb1: Add dts files for K1879XB1YA
  ARM: Add defconfig for RC Module K1879XB1YA SoC
  cpuidle: ARM: Add cpuidle driver for K1879XB1YA

 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Kconfig.debug                             |    3 +-
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/rcm-k1879xb1-mb7707.dts          |  146 ++
 arch/arm/boot/dts/rcm-k1879xb1.dtsi                |  518 ++++
 arch/arm/configs/rcm_k1879xb1ya_defconfig          | 2678 ++++++++++++++++++++
 arch/arm/mach-rcm-k1879xb1/Kconfig                 |   10 +
 arch/arm/mach-rcm-k1879xb1/Makefile                |    2 +
 arch/arm/mach-rcm-k1879xb1/board-dt.c              |  146 ++
 arch/arm/mach-rcm-k1879xb1/hardware.h              |   48 +
 drivers/cpuidle/Kconfig.arm                        |    6 +
 drivers/cpuidle/Makefile                           |    1 +
 drivers/cpuidle/cpuidle-rcm-k1879xb1.c             |   48 +
 15 files changed, 3610 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rcm-k1879xb1-mb7707.dts
 create mode 100644 arch/arm/boot/dts/rcm-k1879xb1.dtsi
 create mode 100644 arch/arm/configs/rcm_k1879xb1ya_defconfig
 create mode 100644 arch/arm/mach-rcm-k1879xb1/Kconfig
 create mode 100644 arch/arm/mach-rcm-k1879xb1/Makefile
 create mode 100644 arch/arm/mach-rcm-k1879xb1/board-dt.c
 create mode 100644 arch/arm/mach-rcm-k1879xb1/hardware.h
 create mode 100644 drivers/cpuidle/cpuidle-rcm-k1879xb1.c

-- 
2.1.4
