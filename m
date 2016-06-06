From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jun 2016 17:41:29 +0100
Subject: [PATCH kexec-tools v2 00/32] Keystone II updates for kexec tools
Message-ID: <20160606164129.GM1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the latest set of kexec-tools patches to support Keystone II
platforms, which work in conjunction with the kernel patches which
Andrew Morton has already taken.

Most of the patches have been reviewed, but there are a small number
which do not have Reviewed-by or Acked-by tags; these are due to
comments, which I've replied to, which have yet to have further
responses.

 kdump/kdump.c                     |  27 ++++-
 kexec/Makefile                    |   4 +
 kexec/arch/arm/Makefile           |   5 +
 kexec/arch/arm/crashdump-arm.c    | 247 +++++++++++++++++++-------------------
 kexec/arch/arm/crashdump-arm.h    |   2 +-
 kexec/arch/arm/iomem.h            |   9 ++
 kexec/arch/arm/kexec-arm.c        |   8 +-
 kexec/arch/arm/kexec-uImage-arm.c |   3 +-
 kexec/arch/arm/kexec-zImage-arm.c |   6 +-
 kexec/arch/arm/phys_to_virt.c     |   6 +-
 kexec/arch/arm/phys_to_virt.h     |   8 ++
 kexec/crashdump.h                 |   2 +-
 kexec/kexec-uImage.c              |   3 +-
 kexec/kexec.c                     |   4 +-
 kexec/kexec.h                     |   1 +
 kexec/mem_regions.c               | 128 ++++++++++++++++++++
 kexec/mem_regions.h               |  15 +++
 kexec/phys_to_virt.c              |   2 +-
 kexec/zlib.c                      |   4 +-
 19 files changed, 339 insertions(+), 145 deletions(-)


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
