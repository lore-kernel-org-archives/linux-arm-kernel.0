Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83418C282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:20:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC5F20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rtqWCtaA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="FUL4cGIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC5F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jbgtjh0WoZVDePIoQjhby0d0f1c3rI8TWD4cgfDA+6w=; b=rtqWCtaA6wzk7I
	HRkrbE39+zN1PKwvERCPt0+0ZM4UIoKBY0IrLUHV8nUP0tWo/aPzgt8OylSjFt8Z2NXCzWJ9ICDMF
	PxFMEAehMnSLG1cL1LQbttqid0iIk0e3gp4GozE5kynCiYtQHvTeIiqYub/9V/F5YtKTF1czNTtAv
	dQeHMGbE1Z2cIGuGEQ0L+Zx2UZQxYvesrL40wiz7ysfxSC7Fnytv7FIpR/INooOdMN7SrExXOTUfu
	MIkUyboHzNr9yFOAcAgv1T5yuRsOX/fkDulBi2nin4GVIk+XrQ7aiwLN+DsndK+qJUnOwHiyoqiex
	Mscnj8iNLKPQY/Vz2NKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go41z-0004ar-Vi; Mon, 28 Jan 2019 10:20:43 +0000
Received: from mout02.posteo.de ([185.67.36.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go41v-0004Tw-TS
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:20:42 +0000
Received: from submission (posteo.de [89.146.220.130]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 869EE2400FB
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 11:20:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1548670828; bh=R2SL3qXPRrTk5inyV+kmoVKVzKoBzirKte3NylclSkY=;
 h=From:To:Cc:Subject:Date:From;
 b=FUL4cGIP5kOvXbqr6X9wEmCXPGQmSukbLd76m5DpKSxFYCmb1e1yJMl/oWEimP6MC
 wRF6/rhvOMpudAX9gOoM4NeOh/DSJjINTQlBd0xZM8V55iq6v7fg/Tltf0M+7ltsRJ
 EjVcZztNLQ5e+QZbsG9kcdD8Vhm6GcW/J+eG1nLgB29Ep7NFlZ9XI+dMKaYAxT9xRP
 VVIOR6IsUQC1fs0GqlSez2rHt97qUusOi6zBX0kJ4wR/zesLLq2xg41oXUaFtSyUN9
 kKXX6NZGITHsv2henaEVjZ2T+zI/xPnzGjnUcMbfBV+KCHJEEZYMBSG8D1bkcRQyyi
 /8QNLMoDVNJ1A==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 43p5HF6Kdfz9rxb;
 Mon, 28 Jan 2019 11:20:25 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robin@protonic.nl, ulf.hansson@linaro.org
Subject: [PATCH v2] mmc: mxs-mmc: Introduce regulator support
Date: Mon, 28 Jan 2019 11:20:22 +0100
Message-Id: <20190128102022.1880-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_022040_095502_691AD2F2 
X-CRM114-Status: GOOD (  13.37  )
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
Cc: s.hauer@pengutronix.de, Martin Kepplinger <martin.kepplinger@ginzinger.com>,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 shawnguo@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

This adds support for explicitly switching the mmc's power on and off
which is needed for example for WL1837 wifi controllers. ip link set wlan0 down
doesn't turn off the VMMC regulator which leads to hangs when loading firmware.

Tested on i.MX28.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

again, this isn't new. it's (rebased and simplified)
https://patchwork.kernel.org/patch/4365751/

Thanks Robin for your input!

revision history
----------------
v1: was just a question why this hasn't gone in earlier.


 drivers/mmc/host/mxs-mmc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70195ea..fdaca0fcec99 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -66,11 +66,13 @@ struct mxs_mmc_host {
 	struct mmc_request		*mrq;
 	struct mmc_command		*cmd;
 	struct mmc_data			*data;
+	struct regulator		*vmmc;
 
 	unsigned char			bus_width;
 	spinlock_t			lock;
 	int				sdio_irq_en;
 	bool				broken_cd;
+	unsigned char			power_mode;
 };
 
 static int mxs_mmc_get_cd(struct mmc_host *mmc)
@@ -517,6 +519,24 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	if (host->vmmc && ios->power_mode != host->power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			if (regulator_disable(host->vmmc))
+				dev_err(mmc_dev(host->mmc),
+					"Failed to disable vmmc regulator\n");
+			break;
+		case MMC_POWER_UP:
+			if (regulator_enable(host->vmmc))
+				dev_err(mmc_dev(host->mmc),
+					"Failed to enable vmmc regulator\n");
+			break;
+		default:
+			break;
+		}
+		host->power_mode = ios->power_mode;
+	}
+
 	if (ios->clock)
 		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
 }
@@ -613,16 +633,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 
 	host->mmc = mmc;
 	host->sdio_irq_en = 0;
+	host->power_mode = MMC_POWER_OFF;
 
 	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
-	if (!IS_ERR(reg_vmmc)) {
-		ret = regulator_enable(reg_vmmc);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable vmmc regulator: %d\n", ret);
-			goto out_mmc_free;
-		}
-	}
+	if (!IS_ERR(reg_vmmc))
+		host->vmmc = reg_vmmc;
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk)) {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
