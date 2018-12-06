Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A95C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:14:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5002120700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lL0lVIVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5002120700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ofcT44bWE7jY9cD1H/vp7yYqKF2/iS7hx391fnlflVo=; b=lL0lVIVFFBrxeA
	W/MKwvqpTNcFDaEeSuUVxxsP54EN/HZ6Q6kYGi3gig7bg4nrp3qPrKia7WYjd6NzZeWAnJ+AwPDap
	aVrWSqCWPagq/QTUOOJWKrAo1JtOpKMf/32hDHEjnAsRMRw5cq7oZr/+kJbmp6KAU6cLa3t8gVLLC
	PoOZjfPORVP3TxzhfpVkDnJJsisxajjRCoTn17wFSdckir6FcxLhLXou5zsBRuGlio7jtjgpcxN+K
	Ns4wqUlCg5GHF6Oedma6gEnTHAynGrz88n/InOEesXNzm1tHbSxpVbEkKJyIkAwdgGcDKjavnh34N
	Lpf5MGf7RToewA+g4Ipg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvLw-0005gF-Gs; Thu, 06 Dec 2018 15:14:12 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvLd-0005KV-Uh
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:13:59 +0000
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB6FBWnw024845; Thu, 6 Dec 2018 16:13:41 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p53mbc4ps-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 06 Dec 2018 16:13:41 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 423C734;
 Thu,  6 Dec 2018 15:13:40 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1B4194E1D;
 Thu,  6 Dec 2018 15:13:40 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 6 Dec 2018
 16:13:40 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 6 Dec 2018
 16:13:37 +0100
From: Ludovic Barre <ludovic.Barre@st.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH V3 2/2] mmc: mmci: send stop command to clear the dpsm
Date: Thu, 6 Dec 2018 16:13:32 +0100
Message-ID: <1544109212-12621-3-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_05:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_071354_286509_E5F9D831 
X-CRM114-Status: GOOD (  15.52  )
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

The current approach with sending a CMD12 (STOP_TRANSMISSION) to
complete a data transfer request, either because of using the open
ended transmission type or because of receiving an error during a data
transfer, isn't sufficient for the STM32 sdmmc variant.

More precisely, for STM32 sdmmc the DPSM ("Data Path State Machine")
needs to be cleared by sending a CMD12, also for the so called ADTC
commands. For this reason, let the driver send a CMD12 to complete
ADTC commands, in case it's set (depend of cmdreg_stop variant property).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index e352f5a..4e5643d 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -58,6 +58,8 @@ void sdmmc_variant_init(struct mmci_host *host);
 #else
 static inline void sdmmc_variant_init(struct mmci_host *host) {}
 #endif
+static void
+mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c);
 
 static unsigned int fmax = 515633;
 
@@ -572,9 +574,37 @@ void mmci_dma_error(struct mmci_host *host)
 		host->ops->dma_error(host);
 }
 
+static int mmci_stop_command(struct mmci_host *host, struct mmc_request *mrq)
+{
+	u32 dpsm;
+
+	/*
+	 * If an error happens on command or data transmission
+	 * the DPSM stay enabled. The CPSM required a stop command
+	 * to reinitialize the DPSM.
+	 */
+	dpsm = readl_relaxed(host->base + MMCISTATUS);
+	dpsm &= MCI_STM32_DPSMACTIVE;
+
+	if (dpsm && ((mrq->cmd && mrq->cmd->error) ||
+		     (mrq->data && mrq->data->error))) {
+		mmci_start_command(host, &host->stop_abort, 0);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
+	/*
+	 * For variant with cmdstop bit, a stop command could be needed
+	 * to finish the request.
+	 */
+	if (host->variant->cmdreg_stop && mmci_stop_command(host, mrq))
+		return;
+
 	writel(0, host->base + MMCICOMMAND);
 
 	BUG_ON(host->data);
@@ -1956,6 +1986,13 @@ static int mmci_probe(struct amba_device *dev,
 		mmc->max_busy_timeout = 0;
 	}
 
+	/* prepare the stop command, used to abort and reinitialized the DPSM */
+	if (variant->cmdreg_stop) {
+		host->stop_abort.opcode = MMC_STOP_TRANSMISSION;
+		host->stop_abort.arg = 0;
+		host->stop_abort.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	}
+
 	mmc->ops = &mmci_ops;
 
 	/* We support these PM capabilities. */
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 2422909..35372cd 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -161,6 +161,7 @@
 #define MCI_ST_CEATAEND		(1 << 23)
 #define MCI_ST_CARDBUSY		(1 << 24)
 /* Extended status bits for the STM32 variants */
+#define MCI_STM32_DPSMACTIVE	BIT(12)
 #define MCI_STM32_BUSYD0	BIT(20)
 
 #define MMCICLEAR		0x038
@@ -377,6 +378,7 @@ struct mmci_host {
 	void __iomem		*base;
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
+	struct mmc_command	stop_abort;
 	struct mmc_data		*data;
 	struct mmc_host		*mmc;
 	struct clk		*clk;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
