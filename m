Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031A6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:21:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C590021872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ufnxK98a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C590021872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8HDzLk2B2VGRWPQMyFGdrr7T+6sFjub068TpahhE/50=; b=ufnxK98a1lbDz2
	UYpBzqFb5BHpeS7Ghmose7ytl51bgV3saJUp+watnB/ylxCGyV+ulEGsevY+oT3jj257KOaxT6eS2
	xmmIbiGfQIoahOxfzD1SczUbVUicjByfGtLFBI4EQ3OOih1GhAbq1of3cYdloYLb/cPVdm5sv9UPU
	EFw1UipjngtCg2BJEE4E+MzwRcZoFtOFkikLo5fg+QItj0b3K6SOkepU6gWSfXQQx3N+xi7ltl/UL
	ziSIaDMCnStRX8LdhdFHiquH+WPphGgSDUAUVHj84uUE0mZDaWfQCgGTpwLck8gSgrOS4LapGwO1Z
	eO99kINPtdsWPJLcr+hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guQJa-0001lF-5M; Thu, 14 Feb 2019 23:21:10 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guQIa-0008Ko-8O; Thu, 14 Feb 2019 23:20:11 +0000
X-UUID: c4fd929f3d2942c6b64e392488711833-20190214
X-UUID: c4fd929f3d2942c6b64e392488711833-20190214
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <sean.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 104081332; Thu, 14 Feb 2019 15:19:59 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 15:19:57 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 07:19:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 15 Feb 2019 07:19:42 +0800
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
 <johan.hedberg@gmail.com>
Subject: [PATCH 4/6] Bluetooth: mediatek: pass a pointer to mtk_hci_wmt_sync
Date: Fri, 15 Feb 2019 07:19:36 +0800
Message-ID: <614e7741328e835071099ddcd4f9c2afd9528534.1550184473.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550184473.git.sean.wang@mediatek.com>
References: <cover.1550184473.git.sean.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_152008_328706_87CD03E3 
X-CRM114-Status: GOOD (  11.37  )
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

Pass a structure pointer to mtk_hci_wmt_sync rather than several arguments
to avoid take up additional stack area and be better to read the code.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtkuart.c | 63 ++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 9f8177b216b6..4451b1db139a 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -58,6 +58,14 @@ struct mtk_hci_wmt_cmd {
 	u8 data[256];
 } __packed;
 
+struct btmtk_hci_wmt_params {
+	u8 op;
+	u8 flag;
+	u16 dlen;
+	const void *data;
+	u32 *status;
+};
+
 struct btmtkuart_dev {
 	struct hci_dev *hdev;
 	struct serdev_device *serdev;
@@ -74,8 +82,8 @@ struct btmtkuart_dev {
 	u16	stp_dlen;
 };
 
-static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
-			    const void *param)
+static int mtk_hci_wmt_sync(struct hci_dev *hdev,
+			    struct btmtk_hci_wmt_params *wmt_params)
 {
 	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
 	struct mtk_hci_wmt_cmd wc;
@@ -83,16 +91,16 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
 	u32 hlen;
 	int err;
 
-	hlen = sizeof(*hdr) + plen;
+	hlen = sizeof(*hdr) + wmt_params->dlen;
 	if (hlen > 255)
 		return -EINVAL;
 
 	hdr = (struct mtk_wmt_hdr *)&wc;
 	hdr->dir = 1;
-	hdr->op = op;
-	hdr->dlen = cpu_to_le16(plen + 1);
-	hdr->flag = flag;
-	memcpy(wc.data, param, plen);
+	hdr->op = wmt_params->op;
+	hdr->dlen = cpu_to_le16(wmt_params->dlen + 1);
+	hdr->flag = wmt_params->flag;
+	memcpy(wc.data, wmt_params->data, wmt_params->dlen);
 
 	set_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state);
 
@@ -130,6 +138,7 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
 
 static int mtk_setup_fw(struct hci_dev *hdev)
 {
+	struct btmtk_hci_wmt_params wmt_params;
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	size_t fw_size;
@@ -155,6 +164,9 @@ static int mtk_setup_fw(struct hci_dev *hdev)
 	fw_ptr += 30;
 	flag = 1;
 
+	wmt_params.op = MTK_WMT_PATCH_DWNLD;
+	wmt_params.status = NULL;
+
 	while (fw_size > 0) {
 		dlen = min_t(int, 250, fw_size);
 
@@ -164,8 +176,11 @@ static int mtk_setup_fw(struct hci_dev *hdev)
 		else if (fw_size < fw->size - 30)
 			flag = 2;
 
-		err = mtk_hci_wmt_sync(hdev, MTK_WMT_PATCH_DWNLD, flag, dlen,
-				       fw_ptr);
+		wmt_params.flag = flag;
+		wmt_params.dlen = dlen;
+		wmt_params.data = fw_ptr;
+
+		err = mtk_hci_wmt_sync(hdev, &wmt_params);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
 				   err);
@@ -469,6 +484,7 @@ static int btmtkuart_flush(struct hci_dev *hdev)
 
 static int btmtkuart_setup(struct hci_dev *hdev)
 {
+	struct btmtk_hci_wmt_params wmt_params;
 	u8 param = 0x1;
 	int err = 0;
 
@@ -477,16 +493,27 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
-	/* Activate function the firmware providing to */
-	err = mtk_hci_wmt_sync(hdev, MTK_WMT_RST, 0x4, 0, 0);
+	wmt_params.op = MTK_WMT_RST;
+	wmt_params.flag = 4;
+	wmt_params.dlen = 0;
+	wmt_params.data = NULL;
+	wmt_params.status = NULL;
+
+	/* Activate funciton the firmware providing to */
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
 		return err;
 	}
 
 	/* Enable Bluetooth protocol */
-	err = mtk_hci_wmt_sync(hdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param),
-			       &param);
+	wmt_params.op = MTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 0;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
 		return err;
@@ -497,12 +524,18 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 
 static int btmtkuart_shutdown(struct hci_dev *hdev)
 {
+	struct btmtk_hci_wmt_params wmt_params;
 	u8 param = 0x0;
 	int err;
 
 	/* Disable the device */
-	err = mtk_hci_wmt_sync(hdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param),
-			       &param);
+	wmt_params.op = MTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 0;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
 		return err;
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
