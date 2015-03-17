From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 17 Mar 2015 10:36:10 +0100
Subject: [PATCH v6 0/8] Add support for Tegra Activity Monitor
Message-ID: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

something happened during the last cycle and an old version of the devfreq
driver was merged.

This thread contains patches that bring it up to date to the last submitted
version and also incorporates the feedback that that version received, plus
some other small fixes and improvements that came up during rebase and
testing.

These patches implement support for setting the rate of the EMC clock based on
stats collected from the ACTMON, a piece of hw in the Tegra124 that counts
memory accesses (among others).

It depends on the following in-flight patches:

* EMC driver: http://thread.gmane.org/gmane.linux.kernel/1907035
* CPUFreq driver: http://thread.gmane.org/gmane.linux.kernel/1897078

I have pushed a branch here for testing:

http://cgit.collabora.com/git/user/tomeu/linux.git/log/?h=actmon-v6

Regards,

Tomeu

Tomeu Vizoso (8):
  of: Add binding for NVIDIA Tegra ACTMON node
  PM / devfreq: tegra: Update to v5 of the submitted patches
  clk: tegra: Have EMC clock implement determine_rate()
  PM / devfreq: tegra: Use clock rate constraints
  PM / devfreq: tegra: remove operating-points
  PM / devfreq: tegra: Set drvdata before enabling the irq
  PM / devfreq: tegra: Enable interrupts after resuming the devfreq
    monitor
  ARM: tegra: Add Tegra124 ACTMON support

 .../devicetree/bindings/arm/tegra/actmon.txt       |  28 ++
 arch/arm/boot/dts/tegra124.dtsi                    |  11 +
 drivers/clk/tegra/clk-emc.c                        |  19 +-
 drivers/devfreq/tegra-devfreq.c                    | 480 +++++++++++----------
 4 files changed, 316 insertions(+), 222 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/actmon.txt

-- 
2.1.0
