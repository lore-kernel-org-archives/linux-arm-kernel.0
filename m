From: jean.pihet@linaro.org (Jean Pihet)
Date: Mon,  3 Mar 2014 10:53:20 +0100
Subject: [PATCH 0/3] perf tools: Add libdw DWARF post unwind support for ARM
Message-ID: <1393840403-26639-1-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding libdw DWARF post unwind support, which is part
of elfutils-devel/libdw-dev package from version 0.158.

Also includes the test suite for dwarf unwinding, by adding the
arch specific test code and the perf_regs_load function.

Jean Pihet (3):
  perf tests: Introduce perf_regs_load function on ARM
  perf tests: Add dwarf unwind test on ARM
  perf tools: Add libdw DWARF post unwind support for ARM

 tools/perf/Makefile.perf                 |  2 +-
 tools/perf/arch/arm/Makefile             |  7 ++++
 tools/perf/arch/arm/include/perf_regs.h  |  5 +++
 tools/perf/arch/arm/tests/dwarf-unwind.c | 59 ++++++++++++++++++++++++++++++++
 tools/perf/arch/arm/tests/regs_load.S    | 51 +++++++++++++++++++++++++++
 tools/perf/arch/arm/util/unwind-libdw.c  | 36 +++++++++++++++++++
 tools/perf/tests/builtin-test.c          |  2 +-
 tools/perf/tests/tests.h                 |  2 +-
 8 files changed, 161 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/arch/arm/tests/dwarf-unwind.c
 create mode 100644 tools/perf/arch/arm/tests/regs_load.S
 create mode 100644 tools/perf/arch/arm/util/unwind-libdw.c

---

- Rebased on latest acme/perf/core git tree,
- Tested on quad-core ARMv7 machine

-- 
1.7.11.7
