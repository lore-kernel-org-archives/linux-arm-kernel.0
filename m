Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BB3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:21:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D0921B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UNmlva7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D0921B68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1rFpTBHUZkgT11YWJkeTEq2dHIkHRNxZf3n39khbw+U=; b=UNmlva7Tz3l9HD
	yKaVPB66Vh8W9CsTPShOoIPyA9px0I2COWrswn12cPV/ke1Ky4LUKtLuS5LO1JSyD9kNLJsK2Pvrs
	+OQmGslNCwqYlf9+/UvH4z/a82Eu8x3XwtHQYYJQ+x+9QltRcIroKHK4QSJ3ehQIRadOjAU5UADB3
	fSQRWsn0U5/R6cTFu3WXJrzUCh5waR9dm3QFq8761YyMSgjYI4i4SymhDV4ZgBriEgREjwhVUgJia
	NOQnxNQg5paiCgMgTF++LPu8GAmABGZFbittvD0diyvhGTLDfrUrSJroh/sSOeoV8Ry/yvqzHgu5x
	Xd0OEGBSKZqhBzjVEhbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guQJx-0002AH-DN; Thu, 14 Feb 2019 23:21:33 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQId-0008Ko-Sc; Thu, 14 Feb 2019 23:20:22 +0000
X-UUID: 5cf1731bb9744704b89149eecca7a884-20190214
X-UUID: 5cf1731bb9744704b89149eecca7a884-20190214
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <sean.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1988041137; Thu, 14 Feb 2019 15:19:59 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 15:19:58 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 07:19:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 15 Feb 2019 07:19:42 +0800
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
 <johan.hedberg@gmail.com>
Subject: [PATCH 6/6] Bluetooth: mediatek: add support for MediaTek MT7663U and
 MT7668U UART devices
Date: Fri, 15 Feb 2019 07:19:38 +0800
Message-ID: <aa7ebe9c5935eae1df5528bf64ae9689996d06d7.1550184473.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550184473.git.sean.wang@mediatek.com>
References: <cover.1550184473.git.sean.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_152012_279114_9ED6A5D9 
X-CRM114-Status: GOOD (  21.74  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This adds the support of enabling MT7663U and MT7668U Bluetooth function
running on the top of btmtkuart driver.

There are a few differences between MT766[3,8]U and MT7622 where
MT766[3,8]U are standalone devices based on UART transport while MT7622
bluetooth is a built-in device on MediaTek SoC communicating with the host
through BTIF serial transport. Thus, extra setup sequence is necessary
for these standalone devices such as remote regulator and reset control via
GPIO, baud rate changing handshake between the host and device and so on.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtkuart.c | 281 ++++++++++++++++++++++++++++++++--
 1 file changed, 271 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index e73b1013ba73..b0b680dd69f4 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -12,11 +12,15 @@
 #include <linux/atomic.h>
 #include <linux/clk.h>
 #include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
 
@@ -25,18 +29,26 @@
 
 #include "h4_recv.h"
 
-#define VERSION "0.1"
+#define VERSION "0.2"
 
 #define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
+#define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
+#define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
 
 #define MTK_STP_TLR_SIZE	2
 
 #define BTMTKUART_TX_STATE_ACTIVE	1
 #define BTMTKUART_TX_STATE_WAKEUP	2
 #define BTMTKUART_TX_WAIT_VND_EVT	3
+#define BTMTKUART_REQUIRED_WAKEUP	4
+
+#define BTMTKUART_FLAG_STANDALONE_HW	 BIT(0)
 
 enum {
 	MTK_WMT_PATCH_DWNLD = 0x1,
+	MTK_WMT_TEST = 0x2,
+	MTK_WMT_WAKEUP = 0x3,
+	MTK_WMT_HIF = 0x4,
 	MTK_WMT_FUNC_CTRL = 0x6,
 	MTK_WMT_RST = 0x7,
 	MTK_WMT_SEMAPHORE = 0x17,
@@ -57,6 +69,11 @@ struct mtk_stp_hdr {
 	u8	cs;
 } __packed;
 
+struct btmtkuart_data {
+	unsigned int flags;
+	const char *fwname;
+};
+
 struct mtk_wmt_hdr {
 	u8	dir;
 	u8	op;
@@ -100,6 +117,14 @@ struct btmtkuart_dev {
 	struct serdev_device *serdev;
 	struct clk *clk;
 
+	struct regulator *vcc;
+	struct gpio_desc *reset;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_runtime;
+	struct pinctrl_state *pins_boot;
+	speed_t	desired_speed;
+	speed_t	curr_speed;
+
 	struct work_struct tx_work;
 	unsigned long tx_state;
 	struct sk_buff_head txq;
@@ -110,8 +135,15 @@ struct btmtkuart_dev {
 	u8	stp_pad[6];
 	u8	stp_cursor;
 	u16	stp_dlen;
+
+	const struct btmtkuart_data *data;
 };
 
+#define btmtkuart_is_standalone(bdev)	\
+	((bdev)->data->flags & BTMTKUART_FLAG_STANDALONE_HW)
+#define btmtkuart_is_builtin_soc(bdev)	\
+	!((bdev)->data->flags & BTMTKUART_FLAG_STANDALONE_HW)
+
 static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 			    struct btmtk_hci_wmt_params *wmt_params)
 {
@@ -202,7 +234,7 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	return err;
 }
 
-static int mtk_setup_fw(struct hci_dev *hdev)
+static int mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 {
 	struct btmtk_hci_wmt_params wmt_params;
 	const struct firmware *fw;
@@ -211,7 +243,7 @@ static int mtk_setup_fw(struct hci_dev *hdev)
 	int err, dlen;
 	u8 flag;
 
-	err = request_firmware(&fw, FIRMWARE_MT7622, &hdev->dev);
+	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
 		return err;
@@ -523,6 +555,23 @@ static int btmtkuart_open(struct hci_dev *hdev)
 		goto err_open;
 	}
 
+	if (btmtkuart_is_standalone(bdev)) {
+		if (bdev->curr_speed != bdev->desired_speed)
+			err = serdev_device_set_baudrate(bdev->serdev,
+							 115200);
+		else
+			err = serdev_device_set_baudrate(bdev->serdev,
+							 bdev->desired_speed);
+
+		if (err < 0) {
+			bt_dev_err(hdev, "Unable to set baudrate UART device %s",
+				   dev_name(&bdev->serdev->dev));
+			goto  err_serdev_close;
+		}
+
+		serdev_device_set_flow_control(bdev->serdev, false);
+	}
+
 	bdev->stp_cursor = 2;
 	bdev->stp_dlen = 0;
 
@@ -546,6 +595,8 @@ static int btmtkuart_open(struct hci_dev *hdev)
 	pm_runtime_put_sync(dev);
 err_disable_rpm:
 	pm_runtime_disable(dev);
+err_serdev_close:
+	serdev_device_close(bdev->serdev);
 err_open:
 	return err;
 }
@@ -606,8 +657,74 @@ static int btmtkuart_func_query(struct hci_dev *hdev)
 	return status;
 }
 
+static int btmtkuart_change_baudrate(struct hci_dev *hdev)
+{
+	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_hci_wmt_params wmt_params;
+	u32 baudrate;
+	u8 param;
+	int err;
+
+	/* Indicate the device to enter the probe state the host is
+	 * ready to change a new baudrate.
+	 */
+	baudrate = cpu_to_le32(bdev->desired_speed);
+	wmt_params.op = MTK_WMT_HIF;
+	wmt_params.flag = 1;
+	wmt_params.dlen = 4;
+	wmt_params.data = &baudrate;
+	wmt_params.status = NULL;
+
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to device baudrate (%d)", err);
+		return err;
+	}
+
+	err = serdev_device_set_baudrate(bdev->serdev,
+					 bdev->desired_speed);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to set up host baudrate (%d)",
+			   err);
+		return err;
+	}
+
+	serdev_device_set_flow_control(bdev->serdev, false);
+
+	/* Send a dummy byte 0xff to activate the new baudrate */
+	param = 0xff;
+	err = serdev_device_write(bdev->serdev, &param, sizeof(param),
+				  MAX_SCHEDULE_TIMEOUT);
+	if (err < 0 || err < sizeof(param))
+		return err;
+
+	serdev_device_wait_until_sent(bdev->serdev, 0);
+
+	/* Wait some time for the device changing baudrate done */
+	usleep_range(20000, 22000);
+
+	/* Test the new baudrate */
+	wmt_params.op = MTK_WMT_TEST;
+	wmt_params.flag = 7;
+	wmt_params.dlen = 0;
+	wmt_params.data = NULL;
+	wmt_params.status = NULL;
+
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to test new baudrate (%d)",
+			   err);
+		return err;
+	}
+
+	bdev->curr_speed = bdev->desired_speed;
+
+	return 0;
+}
+
 static int btmtkuart_setup(struct hci_dev *hdev)
 {
+	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
 	struct btmtk_hci_wmt_params wmt_params;
 	ktime_t calltime, delta, rettime;
 	struct btmtk_tci_sleep tci_sleep;
@@ -618,6 +735,28 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 
 	calltime = ktime_get();
 
+	/* Wakeup MCUSYS is required for certain devices before we start to
+	 * do any setups.
+	 */
+	if (test_bit(BTMTKUART_REQUIRED_WAKEUP, &bdev->tx_state)) {
+		wmt_params.op = MTK_WMT_WAKEUP;
+		wmt_params.flag = 3;
+		wmt_params.dlen = 0;
+		wmt_params.data = NULL;
+		wmt_params.status = NULL;
+
+		err = mtk_hci_wmt_sync(hdev, &wmt_params);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to wakeup the chip (%d)", err);
+			return err;
+		}
+
+		clear_bit(BTMTKUART_REQUIRED_WAKEUP, &bdev->tx_state);
+	}
+
+	if (btmtkuart_is_standalone(bdev))
+		btmtkuart_change_baudrate(hdev);
+
 	/* Query whether the firmware is already download */
 	wmt_params.op = MTK_WMT_SEMAPHORE;
 	wmt_params.flag = 1;
@@ -637,7 +776,7 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 	}
 
 	/* Setup a firmware which the device definitely requires */
-	err = mtk_setup_fw(hdev);
+	err = mtk_setup_firmware(hdev, bdev->data->fwname);
 	if (err < 0)
 		return err;
 
@@ -754,24 +893,82 @@ static int btmtkuart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static int btmtkuart_parse_dt(struct serdev_device *serdev)
+{
+	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
+	struct device_node *node = serdev->dev.of_node;
+	u32 speed = 921600;
+	int err;
+
+	if (btmtkuart_is_standalone(bdev)) {
+		of_property_read_u32(node, "current-speed", &speed);
+
+		bdev->desired_speed = speed;
+
+		bdev->vcc = devm_regulator_get(&serdev->dev, "vcc");
+		if (IS_ERR(bdev->vcc)) {
+			err = PTR_ERR(bdev->vcc);
+			return err;
+		}
+
+		bdev->pinctrl = devm_pinctrl_get(&serdev->dev);
+		if (IS_ERR(bdev->pinctrl)) {
+			err = PTR_ERR(bdev->pinctrl);
+			return err;
+		}
+
+		bdev->pins_boot = pinctrl_lookup_state(bdev->pinctrl,
+						       "default");
+		if (IS_ERR(bdev->pins_boot)) {
+			err = PTR_ERR(bdev->pins_boot);
+			return err;
+		}
+
+		bdev->pins_runtime = pinctrl_lookup_state(bdev->pinctrl,
+							  "runtime");
+		if (IS_ERR(bdev->pins_runtime)) {
+			err = PTR_ERR(bdev->pins_runtime);
+			return err;
+		}
+
+		bdev->reset = devm_gpiod_get_optional(&serdev->dev, "reset",
+						      GPIOD_OUT_LOW);
+		if (IS_ERR(bdev->reset)) {
+			err = PTR_ERR(bdev->reset);
+			return err;
+		}
+	} else if (btmtkuart_is_builtin_soc(bdev)) {
+		bdev->clk = devm_clk_get(&serdev->dev, "ref");
+		if (IS_ERR(bdev->clk))
+			return PTR_ERR(bdev->clk);
+	}
+
+	return 0;
+}
+
 static int btmtkuart_probe(struct serdev_device *serdev)
 {
 	struct btmtkuart_dev *bdev;
 	struct hci_dev *hdev;
+	int err;
 
 	bdev = devm_kzalloc(&serdev->dev, sizeof(*bdev), GFP_KERNEL);
 	if (!bdev)
 		return -ENOMEM;
 
-	bdev->clk = devm_clk_get(&serdev->dev, "ref");
-	if (IS_ERR(bdev->clk))
-		return PTR_ERR(bdev->clk);
+	bdev->data = of_device_get_match_data(&serdev->dev);
+	if (!bdev->data)
+		return -ENODEV;
 
 	bdev->serdev = serdev;
 	serdev_device_set_drvdata(serdev, bdev);
 
 	serdev_device_set_client_ops(serdev, &btmtkuart_client_ops);
 
+	err = btmtkuart_parse_dt(serdev);
+	if (err < 0)
+		return err;
+
 	INIT_WORK(&bdev->tx_work, btmtkuart_tx_work);
 	skb_queue_head_init(&bdev->txq);
 
@@ -798,13 +995,54 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 	hdev->manufacturer = 70;
 	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 
-	if (hci_register_dev(hdev) < 0) {
+	if (btmtkuart_is_standalone(bdev)) {
+		/* Switch to the specific pin state for the booting requires */
+		pinctrl_select_state(bdev->pinctrl, bdev->pins_boot);
+
+		/* Power on */
+		err = regulator_enable(bdev->vcc);
+		if (err < 0)
+			return err;
+
+		/* Reset if the reset-gpios is available otherwise the board
+		 * -level design should be guaranteed.
+		 */
+		if (bdev->reset) {
+			gpiod_set_value_cansleep(bdev->reset, 1);
+			usleep_range(1000, 2000);
+			gpiod_set_value_cansleep(bdev->reset, 0);
+		}
+
+		/* Wait some time until device got ready and switch to the pin
+		 * mode the device requires for UART transfers.
+		 */
+		msleep(50);
+		pinctrl_select_state(bdev->pinctrl, bdev->pins_runtime);
+
+		/* A standalone device doesn't depends on power domain on SoC,
+		 * so mark it as no callbacks.
+		 */
+		pm_runtime_no_callbacks(&serdev->dev);
+
+		set_bit(BTMTKUART_REQUIRED_WAKEUP, &bdev->tx_state);
+	}
+
+	err = hci_register_dev(hdev);
+	if (err < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		hci_free_dev(hdev);
-		return -ENODEV;
+		goto err_regulator_disable;
 	}
 
 	return 0;
+
+err_regulator_disable:
+	if (btmtkuart_is_standalone(bdev))  {
+		pinctrl_select_state(bdev->pinctrl, bdev->pins_boot);
+		regulator_disable(bdev->vcc);
+	}
+
+	return err;
 }
 
 static void btmtkuart_remove(struct serdev_device *serdev)
@@ -812,13 +1050,34 @@ static void btmtkuart_remove(struct serdev_device *serdev)
 	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
 	struct hci_dev *hdev = bdev->hdev;
 
+	if (btmtkuart_is_standalone(bdev))  {
+		pinctrl_select_state(bdev->pinctrl, bdev->pins_boot);
+		regulator_disable(bdev->vcc);
+	}
+
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 }
 
+static const struct btmtkuart_data mt7622_data = {
+	.fwname = FIRMWARE_MT7622,
+};
+
+static const struct btmtkuart_data mt7663_data = {
+	.flags = BTMTKUART_FLAG_STANDALONE_HW,
+	.fwname = FIRMWARE_MT7663,
+};
+
+static const struct btmtkuart_data mt7668_data = {
+	.flags = BTMTKUART_FLAG_STANDALONE_HW,
+	.fwname = FIRMWARE_MT7668,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id mtk_of_match_table[] = {
-	{ .compatible = "mediatek,mt7622-bluetooth"},
+	{ .compatible = "mediatek,mt7622-bluetooth", .data = &mt7622_data},
+	{ .compatible = "mediatek,mt7663u-bluetooth", .data = &mt7663_data},
+	{ .compatible = "mediatek,mt7668u-bluetooth", .data = &mt7668_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_of_match_table);
@@ -840,3 +1099,5 @@ MODULE_DESCRIPTION("MediaTek Bluetooth Serial driver ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FIRMWARE_MT7622);
+MODULE_FIRMWARE(FIRMWARE_MT7663);
+MODULE_FIRMWARE(FIRMWARE_MT7668);
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
