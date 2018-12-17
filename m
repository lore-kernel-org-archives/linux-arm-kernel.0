Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68929C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3829E2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BPG8yfYm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YbXbCYun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3829E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=LQqA+06R+6te2OjYoLKtWe3PQrFAU3EVjsolXnJcC2c=; b=BPG8yfYmAKovee01rior0xAt+M
	7LB2lr6EbjWBKMY6bMr2FgBG4qN3kvZOUzYszZAlhgEpl/okrE4FfEInN/UXkV/wg8x7zsmcRLsfC
	WtO3H63K40am8GSN0ek5K+MsKV+X8wSYG5MfigrvNsvFdteor+qEyONFQUKIbM0YQXkk/Yhupk6h/
	/fWY2k4H28o7LZj+QAETr+b4HPrUQQCfDeL25CiL4xccsL8niFOoM6GoyVlMhh20m+QdVc8A8Sda7
	X/UgUHsXSd8G/hqHODy+eaSpZbQITYDFdh4pu7Uz+BKDFhj9r+zy/mOu6u+FLfMVj8uuRd6OyEfmJ
	EXz3gvgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpUz-0006k6-Tv; Mon, 17 Dec 2018 09:47:41 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpUA-0005qW-Pq
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:46:55 +0000
Received: by mail-wm1-x341.google.com with SMTP id s14so11656753wmh.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 01:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rA8teKiCQvBpv/jfjC2a7MA/lCNZKpqm0xO+S8oLkqM=;
 b=YbXbCYunUW3tubTWVVJb5UBGIYmnq3QR6aAeKO8sBv641SUkCq2JGFk3UXK9gihIF+
 yS59VYvgidBAEq9hRQ3kc5BPXQuoJEoA2f6mXSojC1iz7M4w1nmn/S/TNOGEKdzbLP7n
 tCUPHDMhIQ7mrxrDTHm3zx9iIT7shIbdFz2GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rA8teKiCQvBpv/jfjC2a7MA/lCNZKpqm0xO+S8oLkqM=;
 b=R+oc12nF01Sw9ZVsZT16OY3O8mD2NaCq1M4p1xMGjyAbQ4IFQoOU8HXj0qBnUwKEUG
 JjKoDq27aP3O+TrjnFuOqzw1aD4iVMPbm8k95YO/SGG6cVTzjOU+J/fIZTKJlv05n354
 qDOV7RgTuFSyz+0CECk85k5jXtCYWwc0u8HGyyJ9LNiLIoReBCvPbVjARtLyormtdhA1
 QowVnZjr9lulHPtyAHIFroVO7wWUGNArDxKodi7MqlGYkc97sYgNFUcd+sMdx5TumyiM
 PTEgox3IuZSercUvVM0GJF9KSa7SG3Qm3lSGtt6WN5bW4MGXugt7LXzJaAFPryUcWGtS
 xhcQ==
X-Gm-Message-State: AA+aEWb6KZ4gs8vk85QeTMCpBtxnX//ii1scXAltp5/dUG0wUJABkSCl
 zFnOpqR5zypBJKbeD53wWE3p3Q==
X-Google-Smtp-Source: AFSGD/UYdiFVj+9m/cqZ0SaVersMLTUha7XyliP7JunYTdoPuXWcGMWWqcUG/I8FWhybcV+WFxCHSw==
X-Received: by 2002:a1c:1b8d:: with SMTP id
 b135mr10854223wmb.115.1545039999082; 
 Mon, 17 Dec 2018 01:46:39 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.58])
 by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 01:46:38 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
 will.deacon@arm.com, mturquette@baylibre.com, jassisinghbrar@gmail.com
Subject: [PATCH 02/13] mbox: qcom: add APCS child device for QCS404
Date: Mon, 17 Dec 2018 10:46:19 +0100
Message-Id: <1545039990-19984-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_014651_209714_C64FDBEF 
X-CRM114-Status: GOOD (  13.28  )
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

There is clock controller functionality in the APCS hardware block of
qcs404 devices similar to msm8916.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index aed23ac..dc8fdab1 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -97,16 +97,21 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global")) {
-		apcs->clk = platform_device_register_data(&pdev->dev,
-							  "qcom-apcs-msm8916-clk",
-							  -1, NULL, 0);
-		if (IS_ERR(apcs->clk))
-			dev_err(&pdev->dev, "failed to register APCS clk\n");
-	}
-
 	platform_set_drvdata(pdev, apcs);
 
+	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global") ||
+	    of_device_is_compatible(np, "qcom,qcs404-apcs-apps-global"))
+		goto register_clk;
+
+	return 0;
+
+register_clk:
+	apcs->clk = platform_device_register_data(&pdev->dev,
+						  "qcom-apcs-msm8916-clk",
+						  -1, NULL, 0);
+	if (IS_ERR(apcs->clk))
+		dev_err(&pdev->dev, "failed to register APCS clk\n");
+
 	return 0;
 }
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
