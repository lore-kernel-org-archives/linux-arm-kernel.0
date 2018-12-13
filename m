Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30403C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 028912075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KhDjbOGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 028912075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JSVKxAXHmORnnnUo0AxEhssy/uIYhwW+sMsTZ586fmE=; b=KhDjbOGaVv41NY
	2zg/A5TFZezaeu6EptdKh4Kii7bxIuIthIZP4eeb4ca3faVTfFi+0WYeRl/eO1Fg9E7qnGga1yc/x
	iyLoJqtmJzk9QWezgJhJkerP6ycqbU6QwVq5pMeorMKhihiZlrES+8VxtFxJ03n1325TUoMV0Xtg6
	FkG6+EVnrNlO/0aBbzerTA++WtLr7U2to8WjwUgIkiVCTg9VRBp0/169fX1TfrsXFL/fdOF6JRUUm
	WGZ5WxJVO5vUA5gGGLr4QtKwloCLd4Ws5ZfjbyN9ugBGcvoX5gNNODofmZtz4rZz/cEwg3iCxMLfZ
	S4aTZ7NSmADoac3SC+iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXMZF-0006Ac-TA; Thu, 13 Dec 2018 08:42:02 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXMXK-0002zS-6g; Thu, 13 Dec 2018 08:40:20 +0000
Received: from localhost.localdomain (10.28.8.16) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 13 Dec 2018
 16:39:57 +0800
From: Sunny Luo <sunny.luo@amlogic.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/3] spi: meson-axg: support MAX 80M clock
Date: Thu, 13 Dec 2018 16:39:12 +0800
Message-ID: <1544690354-16409-2-git-send-email-sunny.luo@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
MIME-Version: 1.0
X-Originating-IP: [10.28.8.16]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_004002_851527_9A813CAB 
X-CRM114-Status: GOOD (  11.49  )
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
Cc: Jianxin Pan <jianxin.pan@amlogic.com>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Sunny Luo <sunny.luo@amlogic.com>, Xingyu Chen <xingyu.chen@amlogic.com>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The SPICC controller in Meson-AXG is capable of running at 80M clock.
The ASIC IP is improved and the clock is actually running higher than
previous old SoCs.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/spi/spi-meson-spicc.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 7fe4488..b56249d 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -9,11 +9,13 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
@@ -34,7 +36,6 @@
  *   to have a CS go down over the full transfer
  */
 
-#define SPICC_MAX_FREQ	30000000
 #define SPICC_MAX_BURST	128
 
 /* Register Map */
@@ -120,6 +121,10 @@
 #define SPICC_BURST_MAX	16
 #define SPICC_FIFO_HALF 10
 
+struct meson_spicc_data {
+	unsigned int			max_speed_hz;
+};
+
 struct meson_spicc_device {
 	struct spi_master		*master;
 	struct platform_device		*pdev;
@@ -127,6 +132,7 @@ struct meson_spicc_device {
 	struct clk			*core;
 	struct spi_message		*message;
 	struct spi_transfer		*xfer;
+	const struct meson_spicc_data	*data;
 	u8				*tx_buf;
 	u8				*rx_buf;
 	unsigned int			bytes_per_word;
@@ -517,6 +523,9 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	spicc->pdev = pdev;
 	platform_set_drvdata(pdev, spicc);
 
+	spicc->data = (const struct meson_spicc_data *)
+		of_device_get_match_data(&pdev->dev);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	spicc->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(spicc->base)) {
@@ -567,11 +576,9 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	master->unprepare_transfer_hardware = meson_spicc_unprepare_transfer;
 	master->transfer_one = meson_spicc_transfer_one;
 
-	/* Setup max rate according to the Meson GX datasheet */
-	if ((rate >> 2) > SPICC_MAX_FREQ)
-		master->max_speed_hz = SPICC_MAX_FREQ;
-	else
-		master->max_speed_hz = rate >> 2;
+	/* Setup max rate according to the Meson datasheet */
+	master->max_speed_hz = min_t(unsigned int, rate >> 1,
+				     spicc->data->max_speed_hz);
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
@@ -602,9 +609,23 @@ static int meson_spicc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct meson_spicc_data meson_spicc_gx_data = {
+	.max_speed_hz	= 30000000,
+};
+
+static const struct meson_spicc_data meson_spicc_axg_data = {
+	.max_speed_hz	= 80000000,
+};
+
 static const struct of_device_id meson_spicc_of_match[] = {
-	{ .compatible = "amlogic,meson-gx-spicc", },
-	{ .compatible = "amlogic,meson-axg-spicc", },
+	{
+		.compatible	= "amlogic,meson-gx-spicc",
+		.data		= &meson_spicc_gx_data,
+	},
+	{
+		.compatible = "amlogic,meson-axg-spicc",
+		.data		= &meson_spicc_axg_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_spicc_of_match);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
