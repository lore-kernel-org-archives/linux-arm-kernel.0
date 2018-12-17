Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E51C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E4B20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ViiRTDXP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJ94LMcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E4B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tkF5wGmYBmZ5Y2PXFPJDE6sgR1ZQL7wNBkcefKJ/+eE=; b=ViiRTDXPamdVyKrIhnMjKSgczu
	mO9sPbPyj3zs7V8tH0eJBpXeVoZLJj0BhBAaVVCLg1Ol/RSnAqGIBp0HRBP9Aop6SMYkAZ9auMSKR
	DXSijkAQjF1TrglMt/0eMhaBUUGAtNhtWXNTrMzfLhSC5XGmFiulYLGPhg2n/MzQ+ZGJMhEEThj5L
	I/KfAOv/l5SCJRP+GXxhhirVwBqEafeF9eXModJECLPbUjTiFmssE7GCQn2y6qCe4PJ/aFPwqwWsb
	Mc+iSrx702CZPQ17kgOuA2O0FYjenTZ/xmHrVcoL9nJ1PC+gPaiytxbISrL+Kvrzink6ljYeWZuRA
	ZmG/ewBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpUX-0006Gw-MT; Mon, 17 Dec 2018 09:47:13 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpU8-0005qw-Ue
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:46:50 +0000
Received: by mail-wr1-x444.google.com with SMTP id s12so11100071wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 01:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rPu/KTYynL2hZ7Udac90NfGfOmFb5CPU0go+pwum/Ko=;
 b=GJ94LMcb2mXK/ECVCU6TpApvTHWweBWfPuTlBANuxKYmT4xaLEEdPjiPieHmsBgCCJ
 z4ECesqUmXpzpaYofaj1LKaF+l2Je+bQxM9psvo3s1WnbjqTzYEQWA5v+p8daXFv4J9Z
 Z8UZHjZ9x5J6+ubZs+m3Rzsq2Al5FdcnarC60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rPu/KTYynL2hZ7Udac90NfGfOmFb5CPU0go+pwum/Ko=;
 b=Cnn1At4LFA0viBCwTeb8T5eV500yL5i8Xz0QrsFCFyRgrtfV7c5O8jgRoiNoA9C6PA
 xeVQ2WzySV/qjfr38xOlTqAkhdxL452WMBUw8gJwvZ2pptahu45XpUg7QYislWNbcv7d
 WhTO4E4J2KOlMKS0RQcUdYqp/JGqQP7zPYw5g2CG3hQ0fXWErRE4OMMAlHA2IwtjhjeY
 L9d2vaNc3JDYm0Q+0TjayDO+G1Poqdh9FLsMnl0VUZmtKQO+KuSyMzFH23rXITL8oVBH
 UWKwrt9pFPUxJl2Wbd3KlLEithQxrCh/1IF2zA8mgTx/4yz346lZXtPqE4dF23wg2aeF
 u4mQ==
X-Gm-Message-State: AA+aEWZ3b1n4AtgAMwVl3SQcPwrtPbDcq1yglkKBI711pMmmNymrq+qy
 jN29DKaHf//1G/uju+CxWuT/hg==
X-Google-Smtp-Source: AFSGD/WPbRY1qjo9wPqeWKiKnySAmHLHE2lhnFzt6KZue5DSPhSZN+WWivK1Ikwsj0MRbtN1VoM1JA==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr9480128wrq.5.1545040005201;
 Mon, 17 Dec 2018 01:46:45 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.58])
 by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 01:46:44 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
 will.deacon@arm.com, mturquette@baylibre.com, jassisinghbrar@gmail.com
Subject: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names from DT
Date: Mon, 17 Dec 2018 10:46:22 +0100
Message-Id: <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_014649_096761_13F5AFA5 
X-CRM114-Status: GOOD (  16.87  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allow accessing the parent clock names required for the driver
operation by using the device tree node.

This permits extending the driver to other platforms without having to
modify its source code.

For backwards compatibility leave previous values as default.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/apcs-msm8916.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index a6c89a3..2453242 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -19,7 +19,7 @@
 
 static const u32 gpll0_a53cc_map[] = { 4, 5 };
 
-static const char * const gpll0_a53cc[] = {
+static const char *gpll0_a53cc[] = {
 	"gpll0_vote",
 	"a53pll",
 };
@@ -50,17 +50,39 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct clk_init_data init = { };
 	int ret = -ENODEV;
+	struct clk_bulk_data pclks[] = {
+		[0] = { .id = "aux", .clk = NULL },
+		[1] = { .id = "pll", .clk = NULL },
+	};
 
 	regmap = dev_get_regmap(parent, NULL);
 	if (!regmap) {
 		dev_err(dev, "failed to get regmap: %d\n", ret);
 		return ret;
 	}
-
 	a53cc = devm_kzalloc(dev, sizeof(*a53cc), GFP_KERNEL);
 	if (!a53cc)
 		return -ENOMEM;
 
+	/* check if the parent names are present in the device tree */
+	ret = devm_clk_bulk_get(parent, ARRAY_SIZE(pclks), pclks);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+
+	if (!ret) {
+		gpll0_a53cc[0] = __clk_get_name(pclks[0].clk);
+		gpll0_a53cc[1] = __clk_get_name(pclks[1].clk);
+		a53cc->pclk = pclks[1].clk;
+	} else {
+		/* support old binding where only pll was explicitily defined */
+		a53cc->pclk = devm_clk_get(parent, NULL);
+		if (IS_ERR(a53cc->pclk)) {
+			ret = PTR_ERR(a53cc->pclk);
+			dev_err(dev, "failed to get clk: %d\n", ret);
+			return ret;
+		}
+	}
+
 	init.name = "a53mux";
 	init.parent_names = gpll0_a53cc;
 	init.num_parents = ARRAY_SIZE(gpll0_a53cc);
@@ -76,13 +98,6 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	a53cc->src_shift = 8;
 	a53cc->parent_map = gpll0_a53cc_map;
 
-	a53cc->pclk = devm_clk_get(parent, NULL);
-	if (IS_ERR(a53cc->pclk)) {
-		ret = PTR_ERR(a53cc->pclk);
-		dev_err(dev, "failed to get clk: %d\n", ret);
-		return ret;
-	}
-
 	a53cc->clk_nb.notifier_call = a53cc_notifier_cb;
 	ret = clk_notifier_register(a53cc->pclk, &a53cc->clk_nb);
 	if (ret) {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
