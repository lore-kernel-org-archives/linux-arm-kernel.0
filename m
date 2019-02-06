Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9422BC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:12:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652BA20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FUJz5mQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652BA20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VmwG8n/uvOHl8PNmY6lT6gUM6AgBSuFylc7CV/zU/QU=; b=FUJz5mQiPTh7aX
	IvU/KOaEiJjQMrzEmXtwPUyKN1F18DzFPBja8r5Dxn7dEweUsN9f9/9cZ2kWRzoR3b4ogNoZ90Nhh
	U7sLUd1X0pREB1Pw4AJ5kZyxjt3KaGb/WskPVlWtc1qD1wIx4IeFkHGb6VQE/jiwaLnUqVCcYr0iq
	rnCJzh8zR5AcoWxb+oQOYrG3LWUV1grVQZg3nNAoUVe12e7iLhSapmckZxWrpPYSu4B4p3PTcIYa0
	jjO4j9bi34Z14VjAOHuMbHJrHLk5wWjX3kbeIfUzE7SsJT2ETkAi3+wV7PI4pzPfHjzBinjKVzPdE
	j5yusb+8dxunY2EgEr5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grRgr-0004Ki-H3; Wed, 06 Feb 2019 18:12:53 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grRgo-0004K0-MA
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:12:52 +0000
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; d="scan'208";a="26383923"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 06 Feb 2019 11:12:33 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch04.mchp-main.com (10.10.76.105) with Microsoft SMTP Server id
 14.3.352.0; Wed, 6 Feb 2019 11:12:33 -0700
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches
 <ludovic.desroches@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
 Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 3/3] power: reset: at91-reset: add support for sam9x60 SoC
Date: Wed, 6 Feb 2019 19:12:21 +0100
Message-ID: <20190206181221.27914-3-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206181221.27914-1-nicolas.ferre@microchip.com>
References: <20190206181221.27914-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_101250_827331_3462F398 
X-CRM114-Status: GOOD (  10.32  )
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
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for additional reset causes and the proper compatibility
string for sam9x60 SoC. The restart function is the same as the samx7.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
v2: split series and collect tag

Sebastian,
I add your Acked-by tag here but as I would like that you take the 3 patches on
your tree now, I let you modify it on your side. I'm expecting Alexandre or
Ludovic to have a look as well.

Best regards,
  Nicolas

 drivers/power/reset/at91-reset.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index f44a9ffcc2ab..44ca983a49a1 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -44,6 +44,9 @@ enum reset_type {
 	RESET_TYPE_WATCHDOG	= 2,
 	RESET_TYPE_SOFTWARE	= 3,
 	RESET_TYPE_USER		= 4,
+	RESET_TYPE_CPU_FAIL	= 6,
+	RESET_TYPE_XTAL_FAIL	= 7,
+	RESET_TYPE_ULP2		= 8,
 };
 
 static void __iomem *at91_ramc_base[2], *at91_rstc_base;
@@ -164,6 +167,15 @@ static void __init at91_reset_status(struct platform_device *pdev)
 	case RESET_TYPE_USER:
 		reason = "user reset";
 		break;
+	case RESET_TYPE_CPU_FAIL:
+		reason = "CPU clock failure detection";
+		break;
+	case RESET_TYPE_XTAL_FAIL:
+		reason = "32.768 kHz crystal failure detection";
+		break;
+	case RESET_TYPE_ULP2:
+		reason = "ULP2 reset";
+		break;
 	default:
 		reason = "unknown reset";
 		break;
@@ -183,6 +195,7 @@ static const struct of_device_id at91_reset_of_match[] = {
 	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
 	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
 	{ .compatible = "atmel,samx7-rstc", .data = samx7_restart },
+	{ .compatible = "microchip,sam9x60-rstc", .data = samx7_restart },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, at91_reset_of_match);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
