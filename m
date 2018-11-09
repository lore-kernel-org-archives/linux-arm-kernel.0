From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Fri,  9 Nov 2018 12:37:25 +0000
Subject: [PATCH 22/27] arm64: Enable compat vDSO support
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
Message-ID: <20181109123730.8743-23-vincenzo.frascino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables compat vDSO support in the arm64 defconfig.

Note that the default compiler is set to arm-linux-gnueabihf-.
For this to take effect and for the compat vDSO to compile correctly, it
is required that this compiler is in the PATH.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a57d11330b..cfd5d67c6407 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -709,6 +709,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=y
+CONFIG_CROSS_COMPILE_COMPAT_VDSO="arm-linux-gnueabihf-"
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
-- 
2.19.1
