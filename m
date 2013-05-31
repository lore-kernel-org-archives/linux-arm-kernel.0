From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 31 May 2013 16:09:06 +0100
Subject: [PATCH] ARM: ux500: Enable HIGHMEM in the u8540 defconfig
Message-ID: <1370012946-7374-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to utilise all of the memory located on ux500 based devices
we have to enable HIGHMEM. Without it the kernel truncates memory down
to what's left after the PAGE_OFFSET has been applied, which doesn't
leave an awful lot, especially if we're running large rootfs' such
as full Linux desktop distributions or Android.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/u8500_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 2d322d2..38d633a 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -1,3 +1,4 @@
+CONFIG_HIGHMEM=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
-- 
1.7.10.4
