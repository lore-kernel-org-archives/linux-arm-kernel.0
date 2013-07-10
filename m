From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Wed, 10 Jul 2013 14:59:03 +0200
Subject: [PATCH v2 0/2] arm: omap: RX-51: ARM errata 430973 workaround
In-Reply-To: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1373461145-9812-1-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds RX-51 specific SMC support and sets IBE bit in ACTLR during
board init code for ARM errata 430973 workaround.

This is second version of patch which simplifing API and moving all board
functions to one file board-rx51.c. Wrapper around smc #1 instruction is in
omap-smc.S file because some other board may use it too.

Pali Roh?r (2):
  ARM: OMAP: Add secure function omap_smc3() which calling instruction
    smc #1
  RX-51: ARM errata 430973 workaround

 arch/arm/mach-omap2/board-rx51.c  |   78 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-secure.h |    1 +
 arch/arm/mach-omap2/omap-smc.S    |   22 ++++++++++-
 3 files changed, 100 insertions(+), 1 deletion(-)

-- 
1.7.10.4
