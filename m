Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC41C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:40:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A0320881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jIeY2S+N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9vc9C12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A0320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YsM9VAoWqaSLVejMLLnyv0K0kuHJmogfS7Xw7XMf0XU=; b=jIeY2S+NzZzXe4ZLbHFyzHUpZl
	bgN/dnbPogg0XuFuIkrzwwXC67s9x/Xj2OnK5Z3Xu2znCoUCojKiNMvG9Gyie6Iw0UoGif9udhSho
	dxnzJhj5//HiBRbNThJTHEK7ijiPf9D9sFaIRPOm5gAjX6JN9l0eWw6yMGFB0UupY9dOi7eXRgNin
	HXkQq+1+E10CROLl4U1POzIpFY1HK5gKcw9iqRW8Dz1b8xzfgUWL8j8yxysYzkYwgPevxVV4uvO71
	HiIoq0qv1lg75D6n3zDEcsvxp+Qg3ek3vehH8PbF1v9k742lt8RAr07WaUvuOQp/25UH/Cw7B24oP
	XWWT2aCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBpY-0004AD-VZ; Mon, 28 Jan 2019 18:40:25 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBj3-0005r3-64
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:33:43 +0000
Received: by mail-wr1-x443.google.com with SMTP id q18so19215733wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5jwkKlS341j7fyk95QNvo70XMLCAjNUCF7cHyyXT/yc=;
 b=I9vc9C123OGGrDPTEKb5TUh/XNiAw4yOfrCyECVMnCLNqO9xZI5rx/Z6EAJpySXVEt
 xDwDN/UvvPHwcg1qG1Isdt7DytmzEJEQ6U8ew76/GlCl7yThh6ae2lefENgeb8ucGlZt
 j7YQ1Z3CclpMfyTSM8r8Mj6GPj7DUjfRMOoDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5jwkKlS341j7fyk95QNvo70XMLCAjNUCF7cHyyXT/yc=;
 b=mDYDKtMEUL4+0dJET4VuRBHP31sJ3OSSb7MTnmq2sfWllUScZfthsErgZc4Dr9xGIN
 grIaJo7Bj945p+v1YmvkuP3tNq860a5VAGP+9CA7NUoNqz3eVJG/zxYOuPnARGQeFPCh
 GyOsrq5f9+OgXVa6u3rvc7qtr+0Be0VzWAteCz4O+El/x4jc2qTrV1AyBizs9MJbofgl
 UC49UNC13Jk9//85vFCp49OkxutWNUZiXk0X8BxpWwNLnb+6poROa8p+J7SzTRKqrpI5
 vSXu2EbDlEWMBknsTAHuGENGrl3p74DKdGumdOjq1nHa26DStUcUtWFMkjZYHCtnop/S
 dF4w==
X-Gm-Message-State: AJcUukfdWfPJy7+rZK/S56YcWsI+pQyoPYidTvIp/m5MTNTUuwILuZBv
 79a0poqHg9aKyEQPnoN2VNnrUA==
X-Google-Smtp-Source: ALg8bN4ANPmpripSYqtVHClOsBGDkEBMMr4PV/AL/gsrTDBadsPwLHr9Ee1OKnOCk6NaYkvg8yFXLQ==
X-Received: by 2002:adf:9521:: with SMTP id 30mr21617095wrs.192.1548700419861; 
 Mon, 28 Jan 2019 10:33:39 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 10:33:39 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
 bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org,
 jassisinghbrar@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com, arnd@arndb.de,
 horms+renesas@verge.net.au, heiko@sntech.de, sibis@codeaurora.org,
 enric.balletbo@collabora.com, jagan@amarulasolutions.com, olof@lixom.net
Subject: [PATCH v2 13/14] arm64: dts: qcom: qcs404: Add cpufreq support
Date: Mon, 28 Jan 2019 19:33:00 +0100
Message-Id: <1548700381-22376-14-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103341_439210_A7450819 
X-CRM114-Status: GOOD (  10.59  )
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

Support CPU frequency scaling on qcs404.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 948ba3c..a0f58bf 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -30,6 +30,8 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU1: cpu@101 {
@@ -38,6 +40,8 @@
 			reg = <0x101>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU2: cpu@102 {
@@ -46,6 +50,8 @@
 			reg = <0x102>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		CPU3: cpu@103 {
@@ -54,6 +60,8 @@
 			reg = <0x103>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
 		};
 
 		L2_0: l2-cache {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
