From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 28 Feb 2018 14:10:56 +0100
Subject: [PATCH v2 2/4] ARM: configs: stm32: remove XIP configuration
In-Reply-To: <1519823458-27734-1-git-send-email-alexandre.torgue@st.com>
References: <1519823458-27734-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1519823458-27734-3-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Embedded flash becomes too small to be used as XIP support. SD card is now
available on most of stm32 boards and could be used as boot support.
Furthermore, ARM_MPU flags will be used by default and it imposes that XIP
image to be aligned on 1MB (which is not the case). For all those reasons
I prefer to remove XIP configuration from default stm32 config and let
user configure it if needed.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index ba805b7..b162b8d 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -28,8 +28,6 @@ CONFIG_PREEMPT=y
 # CONFIG_ATAGS is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_XIP_KERNEL=y
-CONFIG_XIP_PHYS_ADDR=0x08008000
 CONFIG_BINFMT_FLAT=y
 CONFIG_BINFMT_SHARED_FLAT=y
 # CONFIG_COREDUMP is not set
-- 
2.7.4
