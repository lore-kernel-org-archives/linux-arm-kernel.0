From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2018 13:39:35 +0000
Subject: [PATCH 0/4] Enable deadcode elimination at link time
Message-ID: <20181106133935.GB30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables elimination of dead code from the kernel at link
time.  The changes are mostly ARM specific, except for one change in
EFI as the EFI stub must not be compiled with -fdata-sections.

 arch/arm/Kconfig                       |  1 +
 arch/arm/boot/compressed/vmlinux.lds.S |  2 +-
 arch/arm/kernel/vmlinux.lds.S          | 10 +++++-----
 arch/arm/kernel/vmlinux.lds.h          | 18 +++++++++---------
 drivers/firmware/efi/libstub/Makefile  |  2 +-
 5 files changed, 17 insertions(+), 16 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
