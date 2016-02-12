From: jglauber@cavium.com (Jan Glauber)
Date: Fri, 12 Feb 2016 17:55:05 +0100
Subject: [RFC PATCH 0/7] Cavium ThunderX uncore PMU support
Message-ID: <cover.1455295032.git.jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patch series provides access to various counters on the ThunderX SOC.

For details of the implementation see patch #1.

Patches #2-7 add ther various ThunderX specific PMUs.

I did not want to put these file into arch/arm64/kernel so I added a
"uncore" directory. Maybe this should be put somewhere under drivers/
instead.

Feedback welcome!

Jan


Jan Glauber (7):
  arm64/perf: Basic uncore counter support for Cavium ThunderX
  arm64/perf: Cavium ThunderX L2C TAD uncore support
  arm64/perf: Cavium ThunderX L2C CBC uncore support
  arm64/perf: Cavium ThunderX LMC uncore support
  arm64/perf: Cavium ThunderX OCX LNE uncore support
  arm64/perf: Cavium ThunderX OCX FRC uncore support
  arm64/perf: Cavium ThunderX OCX TLK uncore support

 arch/arm64/kernel/Makefile                       |   1 +
 arch/arm64/kernel/uncore/Makefile                |   7 +
 arch/arm64/kernel/uncore/uncore_cavium.c         | 229 +++++++++
 arch/arm64/kernel/uncore/uncore_cavium.h         |  97 ++++
 arch/arm64/kernel/uncore/uncore_cavium_l2c_cbc.c | 239 +++++++++
 arch/arm64/kernel/uncore/uncore_cavium_l2c_tad.c | 600 +++++++++++++++++++++++
 arch/arm64/kernel/uncore/uncore_cavium_lmc.c     | 201 ++++++++
 arch/arm64/kernel/uncore/uncore_cavium_ocx_frc.c | 248 ++++++++++
 arch/arm64/kernel/uncore/uncore_cavium_ocx_lne.c | 270 ++++++++++
 arch/arm64/kernel/uncore/uncore_cavium_ocx_tlk.c | 366 ++++++++++++++
 10 files changed, 2258 insertions(+)
 create mode 100644 arch/arm64/kernel/uncore/Makefile
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium.c
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium.h
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium_l2c_cbc.c
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium_l2c_tad.c
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium_lmc.c
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium_ocx_frc.c
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium_ocx_lne.c
 create mode 100644 arch/arm64/kernel/uncore/uncore_cavium_ocx_tlk.c

-- 
1.9.1
