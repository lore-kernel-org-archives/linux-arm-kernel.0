From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Jan 2013 14:54:00 +0800
Subject: [PATCH 0/3] Add imx6q-cpufreq driver support
Message-ID: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic cpufreq-cpu0 driver works well for imx6q before.  But it
does not work for 1 GHz and 1.2 GHz operating points the series adds
here.  We ended up with having to add an imx6q specific cpufreq driver
to handle those special frequency and voltage scaling requirements for
the new operating points.

I expect patches #1 and #2 go via cpufreq tree and the #3 through
arm-soc tree.

Shawn Guo (3):
  PM / OPP: Export more symbols for module usage
  cpufreq: add imx6q-cpufreq driver
  ARM: imx: enable imx6q-cpufreq support

 arch/arm/boot/dts/imx6q.dtsi    |   19 ++-
 arch/arm/mach-imx/mach-imx6q.c  |   64 ++++++++
 drivers/base/power/opp.c        |    2 +
 drivers/cpufreq/Kconfig.arm     |    9 ++
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/imx6q-cpufreq.c |  325 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 414 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpufreq/imx6q-cpufreq.c

-- 
1.7.9.5
