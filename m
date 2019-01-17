Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E093CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:16:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B051020657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BZt+xpuq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGdD4FKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B051020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=66DxeBcmxFXMKjk7Hm0yPxj47tUCykh6QEqFXbLlSqo=; b=BZt+xpuq612oXr
	Jk33mpLeScdoVNPSm7rn1800NstJjn84GsO9NNMRTmWYlU2P90y954mZ9QzAEO/Q131TEqj51rA+b
	hDBCEWPW2oopmMqB5o/w7KPIDDE3UZO9w++Q0wIfQTLdr3xtX9CQutIWi+jCkArVSRe0UqyJkJoOt
	kQNI8n2k4HXiFsdeYsNrWli6lCKtzWM5cNh6kJTEzgxfEu7W94fjM4qg6lHUCmgNBCPS/zBLGEOoS
	2V/IrtZYL4mM/nsMVsayo4Prjr1IwmMK4sKyKF9xJHXFuaPw7VDRhIMYvp8Tbv+xGfWenwHTgWL2P
	LOtHXdtg5vWIws1MBVcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkD9E-0005dp-Ib; Thu, 17 Jan 2019 19:16:16 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkD9A-0005dP-VV
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 19:16:14 +0000
Received: by mail-lj1-x243.google.com with SMTP id n18-v6so9540946lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 11:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1tKmRB7GJaHSSkIUDoo2AkZBmBsvmRkAjrjhw9AzhMk=;
 b=nGdD4FKDQtKcvmuUXxXQ0m9Wgo2DnotcIIpIJPA/G2e3hbtO1+V0d0mpyNv6bS+avf
 CDEEBrTrpDOPvOq8I+iOq+D1VIOdy4k6tCR2gfPL79JBxycC4+pUhbxM28HMXGMBCIWU
 clgNDHhKqwNUUqqIeRWIZQrk+IBHEgVKHZD/FfxrVw8eopvcOXgSWOmvURayTLilcZ3V
 3ybcdbUKFF6zDfIISo/6onWATA3vJaKgAMHXHdQvVa4xuFaqlNPwwJR/G14mhzIljNRL
 ZEVLPR94wmz37FCjKJbw4ii/6DSCsHJ1VDyjR+q3fFZLcIjksn4ukXBgwGkRWx/ZP6Bp
 QHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=1tKmRB7GJaHSSkIUDoo2AkZBmBsvmRkAjrjhw9AzhMk=;
 b=OTrhiSjTIfbk6pRYuHXVGdZJtie5oa8shc40vk4f7iLeQ/Mo1JsTYwKxtON+PsxF+d
 iBZ8OqnYrYmx+RS42m4Nggypuk1fAGp09YSmkqOg6UWsToTz0yY7i0Y6Ls558ev4DuHV
 aqLMV6SEtJKfDYvBZQ3Vc+P8k4yjl+bB/o6DFPlfwMoYPH9+OdGFZiA8n0SO8ot5j0RU
 tgih8xYNb4QchjQ2kuH8DMV1WzUsxLa9PcHWsTq9VsNqbzlAiHeqao9Kx2DMRgzNaRNl
 xiUecWB9GpOAvN3Zv7VHNFTJnsPR3l4Ohq7LknmswjlLsUNX0+oKBeMTIK7IripA4XVd
 FFlQ==
X-Gm-Message-State: AJcUukfAzlFhPVvS9iGWv5k4CwQjYt8qh/p8eAJM7mHjOoeLNafFMTyc
 RTyObxgEXi3n+XJc/JfLMmQ=
X-Google-Smtp-Source: ALg8bN6Y/h6th3UAyWbW8ywgeUAMYwnlqDcdH0tE8E46FdpdOGQhzTIt6tact62sZoH+wdOVlgiN0Q==
X-Received: by 2002:a2e:92:: with SMTP id
 e18-v6mr11205527lji.130.1547752569996; 
 Thu, 17 Jan 2019 11:16:09 -0800 (PST)
Received: from localhost.localdomain ([31.134.130.226])
 by smtp.googlemail.com with ESMTPSA id r1-v6sm390252ljb.64.2019.01.17.11.16.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Jan 2019 11:16:09 -0800 (PST)
From: Artem Panfilov <panfilov.artyom@gmail.com>
To: 
Subject: [PATCH 1/1] net: stmmac: implement the SIOCGHWTSTAMP ioctl
Date: Thu, 17 Jan 2019 22:15:36 +0300
Message-Id: <20190117191536.24699-1-panfilov.artyom@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_111613_042216_F2749BE8 
X-CRM114-Status: GOOD (  18.75  )
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
Cc: panfilov.artyom@gmail.com, Alexandre Torgue <alexandre.torgue@st.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Jose Abreu <joabreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 "David S. Miller" <davem@davemloft.net>, Tema <panfilovartyom@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Tema <panfilovartyom@gmail.com>

This patch adds support for the SIOCGHWTSTAMP ioctl which enables user
processes to read the current hwtstamp_config settings
non-destructively.

Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 77 ++++++++++++-------
 2 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 63e1064b27a2..f9b42b0c20f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include "common.h"
 #include <linux/ptp_clock_kernel.h>
+#include <linux/net_tstamp.h>
 #include <linux/reset.h>
 
 struct stmmac_resources {
@@ -174,6 +175,7 @@ struct stmmac_priv {
 	unsigned int mode;
 	unsigned int chain_mode;
 	int extend_desc;
+	struct hwtstamp_config tstamp_config;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_ops;
 	unsigned int default_addend;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5afba69981cf..a6dc40a70428 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -534,7 +534,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 }
 
 /**
- *  stmmac_hwtstamp_ioctl - control hardware timestamping.
+ *  stmmac_hwtstamp_set - control hardware timestamping.
  *  @dev: device pointer.
  *  @ifr: An IOCTL specific structure, that can contain a pointer to
  *  a proprietary structure used to pass information to the driver.
@@ -544,10 +544,10 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
  *  Return Value:
  *  0 on success and an appropriate -ve integer on failure.
  */
-static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
+static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	struct hwtstamp_config config;
+	struct hwtstamp_config *config =  &priv->tstamp_config;
 	struct timespec64 now;
 	u64 temp = 0;
 	u32 ptp_v2 = 0;
@@ -572,31 +572,31 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 		return -EOPNOTSUPP;
 	}
 
-	if (copy_from_user(&config, ifr->ifr_data,
+	if (copy_from_user(config, ifr->ifr_data,
 			   sizeof(struct hwtstamp_config)))
 		return -EFAULT;
 
 	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
-		   __func__, config.flags, config.tx_type, config.rx_filter);
+		   __func__, config->flags, config->tx_type, config->rx_filter);
 
 	/* reserved for future extensions */
-	if (config.flags)
+	if (config->flags)
 		return -EINVAL;
 
-	if (config.tx_type != HWTSTAMP_TX_OFF &&
-	    config.tx_type != HWTSTAMP_TX_ON)
+	if (config->tx_type != HWTSTAMP_TX_OFF &&
+	    config->tx_type != HWTSTAMP_TX_ON)
 		return -ERANGE;
 
 	if (priv->adv_ts) {
-		switch (config.rx_filter) {
+		switch (config->rx_filter) {
 		case HWTSTAMP_FILTER_NONE:
 			/* time stamp no incoming packet at all */
-			config.rx_filter = HWTSTAMP_FILTER_NONE;
+			config->rx_filter = HWTSTAMP_FILTER_NONE;
 			break;
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 			/* PTP v1, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 			/* take time stamp for all event messages */
 			if (xmac)
 				snap_type_sel = PTP_GMAC4_TCR_SNAPTYPSEL_1;
@@ -609,7 +609,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 			/* PTP v1, UDP, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
 
@@ -619,7 +619,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 			/* PTP v1, UDP, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -630,7 +630,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 			/* PTP v2, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
 			if (xmac)
@@ -644,7 +644,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 			/* PTP v2, UDP, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -655,7 +655,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 			/* PTP v2, UDP, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
@@ -667,7 +667,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_EVENT:
 			/* PTP v2/802.AS1 any layer, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
 			if (xmac)
@@ -682,7 +682,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_SYNC:
 			/* PTP v2/802.AS1, any layer, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -694,7 +694,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 			/* PTP v2/802.AS1, any layer, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
@@ -708,7 +708,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 		case HWTSTAMP_FILTER_NTP_ALL:
 		case HWTSTAMP_FILTER_ALL:
 			/* time stamp any incoming packet */
-			config.rx_filter = HWTSTAMP_FILTER_ALL;
+			config->rx_filter = HWTSTAMP_FILTER_ALL;
 			tstamp_all = PTP_TCR_TSENALL;
 			break;
 
@@ -716,18 +716,18 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 			return -ERANGE;
 		}
 	} else {
-		switch (config.rx_filter) {
+		switch (config->rx_filter) {
 		case HWTSTAMP_FILTER_NONE:
-			config.rx_filter = HWTSTAMP_FILTER_NONE;
+			config->rx_filter = HWTSTAMP_FILTER_NONE;
 			break;
 		default:
 			/* PTP v1, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 			break;
 		}
 	}
-	priv->hwts_rx_en = ((config.rx_filter == HWTSTAMP_FILTER_NONE) ? 0 : 1);
-	priv->hwts_tx_en = config.tx_type == HWTSTAMP_TX_ON;
+	priv->hwts_rx_en = ((config->rx_filter == HWTSTAMP_FILTER_NONE) ? 0 : 1);
+	priv->hwts_tx_en = config->tx_type == HWTSTAMP_TX_ON;
 
 	if (!priv->hwts_tx_en && !priv->hwts_rx_en)
 		stmmac_config_hw_tstamping(priv, priv->ptpaddr, 0);
@@ -765,7 +765,28 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 				(u32)now.tv_sec, now.tv_nsec);
 	}
 
-	return copy_to_user(ifr->ifr_data, &config,
+	return copy_to_user(ifr->ifr_data, config,
+			    sizeof(struct hwtstamp_config)) ? -EFAULT : 0;
+}
+
+/**
+ *  stmmac_hwtstamp_get - read hardware timestamping.
+ *  @dev: device pointer.
+ *  @ifr: An IOCTL specific structure, that can contain a pointer to
+ *  a proprietary structure used to pass information to the driver.
+ *  Description:
+ *  This function obtain the current hardware timestamping settings
+    as requested.
+ */
+static int stmmac_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
+{
+	struct stmmac_priv *priv = netdev_priv(dev);
+	struct hwtstamp_config *config = &priv->tstamp_config;
+
+	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
+		return -EOPNOTSUPP;
+
+	return copy_to_user(ifr->ifr_data, config,
 			    sizeof(struct hwtstamp_config)) ? -EFAULT : 0;
 }
 
@@ -3767,7 +3788,9 @@ static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		ret = phy_mii_ioctl(dev->phydev, rq, cmd);
 		break;
 	case SIOCSHWTSTAMP:
-		ret = stmmac_hwtstamp_ioctl(dev, rq);
+		ret = stmmac_hwtstamp_set(dev, rq);
+	case SIOCGHWTSTAMP:
+		ret = stmmac_hwtstamp_get(dev, rq);
 		break;
 	default:
 		break;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
