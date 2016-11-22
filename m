From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 22 Nov 2016 15:09:13 +0000
Subject: [PATCH v2 0/4] boot-wrapper: arm64: Xen support
Message-ID: <20161122150917.16524-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches allow to include a Xen hypervisor binary into a boot-wrapper
ELF file, so that a Foundation Platform or a Fast Model can boot a Xen
system (including a Dom0 kernel).
The original patches have been around for a while, so this series is
merely an update to apply on the latest boot-wrapper HEAD. Also I fixed
minor things here and there (like increasing Xen's load address to
accomodate for Dom0 kernels bigger than 16 MB) and addressed Julien's
review comments.

For testing this just add: "--with-xen=/path/to/src/xen/xen" to the
./configure command line and feed the resulting xen-system.axf file to
the model.

Cheers,
Andre.

Changelog v1 .. v2:
- use "xen-cmdline" instead of bootargs as parameter and variable name
- move hunk in patch 1/4 to make patch 2/4 smaller
- replace AC_FILE_CHECK macro usage to fix cross compilation

Christoffer Dall (3):
  Support for building in a Xen binary
  Xen: Support adding DT nodes
  Explicitly clean linux-system.axf and xen-system.axf

Ian Campbell (1):
  Xen: Select correct dom0 console

 .gitignore    |  1 +
 Makefile.am   | 35 +++++++++++++++++++++++------------
 boot_common.c |  4 ++--
 configure.ac  | 29 ++++++++++++++++++++++++++++-
 model.lds.S   | 14 ++++++++++++++
 5 files changed, 68 insertions(+), 15 deletions(-)

-- 
2.9.0
