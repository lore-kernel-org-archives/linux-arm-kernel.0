From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Thu, 24 Dec 2015 18:37:54 +0200
Subject: [PATCH 0/2] OMAP: RX51: save atags data to be exported on /proc/atags
In-Reply-To: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
Message-ID: <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nokia N900 legacy userspace needs ATAGS passed by the bootloder to be
available in /proc/atags. With DT booted kernel this information is
no longer availabe. Fix that by saving ATAGS data early in the boot 
stage so it can be exported in /proc/atags later

Ivaylo Dimitrov (2):
  ARM: ATAGS: move save_atags() to include/asm
    arch/arm/include/asm/setup.h
  OMAP: RX51: save ATAGS data in the early boot stage

 arch/arm/include/asm/setup.h        |  6 ++++++
 arch/arm/kernel/atags.h             |  6 ------
 arch/arm/mach-omap2/board-generic.c | 12 +++++++++++-
 3 files changed, 17 insertions(+), 7 deletions(-)

-- 
1.9.1
