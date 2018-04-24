From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 24 Apr 2018 11:37:33 +0530
Subject: [PATCH 0/3] cpufreq: dt: Allow platforms to provide suspend/resume
 hooks
Message-ID: <cover.1524549644.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

This is in response to the patch[1] you sent.

I have updated the cpufreq-dt driver to allow platform specific
suspend/resume hooks and done some minor cleanup in the driver. I have
updated your patch and applied that on top of all this. I haven't tested
any of this and would need your help to get that done.

Thanks.

--
viresh

[1] https://lkml.kernel.org/r/20180421141943.25705-1-miquel.raynal at bootlin.com

Miquel Raynal (1):
  cpufreq: add suspend/resume support in Armada 37xx DVFS driver

Viresh Kumar (2):
  cpufreq: dt: Allow platform specific suspend/resume callbacks
  cpufreq: armada: Free resources on error paths

 drivers/cpufreq/armada-37xx-cpufreq.c | 107 +++++++++++++++++++++++++++++-----
 drivers/cpufreq/cpufreq-dt.c          |  10 +++-
 drivers/cpufreq/cpufreq-dt.h          |   5 ++
 3 files changed, 104 insertions(+), 18 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
