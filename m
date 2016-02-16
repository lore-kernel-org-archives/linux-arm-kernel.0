From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Feb 2016 14:17:00 +0000
Subject: [PATCH 2/3] ARM: configs: Add new config fragment to change RAM start
 point
In-Reply-To: <1455632221-31834-1-git-send-email-lee.jones@linaro.org>
References: <1455632221-31834-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1455632221-31834-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than duplicate a defconfig for each difference
between platforms, we can choose to pick a basic defconfig and
manipulate it at run-time using config fragments.  Here we're
adding a new fragment to over-ride the RAM start point to 0x0.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/dram_0x00000000.config | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 arch/arm/configs/dram_0x00000000.config

diff --git a/arch/arm/configs/dram_0x00000000.config b/arch/arm/configs/dram_0x00000000.config
new file mode 100644
index 0000000..db96dcb
--- /dev/null
+++ b/arch/arm/configs/dram_0x00000000.config
@@ -0,0 +1 @@
+CONFIG_DRAM_BASE=0x00000000
-- 
1.9.1
