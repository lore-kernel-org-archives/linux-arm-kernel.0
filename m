From: p.wilczek@samsung.com (Piotr Wilczek)
Date: Wed, 11 Dec 2013 14:07:31 +0100
Subject: [PATCH 0/8] Impedance matcher for Samsung boards
Message-ID: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset implements the impedance-matcher for Samsung Exynos boards
and does the following:
 - fix strncmp function;
 - ensure each DT blob is 4-byte aligned;
 - port 'atags_to_fdt' form Kernel;
 - add Exynos specific serial driver;
 - add support for Samsung boards, Trats and Trats2;

This patch set is based on:
https://github.com/zonque/pxa-impedance-matcher.git

Piotr Wilczek (8):
  registers: add write u8 type
  string: fix strncmp function
  device tree blob must be 4-bytes alingned
  Makefile: disable generating Thumb code
  add memory operations
  add support to supplement atags to device tree
  serial: add Exynos specific serial driver
  board: add Samsung specific board support

 Makefile                       |   12 +-
 append_dtbs.sh                 |   11 +
 atags.h                        |    2 +
 atags_to_fdt.c                 |  197 ++++++
 board-exynos.c                 |   77 +++
 configs/Makefile.config.exynos |   13 +
 dtbs.c                         |    4 +
 fdt.c                          |  224 ++++++
 fdt_ro.c                       |  576 ++++++++++++++++
 fdt_rw.c                       |  494 ++++++++++++++
 fdt_wip.c                      |  120 ++++
 libfdt.h                       | 1478 ++++++++++++++++++++++++++++++++++++++++
 libfdt_env.h                   |   13 +
 libfdt_internal.h              |   95 +++
 main.c                         |    4 +
 register.c                     |   10 +
 register.h                     |    3 +
 serial-exynos.c                |   84 +++
 setup.h                        |  187 +++++
 string.c                       |  119 +++-
 string.h                       |   10 +
 types.h                        |   32 +
 22 files changed, 3761 insertions(+), 4 deletions(-)
 create mode 100644 atags_to_fdt.c
 create mode 100644 board-exynos.c
 create mode 100644 configs/Makefile.config.exynos
 create mode 100644 fdt.c
 create mode 100644 fdt_ro.c
 create mode 100644 fdt_rw.c
 create mode 100644 fdt_wip.c
 create mode 100644 libfdt.h
 create mode 100644 libfdt_env.h
 create mode 100644 libfdt_internal.h
 create mode 100644 serial-exynos.c
 create mode 100644 setup.h

-- 
1.7.9.5
