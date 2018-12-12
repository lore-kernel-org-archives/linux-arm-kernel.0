Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D90AC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:41:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C4520849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NH3cutSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C4520849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9PIn7ERVEPreV8zDHu8uq44sSpQvytcWZNEKrOHFEQM=; b=NH3cutStlefBTY
	lCz45skrZxkpQuYBKmKaIfIlMEqhhxRxzh1lXf1AByPYPkxJkDOMGI5wO0n6I0UM8zcbJVh5qVDxi
	jmM1hNQbKCVtFEI6pwuP3Nu0DqS+gQZpmMUO/uVHqaeIkxX+6EMYqI28mnPEiCM/xrn86aNaR+jpr
	x6eVmSi9XhXDwoHjXPHryWKwV/AZWmRX/eUA9D/5h11OXrT1pw90ThQs+LOnAImpLxzpdYGyexjxy
	tRdzxpHI0q4C6wqzNqr7ta3LMc2h8cxMOUGQ980Ez3oXrqs4dLPmyq64RbMh45JEdL6mDmv0odPxx
	yhY/VeTTUu22wjbJG8zA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1xH-0004s1-3D; Wed, 12 Dec 2018 10:41:27 +0000
Received: from esa6.microchip.iphmx.com ([216.71.154.253])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1xD-0004qk-UL
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 10:41:25 +0000
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; d="scan'208";a="21413891"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 12 Dec 2018 03:41:12 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Wed, 12 Dec 2018 03:41:11 -0700
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches
 <ludovic.desroches@microchip.com>
Subject: [PATCH] ARM: at91: add support in soc driver for new SAM9X60
Date: Wed, 12 Dec 2018 11:41:10 +0100
Message-ID: <20181212104110.5584-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_024124_029580_6A02A9D3 
X-CRM114-Status: UNSURE (   7.61  )
X-CRM114-Notice: Please train this message.
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
Cc: sandeepsheriker.mallikarjun@microchip.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>

Add detection of new SAM9X60 by this soc.c driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[nicolas.ferre@microchip.com: split patch]
Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
---
 drivers/soc/atmel/soc.c | 2 ++
 drivers/soc/atmel/soc.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 2cc272ddf906..096a83cf0caf 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -66,6 +66,8 @@ static const struct at91_soc __initconst socs[] = {
 	AT91_SOC(AT91SAM9XE128_CIDR_MATCH, 0, "at91sam9xe128", "at91sam9xe128"),
 	AT91_SOC(AT91SAM9XE256_CIDR_MATCH, 0, "at91sam9xe256", "at91sam9xe256"),
 	AT91_SOC(AT91SAM9XE512_CIDR_MATCH, 0, "at91sam9xe512", "at91sam9xe512"),
+	AT91_SOC(SAM9X60_CIDR_MATCH, SAM9X60_EXID_MATCH,
+		 "sam9x60", "sam9x60"),
 #endif
 #ifdef CONFIG_SOC_SAMA5
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D21CU_EXID_MATCH,
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index ed89b24ecee1..ee652e4841a5 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -42,6 +42,7 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9G45_CIDR_MATCH		0x019b05a0
 #define AT91SAM9X5_CIDR_MATCH		0x019a05a0
 #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
+#define SAM9X60_CIDR_MATCH		0x019b35a0
 
 #define AT91SAM9M11_EXID_MATCH		0x00000001
 #define AT91SAM9M10_EXID_MATCH		0x00000002
@@ -58,6 +59,8 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9N12_EXID_MATCH		0x00000006
 #define AT91SAM9CN11_EXID_MATCH		0x00000009
 
+#define SAM9X60_EXID_MATCH		0x00000000
+
 #define AT91SAM9XE128_CIDR_MATCH	0x329973a0
 #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
 #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
