Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0EEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:47:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F44D20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VIkcCs7c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="A6iZ9OW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F44D20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=J0sVoAW1OH9AHYEyG6AS+JeV98CXLbHyM1E2vfZzTqE=; b=VIk
	cCs7ccnmSXStgv+ssQfHmSJy91RBFoW02KWl386hbBxeEo8WBiUr3TDm4ZJ5Jc6jZR0PGCOQAxbTl
	QECkjnakY7h82BEmdmefUmVnpnIKEERyc/BqU/DbHDqmEpk+EK4/dfoZd3OaV2h9YZee1LUK/Hows
	R53pvru0mn2Fh/ip1OBlRluGz9hbMVKPFRBckk9T74G8Kn7FY4G7XULOSLGzD8NLgXf//RXo9O8vb
	HrX+0wFYSyBN/yJsowH5mQ9txIc9B8O1Y5BD8VPg3FDuZXsFYZE9LX1Chqatsu7si72FeukQKUzFr
	aLgQ2pF4DIb7H3YCYIt9h5rHe3FTN9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz3J9-0003Tr-8l; Wed, 27 Feb 2019 17:47:51 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz3J6-0003T1-AE
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 17:47:49 +0000
Received: by mail-lf1-x143.google.com with SMTP id r123so4757970lff.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=mmyBk9GgC8EvaZvsSj8EKGJFsCq9XS5xh0XfvJeZhkM=;
 b=A6iZ9OW1g/IIKbEvxkLCcp0DyilxMt7omV7zMciJ5Ev3wNiwQuIImYMWMckMjTcm8S
 JZFzQTMRbQgHgydFHny/otMDF/IG1tCoFKXTHXNTADhsfiWv3eIXYC0A0K8SeH1lBB3G
 dbNx8PxoKWBKtlPOSfZ85liifynfr1kBnQEYQHH/Q010CKme+iIsEd1ry4Yb8EOAwMsC
 hmCIbwkSjfydkwOOVezYCTv0zu8RCIJ22SzqgPv2G8YzcEvOWclvygf99E49P32pgVhJ
 P7mMFES8S4B1On/W2KnT1uigllPLCAiVdlHlGaNnYIFVXOw9s2U4cEGmrhzuIOw/j4gC
 8RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=mmyBk9GgC8EvaZvsSj8EKGJFsCq9XS5xh0XfvJeZhkM=;
 b=ks7NfPUg/Uj5uR3qZtu/HDTNxdL0CZSEI2neKhl9pB+K6s5zFEJ7qSm8zkJBk0DTIz
 I+hN7dT2T76m3cToS8fp1vzIt/hC2ZBFrjb/fIfgH5F0TzxjaxAo0A4qyCItVZtWvyWi
 YHmy+AV4ZYqQHyvW8jKPSf10g82D4dS3HVCbU/m7IfFV+tmFieEfJzmypx50wTz4Sfa3
 +StPbYHxf4YvG8nR1QgqAC+WBiOUFE0ajjNL9VbRD1LCDjSWPNNFqVtPMV4PfJzZNCtk
 BmEZa2l/AusqK4FVw8No2W95wfHYI2Qfd8Ixx050mjt071FgR2aWBRFYJdsrEDk59NYC
 KoVw==
X-Gm-Message-State: AHQUAubqnuDPhkIr7nsq+93tfO0eFWbjkee/UWHTuQhyydfcHB24dZaa
 jT25wTucXxuLHpnEhQvRljWW7g==
X-Google-Smtp-Source: AHgI3IYiEUnhOIAF9R6AfcE20S+QTWnML4Mbba11DqQDiwQoxl71EY1NiGxicUp6KPTCWsOlAJSVZQ==
X-Received: by 2002:a19:384a:: with SMTP id d10mr1577325lfj.111.1551289663762; 
 Wed, 27 Feb 2019 09:47:43 -0800 (PST)
Received: from gilgamesh.semihalf.com (31-172-191-173.noc.fibertech.net.pl.
 [31.172.191.173])
 by smtp.gmail.com with ESMTPSA id m26sm3561637lji.22.2019.02.27.09.47.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 27 Feb 2019 09:47:42 -0800 (PST)
From: Marcin Wojtas <mw@semihalf.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Subject: [net: PATCH] net: mvpp2: disable link IRQ waiting for IDLE frames
Date: Wed, 27 Feb 2019 18:47:32 +0100
Message-Id: <1551289652-7377-1-git-send-email-mw@semihalf.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_094748_409304_B72B87C3 
X-CRM114-Status: GOOD (  11.86  )
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
Cc: antoine.tenart@bootlin.com, jaz@semihalf.com, gregory.clement@bootlin.com,
 linux@armlinux.org.uk, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 tn@semihalf.com, stefanc@marvell.com, mw@semihalf.com, davem@davemloft.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Current version of the driver was configuring XLG MAC
in a way to wait 3 IDLE frames before allowing for the
link-up interrupt to be triggered. This resulted in an
issue, preventing to detect the link change during RX
traffic on the interface. Fix that.

Fixes: 4bb043262878 ("net: mvpp2: phylink support")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 16066c2..f1378f9 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4532,8 +4532,7 @@ static void mvpp2_xlg_config(struct mvpp2_port *port, unsigned int mode,
 		ctrl0 |= MVPP22_XLG_CTRL0_RX_FLOW_CTRL_EN;
 
 	ctrl4 &= ~MVPP22_XLG_CTRL4_MACMODSELECT_GMAC;
-	ctrl4 |= MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC |
-		 MVPP22_XLG_CTRL4_EN_IDLE_CHECK;
+	ctrl4 |= MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC;
 
 	writel(ctrl0, port->base + MVPP22_XLG_CTRL0_REG);
 	writel(ctrl4, port->base + MVPP22_XLG_CTRL4_REG);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
