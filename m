From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:54 +0900
Subject: [PATCH 123/130] Revert "ARM: shmobile: Disallow PINCTRL without
 GPIOLIB"
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-124-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

GPIOLIB dependency handling was added to the PINCTRL core by

commit 2afe8229687ec24cbc07e78449a588bb8b68f858
Author: Haojian Zhuang <haojian.zhuang@linaro.org>
Date:   Thu Mar 28 07:34:19 2013 +0800

    pinctrl: core: add dependence of GPIOLIB

There is not need to handle that dependency at the SH Mobile level
anymore. Revert

commit 6722f6cb763203cab775297b6e9d00834af0d6d7
Author: Magnus Damm <damm@opensource.se>
Date:   Mon Mar 18 22:58:18 2013 +0900

    ARM: shmobile: Disallow PINCTRL without GPIOLIB

    Modify mach-shmobile to only select PINCTRL in case of
    ARCH_WANT_OPTIONAL_GPIOLIB is set.

    This fixes a build error triggered when adding a new SoC
    lacking GPIO software support (ARCH_WANT_OPTIONAL_GPIOLIB=n):

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 49d993c..dfb4fee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -645,7 +645,7 @@ config ARCH_SHMOBILE
 	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select NO_IOPORT
-	select PINCTRL if ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 	select PM_GENERIC_DOMAINS if PM
 	select SPARSE_IRQ
 	help
-- 
1.8.2.1
