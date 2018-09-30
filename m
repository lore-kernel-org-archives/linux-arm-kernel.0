From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun, 30 Sep 2018 11:32:25 +0800
Subject: [PATCH V3 0/3] Add i.MX6ULZ SoC support
Message-ID: <1538278348-7716-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds i.MX6ULZ SoC support, i.MX6ULZ is a new SoC of
i.MX6 family, compared to i.MX6ULL, it removes below modules:

    - UART5/UART6/UART7/UART8;
    - PWM5/PWM6/PWM7/PWM8;
    - eCSPI3/eCSPI4;
    - CAN1/CAN2;
    - FEC1/FEC2;
    - I2C3/I2C4;
    - EPIT2;
    - LCDIF;
    - GPT2;
    - TSC;

And i.MX6ULZ has same soc_id as i.MX6ULL, but SRC_SBMR2 bit[6] is
to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means i.MX6ULZ and
1'b0 means i.MX6ULL. i.MX6ULZ reuse most of i.MX6UL/i.MX6ULL code,
just add the new CPU type and remove those non-exist modules from dtb.

Anson Huang (3):
  ARM: imx: add i.mx6ulz msl support
  dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
  ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support

 Documentation/devicetree/bindings/arm/fsl.txt |  4 +++
 arch/arm/boot/dts/Makefile                    |  3 ++-
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts       | 20 ++++++++++++++
 arch/arm/boot/dts/imx6ulz.dtsi                | 38 +++++++++++++++++++++++++++
 arch/arm/mach-imx/anatop.c                    | 20 ++++++++++++++
 arch/arm/mach-imx/cpu.c                       |  3 +++
 arch/arm/mach-imx/mxc.h                       |  7 +++++
 arch/arm/mach-imx/pm-imx6.c                   |  4 +--
 8 files changed, 96 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz.dtsi

-- 
2.7.4
