From: pi-cheng.chen@linaro.org (Pi-Cheng Chen)
Date: Sun, 27 Dec 2015 14:21:55 +0800
Subject: [PATCH v2 0/3] ARM64: dts: cpufreq: mt8173: Migrate mt8173-cpufreq to
 use OPPv2 bindings
Message-ID: <1451197318-12418-1-git-send-email-pi-cheng.chen@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to migrate mt8173-cpufreq driver to use
operating-points-v2 bindings and add support for mt8173-cpufreq driver

v1->v2:
- update dev_pm_opp_of_get_sharing_cpus() to setup bitfield of original CPU
- rename OPP nodes in dts according to OPPv2 bindings in linux-next

Pi-Cheng Chen (3):
  PM/OPP: Don't skip cpu_dev->id when setting up cpumask
  cpufreq: mt8173: migrate to use operating-points-v2 bindings
  ARM64: dts: mt8173: Add CPU OPP, clock and regulator supply properties

 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90 +++++++++++++++++++++++++++++
 drivers/base/power/opp/cpu.c                |  4 --
 drivers/cpufreq/mt8173-cpufreq.c            | 17 ++++--
 4 files changed, 119 insertions(+), 10 deletions(-)

-- 
1.9.1
