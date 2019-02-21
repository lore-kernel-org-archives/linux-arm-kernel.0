Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40214C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:11:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1202321738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PVKGcfpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1202321738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T8BJGea/uYXyu6Be7f+yE1TT74Nwz54JDwhBmxtUp2E=; b=PVKGcfpCr6s6sx
	ZRr0L01jKFysH5jaxWH27WBomruibbA8jbLueCgI+x1tfAr5SKSwDvBKRX8mpuRueU+ootqFzDzEU
	IPSrlkez6MTQnCaG4rVm0qg5avfKG3biNG5WDSufSpDhIf9pbgPahVjZD6M+Hcd6m+0pV1HGgcO1g
	7gZR118PL5nhd2E+7L9WdRozHfOyqPppJdzOB7LSFqxC6WKkmTIJwYOZdn8umowlqPkFyWU9Fa7Zy
	tTli4otMQhY8WbmFojPwgQa5JHk+kzKeIKUa1wMpfcYFUvlwvvaLinAF1EF2HZrzSPNXplzaR96xW
	bmPA6AseTisVSHWS6+uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlK6-0008Tg-Hq; Thu, 21 Feb 2019 10:11:22 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlK3-0008Sk-4x
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 10:11:21 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1LA6sRO023425; Thu, 21 Feb 2019 11:11:12 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qsbm9bt6j-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 21 Feb 2019 11:11:12 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 162A149;
 Thu, 21 Feb 2019 10:11:11 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8E16B2858;
 Thu, 21 Feb 2019 10:11:10 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Feb
 2019 11:11:10 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Feb
 2019 11:11:09 +0100
From: Ludovic Barre <ludovic.Barre@st.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 2/2] mmc: mmci: add quirk property to add stm32 transfer mode
Date: Thu, 21 Feb 2019 11:10:51 +0100
Message-ID: <1550743851-13588-3-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-21_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_021119_481002_C547334A 
X-CRM114-Status: GOOD (  12.70  )
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
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 srinivas.kandagatla@linaro.org, Ludovic Barre <ludovic.barre@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds a quirk bit to define specific stm32 transfer
modes. sdmmc data transfer mode selection could be:
-Block data transfer ending on block count.
-SDIO multibyte data transfer.
-MMC Stream data transfer (not used).
-Block data transfer ending with STOP_TRANSMISSION command.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 11 +++++++++++
 drivers/mmc/host/mmci.h |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 387ff14..44c721a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -284,6 +284,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datactrl_blocksz	= 14,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
 	.init			= sdmmc_variant_init,
+	.quirks			= MMCI_QUIRK_STM32_DTMODE,
 };
 
 static struct variant_data variant_qcom = {
@@ -1028,6 +1029,16 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	else
 		datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
 
+	if (variant->quirks & MMCI_QUIRK_STM32_DTMODE) {
+		if (host->mmc->card && mmc_card_sdio(host->mmc->card) &&
+		    data->blocks == 1)
+			datactrl |= MCI_DPSM_STM32_MODE_SDIO;
+		else if (data->stop && !host->mrq->sbc)
+			datactrl |= MCI_DPSM_STM32_MODE_BLOCK_STOP;
+		else
+			datactrl |= MCI_DPSM_STM32_MODE_BLOCK;
+	}
+
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 474f4fa..9fbd0a4 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -131,6 +131,11 @@
 /* Control register extensions in the Qualcomm versions */
 #define MCI_DPSM_QCOM_DATA_PEND	BIT(17)
 #define MCI_DPSM_QCOM_RX_DATA_PEND BIT(20)
+/* Control register extensions in STM32 versions */
+#define MCI_DPSM_STM32_MODE_BLOCK	(0 << 2)
+#define MCI_DPSM_STM32_MODE_SDIO	(1 << 2)
+#define MCI_DPSM_STM32_MODE_STREAM	(2 << 2)
+#define MCI_DPSM_STM32_MODE_BLOCK_STOP	(3 << 2)
 
 #define MMCIDATACNT		0x030
 #define MMCISTATUS		0x034
@@ -357,6 +362,8 @@ struct variant_data {
 	void (*init)(struct mmci_host *host);
 };
 
+#define MMCI_QUIRK_STM32_DTMODE	BIT(0)
+
 /* mmci variant callbacks */
 struct mmci_host_ops {
 	int (*validate_data)(struct mmci_host *host, struct mmc_data *data);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
