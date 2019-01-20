Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC0BC7113D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:06:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39BB72085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VT/rZQHw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu4wB/03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BB72085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=j2sUqtz7nJ42doamL3LLPmpZk0VnIgIdP9/iKheMj0s=; b=VT/rZQHww3MCkC
	eur837NZvOZWjNS0rqU581GqHbNxovlEun2ILoXoKF2zaS0gI2bWCQPFPao4/D9/7AjoZBch2CruG
	0GRen2DJBbXiY90Xx7LAL5o+aqfIiJou1IOcWv8kp8BKM19brcYY3JMivreoboN62WmbpkmZ7m0z6
	clyVM/4Qab6BP2IANUeMDd8T/Y9fNMAIN6efy8Ct7Y9Eki5rPpm0TT/RJU9nVYiCh+iExO9+uzqI0
	+mbJXZSHnL41yRBt6fzupajppMUQQHkEedwE6PZ6ONkubkKWOd9QUj+jcJVnjlE+95VfStatmfI7Y
	kod/Q0pt5H0qI3ww1LoA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glFc1-0004uj-BE; Sun, 20 Jan 2019 16:06:17 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glFbx-0004uJ-RM
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 16:06:15 +0000
Received: by mail-lf1-x143.google.com with SMTP id n18so13769157lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 08:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Wzao/hU6QG9MuXoF33EVgSfu5MdpCuvVVrCUvJF7L8s=;
 b=Cu4wB/03fAmp2pkWvVa/2DBZoXAPkASLyD2ygeQPiEKf9quoeMl9WYNUwOc0RgGv5U
 xdjuRB65GCCv1TgMxbTEFkEdJ9xYhHQYhuwiixnAzDR0jOj4sb8wssrxsH/WERrIwU/w
 O5tLsJkSKlPoT7v/2wB4Cvm72nt+zeusEMwOlm7ehpSUsrUfhPCQyTL4Vq275pdu+8IQ
 zRchYtFxjZ8KHio4vbRoitrE0Beufv2Gb+nGjqlVgacAjmYsydOpr3GR6wU3WNOCP7n8
 hzq4TIN4VzJcBoLEAwvwhNyn/qS9ymqx11al2Ql6SFOVW2cKjGajLk+Rc8fWqoRikysO
 +1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Wzao/hU6QG9MuXoF33EVgSfu5MdpCuvVVrCUvJF7L8s=;
 b=hCXM83xhGtfXn4NHRJ3K9XD+WBXa/dkMKRCdzdl7g4jjjHTjbLrLKHWErtDPbXLzJ5
 8yGDb2hPAHxmrxZq0jVjcIh9y6Dwab8N0WAbg7DduOISzb6pOT9DZHtra1VBIom+mOXC
 8C6ms74BvmgZMnl8cyFfhlq3v1MBYBV4kqeXsQoY9MvVh2O0tNjGIuRrBnh9INUvH+hn
 DHEBOzI0wuY8+K73NTDW/cXqKY3WAZAWQiDZqQLfjGni0tZdAz7jsDu/W4U/tsF17t1f
 JSsLX9+Wm8QxZlH+lCFOLF64w4EONzdiDTPNqI4GxYjqOlf0hhfrl237J7XiZYibfGaC
 Sx+w==
X-Gm-Message-State: AJcUukevAjr6Uw7kmSBDt5e7nVuXkoRZdotlMp9cPgu/scsk0A9b/UDs
 +0GwQnRoL0PT5LasL808ELQ=
X-Google-Smtp-Source: ALg8bN6URnXDDx6Bg9+J/UqdX/Kgm0FXM792oZt+XtaG/6xxDZjZjxQ98jCkzzVTfyicuCCykppJRA==
X-Received: by 2002:a19:5059:: with SMTP id z25mr11978146lfj.120.1548000370907; 
 Sun, 20 Jan 2019 08:06:10 -0800 (PST)
Received: from localhost.localdomain ([31.134.130.226])
 by smtp.googlemail.com with ESMTPSA id
 k11-v6sm1801540ljk.40.2019.01.20.08.06.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Jan 2019 08:06:10 -0800 (PST)
From: Artem Panfilov <panfilov.artyom@gmail.com>
To: 
Subject: [PATCH net-next 1/1] net: stmmac: implement the SIOCGHWTSTAMP ioctl
Date: Sun, 20 Jan 2019 19:05:15 +0300
Message-Id: <20190120160515.26473-1-panfilov.artyom@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_080613_920075_63A9069E 
X-CRM114-Status: GOOD (  16.36  )
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
Cc: Artem Panfilov <panfilov.artyom@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds support for the SIOCGHWTSTAMP ioctl which enables user
processes to read the current hwtstamp_config settings
non-destructively.

Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 ++++++++++++++++---
 2 files changed, 33 insertions(+), 5 deletions(-)

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
index 5afba69981cf..517555bcfa44 100644
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
@@ -544,7 +544,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
  *  Return Value:
  *  0 on success and an appropriate -ve integer on failure.
  */
-static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
+static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	struct hwtstamp_config config;
@@ -573,7 +573,7 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 	}
 
 	if (copy_from_user(&config, ifr->ifr_data,
-			   sizeof(struct hwtstamp_config)))
+			   sizeof(config)))
 		return -EFAULT;
 
 	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
@@ -765,8 +765,31 @@ static int stmmac_hwtstamp_ioctl(struct net_device *dev, struct ifreq *ifr)
 				(u32)now.tv_sec, now.tv_nsec);
 	}
 
+	memcpy(&priv->tstamp_config, &config, sizeof(config));
+
 	return copy_to_user(ifr->ifr_data, &config,
-			    sizeof(struct hwtstamp_config)) ? -EFAULT : 0;
+			    sizeof(config)) ? -EFAULT : 0;
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
+			    sizeof(*config)) ? -EFAULT : 0;
 }
 
 /**
@@ -3767,7 +3790,10 @@ static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		ret = phy_mii_ioctl(dev->phydev, rq, cmd);
 		break;
 	case SIOCSHWTSTAMP:
-		ret = stmmac_hwtstamp_ioctl(dev, rq);
+		ret = stmmac_hwtstamp_set(dev, rq);
+		break;
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
