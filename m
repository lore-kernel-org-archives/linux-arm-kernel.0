From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Apr 2012 15:30:35 +0100
Subject: [PATCH v2 0/4] Miscellaneous nommu fixes
Message-ID: <1334154639-13869-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version two of the patches originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/088158.html

Changes since v1 include:
	- kexec and ptrace patches now merged upstream
	- Rewrote vector copying fix to fit with 94e5a85b ("ARM: earlier
	  initialization of vectors page").
	- Added comment to membank truncation following feedback from
	  Nicolas and Sergei.
	- Based on 3.4-rc2

All feedback welcome,

Will


Will Deacon (4):
  ARM: nommu: fix typo in mm/Kconfig
  ARM: suspend: fix CPU suspend code for !CONFIG_MMU configurations
  ARM: mm: truncate memory banks to fit in 4GB space for classic MMU
  ARM: nommu: populate vectors page from paging_init

 arch/arm/kernel/setup.c   |   16 +++++++++++++-
 arch/arm/kernel/suspend.c |   52 ++++++++++++++++++++++++++-------------------
 arch/arm/mm/Kconfig       |    2 +-
 arch/arm/mm/nommu.c       |    2 +
 arch/arm/mm/proc-v6.S     |    6 ++++-
 arch/arm/mm/proc-v7.S     |   14 +++++++----
 6 files changed, 62 insertions(+), 30 deletions(-)

-- 
1.7.4.1
