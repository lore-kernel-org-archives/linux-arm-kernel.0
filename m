From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue,  3 Apr 2018 15:37:37 +0530
Subject: [PATCH V2 0/2] cpufreq: Stop validating cpufreq table in drivers
Message-ID: <cover.1522749887.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Most of the patches from the previous series are already applied but we
didn't remove the cpufreq_table_validate_and_show() helper yet as the
scmi driver came from a different tree than PM.

These can be applied over 4.17-rc1 (that would come out after a week),
currently based off linux next.

Viresh Kumar (2):
  cpufreq: scmi: Don't validate the frequency table twice
  cpufreq: Drop cpufreq_table_validate_and_show()

 Documentation/cpu-freq/core.txt        | 12 +++++-------
 Documentation/cpu-freq/cpu-drivers.txt |  6 ++----
 drivers/cpufreq/freq_table.c           | 14 --------------
 drivers/cpufreq/scmi-cpufreq.c         | 10 +---------
 include/linux/cpufreq.h                |  2 --
 5 files changed, 8 insertions(+), 36 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
