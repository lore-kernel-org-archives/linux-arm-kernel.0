From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Nov 2013 09:29:15 +0000
Subject: [PATCH 4/4] mfd: rtsx: Prevent 'used uninitialised' warnings
In-Reply-To: <1384421355-4434-1-git-send-email-lee.jones@linaro.org>
References: <1384421355-4434-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1384421355-4434-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/mfd/rtl8411.c: In function ?rtl8411_fetch_vendor_settings?:
drivers/mfd/rtl8411.c:58:7: warning: ?reg1? is used uninitialized in this function [-Wuninitialized]
drivers/mfd/rtl8411.c: In function ?rtl8411b_fetch_vendor_settings?:
drivers/mfd/rtl8411.c:79:7: warning: ?reg? is used uninitialized in this function [-Wuninitialized]
drivers/mfd/rtl8411.c: In function ?rtl8411_fetch_vendor_settings?:
drivers/mfd/rtl8411.c:69:26: warning: ?reg3? may be used uninitialized in this function [-Wuninitialized]

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/rtl8411.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/rtl8411.c b/drivers/mfd/rtl8411.c
index 0771796..cb8416c 100644
--- a/drivers/mfd/rtl8411.c
+++ b/drivers/mfd/rtl8411.c
@@ -49,8 +49,8 @@ static int rtl8411b_is_qfn48(struct rtsx_pcr *pcr)
 
 static void rtl8411_fetch_vendor_settings(struct rtsx_pcr *pcr)
 {
-	u32 reg1;
-	u8 reg3;
+	u32 reg1 = 0;
+	u8 reg3 = 0;
 
 	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg1);
 	dev_dbg(&(pcr->pci->dev), "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg1);
@@ -71,7 +71,7 @@ static void rtl8411_fetch_vendor_settings(struct rtsx_pcr *pcr)
 
 static void rtl8411b_fetch_vendor_settings(struct rtsx_pcr *pcr)
 {
-	u32 reg;
+	u32 reg = 0;
 
 	rtsx_pci_read_config_dword(pcr, PCR_SETTING_REG1, &reg);
 	dev_dbg(&(pcr->pci->dev), "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG1, reg);
-- 
1.8.1.2
