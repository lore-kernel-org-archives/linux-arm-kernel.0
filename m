From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 22 Oct 2015 10:47:28 +0200
Subject: cpufreq: i.MX6: -EPROBE_DEFER fixes
Message-ID: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6 cpufreq driver can't cope with -EPROBE_DEFER returned from
regulator_get/clk_get. This series fix that and some other small issues.

This series supersedes
[PATCH 1/2] cpufreq: imx: fix regulator_get error handling
[PATCH 2/2] cpufreq: imx: fix regulator_get_optional error handling
from Heiner Kallweit.

Sascha

----------------------------------------------------------------
Sascha Hauer (4):
      cpufreq: imx6q: Fix goto wrong error label
      cpufreq: imx6q: Fix wrong device in devm_kzalloc
      cpufreq: imx6q: Fix regulator/clock error handling
      cpufreq: imx6q: check regulator_get_optional return value

 drivers/cpufreq/imx6q-cpufreq.c | 182 +++++++++++++++++++++++++---------------
 1 file changed, 113 insertions(+), 69 deletions(-)
