From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 06 Sep 2010 11:12:21 +0200
Subject: [PATCH v3] ARM: S5P: Add support for gpio interrupts
Message-ID: <1283764347-460-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for gpio interrupts on Samsung S5P SoC
series (S5PC100 and S5PC110/S5PV210). It is based on the previous
version created by Joonyoung Shim (which is available from the 
"[PATCH v2 0/4] ARM: S5P: Support gpio interrupts" thread:
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/1662 ).

This version has been redesigned to assign irq numbers dynamically to
reduce resource waste. Such idea has proposed by Ben Dooks some time ago
(see "[PATCH] ARM: S5P: Dynamicly numbered GPIO interrupt support"
thread: http://comments.gmane.org/gmane.linux.kernel.samsung-soc/1198 ).

The last patch in this series is an example how to use the dynamically
registered gpio interrupt. The QT602240 touch screen device on Goni
machine requires it.

The patch series has been rebased onto latest kgene/for-next kernel
tree.

The complete list of patches:

[PATCH 1/6] ARM: Samsung: Add common s5p gpio interrupt support
[PATCH 2/6] ARM: S5PC110: add support for gpio interrupts
[PATCH 3/6] ARM: S5PC100: Use generic S5P gpio interrupts interface
[PATCH 4/6] ARM: S5PC100: Move external interrupt defines
[PATCH 5/6] ARM: Samsung: Add common samsung_gpiolib_to_irq function
[PATCH 6/6] ARM: S5PC110: GONI: Add support for QT602240 TS driver

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
