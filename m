From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Fri, 31 Oct 2014 16:04:18 +0000
Subject: [PATCH 1/3] arm64: defconfig: Enable support for generic EHCI and
 OHCI platforms
In-Reply-To: <1414771460-7340-1-git-send-email-Liviu.Dudau@arm.com>
References: <1414771460-7340-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1414771460-7340-2-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that real arm64 platforms exists and they have standard EHCI and
OHCI USB controllers, enable support for them.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4ce602c..8643e58 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -97,8 +97,13 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_ISP1760_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_ULPI=y
 CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_VIRTIO_BALLOON=y
-- 
2.1.2
