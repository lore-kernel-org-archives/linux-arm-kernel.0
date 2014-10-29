From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 29 Oct 2014 15:50:10 +0100
Subject: [PATCH 0/3] Add support for Tegra Activity Monitor
Message-ID: <1414594232-15684-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

these patches implement support for setting the rate of the EMC clock based on
stats collected from the ACTMON, a piece of hw in the Tegra124 that counts
memory accesses (among others).

It depends on the following in-flight patches:

* MC driver: http://thread.gmane.org/gmane.linux.ports.tegra/19623
* EMC driver: http://thread.gmane.org/gmane.linux.ports.arm.kernel/365125
* CPUFreq driver: http://thread.gmane.org/gmane.linux.kernel/1812962

I have pushed a branch here for testing:

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=actmon

Regards,

Tomeu

Tomeu Vizoso (3):
  of: Add binding for NVIDIA Tegra ACTMON node
  soc/tegra: add support for Tegra Activity Monitor
  ARM: tegra: Add Tegra124 ACTMON support

 .../devicetree/bindings/arm/tegra/actmon.txt       |  26 +
 arch/arm/boot/dts/tegra124.dtsi                    |  11 +
 drivers/soc/tegra/Makefile                         |   1 +
 drivers/soc/tegra/actmon.c                         | 523 +++++++++++++++++++++
 4 files changed, 561 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/actmon.txt
 create mode 100644 drivers/soc/tegra/actmon.c

-- 
1.9.3
