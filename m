From: peter.chen@nxp.com (Peter Chen)
Date: Fri, 1 Jul 2016 17:41:54 +0800
Subject: [PATCH 0/7] add missing of_node_put after calling of_parse_phandle
 (1st)
Message-ID: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using, but there are many codes
do not follow that, this patch set fixes some of them.

Peter Chen (7):
  extcon: add missing of_node_put after calling of_parse_phandle
  arm: mach-shmobile: pm-rmobile: add missing of_node_put after calling
    of_parse_phandle
  arm: mach-u300: regulator: add missing of_node_put after calling
    of_parse_phandle
  bus: arm-cci: add missing of_node_put after calling of_parse_phandle
  bus: vexpress-config: add missing of_node_put after calling
    of_parse_phandle
  devfreq: add missing of_node_put after calling of_parse_phandle
  devfreq: exynos-bus: add missing of_node_put after calling
    of_parse_phandle

 arch/arm/mach-shmobile/pm-rmobile.c |  1 +
 arch/arm/mach-u300/regulator.c      | 12 +++++++++---
 drivers/bus/arm-cci.c               |  5 ++++-
 drivers/bus/vexpress-config.c       |  1 +
 drivers/devfreq/devfreq.c           |  2 ++
 drivers/devfreq/exynos-bus.c        |  9 ++++++---
 drivers/extcon/extcon.c             |  2 ++
 7 files changed, 25 insertions(+), 7 deletions(-)

-- 
1.9.1
