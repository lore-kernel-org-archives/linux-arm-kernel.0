From: bill4carson@gmail.com (bill4carson at gmail.com)
Date: Mon, 30 Jan 2012 16:36:06 +0800
Subject: [PATCH V3] Skip unnecessary pte makeup when clearing it 
Message-ID: <1327912567-18966-1-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



If we are only about to clear a hardware pte entry, then pte makeup code is
unnecessary for cpu_v7_set_pte_ext and armv6_set_pte_ext, so just skip it.

Signeed-off-by: Bill Carson <bill4carson@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: arm-mail-list <linux-arm-kernel@lists.infradead.org>


Changes for V3:
    - Fix double tab issue pointed out by Uwe Kleine-K?nig

Changes for V2:
    - Use "1f" instead of "set_pte" as label
    - Build/bootup test with thumb mode
    - checkpatch script shows:
total: 0 errors, 0 warnings, 44 lines checked

./0001-Skip-unnecessary-pte-makeup-when-clearing-it.patch has no obvious style problems and is ready for submission.

 arch/arm/mm/proc-macros.S    |   10 +++++-----
 arch/arm/mm/proc-v7-2level.S |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)
