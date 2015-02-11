From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 11 Feb 2015 16:16:23 +0800
Subject: [PATCH 0/7] OPP: Introduce OPP bindings V2 and supporting code
Message-ID: <cover.1423642246.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that I have received an verbal Ack from Rob Herring (in a personal
conversation) about the bindings, I am showing how the code looks like with
these new bindings.

Some part is still now done:
- Interface for adding new detailed OPPs from platform code instead of DT
- Providing cpufreq helpers for the next OPPs
- Providing regulator helpers for the target/min/max ranges

Please provide feedback on how this looks like..

--
viresh

Viresh Kumar (7):
  OPP: Redefine bindings to overcome shortcomings
  opp: Relocate few routines
  OPP: Break _opp_add_dynamic() into smaller functions
  opp: Parse new (v2) bindings
  opp: convert device_opp->dev to a list of devices
  opp: Add helpers for initializing CPU opps
  cpufreq-dt: Use DT to set policy->cpus/related_cpus

 Documentation/devicetree/bindings/power/opp.txt |  407 ++++++++-
 drivers/base/power/opp.c                        | 1041 +++++++++++++++++------
 drivers/cpufreq/cpufreq-dt.c                    |   16 +-
 include/linux/pm_opp.h                          |   23 +
 4 files changed, 1232 insertions(+), 255 deletions(-)

-- 
2.3.0.rc0.44.ga94655d
