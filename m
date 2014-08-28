From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 28 Aug 2014 14:14:09 +0100
Subject: [PATCH 03/11] misc: st_kim: Increase size of dev_name buffer to
 incorporate termination
In-Reply-To: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
References: <1409231657-18294-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1409231657-18294-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling strncpy with a maximum size argument of 32 bytes on destination
array kim_gdata->dev_name of size 32 bytes might leave the destination
string unterminated.

Cc: gregkh at linuxfoundation.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/ti_wilink_st.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ti_wilink_st.h b/include/linux/ti_wilink_st.h
index 932b7639..884d626 100644
--- a/include/linux/ti_wilink_st.h
+++ b/include/linux/ti_wilink_st.h
@@ -268,7 +268,7 @@ struct kim_data_s {
 	struct st_data_s *core_data;
 	struct chip_version version;
 	unsigned char ldisc_install;
-	unsigned char dev_name[UART_DEV_NAME_LEN];
+	unsigned char dev_name[UART_DEV_NAME_LEN + 1];
 	unsigned char flow_cntrl;
 	unsigned long baud_rate;
 };
-- 
1.9.1
