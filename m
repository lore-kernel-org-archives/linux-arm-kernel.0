From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 16:34:21 +0800
Subject: [PATCH v2 0/2] Add imx6q-cpufreq driver support
Message-ID: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 - Drop patch "PM / OPP: Export more symbols for module usage", as
   there is already one "[PATCH 5/6 v9] power: export opp cpufreq
   functions" from Mark Langsdorf.
 - Instead of having cpu_dev be the struct device retrieved from
   get_cpu_device(), have it be &pdev->dev, so that we can use managed
   functions to simplified the cleanup path.
 - Use dev_* rather than pr_* for message output
 - Fix Typos and others commented by Viresh and Sascha. 

Once the first patch gets accepted, I will apply the second one for
going through arm-soc tree.

Shawn Guo (2):
  cpufreq: add imx6q-cpufreq driver
  ARM: imx: enable imx6q-cpufreq support

 arch/arm/boot/dts/imx6q.dtsi    |   19 ++-
 arch/arm/mach-imx/mach-imx6q.c  |   65 +++++++++
 drivers/cpufreq/Kconfig.arm     |    9 ++
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/imx6q-cpufreq.c |  296 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 384 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpufreq/imx6q-cpufreq.c

-- 
1.7.9.5
