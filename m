From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue,  8 Dec 2015 18:32:27 +0000
Subject: [PATCH v10 0/6] QEMU support for KVM Guest Debug on arm64
Message-ID: <1449599553-24713-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the latest patch set to support debugging of KVM guests on
arm64. The main changes are fixing arm32 compiles (mostly with stubs
for the upcomming arm32 debug) and the usual bunch of minor tweaks and
clarifications following review.

I've kept the GDB Python based test in tests/guest-debug and cleaned
it up so it will work with python2/3 linked GDBs. It still isn't
plumbed it in to the "make check" so can be dropped until we have a
solution for testing against non-host binaries.

So in summary the changes are:

  - Fixed arm32 compile
  - Use results of debug capability checks
  - Whitespace and comment cleanups
  - Py2/3 cleanliness for test script

More detailed changelogs are attached to each patch.

GIT Repo:

The patch series is based off a recent master and can be found at:

https://github.com/stsquad/qemu
branch: kvm/guest-debug-v10

Alex Benn?e (6):
  target-arm: kvm64 - introduce kvm_arm_init_debug()
  target-arm: kvm - implement software breakpoints
  target-arm: kvm - support for single step
  target-arm: kvm - add support for HW assisted debug
  target-arm: kvm - re-inject guest debug exceptions
  tests/guest-debug: introduce basic gdbstub tests

 target-arm/helper-a64.c           |  12 +-
 target-arm/kvm.c                  |  65 +++---
 target-arm/kvm32.c                |  47 ++++
 target-arm/kvm64.c                | 464 ++++++++++++++++++++++++++++++++++++++
 target-arm/kvm_arm.h              |  30 +++
 tests/guest-debug/test-gdbstub.py | 176 +++++++++++++++
 6 files changed, 757 insertions(+), 37 deletions(-)
 create mode 100644 tests/guest-debug/test-gdbstub.py

-- 
2.6.3
