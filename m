From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 5 Jun 2013 13:14:44 +0100
Subject: [PATCH v3 0/6] Introduce Xen support to ARM64
Message-ID: <alpine.DEB.2.02.1306041712100.4589@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series introduces Xen support to arch/arm64.

As you can see from the following patches, there is very little arm64
specific code here, basically only one assembly file
(arch/arm64/xen/hypercall.S).

Everything else is common with Xen for ARMv7, in particular the code
under arch/arm/xen (enlighten.c and the stubs in grant-table.c) and most
of the header files under arch/arm/include/asm/xen (hypercall.h,
hypervisor.h, interface.h, page.h) can be reused as-is.



Changes in v3:
- fix comment in hypercall.S to reflect the actual calling convention;
- add a patch to update the MAINTAINERS file.



Stefano Stabellini (6):
      arm/xen: define xen_remap as ioremap_cached
      arm64/xen: introduce asm/xen header files on arm64
      arm64/xen: implement ioremap_cached on arm64
      arm64/xen: use XEN_IO_PROTO_ABI_ARM on ARM64
      arm64/xen: introduce CONFIG_XEN and hypercall.S on ARM64
      MAINTAINERS: add myself as arm64/xen maintainer

 MAINTAINERS                             |    7 ++
 arch/arm/include/asm/xen/page.h         |    3 +-
 arch/arm64/Kconfig                      |   10 +++
 arch/arm64/Makefile                     |    1 +
 arch/arm64/include/asm/hypervisor.h     |    6 ++
 arch/arm64/include/asm/io.h             |    2 +
 arch/arm64/include/asm/sync_bitops.h    |   26 +++++++++
 arch/arm64/include/asm/xen/events.h     |   21 +++++++
 arch/arm64/include/asm/xen/hypercall.h  |    1 +
 arch/arm64/include/asm/xen/hypervisor.h |    1 +
 arch/arm64/include/asm/xen/interface.h  |    1 +
 arch/arm64/include/asm/xen/page.h       |    1 +
 arch/arm64/xen/Makefile                 |    2 +
 arch/arm64/xen/hypercall.S              |   92 +++++++++++++++++++++++++++++++
 include/xen/interface/io/protocols.h    |    2 +-
 15 files changed, 173 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/include/asm/hypervisor.h
 create mode 100644 arch/arm64/include/asm/sync_bitops.h
 create mode 100644 arch/arm64/include/asm/xen/events.h
 create mode 100644 arch/arm64/include/asm/xen/hypercall.h
 create mode 100644 arch/arm64/include/asm/xen/hypervisor.h
 create mode 100644 arch/arm64/include/asm/xen/interface.h
 create mode 100644 arch/arm64/include/asm/xen/page.h
 create mode 100644 arch/arm64/xen/Makefile
 create mode 100644 arch/arm64/xen/hypercall.S


git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git xen-arm64-3


- Stefano
