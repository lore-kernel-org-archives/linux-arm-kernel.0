From: colin.king@canonical.com (Colin King)
Date: Sat, 28 Nov 2015 16:27:34 +0000
Subject: [PATCH] ARM: mach-imx: iomux-imx31: fix spelling mistake in error
 message
Message-ID: <1448728054-8766-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Minor issue, fix spelling mistake, nonexistant -> nonexistent

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/mach-imx/iomux-imx31.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/iomux-imx31.c b/arch/arm/mach-imx/iomux-imx31.c
index 6dd22ca..0b5ba4b 100644
--- a/arch/arm/mach-imx/iomux-imx31.c
+++ b/arch/arm/mach-imx/iomux-imx31.c
@@ -100,7 +100,7 @@ int mxc_iomux_alloc_pin(unsigned int pin, const char *label)
 	unsigned pad = pin & IOMUX_PADNUM_MASK;
 
 	if (pad >= (PIN_MAX + 1)) {
-		printk(KERN_ERR "mxc_iomux: Attempt to request nonexistant pin %u for \"%s\"\n",
+		printk(KERN_ERR "mxc_iomux: Attempt to request nonexistent pin %u for \"%s\"\n",
 			pad, label ? label : "?");
 		return -EINVAL;
 	}
-- 
2.6.2
