Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7BCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:27:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA83821934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jt6Be6eb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA83821934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wa9+v+5TVOuOsQl5nXlRDrehXHGbm8RRkXI1CijYUoo=; b=jt6Be6ebJGDyfk
	KOTtrm8TL2QJI1utBywi8XaXmA+J3qO0ClMK1FhswdWuUBt7BqyvMlLmhyTz78UySedQxMznBdlIo
	ABIATLoBgJyp8MbAp/ZogHTWD4T8lUOscu2KOhCek+gax3dZ72hF9eyBp9h8xEIt1hM+ns0i5Hy5G
	TIl/pINlWOjLc/tSNKS93YNRtIF3AdwXxt6m9gYw0bt9abNp2VVzzrM7Q4QdyUMX7gbTo+qfGh3Cu
	84s5u1lSRVTyH9KN190dxAjqtEAbcloxFTyqNOZUQUeDia0I/1LBJekM/BCMyncKwgehhwxuyicQ9
	/zSUnjwFsApUxVbjPa/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gansJ-0000tA-6M; Sat, 22 Dec 2018 20:27:55 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ganrN-0008AZ-Ou
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 20:27:00 +0000
Received: from localhost (p54B67A8B.dip0.t-ipconnect.de [84.182.122.139])
 by pokefinder.org (Postfix) with ESMTPSA id 8A9602E35D3;
 Sat, 22 Dec 2018 21:26:37 +0100 (CET)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH v2 6/9] i2c: sprd: don't use pdev as variable name for struct
 device *
Date: Sat, 22 Dec 2018 21:26:20 +0100
Message-Id: <20181222202623.4521-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_122658_142873_F32726EA 
X-CRM114-Status: UNSURE (   9.54  )
X-CRM114-Notice: Please train this message.
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>, Baolin Wang <baolin.wang@linaro.org>,
 Orson Zhai <orsonzhai@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pointer to a device is usually named 'dev'. These 'pdev' here look
much like copy&paste errors. Fix them to avoid confusion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/i2c/busses/i2c-sprd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index a94e724f51dc..e266d8a713d9 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -586,40 +586,40 @@ static int sprd_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused sprd_i2c_suspend_noirq(struct device *pdev)
+static int __maybe_unused sprd_i2c_suspend_noirq(struct device *dev)
 {
-	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
 
 	i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 	i2c_dev->is_suspended = true;
 	i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 
-	return pm_runtime_force_suspend(pdev);
+	return pm_runtime_force_suspend(dev);
 }
 
-static int __maybe_unused sprd_i2c_resume_noirq(struct device *pdev)
+static int __maybe_unused sprd_i2c_resume_noirq(struct device *dev)
 {
-	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
 
 	i2c_lock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 	i2c_dev->is_suspended = false;
 	i2c_unlock_bus(&i2c_dev->adap, I2C_LOCK_ROOT_ADAPTER);
 
-	return pm_runtime_force_resume(pdev);
+	return pm_runtime_force_resume(dev);
 }
 
-static int __maybe_unused sprd_i2c_runtime_suspend(struct device *pdev)
+static int __maybe_unused sprd_i2c_runtime_suspend(struct device *dev)
 {
-	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
 
 	clk_disable_unprepare(i2c_dev->clk);
 
 	return 0;
 }
 
-static int __maybe_unused sprd_i2c_runtime_resume(struct device *pdev)
+static int __maybe_unused sprd_i2c_runtime_resume(struct device *dev)
 {
-	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
+	struct sprd_i2c *i2c_dev = dev_get_drvdata(dev);
 	int ret;
 
 	ret = clk_prepare_enable(i2c_dev->clk);
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
