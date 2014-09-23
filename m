From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 23 Sep 2014 13:46:04 +0530
Subject: [PATCH v2 0/5] Add initial support for pinctrl on Exynos7
Message-ID: <1411460169-30536-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
	- Marked the newly created irq_chip instances as __initdata
	- Used kmemdup to keep a copy of the irq_chip
	- Change the pinctrl name from sd0_rdqs to sd0_ds as per UM
	- Moved the pinctrl enablement for exynos7 into a separate patch
	- Added tested-by and reviewed-by tags from Thomas Abraham

Following patches have been tested on linux-next (20140922).
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/
 
Following patches are required for this series:
1) "tty/serial: fix config dependencies for samsung serial"
   https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg36208.html
2) "dts, kbuild: Implement support for dtb vendor subdirs" patchset 
   http://comments.gmane.org/gmane.linux.kbuild.devel/12131
3) "arch: arm64: enable support for Samsung Exynos7 SoC" patchset (v5)
   http://www.spinics.net/lists/arm-kernel/msg364014.html
