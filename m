From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Mon,  6 Jul 2015 22:26:08 +0200
Subject: [PATCH 0/5] ATAGs to DT patches
Message-ID: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series converts some legacy ATAGs into DT and provide them to
userspace. It is needed for userspace applications which needs some
informations from legacy bootloaders which are not DT compatible.

Patch series is for now without DT documentation files. It was tested in
QEMU for Nokia N900. File /proc/cpuinfo contains correct "Revision" line
from ATAG_REVISION and /proc/atags contains full ATAGs structure.

Pali Roh?r (5):
  arm: devtree: Set system_rev from DT "/revision"
  arm: boot: convert ATAG_REVISION to DT "/revision" entry
  arm: atags: Fix declaration of function save_atags
  arm: devtree: Read ATAGs structure from DT "/chosen/linux,atags"
    entry
  arm: boot: store ATAGs structure into DT "/chosen/linux,atags" entry

 arch/arm/boot/compressed/atags_to_fdt.c |    8 ++++++-
 arch/arm/kernel/atags.h                 |    4 ++--
 arch/arm/kernel/devtree.c               |   36 ++++++++++++++++++++++++++++---
 3 files changed, 42 insertions(+), 6 deletions(-)

-- 
1.7.9.5
