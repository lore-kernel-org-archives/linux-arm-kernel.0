From: timur@codeaurora.org (Timur Tabi)
Date: Wed,  3 May 2017 11:17:57 -0500
Subject: [PATCH 6/9] arm64: defconfig: enable APEI and GHES features
In-Reply-To: <1493828280-6620-1-git-send-email-timur@codeaurora.org>
References: <1493828280-6620-1-git-send-email-timur@codeaurora.org>
Message-ID: <1493828280-6620-7-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 server platforms can support ACPI Platform Error Interface (APEI)
and Generic Hardware Error Source (GHES) features, so enable them.

Platforms which support the firmware-first RAS error reporting model
require APEI and GHES functionality for the OS to receive and report
error records provided by the platform.

PCIe AER functionality is required for PCIe AER errors to be properly
reported and recovered from.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f6b86a1..389f97f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -488,6 +488,9 @@ CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_ACPI=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_PCIEAER=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
