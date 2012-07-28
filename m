From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 28 Jul 2012 14:58:40 +0800
Subject: [PATCH 4/6] pinctrl: append new groups of mmp2
In-Reply-To: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
References: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1343458722-17127-5-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/pinctrl-mmp2.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mmp2.c b/drivers/pinctrl/pinctrl-mmp2.c
index 25b9cd3..2c56de7 100644
--- a/drivers/pinctrl/pinctrl-mmp2.c
+++ b/drivers/pinctrl/pinctrl-mmp2.c
@@ -483,12 +483,14 @@ struct pxa3xx_mfp_pin mmp2_mfp[] = {
 static const unsigned mmp2_uart1_pin1[] = {GPIO29, GPIO30, GPIO31, GPIO32};
 static const unsigned mmp2_uart1_pin2[] = {GPIO45, GPIO46};
 static const unsigned mmp2_uart1_pin3[] = {GPIO140, GPIO141};
+static const unsigned mmp2_uart1_pin4[] = {GPIO29, GPIO30};
 static const unsigned mmp2_uart2_pin1[] = {GPIO37, GPIO38, GPIO39, GPIO40};
 static const unsigned mmp2_uart2_pin2[] = {GPIO43, GPIO44, GPIO45, GPIO46};
 static const unsigned mmp2_uart2_pin3[] = {GPIO47, GPIO48, GPIO49, GPIO50};
 static const unsigned mmp2_uart2_pin4[] = {GPIO74, GPIO75, GPIO76, GPIO77};
 static const unsigned mmp2_uart2_pin5[] = {GPIO55, GPIO56};
 static const unsigned mmp2_uart2_pin6[] = {GPIO140, GPIO141};
+static const unsigned mmp2_uart2_pin7[] = {GPIO47, GPIO48};
 static const unsigned mmp2_uart3_pin1[] = {GPIO37, GPIO38, GPIO39, GPIO40};
 static const unsigned mmp2_uart3_pin2[] = {GPIO43, GPIO44, GPIO45, GPIO46};
 static const unsigned mmp2_uart3_pin3[] = {GPIO51, GPIO52, GPIO53, GPIO54};
@@ -552,12 +554,14 @@ static struct pxa3xx_pin_group mmp2_grps[] = {
 	GRP_MMP2("uart1 4p1", UART1, mmp2_uart1_pin1),
 	GRP_MMP2("uart1 2p2", UART1, mmp2_uart1_pin2),
 	GRP_MMP2("uart1 2p3", UART1, mmp2_uart1_pin3),
+	GRP_MMP2("uart1 2p4", UART1, mmp2_uart1_pin4),
 	GRP_MMP2("uart2 4p1", UART2, mmp2_uart2_pin1),
 	GRP_MMP2("uart2 4p2", UART2, mmp2_uart2_pin2),
 	GRP_MMP2("uart2 4p3", UART2, mmp2_uart2_pin3),
 	GRP_MMP2("uart2 4p4", UART2, mmp2_uart2_pin4),
 	GRP_MMP2("uart2 2p5", UART2, mmp2_uart2_pin5),
 	GRP_MMP2("uart2 2p6", UART2, mmp2_uart2_pin6),
+	GRP_MMP2("uart2 2p7", UART2, mmp2_uart2_pin7),
 	GRP_MMP2("uart3 4p1", UART3, mmp2_uart3_pin1),
 	GRP_MMP2("uart3 4p2", UART3, mmp2_uart3_pin2),
 	GRP_MMP2("uart3 4p3", UART3, mmp2_uart3_pin3),
@@ -610,9 +614,9 @@ static struct pxa3xx_pin_group mmp2_grps[] = {
 };
 
 static const char * const mmp2_uart1_grps[] = {"uart1 4p1", "uart1 2p2",
-	"uart1 2p3"};
+	"uart1 2p3", "uart1 2p4"};
 static const char * const mmp2_uart2_grps[] = {"uart2 4p1", "uart2 4p2",
-	"uart2 4p3", "uart2 4p4", "uart2 4p5", "uart2 4p6"};
+	"uart2 4p3", "uart2 4p4", "uart2 2p5", "uart2 2p6", "uart2 2p7"};
 static const char * const mmp2_uart3_grps[] = {"uart3 4p1", "uart3 4p2",
 	"uart3 4p3", "uart3 4p4", "uart3 4p5", "uart3 2p6"};
 static const char * const mmp2_uart4_grps[] = {"uart4 4p1", "uart4 4p2",
-- 
1.7.9.5
