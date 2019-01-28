Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C037C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:34:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F3320881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tgMFiJfj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kI8S6Adu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F3320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=H7TmfEj2P7Qhpi6rdvygn3/+NyKeQIEUqsEi30A9MsY=; b=tgMFiJfjPtLV5RmtFvfiCTzlQ1
	kYd1wR2Qd4uuOZinSzCNU44WE3cnWlrc5kAP/juMmUAEBlESZldca+nKsG4y2ffX8EoTbPGEEysyW
	9VCUX4US2wb6MMUQkCoCEmvbyDZML59tAG+FjcDFKpBvGYKm/Cdoct0WLTB53/2Gug9znj5L2A1Zd
	GZcziIM/bSgFmoh0lA5WIlK/ur5kVB1LWtN36JNA2GqUULgiNDlFcmDv6XA3iCKIvsret5/6NsoNc
	h4RqKRnieP1v2GZ/7olFWPFJd9t3mtOdwOyXnbtI2teW1bDfcOJY7L+AjCJraFz81is4cBv33kSjL
	QkPDeEmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBk6-0006lr-KG; Mon, 28 Jan 2019 18:34:46 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBio-0005dh-EX
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:33:33 +0000
Received: by mail-wm1-x344.google.com with SMTP id y139so14984623wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0hHd3izZjkE/zbr93sjgSJI16UQMbc5YRiXdFWOT/jk=;
 b=kI8S6AduKzz9wxl/MDzKM3malF+7UGzYK1zbeBoG8GSNdFgohonCQflEcSHdoTPASw
 lzFxi7YYPRdbm7u9A4i4mwfq7Z9NQoDBZcCOmUfxZcA5EEpZPKd7qZL7D3Y4XG/dCscu
 it9CLMygETIGCMm0PJbLFRg787N1t84tffxIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0hHd3izZjkE/zbr93sjgSJI16UQMbc5YRiXdFWOT/jk=;
 b=FmC0CWUa/NIGTjZs/EdKr8ew207uMnn5kPX99Sbl2h2T9HhXJ9R/+43iLF2zdBV+ud
 ZzaW0i/HdZGP5+jyqF7vANvXiMrekaNmo/t5tLVNoMug6LMbmNx2wbVsXkvAG7JS9N2H
 G6ZTSqtleQeHIUziAkmfR/QGkpLRfBRehA5aAGSqGOKNFu3DnS+aAZDqXNYcEmBStyAK
 UdVgllLkTYN23f713gV+ezWlFRyOB+06bREIZmGC+4Sd+dcJztvnwoteckvPl88FAQ1U
 t2OPGwhQCVEObRBINzRBHa6SC8E5vTsfkKxMual/igEI25KSUFe2Y4Fo0xB/2SmiSAbb
 GhAg==
X-Gm-Message-State: AJcUukcqRsKEu8e3cJM/5vmMc887lfj2XT11V/KPxKnawqOE1Murq3yK
 1lGK7HCLe/8aA1M3H6MdAxWtaA==
X-Google-Smtp-Source: ALg8bN6t+0vjlFUpTvlcpNaeEM5rLYmpagl1jx/x0bgSvlVKSQhUx/xwm1tGzvEU9vC4IEKq6yUb/g==
X-Received: by 2002:a1c:968a:: with SMTP id
 y132mr17912179wmd.107.1548700405028; 
 Mon, 28 Jan 2019 10:33:25 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 10:33:24 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
 bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org,
 jassisinghbrar@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com, arnd@arndb.de,
 horms+renesas@verge.net.au, heiko@sntech.de, sibis@codeaurora.org,
 enric.balletbo@collabora.com, jagan@amarulasolutions.com, olof@lixom.net
Subject: [PATCH v2 05/14] clk: qcom: apcs-msm8916: get parent clock names from
 DT
Date: Mon, 28 Jan 2019 19:32:52 +0100
Message-Id: <1548700381-22376-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103326_979555_1F588F9A 
X-CRM114-Status: GOOD (  16.32  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 niklas.cassel@linaro.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
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
 drivers/clk/qcom/apcs-msm8916.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index a6c89a3..987ee00 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -19,7 +19,7 @@
 
 static const u32 gpll0_a53cc_map[] = { 4, 5 };
 
-static const char * const gpll0_a53cc[] = {
+static const char *gpll0_a53cc[] = {
 	"gpll0_vote",
 	"a53pll",
 };
@@ -50,6 +50,10 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	struct clk_init_data init = { };
 	int ret = -ENODEV;
+	struct clk_bulk_data pclks[] = {
+		[0] = { .id = "aux", .clk = NULL },
+		[1] = { .id = "pll", .clk = NULL },
+	};
 
 	regmap = dev_get_regmap(parent, NULL);
 	if (!regmap) {
@@ -61,6 +65,25 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
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
@@ -76,13 +99,6 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
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
