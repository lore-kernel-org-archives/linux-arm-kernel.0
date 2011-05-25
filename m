From: joe@perches.com (Joe Perches)
Date: Wed, 25 May 2011 10:02:37 -0700
Subject: [PATCH 0/4] printk: cleanups of direct includes
In-Reply-To: <BANLkTimo30L7feKr9_Ec=fMoe1erw8Rnag@mail.gmail.com>
References: <BANLkTimo30L7feKr9_Ec=fMoe1erw8Rnag@mail.gmail.com>
Message-ID: <cover.1306342673.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

printk.h is a subfile of kernel.h, do not allow it to
be included directly.

Joe Perches (4):
  treewide: Remove direct includes of printk.h
  staging: Remove direct includes of printk.h
  printk: Don't allow direct inclusion
  treewide: Remove asmlinkage from printk

 arch/arm/kernel/early_printk.c                |    2 +-
 arch/ia64/kvm/vmm.c                           |    2 +-
 arch/x86/kernel/early_printk.c                |    2 +-
 drivers/staging/brcm80211/brcmfmac/dhd_sdio.c |    1 -
 drivers/staging/brcm80211/util/bcmutils.c     |    1 -
 drivers/staging/usbip/usbip_common.h          |    2 +-
 fs/ext4/inode.c                               |    1 -
 include/linux/oprofile.h                      |    2 +-
 include/linux/printk.h                        |   10 +++++++---
 kernel/printk.c                               |    6 +++---
 kernel/sysctl.c                               |    3 +--
 11 files changed, 16 insertions(+), 16 deletions(-)

-- 
1.7.4.rc3
