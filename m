From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 14 May 2013 17:28:42 +0200
Subject: [PATCH][For 3.10-rc] ARM: zImage: Handle the case with 32bits memory
 size and address from ATAG and 64bits DTB
Message-ID: <1368545323-3621-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Memory description in the Armada XP based boards device tree files
have been converted to 64 bit in order to handle more than 4GB when
LPAE is activated. However most of these platforms still use old
bootloaders (ie not DT compatible) and the kernel hangs when it is
configured with CONFIG_ARM_APPENDED_DTB.

The problem was a bad conversion from 32bit ATAG information to 64bits
device tree information.

The following patch fix this bug and it is a 3.10-rc material.

Regards,

Gregory CLEMENT (1):
  ARM: zImage: Convert 32bits memory size and address from ATAG to
    64bits DTB

 arch/arm/boot/compressed/atags_to_fdt.c | 44 ++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

-- 
1.8.1.2
