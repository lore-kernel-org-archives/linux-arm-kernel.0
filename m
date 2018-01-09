From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue,  9 Jan 2018 16:49:26 +0000
Subject: [PATCH 0/2] drivers: remove incorrect usage/dependency on
 topology_physical_package_id
Message-ID: <1515516568-31359-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

There has been ongoing attempt to add ACPI topology support on ARM/ARM64
platform using PPTT. However it was discovered that the physical package
id is mapped to the so called clusters on ARM platforms and they don't
map to the physical socket as in other architectures.

In order to add the correct support for the well defined physical sockets,
we need to find remove the incorrect usage or any dependency on
topology_physical_package_id which currently maps to the clusters.

There's still one pending user of topology_physical_package_id, which is
arm_big_little driver which is used by bL switcher and by TC2 platform.
I would like to get some feedback on how to remove that dependency ?
Can we hard-code the cluster values ? Any other suggestions ?

Sudeep Holla (2):
  drivers: psci: remove cluster terminology and dependency on
    physical_package_id
  cpufreq: scpi: remove arm_big_little dependency

 drivers/cpufreq/scpi-cpufreq.c  | 193 ++++++++++++++++++++++++++++++++++++----
 drivers/firmware/psci_checker.c |  46 +++++-----
 2 files changed, 200 insertions(+), 39 deletions(-)

--
2.7.4
