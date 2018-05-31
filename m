From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 May 2018 14:30:47 +0100
Subject: [PATCH 0/3] Initial Spectre variant 1 patches
Message-ID: <20180531133047.GS17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds initial support for the Spectre variant 1 workarounds
to the kernel.  This does _not_ cover the user accessors, which are
still in development.

The series adds support for the array_index_mask_nospec() macro, used
by generic kernel code to mask out of bounds pointers, and also adds
the syscall table hardening.

 arch/arm/include/asm/assembler.h |  8 ++++++++
 arch/arm/include/asm/barrier.h   | 31 +++++++++++++++++++++++++++++++
 arch/arm/kernel/entry-common.S   | 14 +++-----------
 arch/arm/kernel/entry-header.S   | 25 +++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 11 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
