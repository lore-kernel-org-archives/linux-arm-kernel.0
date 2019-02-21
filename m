Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A73C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:03:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902702084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GTzImlt+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PQq6PdhW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QPhQxBVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902702084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aGAA2otBwPaQxXWZVf1sTrooS4w90ESCOX0aEfIGra4=; b=GTzImlt+7cifej
	w8lOc0YKLlC7iCIyqyhgvdM1HeiLcjZm3Bw1JHkduSqY+EnoAwDhrlwIRt6cwEgm08GrCn7+YS3Lh
	P6ecMNTbtm6WxKQAdmVi06nq576dwjg1iAiUNeBZZ8bQTz92FhXGpBTSJiON21DTBUEPdCNTp1cco
	6x4lu1P+jKlgy+ddQB5X32m5ZOBhl0dqIEaAFVy4f3ePEo4E+wHydp594jWlHadGm+MAkWyyq3Qgd
	GrioUm6jiqicj0misUH3qnshPkKaHffQ0bkqgQYVLY4WkISVTkaRewbI3FEokix4elkrxV3UxgHIM
	Bg0T3BHPYh0AorAnuVMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqoJ-0001N6-Ls; Thu, 21 Feb 2019 16:02:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqnq-0000bs-Cl
 for linux-arm-kernel@bombadil.infradead.org; Thu, 21 Feb 2019 16:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KIqp1Gx+3oMFpHMW3IZBqaQXCubuSyC+vxBxyjzk0Po=; b=PQq6PdhW+AMAcZ6QuV9HB+0Ks8
 6tY1bxKWKtFKnxNmZQC81PqR7ODSjCfYvHxtyUqMEdXxGvR89LI0RVtjg3njVZNtmbukjKCxZK/Xm
 aHGStJpBrBB+faVQVXNzqJOijOAAYr+GLPFxRmnqcV3D6HIV4/JyGjnGi6Xa5IiPOG7oHawLcJqGs
 ju5veunR16qZE+LpZh/3Iss5Vse7QDf7pnCe3WjZodac+8Hqyw3AilMhtWSH92nh7PnA+fGW/s1RV
 SdLgdz8Uy0T3W2k6fenPEyO156CwBJAEStdVizo3RnkFZYy4r//OIWW1EJYaL5G/X2WZzQIYiXPY4
 iRercPdw==;
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqY6-0006rj-NR
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:46:13 +0000
Received: by mail-lf1-x141.google.com with SMTP id u21so20752417lfu.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KIqp1Gx+3oMFpHMW3IZBqaQXCubuSyC+vxBxyjzk0Po=;
 b=QPhQxBVxbm03i/g1gHo/nR+XArGph+cG0/G59OIByzcrYLJGKAWHaUVoJZ9nxFGk7y
 8ojKBCw/FGZUz/Zu8rcQbfNoTdaCGI/60SUQKlvJk/fjOlq7G/HfTekGxJRLDRYLwPWc
 GA35kvjcDzk28mKE3mPI3PU/95hE/IMpRqAOHSGJf8s7EM2H3RTA3yrWJYmnCTv8tZwq
 1LOYKoAfhiLpGio3QIma2b2ZKi0RlwxKshDkhJO1LBD/2KuPi9janjNKQaQxlkNM0894
 RQjPcQf+C0qv7FnL6RzgZ/vH0Km0ShTDP9nAx/8vIIE69NsBCGkmxS4PolMfXvk310vi
 fgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KIqp1Gx+3oMFpHMW3IZBqaQXCubuSyC+vxBxyjzk0Po=;
 b=k0k+APKt4oBPNZbBxPPk08IlGdT5yQGTeZKvEHq214e8g8SPb9tGwK6uzzqqqd+QNR
 qso9OcfjNcrMSAo9jXhZ4lZtJG1HAt2mqB113x5cBC1soRFhoyTcAWA+IRQitXY4BLsT
 Ul0tm1x+O0/f2ru0ANKl8m6/E0B5UMwcd55RBb+mJLlz8F8jDn2o3jwm8cJo5t5L7V8H
 6a2KZ70SWS1bdDBfmuFWKUd9f2zEFQFc5t6PjwilJOCRSTN8baPTo4CI/lkvDUJU8aXN
 rr2EO0AZPDdiANjn0aX/RJhgn4UVZ5LAy9rW/fqNd/LlDpoPpKho+6nIGz//rEmlWYLi
 jaUg==
X-Gm-Message-State: AHQUAub6l6UJz7y1RPAlomqTB/XzhSFB+iTFJUvD9gHuTnZIwz/rOdst
 cI2st2mJ5Ufp40pd9ecVKoSz6b8wD6w=
X-Google-Smtp-Source: AHgI3Ib/NjXJVNlUrALtfje2b3eCMe9ODDJlx6todR3+QLC2r+5qr7jU+NwtT2XWurSw3Qmi8Jv9mA==
X-Received: by 2002:a19:d83:: with SMTP id 125mr23428769lfn.159.1550763968759; 
 Thu, 21 Feb 2019 07:46:08 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.46.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:46:07 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 24/30 v2] soc: ixp4xx: Remove unused functions
Date: Thu, 21 Feb 2019 16:44:52 +0100
Message-Id: <20190221154458.23763-25-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_154610_919757_2593306C 
X-CRM114-Status: GOOD (  10.01  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These former inlines turn out to be unused in the kernel.
If they are needed in the future, they can be resurrected
by reverting or studying this commit.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/soc/ixp4xx/ixp4xx-qmgr.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
index 412a346136d8..f3775346e007 100644
--- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
+++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
@@ -95,18 +95,6 @@ int qmgr_stat_below_low_watermark(unsigned int queue)
 	return __qmgr_get_stat1(queue) & QUEUE_STAT1_NEARLY_EMPTY;
 }
 
-/**
- * qmgr_stat_above_high_watermark() - checks if a queue is above high watermark
- * @queue:	queue number
- *
- * Returns non-zero value if the queue is above high watermark
- */
-static int qmgr_stat_above_high_watermark(unsigned int queue)
-{
-	BUG_ON(queue >= HALF_QUEUES);
-	return __qmgr_get_stat1(queue) & QUEUE_STAT1_NEARLY_FULL;
-}
-
 /**
  * qmgr_stat_full() - checks if a hardware queue is full
  * @queue:	queue number
@@ -121,17 +109,6 @@ int qmgr_stat_full(unsigned int queue)
 	return __qmgr_get_stat1(queue) & QUEUE_STAT1_FULL;
 }
 
-/**
- * qmgr_stat_underflow() - checks if a hardware queue experienced underflow
- * @queue:	queue number
- *
- * Returns non-zero value if the queue experienced underflow.
- */
-static int qmgr_stat_underflow(unsigned int queue)
-{
-	return __qmgr_get_stat2(queue) & QUEUE_STAT2_UNDERFLOW;
-}
-
 /**
  * qmgr_stat_overflow() - checks if a hardware queue experienced overflow
  * @queue:	queue number
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
