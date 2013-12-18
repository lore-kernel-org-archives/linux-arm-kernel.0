From: p.wilczek@samsung.com (Piotr Wilczek)
Date: Wed, 18 Dec 2013 13:09:03 +0100
Subject: [PATCH V2 0/8] Impedance matcher for Samsung boards
In-Reply-To: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
Message-ID: <1387368551-18958-1-git-send-email-p.wilczek@samsung.com>
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

Changes for V2:
 - libfdt moved to libfdt directory

TODO:
Kernel uses some memory space right after uImage, overwriting the very first
appended device tree blob. As a workaround a fake, 32kB dtb is appended first.

Piotr Wilczek (8):
  registers: add write u8 type
  string: fix strncmp function
  device tree blob must be 4-bytes alingned
  Makefile: disable generating Thumb code
  add memory operations
  add support to supplement atags to device tree
  serial: add Exynos specific serial driver
  board: add Samsung specific board support

 Makefile                       |   16 +-
 append_dtbs.sh                 |   11 +
 atags.h                        |    2 +
 board-exynos.c                 |   77 ++
 configs/Makefile.config.exynos |   13 +
 dtbs.c                         |    4 +
 libfdt.h                       | 1478 ++++++++++++++++++++++++++++++++
 libfdt/Makefile                |   23 +
 libfdt/atags_to_fdt.c          |  199 +++++
 libfdt/fdt.c                   |  224 +++++
 libfdt/fdt_ro.c                |  576 +++++++++++++
 libfdt/fdt_rw.c                |  494 +++++++++++
 libfdt/fdt_wip.c               |  120 +++
 libfdt/libfdt.a                |  Bin 0 -> 32216 bytes
 libfdt/libfdt.h                | 1478 ++++++++++++++++++++++++++++++++
 libfdt/libfdt_env.h            |   13 +
 libfdt/libfdt_internal.h       |   95 +++
 libfdt/patch_libfdt.patch      | 1826 ++++++++++++++++++++++++++++++++++++++++
 libfdt/setup.h                 |  187 ++++
 main.c                         |    4 +
 register.c                     |   10 +
 register.h                     |    3 +
 serial-exynos.c                |   84 ++
 string.c                       |  119 ++-
 string.h                       |   10 +
 types.h                        |   32 +
 26 files changed, 7094 insertions(+), 4 deletions(-)
 create mode 100644 board-exynos.c
 create mode 100644 configs/Makefile.config.exynos
 create mode 100644 libfdt.h
 create mode 100644 libfdt/Makefile
 create mode 100644 libfdt/atags_to_fdt.c
 create mode 100644 libfdt/fdt.c
 create mode 100644 libfdt/fdt_ro.c
 create mode 100644 libfdt/fdt_rw.c
 create mode 100644 libfdt/fdt_wip.c
 create mode 100644 libfdt/libfdt.a
 create mode 100644 libfdt/libfdt.h
 create mode 100644 libfdt/libfdt_env.h
 create mode 100644 libfdt/libfdt_internal.h
 create mode 100644 libfdt/patch_libfdt.patch
 create mode 100644 libfdt/setup.h
 create mode 100644 serial-exynos.c

-- 
1.7.9.5
