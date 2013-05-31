From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 31 May 2013 11:10:01 +0800
Subject: [PATCH 0/2] ARM: dts: add watchdog device tree node in at91 dts files
In-Reply-To: <1369969744-3428-1-git-send-email-wenyou.yang@atmel.com>
References: <1369969744-3428-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1369969802-7840-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The patches is to add watchdog device tree node for at91 SoC and board dts files.

Since the watchdog is disabled in the at91bootstrap with default configuration,
if you want to use the watchdog in the kernel, you must make sure the watchdog
doesn't be disabled in the at91bootstrap.

It is tested on at91sam9g20ek, at91sam9263ek, at91sam9g25ek
using Documentation/watchdog/src/watchdog-simple.c.

It is based on v3.10-rc3, tested on linux-watchdog git tree as well.

Best Regards,
Wenyou Yang

Wenyou Yang (2):
  ARM: dts: add the watchdog nodes for at91 SoC
  ARM: dts: add the watchdog nodes for at91 boards

 arch/arm/boot/dts/at91sam9263ek.dts         |    4 ++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |    4 ++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |    4 ++++
 arch/arm/boot/dts/at91sam9n12.dtsi          |    6 ++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |    4 ++++
 arch/arm/boot/dts/at91sam9x5.dtsi           |    6 ++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |    4 ++++
 7 files changed, 32 insertions(+)

-- 
1.7.9.5
