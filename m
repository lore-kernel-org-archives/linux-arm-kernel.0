From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 10 Jul 2015 13:53:57 +0900
Subject: [PATCH v2 0/3] ARM: add UART and EHCI support for UniPhier DTS and
 enable them.
Message-ID: <1436504040-16375-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The basic support for UniPhier SoC family (arch/arm/mach-uniphier)
was mainlined at Linux 4.2-rc1.
I am now tackling some drivers to support them in the mainline.

I've got UART and EHCI done, so I'd like to enable them from
the ARM-SOC subsystem.


Changes in v2:
  - Add chip-specific compatible strings "socionext,uniphier-ehci"

Masahiro Yamada (3):
  ARM: multi_v7_defconfig: enable UniPhier UART driver
  ARM: dts: UniPhier: add on-chip UART device nodes
  ARM: dts: UniPhier: add USB EHCI device nodes

 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts  | 29 +++++++++++--
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     | 63 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts | 29 +++++++++++--
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    | 56 +++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts | 36 +++++++++++++++--
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi    | 61 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts | 33 +++++++++++++--
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    | 63 +++++++++++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig         |  1 +
 9 files changed, 359 insertions(+), 12 deletions(-)

-- 
1.9.1
