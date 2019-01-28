Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D9AC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:57:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B627C20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y2El6tKb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="NJR5ZwPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B627C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=p1TUszxRFK2JO3QyO/lYYmJOvir6W9SrxgD36QucwZY=; b=Y2El6tKbVHSdpp
	Lr8hx2NsirkhBGmO5iPG9Rtcp9SMceswv0E7HKxMCpgr37pH3PPW82uqOC7GpnJChetD1d5uMjvmp
	3KUcXqd57WPia6MvaF1j8ktMDSuo4mgUgaHOBWWlGGZeclY+ZYhqNTspDVCFnGPeye6kg/z10QSpd
	K09stNr/+5xMCZdTKC88LEuvrRKfUYMBFMXdQkCl8lsV3I78Pz1HwhiDaTpn0exl5Lkc8XEji9OWx
	0YPtuNjH92tdsFHUk8Pp2r8OR985hBBnwxcguYVwNRW9lN+FCg6cKE4kls20ZMm8zO2x74MYnEGCB
	f07ePO0+i/474oemArDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go7PT-0002Ib-I4; Mon, 28 Jan 2019 13:57:11 +0000
Received: from mout01.posteo.de ([185.67.36.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go7PQ-0002Hd-7C
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 13:57:10 +0000
Received: from submission (posteo.de [89.146.220.130]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 76A59160064
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 14:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1548683823; bh=g6yNiMWn6EjFFGIM7uaWlBOhraSmLS6EY9e6o02kLro=;
 h=From:To:Cc:Subject:Date:From;
 b=NJR5ZwPnwhvcne+2mzo4wqPIPdaE3etkl6NWzvprvfGlzYe/sBEI3I43U6wdSEg7+
 SpavZhcEcZlQEU4d2GL/GFH822tBHg0cH/auRz9zk3JWtb4tyXmxAljfx1+udJJMDf
 0pS8yW0zh+ab4UrlCMhhuRSOasD1bghlYMl2apiRRRSFhioSQDfYS18icIxnVWLQo7
 c1hItkPbq4Yf7oErB++gtsxmWorDv48bdyzqrNqa3FQvv/Uy8i2a5eaNNZXTUwUZl8
 hIWTM+ZpCVwa7O3ULyfs+ZPQ33E8RSXPjNy9a2wWuE9R1j5SdfWuNvaQmdRUEaNnq7
 wfDFlZniuEoqw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 43pB5748rCz6tmG;
 Mon, 28 Jan 2019 14:56:59 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robin@protonic.nl, ulf.hansson@linaro.org
Subject: [PATCH v3] mmc: mxs-mmc: Introduce regulator support
Date: Mon, 28 Jan 2019 14:56:47 +0100
Message-Id: <20190128135647.20121-1-martink@posteo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_055708_702973_20DD2317 
X-CRM114-Status: GOOD (  13.40  )
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
which is needed for example for WL1837 WL1271 wifi controllers on imx28.

While the wifi's vmmc-supply regulator can be configured in devicetree,
"ip link set wlan0 down" doesn't turn off the VMMC regulator which leads
to hangs when loading firmware, for example.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---

Thanks Ulf for your review and keeping this up with the current API.            
                                                                                
                            martin                                              
                                                                                
                                                                                
revision history                                                                
----------------                                                                
v3: improve API usage as suggested by Ulf
v2: tested patch with changes suggested by Robin                                
v1: question, why https://patchwork.kernel.org/patch/4365751/ didn't get in



 drivers/mmc/host/mxs-mmc.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index add1e70195ea..af6068152929 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -517,6 +517,27 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		host->bus_width = 0;
 
+	if (host->mmc->supply.vmmc &&
+	    ios->power_mode != host->mmc->ios.power_mode) {
+		switch (ios->power_mode) {
+		case MMC_POWER_OFF:
+			if (mmc_regulator_set_ocr(host->mmc,
+						  host->mmc->supply.vmmc, 0))
+				dev_err(mmc_dev(host->mmc),
+					"Failed to disable vmmc regulator\n");
+			break;
+		case MMC_POWER_UP:
+			if (mmc_regulator_set_ocr(host->mmc,
+						  host->mmc->supply.vmmc,
+						  ios->vdd))
+				dev_err(mmc_dev(host->mmc),
+					"Failed to enable vmmc regulator\n");
+			break;
+		default:
+			break;
+		}
+	}
+
 	if (ios->clock)
 		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
 }
@@ -588,7 +609,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct resource *iores;
 	int ret = 0, irq_err;
-	struct regulator *reg_vmmc;
 	struct mxs_ssp *ssp;
 
 	irq_err = platform_get_irq(pdev, 0);
@@ -614,15 +634,9 @@ static int mxs_mmc_probe(struct platform_device *pdev)
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
-	}
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret)
+		goto out_mmc_free;
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk)) {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
