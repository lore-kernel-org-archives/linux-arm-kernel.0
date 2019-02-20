Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE66C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:15:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0DE21738
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gSVPE8Bp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPNU7CdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0DE21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tO3lx7zSpmIbjyolE7jJWpWaqnkQIXyzWezADYJ50F0=; b=gSVPE8BppaRO97
	IYgq7cVuMwRit3ztNKjDP8tr/NGuToj9tJEsEjRhDgJ2vh0RsPH8hn/p50CxPFUyEZ+x4GolVlg01
	TP5lwyn1h8xreY6104lnNF9vtH3nTbk4aA2ognIsnXiFNbk/gk6MSCLuN5L2D2Z5tR4pmNjSwQLdm
	w8r3qm9WgqoCgoUunYuifILr/jWrZmUO7A9lbs9lyBwEOBjooPt/oZxl5k8M1Mn+/qOsQyiMDCEDX
	YNAOcSX8a1xPjAm8PD05mpLDANOksBuHiVlDDcnRJUcYJ7ibtXJwW0Rin7VJ2q18UfLZa01hIIUEJ
	ybd4p87LPfVTReAEqQuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwHPe-00030m-8E; Wed, 20 Feb 2019 02:15:06 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwHPZ-0002c9-Ui
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 02:15:03 +0000
Received: by mail-pg1-x543.google.com with SMTP id u9so7517485pgo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 18:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SqagvOGzM+1NbNVkTuVd8N0ntUQuQbmaSYvM2+e2Zg8=;
 b=OPNU7CdHUnvsrHQP1WsVmpt3YtGi9dkv6hlltMDg/aWk3Ynbgzi5mV8Pmxbn7vfMhT
 CV1eKKTuSN2Z9218FzZmc8tbrRRgYUZlzzKoUGFKHnbecRi2M+CwShNKgnvAwEEE27BV
 Na7oJ0FSQF4Cgg8flRXk2LhZlK+wfwDsqyjq9nPpo/qYYJrRQO3gaXUXXp62a9DSt6IX
 R+aUI3fmsC+GrRGWerZG0z6F8FFebBPgx270RTT9IZ9+zEj+QPl5FZHsovrUQIgbkRQK
 soUviez9qgwTNGH38rQXqWLtxzk0Z5FcidyAdNaoVPLiqIoR5CcGhWpSliMw+ID1/Tcg
 TVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SqagvOGzM+1NbNVkTuVd8N0ntUQuQbmaSYvM2+e2Zg8=;
 b=sX/0qtmdyH99NcwgtGwHmBVLDCEkUJ8qkUG0NsVp6ENUFqwj0gexY9Wnij/W4q2QnO
 7/uGr7JEBUwHjSoN0SIDaVzmS7hjzsH4OCWOH3E+FUBA5gj0ItYhdJoAHX7L5vSajlsu
 uuzKwHtAyxQY8UKN7B3FfUjpOVjnPayyuU2EVDbbJUZlzIXTluTliZceEEVvjHVIyACz
 CVvXZzXRXySoutwVINUbWnMpyloHDJFVYiwhEOgVpQcIO705LefZlT+ek/TZQmRWRFou
 czZWniSgtl9x2A3wOsAiODs7+MKadtojiExNe06bUWGDn+863DNIAwmdPUwsSgB/VOqi
 g1cg==
X-Gm-Message-State: AHQUAuY5LejyRXs9UYsNzr0mpeD2r0VpWSqNbkM4me4h8m5rRu5o2tLU
 BDd7KpDAkF8F7PadoE1zy8U=
X-Google-Smtp-Source: AHgI3IYwYyP9Qs8ZBGutbuEyX7IMDi/EN/z8BV0g1GY/Knjyz7SMhhVUhgVtIrJiis5U7vwGLKrSbw==
X-Received: by 2002:a62:f517:: with SMTP id n23mr32599145pfh.209.1550628900315; 
 Tue, 19 Feb 2019 18:15:00 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id e5sm6130957pfd.73.2019.02.19.18.14.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 18:14:59 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] soc: imx: gpcv2: Make use of regmap_read_poll_timeout()
Date: Tue, 19 Feb 2019 18:14:29 -0800
Message-Id: <20190220021429.4910-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_181502_109626_BFC10A9E 
X-CRM114-Status: GOOD (  14.53  )
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Replace explicit polling loop with a call to
regmap_read_poll_timeout() to avoid code repetition. Also fix
misspelled "failed" while at it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/soc/imx/gpcv2.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 176f473127b6..e06bf12a1e4b 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -136,8 +136,8 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
 	const bool enable_power_control = !on;
 	const bool has_regulator = !IS_ERR(domain->regulator);
-	unsigned long deadline;
 	int i, ret = 0;
+	u32 pxx_req;
 
 	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
 			   domain->bits.map, domain->bits.map);
@@ -169,30 +169,19 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
 	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
 	 * for PUP_REQ/PDN_REQ bit to be cleared
 	 */
-	deadline = jiffies + msecs_to_jiffies(1);
-	while (true) {
-		u32 pxx_req;
-
-		regmap_read(domain->regmap, offset, &pxx_req);
-
-		if (!(pxx_req & domain->bits.pxx))
-			break;
-
-		if (time_after(jiffies, deadline)) {
-			dev_err(domain->dev, "falied to command PGC\n");
-			ret = -ETIMEDOUT;
-			/*
-			 * If we were in a process of enabling a
-			 * domain and failed we might as well disable
-			 * the regulator we just enabled. And if it
-			 * was the opposite situation and we failed to
-			 * power down -- keep the regulator on
-			 */
-			on = !on;
-			break;
-		}
-
-		cpu_relax();
+	ret = regmap_read_poll_timeout(domain->regmap, offset, pxx_req,
+				       !(pxx_req & domain->bits.pxx),
+				       0, USEC_PER_MSEC);
+	if (ret) {
+		dev_err(domain->dev, "failed to command PGC\n");
+		/*
+		 * If we were in a process of enabling a
+		 * domain and failed we might as well disable
+		 * the regulator we just enabled. And if it
+		 * was the opposite situation and we failed to
+		 * power down -- keep the regulator on
+		 */
+		on = !on;
 	}
 
 	if (enable_power_control)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
