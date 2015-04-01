From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed,  1 Apr 2015 16:20:14 -0700
Subject: [PATCH 0/6] selftests: improve cross compilation support
Message-ID: <1427930420-4762-1-git-send-email-tyler.baker@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set improves cross building functionality by resovling hard coded
assumptions about the compiler used. With this patch set, all but mqueue, 
and kdbus cross build successfully as they must link against a native 
libraries. The hope is tha the above issues can be resolved in future patch 
sets. I have tested this series by building selftests for x86_64, arm and 
arm64 targets.

This motivation behind this series is to enable the kernelci.org service to
easily build, deploy, and execute selftests on many different processor
architectures without natively compiling them. With the hope of quickly
providing these test results back to the community.

This series is based on next-20150401.

Tyler Baker (6):
  selftest/memfd: enable cross compilation
  selftest/kdbus: enable cross compilation
  selftest/mount: enable cross compilation
  selftest/memfd: include default header install path
  selftest/ipc: enable cross compilation
  selftest/mqueue: enable cross compilation

 tools/testing/selftests/ipc/Makefile    | 6 +-----
 tools/testing/selftests/kdbus/Makefile  | 4 ++--
 tools/testing/selftests/memfd/Makefile  | 8 +++++---
 tools/testing/selftests/mount/Makefile  | 5 +++--
 tools/testing/selftests/mqueue/Makefile | 6 ++++--
 5 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.1.4
