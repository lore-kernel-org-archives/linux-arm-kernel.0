Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1E2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:50:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA5320881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LhZswZjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA5320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yTEgU3w1vdlaqIcjunnGaXMxfky0pywlJ0Q3oFch8dc=; b=LhZswZjAWWiClJ
	BuYx5rubBShMGasG6InsM6SKiYOZxRm9xnydACR4IEp4abbJarkur8utflPnkvq7ma2JgfdYG+n7l
	YYBXqUVUh7HkRCIcDSmDHwXED3gNafs7CEPgrO+Qr9qrn4x88pRZMzK5zPf11PW3Z/maCThoLewxN
	kuhF8a2PF4ekerv+4IjTfsuPXwU+65jWjdWescbOC9DOZ9ljg4z51ypjaVTAGFCqcxQoSjS/acHcH
	VvptI4NfpKCFsqyrqethY8ut/B0Nz+u0nIL/eOY2JxRO2d8VG1EzLXZV9oo8yep7WscMxHEvU13oP
	6pm7WiQ86/uJRAzo1dYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goWaX-0005LC-9I; Tue, 29 Jan 2019 16:50:17 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goWaR-0005AT-TF
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 16:50:15 +0000
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; d="scan'208";a="27013017"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 29 Jan 2019 09:50:09 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Tue, 29 Jan 2019 09:50:08 -0700
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH] mmc: atmel-mci: enable 8 bits buswidth support
Date: Tue, 29 Jan 2019 17:49:12 +0100
Message-ID: <20190129164950.31052-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_085012_080752_99EB3917 
X-CRM114-Status: GOOD (  10.38  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds support for 8-bit buswidth.
Relevant SDCR value modified.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/mmc/host/atmel-mci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 47189f9ed4e2..735aa5871358 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1410,6 +1410,9 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_BUS_WIDTH_4:
 		slot->sdc_reg |= ATMCI_SDCBUS_4BIT;
 		break;
+	case MMC_BUS_WIDTH_8:
+		slot->sdc_reg |= ATMCI_SDCBUS_8BIT;
+		break;
 	}
 
 	if (ios->clock) {
@@ -2275,8 +2278,11 @@ static int atmci_init_slot(struct atmel_mci *host,
 	 * use only one bit for data to prevent fifo underruns and overruns
 	 * which will corrupt data.
 	 */
-	if ((slot_data->bus_width >= 4) && host->caps.has_rwproof)
+	if ((slot_data->bus_width >= 4) && host->caps.has_rwproof) {
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
+		if (slot_data->bus_width >= 8)
+			mmc->caps |= MMC_CAP_8_BIT_DATA;
+	}
 
 	if (atmci_get_version(host) < 0x200) {
 		mmc->max_segs = 256;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
