From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:50:41 +0800
Subject: [PATCH 0/3] AT91 pm fixes for 3.21
Message-ID: <1423709441-8342-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The patch series purpose is to fix the AT91 pm.
	Add pm support for sama5d3 and sama5d4.
	Fix the MOR register KEY missing when writing.
	Add flush and disable the cache before going to suspending.

Patrice Vilchez (1):
  pm: at91: pm_suspend: MOR register KEY was missing

Wenyou Yang (2):
  pm: at91: pm_suspend: add the WFI instruction support for ARMv7
  pm: at91: flush data cache and clean, invalidate and disable the L2
    cache

 arch/arm/mach-at91/pm.c         |    6 ++++++
 arch/arm/mach-at91/pm_suspend.S |   22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

-- 
1.7.9.5
