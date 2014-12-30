From: threeway@gmail.com (Steev Klimaszewski)
Date: Tue, 30 Dec 2014 00:55:48 -0600
Subject: [PATCH] Add USB_EHCI_EXYNOS to multi_v7_defconfig
In-Reply-To: <1419922548-6320-1-git-send-email-steev@gentoo.org>
References: <1419922548-6320-1-git-send-email-steev@gentoo.org>
Message-ID: <1419922548-6320-2-git-send-email-steev@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we enable Exynos devices in the multi v7 defconfig, however, when
testing on my ODROID-U3, I noticed that USB was not working.  Enabling this
option causes USB to work, which enables networking support as well since the
ODROID-U3 has networking on the USB bus.

Signed-off-by: Steev Klimaszewski <steev@gentoo.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2328fe7..bc393b7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -338,6 +338,7 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MVEBU=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_EXYNOS=y
 CONFIG_USB_EHCI_TEGRA=y
 CONFIG_USB_EHCI_HCD_STI=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
-- 
2.2.1
