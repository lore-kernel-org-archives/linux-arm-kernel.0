From: wei@redhat.com (Wei Huang)
Date: Mon, 21 Nov 2016 14:24:52 -0600
Subject: [kvm-unit-tests PATCH v10 0/3] ARM PMU tests
Message-ID: <1479759895-10042-1-git-send-email-wei@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v9:
* Move PMCCNTR related configuration from pmu_init() to sub-tests
* Change the name of loop test function to precise_cycles_loop()
* Print out error detail for each test case in check_cpi()
* Fix cpi convertion from argv
* Change the loop calculation in measure_instrs() after cpi is fixed

Note:
1) Current KVM code has bugs in handling PMCCFILTR write. A fix (see
below) is required for this unit testing code to work correctly under
KVM mode.
https://lists.cs.columbia.edu/pipermail/kvmarm/2016-November/022134.html.

Thanks,
-Wei

Christopher Covington (3):
  arm: Add PMU test
  arm: pmu: Check cycle count increases
  arm: pmu: Add CPI checking

 arm/Makefile.common |   3 +-
 arm/pmu.c           | 347 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg   |  19 +++
 3 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 arm/pmu.c

-- 
1.8.3.1
