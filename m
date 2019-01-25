Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090CBC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:35:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDD420870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X6OBhP5l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="cePDq5SO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDD420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2F1OrJNNCTaYo2G5OrxLIEjpRLjzYoRxF1oU0FfGDho=; b=X6OBhP5lETRE6R
	iCzG+k1tedWoqWDArMezWlmFtZsQExqOLOikXLgb9NhoG6TUyqN8EeHZItht2cD7mMVUXodv5zjW7
	g13I9t5LetpIfJ6swGyKcutoOYmUyqj/0plB5jV/w4/JwlAskqcbnZNcyPotOJwNXK88LGom3CWtg
	JURr7lDOwi5bsbSkCZWswAvB9zBflAfecWWcnTbdTqJ5wG0epiTbcj2bxkTablIdC+IlnlCzOjltt
	cdpkuyeIl8afg1Nu/AAoYQqsqm3OjV7mO/FzaOstQmufw+00Vjr9xRDSw5jJWxw1VUQQzJ37TT2j1
	7CZNCi6aDOHYGX2pakOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmzlL-00055q-8q; Fri, 25 Jan 2019 11:35:07 +0000
Received: from mout02.posteo.de ([185.67.36.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmzlH-00049T-Vz
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 11:35:06 +0000
Received: from submission (posteo.de [89.146.220.130]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 727F92400E5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 12:34:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1548416096; bh=oYyYmFp2j7XGH9Jl+ZPXOSkTm9PnOf7BpMey+cN1jYE=;
 h=From:To:Cc:Subject:Date:From;
 b=cePDq5SOum5Ho6JJ19cKN2939Od5ghBEK1UxkOer5Ow5KUDd01FWZYvhcarKUsk/S
 mO1tz4xeozyUbkTe7kAfbOPywnP8OuMxoSKXAya1PWxU6Drt2EGE2xisKtKzhd09GK
 rtJxkHYx2Bj4W1rwSs46GEvnKWpNY+3jzDVlZeTVbIzb1NwNbaWF4xLC395V1xPsF7
 9FhKplaAZhhxdAqc8+nrTc8Vqy1DIDAWIPyf3i+pnwCaVzumDqC5ludM5/1TVFFcYq
 iY2orQbBcIYafZbKqB4WCrGWcp5jIY3dYmjtS84EO+aPpJEBuntPZkP3Jo3fhlIr/v
 qK/svXf2eDdOQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 43mH4Z0Gx9z9rxh;
 Fri, 25 Jan 2019 12:34:53 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robin@protonic.nl
Subject: [PATCH] mmc: mxs-mmc: Introduce regulator support
Date: Fri, 25 Jan 2019 12:34:49 +0100
Message-Id: <20190125113449.10128-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_033504_224986_9A74F5F4 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: ulf.hansson@linaro.org, s.hauer@pengutronix.de,
 Martin Kepplinger <martin.kepplinger@ginzinger.com>,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

This adds support for explicitly switching the mmc's power on and off.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

This is not my patch. It's taken from https://patchwork.kernel.org/patch/4365751/
rebased and minimally changed; but we use this.

Are there any objections to this?

Robin, can I still add your Signed-off-by to this? Also, should I set you
as the author?

thanks,

                                martin

 drivers/mmc/host/mxs-mmc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70195ea..e3c19fabb723 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -517,6 +517,26 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	if (ios->power_mode != host->power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			if ((host->vmmc) && regulator_disable(host->vmmc)) {
+				dev_err(mmc_dev(host->mmc),
+					"Failed to disable vmmc regulator\n");
+			}
+			break;
+		case MMC_POWER_UP:
+			if ((host->vmmc) && regulator_enable(host->vmmc)) {
+				dev_err(mmc_dev(host->mmc),
+					"Failed to enable vmmc regulator\n");
+			}
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
