From: wei@redhat.com (Wei Huang)
Date: Fri, 18 Nov 2016 22:15:39 -0600
Subject: [kvm-unit-tests PATCH v9 0/3] ARM PMU tests
Message-ID: <1479528942-21866-1-git-send-email-wei@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v8:
* Probe PMU version based on ID_DFR0
* pmccntr_read() now returns 64bit and can handle both 32bit and 64bit
  PMCCNTR based on PMU version.
* Add pmccntr_write() support
* Use a common printf format PRId64 to support 64bit variable smoothly in
  test functions
* Add barriers to several PMU write functions
* Verfied on different execution modes

Note:
1) Current KVM code has bugs in handling PMCCFILTR write. A fix (see
below) is required for this unit testing code to work correctly under
KVM mode.
https://lists.cs.columbia.edu/pipermail/kvmarm/2016-November/022134.html.

Thanks,
-Wei

Wei Huang (3):
  arm: Add PMU test
  arm: pmu: Check cycle count increases
  arm: pmu: Add CPI checking

 arm/Makefile.common |   3 +-
 arm/pmu.c           | 339 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg   |  19 +++
 3 files changed, 360 insertions(+), 1 deletion(-)
 create mode 100644 arm/pmu.c

-- 
1.8.3.1
