From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 10 Dec 2012 16:25:37 +0100
Subject: [RESEND PATCH 0/5] cpufreq: db8500: Rename driver and update some
 parts
Message-ID: <1355153142-9534-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This patchset starts by renaming the db8500 cpufreq driver to a more generic
name. There are new variants which rely on it too, so instead we give it a
family name of dbx500.

On top of that a fixup patch for initialization of the driver and some minor
cleanup patches are included as well.

These patches can be material for 3.8.

Since some patches for the db8500 cpufreq driver has recently been merged
through Mike Turquette's clk tree, I decided to base these patches on top
of the clk-next branch. So I hope Mike is fine by merging these patches
through his tree.

So I will try to collect ACKs from Rafael for the cpufreq patches. The
mfd patch has already been ACKED by Samuel.

Jonas Aaberg (1):
  cpufreq: dbx500: Minor code cleanup

Lee Jones (3):
  cpufreq: Give driver used for dbx500 family a more generic name
  mfd: db8500: Update cpufreq device name
  cpufreq: dbx500: Update file header

Ulf Hansson (1):
  cpufreq: dbx500: Move clk_get to probe

 drivers/cpufreq/Makefile         |    2 +-
 drivers/cpufreq/db8500-cpufreq.c |  179 -------------------------------------
 drivers/cpufreq/dbx500-cpufreq.c |  180 ++++++++++++++++++++++++++++++++++++++
 drivers/mfd/db8500-prcmu.c       |    4 +-
 4 files changed, 183 insertions(+), 182 deletions(-)
 delete mode 100644 drivers/cpufreq/db8500-cpufreq.c
 create mode 100644 drivers/cpufreq/dbx500-cpufreq.c

-- 
1.7.10
