Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC0C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:41:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743AD20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="grslpYFk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Na15rwSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743AD20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KOPia2SM3ZCs/2jnkyRwUfk3j6D8RCPxkCYUj4dSVQs=; b=grslpYFk1lWAPp
	rCn6GVGJ99URvEu2+tI2PPI5QdKqiqGxrPb8Qe9IMtLWFXJbOwuBg9wKgO57C7lvHHKTzfot4Ux+M
	rupDN+VB5ylZDLTkQwyt1+Nf5PRTCDcQFQzt+zuMpcsYdyCw1lsHpOJA3Tu9Ve7O7pG/nMuJMsyMU
	GFNPnfohKEj3giax5R0UX6LqqbG2x/Er0NUYGhZLolGBomJhGorOc+LBGTF61MQ+uzxODNGaAPhSG
	rzUiWPabFCE7kaKQCoyfQmBS+nSWVvl5jKxz9uh0CwSLgDCsW1ozx/2VNxEq0Zj2OWHj4rkZqyT9u
	rHsy1NQQCqc6eclabDoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go86V-0006iT-KL; Mon, 28 Jan 2019 14:41:39 +0000
Received: from mout02.posteo.de ([185.67.36.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go86R-0006hZ-ON
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 14:41:37 +0000
Received: from submission (posteo.de [89.146.220.130]) 
 by mout02.posteo.de (Postfix) with ESMTPS id E18D62400E6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 15:41:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1548686491; bh=78zSCAFqEXwMnvzKrGeKAP95cmc72vwf2d7Yy5hAJDg=;
 h=From:To:Cc:Subject:Date:From;
 b=Na15rwSBdMgKfOzFBqgifPJVuGgAqvipKzEF4GR6QRvXpeZYCSsiVYrFB4zSLAaNJ
 Fds+t2kuDA3HO5NX4JEISQpYdPwVfT1rKIjDPr7sM42trCB42XUzj68fNqlMy9mrPN
 CLmxgPji9ljV+GGFsjyyDMeYy6EIbHFj+vSIEIAPTKM8gOyNviMpHuXR8R7fEVxMAE
 74zZ+VkyavE8eNRBALt/pPUOPLrjFnQnsAXzcW+a3T7h/FjK3X126xQ0sOIww5yDpY
 SaivJFJ0vsdHfkvcGxUQAU6U8HvcwvzLVphAJTZcVdcPgRmhkKi6A7SgPa6iXAxjU4
 SdinxxjErUegA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 43pC4R2Hpyz9rxB;
 Mon, 28 Jan 2019 15:41:27 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robin@protonic.nl
Subject: [PATCH v4] mmc: mxs-mmc: Introduce regulator support
Date: Mon, 28 Jan 2019 15:41:19 +0100
Message-Id: <20190128144119.10092-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_064136_077816_CC6FCFD7 
X-CRM114-Status: GOOD (  12.62  )
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

This adds support for explicitly switching the mmc's power on and off
which is needed for example for WL1837 WL1271 wifi controllers on imx28.

While the wifi's vmmc-supply regulator can be configured in devicetree,
"ip link set wlan0 down" doesn't turn off the VMMC regulator which leads
to hangs when loading firmware, for example.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---


revision history                                                               
----------------                                                               
v4: re-added forgotten regulator_enable() during probe
v3: improve API usage as suggested by Ulf
v2: tested patch with changes suggested by Robin                               
v1: question, why https://patchwork.kernel.org/patch/4365751/ didn't get in


 drivers/mmc/host/mxs-mmc.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70195ea..23d275269d61 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -517,6 +517,22 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	switch (ios->power_mode) {
+	case MMC_POWER_OFF:
+		if (!IS_ERR(host->mmc->supply.vmmc))
+			mmc_regulator_set_ocr(host->mmc,
+					      host->mmc->supply.vmmc, 0);
+		break;
+	case MMC_POWER_UP:
+		if (!IS_ERR(host->mmc->supply.vmmc))
+			mmc_regulator_set_ocr(host->mmc,
+					      host->mmc->supply.vmmc,
+					      ios->vdd);
+		break;
+	default:
+		break;
+	}
+
 	if (ios->clock)
 		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
 }
@@ -588,7 +604,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct resource *iores;
 	int ret = 0, irq_err;
-	struct regulator *reg_vmmc;
 	struct mxs_ssp *ssp;
 
 	irq_err = platform_get_irq(pdev, 0);
@@ -614,14 +629,15 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	host->mmc = mmc;
 	host->sdio_irq_en = 0;
 
-	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
-	if (!IS_ERR(reg_vmmc)) {
-		ret = regulator_enable(reg_vmmc);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"Failed to enable vmmc regulator: %d\n", ret);
-			goto out_mmc_free;
-		}
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret == -EPROBE_DEFER)
+		goto out_mmc_free;
+
+	ret = regulator_enable(mmc->supply.vmmc);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to enable vmmc regulator: %d\n", ret);
+		goto out_mmc_free;
 	}
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
