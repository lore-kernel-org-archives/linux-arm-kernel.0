Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF99C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:16:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3F220657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JcAwSp+5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ojpKu2DS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ojpKu2DS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3F220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9ZavzFrRGEWfqB2pDxHBvIrxC3gcth0lk3LlxfDdQaY=; b=JcAwSp+5Dze4SO
	T9ZSVd+zrAQnnUN6ws6GnAAKPtAkaiIlaehgwSyGNE3GpKTOkwDFhEYeML6kxAp+sWPCuS2ofHueR
	jFMdqV33UUGCPJTLgjcWL97nCscmc+SMqr9M3tpV1nXDhlOCGSdokL+plzZvgGwJmJg/s25PzgUto
	BaQ/pgnQS95Lgts9laJNoMzYeZ22lDjmTtY+HM5W1xFzHrU+S1lYvAZdgNU0ix2uqQTeOJLlWoWbZ
	Aqp6G79yNvftWsgzgOAzW/o5cCu3i1+H+GEcHvUQ5roqwJTi+EiEuJ3FgoJ/HCQbTH/ge/3ZC531e
	YsN4HkG+D5kN+YfPP2aA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk3mf-0003LD-DP; Thu, 17 Jan 2019 09:16:21 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk3mc-0003Kt-A4
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 09:16:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id B51EF60807; Thu, 17 Jan 2019 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547716577;
 bh=8T+x0tKb6M4sdkHsZm/gSK6UzAOkiObL3LBGb2D36zo=;
 h=From:To:Cc:Subject:Date:From;
 b=ojpKu2DSmIPp8JlIj0/kwjGCC3mZVLI5aARjtpkpxigcfX0bF4oNAiG/tbJSxYCk2
 M/iLDJwk6nwoHlGGazWBHpBe8lDQcimUayQgiT6ZHmHi1g+B1uQ5YgrS1J6wX47q7Z
 zHiSDVN+WmMbyfYQkbUQVib4H02I8zJXyhYhwhKY=
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 294596075A;
 Thu, 17 Jan 2019 09:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1547716577;
 bh=8T+x0tKb6M4sdkHsZm/gSK6UzAOkiObL3LBGb2D36zo=;
 h=From:To:Cc:Subject:Date:From;
 b=ojpKu2DSmIPp8JlIj0/kwjGCC3mZVLI5aARjtpkpxigcfX0bF4oNAiG/tbJSxYCk2
 M/iLDJwk6nwoHlGGazWBHpBe8lDQcimUayQgiT6ZHmHi1g+B1uQ5YgrS1J6wX47q7Z
 zHiSDVN+WmMbyfYQkbUQVib4H02I8zJXyhYhwhKY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 294596075A
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Guenter Roeck <linux@roeck-us.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org,
 Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] watchdog: qcom: Add suspend/resume support
Date: Thu, 17 Jan 2019 14:45:55 +0530
Message-Id: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_011618_389034_B7954724 
X-CRM114-Status: GOOD (  11.19  )
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
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the support for qcom watchdog suspend and resume
when entering and exiting deep sleep states. Otherwise
having watchdog active after suspend would result in unwanted
crashes/resets if resume happens after a long time.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/watchdog/qcom-wdt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 780971318810..4f58185e89eb 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -245,6 +245,30 @@ static int qcom_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int qcom_wdt_suspend(struct device *dev)
+{
+	struct qcom_wdt *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd))
+		qcom_wdt_stop(&wdt->wdd);
+
+	return 0;
+}
+
+static int qcom_wdt_resume(struct device *dev)
+{
+	struct qcom_wdt *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd))
+		qcom_wdt_start(&wdt->wdd);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(qcom_wdt_pm_ops, qcom_wdt_suspend, qcom_wdt_resume);
+
 static const struct of_device_id qcom_wdt_of_table[] = {
 	{ .compatible = "qcom,kpss-timer", .data = reg_offset_data_apcs_tmr },
 	{ .compatible = "qcom,scss-timer", .data = reg_offset_data_apcs_tmr },
@@ -259,6 +283,7 @@ static struct platform_driver qcom_watchdog_driver = {
 	.driver	= {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= qcom_wdt_of_table,
+		.pm		= &qcom_wdt_pm_ops,
 	},
 };
 module_platform_driver(qcom_watchdog_driver);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
