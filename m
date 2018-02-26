From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 26 Feb 2018 10:38:43 +0530
Subject: [PATCH 00/27] cpufreq: Stop validating cpufreq table in drivers
Message-ID: <cover.1519620578.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A patchset [1] sent last week already updated the cpufreq core to start
validating cpufreq table if the policy contains a valid
"policy->freq_table" pointer.

This series updates all such drivers to stop validating the cpufreq
table directly and let only the core handle it.

It depends on the previous series [1] and two cleanup patches [2][3] and
is rebased over 4.16-rc3.

It is already tested by the 0-day testing infrastructure and no issues
were reported.

--
viresh

[1] https://lkml.kernel.org/r/bd8c6133ad0bdd56c936802bcf26878d7cbdb679.1519279148.git.viresh.kumar at linaro.org
[2] https://lkml.kernel.org/r/77d470741dab32c2076a35253b9c0c2f0136583b.1519293292.git.viresh.kumar at linaro.org
[3] https://lkml.kernel.org/r/6b737a9c285840b4b2036fa51b692ee835664ec8.1519358505.git.viresh.kumar at linaro.org

Viresh Kumar (27):
  cpufreq: imx6q: Find max freq from frequency table itself
  cpufreq: Don't validate cpufreq table from cpufreq_generic_init()
  cpufreq: acpi: Don't validate the frequency table twice
  cpufreq: arm_big_little: Don't validate the frequency table twice
  cpufreq: blackfin: Don't validate the frequency table twice
  cpufreq: brcmstb: Don't validate the frequency table twice
  cpufreq: cpufreq-dt: Don't validate the frequency table twice
  cpufreq: e_powersaver: Don't validate the frequency table twice
  cpufreq: elanfreq: Don't validate the frequency table twice
  cpufreq: ia64-acpi: Don't validate the frequency table twice
  cpufreq: longhaul: Don't validate the frequency table twice
  cpufreq: mediatek: Don't validate the frequency table twice
  cpufreq: p4-clockmod: Don't validate the frequency table twice
  cpufreq: powernow: Don't validate the frequency table twice
  cpufreq: powerenv: Don't validate the frequency table twice
  cpufreq: ppc_cbe: Don't validate the frequency table twice
  cpufreq: pxa: Don't validate the frequency table twice
  cpufreq: qoirq: Don't validate the frequency table twice
  cpufreq: s3c24xx: Don't validate the frequency table twice
  cpufreq: sc520: Don't validate the frequency table twice
  cpufreq: scpi: Don't validate the frequency table twice
  cpufreq: sfi: Don't validate the frequency table twice
  cpufreq: sh: Don't validate the frequency table twice
  cpufreq: sparc: Don't validate the frequency table twice
  cpufreq: speedstep: Don't validate the frequency table twice
  cpufreq: tegra186: Don't validate the frequency table twice
  cpufreq: Drop cpufreq_table_validate_and_show()

 Documentation/cpu-freq/core.txt        | 12 +++++-------
 Documentation/cpu-freq/cpu-drivers.txt |  6 ++----
 drivers/cpufreq/acpi-cpufreq.c         | 20 +++++++++++---------
 drivers/cpufreq/arm_big_little.c       |  9 +--------
 drivers/cpufreq/blackfin-cpufreq.c     |  3 ++-
 drivers/cpufreq/brcmstb-avs-cpufreq.c  |  6 +-----
 drivers/cpufreq/cpufreq-dt.c           |  8 +-------
 drivers/cpufreq/cpufreq.c              |  9 +--------
 drivers/cpufreq/e_powersaver.c         |  8 +-------
 drivers/cpufreq/elanfreq.c             |  3 ++-
 drivers/cpufreq/freq_table.c           | 14 --------------
 drivers/cpufreq/ia64-acpi-cpufreq.c    |  7 +------
 drivers/cpufreq/imx6q-cpufreq.c        |  7 ++++---
 drivers/cpufreq/longhaul.c             |  3 ++-
 drivers/cpufreq/mediatek-cpufreq.c     | 11 +----------
 drivers/cpufreq/p4-clockmod.c          |  3 ++-
 drivers/cpufreq/powernow-k6.c          |  3 ++-
 drivers/cpufreq/powernow-k7.c          |  3 ++-
 drivers/cpufreq/powernow-k8.c          | 10 +---------
 drivers/cpufreq/powernv-cpufreq.c      | 11 +++--------
 drivers/cpufreq/ppc_cbe_cpufreq.c      |  5 ++---
 drivers/cpufreq/pxa2xx-cpufreq.c       |  4 ++--
 drivers/cpufreq/pxa3xx-cpufreq.c       |  4 +++-
 drivers/cpufreq/qoriq-cpufreq.c        | 13 ++-----------
 drivers/cpufreq/s3c24xx-cpufreq.c      |  5 +----
 drivers/cpufreq/sc520_freq.c           |  3 ++-
 drivers/cpufreq/scpi-cpufreq.c         | 10 +---------
 drivers/cpufreq/sfi-cpufreq.c          |  3 ++-
 drivers/cpufreq/sh-cpufreq.c           | 22 ++++++++++++----------
 drivers/cpufreq/sparc-us2e-cpufreq.c   |  3 ++-
 drivers/cpufreq/sparc-us3-cpufreq.c    |  3 ++-
 drivers/cpufreq/speedstep-centrino.c   |  4 ++--
 drivers/cpufreq/speedstep-ich.c        |  4 +++-
 drivers/cpufreq/speedstep-smi.c        |  4 +++-
 drivers/cpufreq/tegra186-cpufreq.c     |  2 +-
 include/linux/cpufreq.h                |  2 --
 36 files changed, 85 insertions(+), 162 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
