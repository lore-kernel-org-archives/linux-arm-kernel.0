Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A99BC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:14:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB8A20700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="la5FdIBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB8A20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oCA6JtrQB+FV9rmWUNl0VEzRFhF2pysfmDzD81Cb1zo=; b=la5FdIBeyZBiJ7
	Nf2IaFg5dwf0dkbJQcuqi8dhpL+daPGNW4zsX0npm8UevRPvppnmtWy4/0D+jRQNAK3TdIjsVGevW
	0X31yf2tF3Q/37qqNjGJPumszwP5x6UE+eqOD3Q/qBQ/+HCbyOQbB0hbOwGZM6ygxi7lia75KxEPH
	CDmTLQ8oj3K7hNCzUUZe02K2/JlBF9APWMfzdj5YK8LlKhAsd7EvOKnI1FZVeTrvWfVN/y8ymde8i
	bjczp5NN80NXyd9BeEpJ3MdiVFdlt+mpE/y0N+lGx7vhYFJW/+6INNqeIdYPEAlwhtJC2hYnHXoOa
	42eIYI1CgSLy7oZnDJDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvM9-0005sc-1s; Thu, 06 Dec 2018 15:14:25 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvLd-0005IG-Ug
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:13:59 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wB6FCLCh010541; Thu, 6 Dec 2018 16:13:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2p3wt6w3cp-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Thu, 06 Dec 2018 16:13:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E14983A;
 Thu,  6 Dec 2018 15:13:36 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B6CD84E1B;
 Thu,  6 Dec 2018 15:13:36 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.92) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 6 Dec 2018
 16:13:37 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 6 Dec 2018
 16:13:36 +0100
From: Ludovic Barre <ludovic.Barre@st.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH V3 1/2] mmc: mmci: add variant property to set command stop bit
Date: Thu, 6 Dec 2018 16:13:31 +0100
Message-ID: <1544109212-12621-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
References: <1544109212-12621-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_05:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_071354_277704_770EDB1B 
X-CRM114-Status: GOOD (  11.99  )
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

On cmd12 (STOP_TRANSMISSION), STM32 sdmmc variant needs to set
cmdstop bit in command register. The CPSM ("Command Path State Machine")
treats the command as a Stop Transmission command and signals
abort to the DPSM ("Data Path State Machine").

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 6 ++++++
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 13fa640..e352f5a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/highmem.h>
 #include <linux/log2.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/pm.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -274,6 +275,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.cmdreg_lrsp_crc	= MCI_CPSM_STM32_LRSP_CRC,
 	.cmdreg_srsp_crc	= MCI_CPSM_STM32_SRSP_CRC,
 	.cmdreg_srsp		= MCI_CPSM_STM32_SRSP,
+	.cmdreg_stop		= MCI_CPSM_STM32_CMDSTOP,
 	.data_cmd_enable	= MCI_CPSM_STM32_CMDTRANS,
 	.irq_pio_mask		= MCI_IRQ_PIO_STM32_MASK,
 	.datactrl_first		= true,
@@ -1100,6 +1102,10 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
 		mmci_reg_delay(host);
 	}
 
+	if (host->variant->cmdreg_stop &&
+	    cmd->opcode == MMC_STOP_TRANSMISSION)
+		c |= host->variant->cmdreg_stop;
+
 	c |= cmd->opcode | host->variant->cmdreg_cpsm_enable;
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136)
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 550dd39..2422909 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -264,6 +264,7 @@ struct mmci_host;
  * @cmdreg_lrsp_crc: enable value for long response with crc
  * @cmdreg_srsp_crc: enable value for short response with crc
  * @cmdreg_srsp: enable value for short response without crc
+ * @cmdreg_stop: enable value for stop and abort transmission
  * @datalength_bits: number of bits in the MMCIDATALENGTH register
  * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
  *	      is asserted (likewise for RX)
@@ -316,6 +317,7 @@ struct variant_data {
 	unsigned int		cmdreg_lrsp_crc;
 	unsigned int		cmdreg_srsp_crc;
 	unsigned int		cmdreg_srsp;
+	unsigned int		cmdreg_stop;
 	unsigned int		datalength_bits;
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
