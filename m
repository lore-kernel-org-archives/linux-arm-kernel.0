From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 19 Oct 2017 11:26:26 +0200
Subject: [GIT PULL] Reset controller fixes for v4.14, part 2
Message-ID: <1508405186.7665.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm-soc-maintainers,

please consider merging this tag for v4.14. It contains a single fix for
the socfpga driver on 64-bit systems by removing the assumption that
BITS_PER_LONG is always 32.

regards
Philipp

The following changes since commit 544e3bf4f0e8278400f19ca7918a3cdf2548b4eb:

? reset: Restrict RESET_HSDK to ARC_SOC_HSDK or COMPILE_TEST (2017-09-21 12:44:01 +0200)

are available in the git repository at:

? git://git.pengutronix.de/git/pza/linux.git tags/reset-fixes-for-4.14-2

for you to fetch changes up to f450f28e70a2378d9d6ded0932fe480055888cfa:

? reset: socfpga: fix for 64-bit compilation (2017-10-04 10:29:44 +0200)

----------------------------------------------------------------
Reset controller fixes for v4.14

Fix SoCFPGA reset controller for 64-bit systems. This patch removes the
assumption that BITS_PER_LONG is 32, which is not the case on Stratix10.

----------------------------------------------------------------
Dinh Nguyen (1):
??????reset: socfpga: fix for 64-bit compilation

?drivers/reset/reset-socfpga.c | 17 ++++++++++-------
?1 file changed, 10 insertions(+), 7 deletions(-)
