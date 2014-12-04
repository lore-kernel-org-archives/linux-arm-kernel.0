From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  4 Dec 2014 17:14:40 +0100
Subject: [PATCH v3 0/3] Add support for Tegra Activity Monitor
Message-ID: <1417709696-29281-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this v3 addresses the comments that the devfreq implementation got, namely:

* Address misc. style issues found by Thierry and Alexander
* Added helpers for register i/o
* Further documented the structs
* Enable the ACTMON after the IRQ handler has been installed
* Disable the ACTMON before removing the IRQ handler
* Add governor in a subsys initcall

There's an open question on whether some functionality currently in this
devfreq driver should be moved into the devfreq framework, but without knowing
of other SoC family that would benefit from it, I'm reticent. It would be
great to hear from the devfreq maintainers if they have any plans regarding
this, or if they have any suggestion.

These patches implement support for setting the rate of the EMC clock based on
stats collected from the ACTMON, a piece of hw in the Tegra124 that counts
memory accesses (among others).

It depends on the following in-flight patches:

* EMC driver: http://thread.gmane.org/gmane.linux.drivers.devicetree/99304
* CPUFreq driver: http://thread.gmane.org/gmane.linux.kernel/1812962

I have pushed a branch here for testing:

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=actmon-v3

Regards,

Tomeu

Tomeu Vizoso (3):
  of: Add binding for NVIDIA Tegra ACTMON node
  PM / devfreq: tegra: add devfreq driver for Tegra Activity Monitor
  ARM: tegra: Add Tegra124 ACTMON support

 .../devicetree/bindings/arm/tegra/actmon.txt       |  38 +
 arch/arm/boot/dts/tegra124.dtsi                    |  23 +
 drivers/devfreq/Kconfig                            |   9 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/tegra-actmon-devfreq.c             | 777 +++++++++++++++++++++
 5 files changed, 848 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/actmon.txt
 create mode 100644 drivers/devfreq/tegra-actmon-devfreq.c

-- 
1.9.3
