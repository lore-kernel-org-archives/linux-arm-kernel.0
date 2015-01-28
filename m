From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 28 Jan 2015 10:21:47 +0800
Subject: [PATCH v2 0/3] AT91 pm improvements for 3.20
Message-ID: <1422411707-10945-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

This patch set is to add the pm support for the ARMv7 SoCs.

It is based on the following patch set,
	[PATCH v4 00/12] AT91 pm cleanup for 3.20

Changes in v2.0
 - Drop patch to enable the l2 cache controller.
 - Remove patches to disable the mpddrc and DDR clock.
 - Remove patch to change to get the memory type.
 - Fix some commments

Patrice Vilchez (1):
  pm: at91: pm_suspend: MOR register KEY was missing

Wenyou Yang (2):
  pm: at91: pm_suspend: add the WFI support for ARMv7
  pm: at91: add disable/enable the L1/L2 cache while suspend/resume

 arch/arm/mach-at91/pm.c         |   12 +++
 arch/arm/mach-at91/pm_suspend.S |  158 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 169 insertions(+), 1 deletion(-)

-- 
1.7.9.5
