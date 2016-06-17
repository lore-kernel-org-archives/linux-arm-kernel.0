From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 16 Jun 2016 18:56:09 -0700
Subject: [GIT PULL 1/7] Broadcom soc changes for 4.8 Part 1
Message-ID: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/soc

for you to fetch changes up to 423779cfd3ca73b9236e6eb798477f3a4f13355d:

  ARM: bcm: fix missing include of kona_l2_cache.h (2016-06-08 10:17:15 -0700)

----------------------------------------------------------------
This pull request contains SoC changes for Broadcom ARM-based SoCs:

- Chris prepares support for the BCM23550 by removing reset code in the
  BCM21664 machine code since a proper drivers/power/reset driver is provided and
  shared, he then adds a machine entry point for BCM23550 and updates the SMP
  code to bring-up the secondary cores on BCM23550

- Ben fixes a warning in the Kona L2 SMC code by adding the missing include file

----------------------------------------------------------------
Ben Dooks (1):
      ARM: bcm: fix missing include of kona_l2_cache.h

Chris Brand (3):
      ARM: bcm21664: Remove reset code
      ARM: Add support for Broadcom BCM23550 SoC
      ARM: BCM23550 SMP support

 arch/arm/mach-bcm/Kconfig          | 12 ++++++--
 arch/arm/mach-bcm/Makefile         |  5 +++-
 arch/arm/mach-bcm/board_bcm21664.c | 42 ---------------------------
 arch/arm/mach-bcm/board_bcm23550.c | 25 ++++++++++++++++
 arch/arm/mach-bcm/kona_l2_cache.c  |  1 +
 arch/arm/mach-bcm/platsmp.c        | 58 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 98 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm/mach-bcm/board_bcm23550.c
