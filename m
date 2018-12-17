Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A18EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:50:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497EA2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UZKNC3Vo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FoJRxte5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497EA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5PP3MoXg3jw0QnWvfVrF6/9ljd9lJF43fUYnLyEjhpA=; b=UZKNC3Vojcn9rlahrqEEsYLn42
	gPCiPD+112BMTrp6HLnL/sH1ujNpYc6T8P+gLePxZYQOxf2v0JP8mTxkIiukKv0uGB/W0Lw5ombcG
	DOnUHqAyNQ/OSFTlv7YjnL6x7lhFco4SzzQ3+uqVO2X31shb5BpNBYgppKTq2192/jpDuTKBapT62
	md7wjeQGTuFLUPRIlrcqBy4CXXH0W7epcd6iVp/veJJlTgceLwjzgjK8Z8kWbk6DrRnLhQ0zqubUh
	HRnGxQxy3nqrPTzZTsNwmD5Ie8jmRmHoVMcbQElRIOIL53/arc81+ykNI/mKeQLHMCiYlF0Rhk4LN
	UVO7qmpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpXU-0001Wk-S4; Mon, 17 Dec 2018 09:50:16 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpUU-00062y-Me
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:47:12 +0000
Received: by mail-wr1-x443.google.com with SMTP id v13so11531094wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 01:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=trBOZeUZ42tXHraYvTz2rphVlhKTWLVThNKSv6QZHLQ=;
 b=FoJRxte5GxIjPmcVqIEkGM+x/BCDOU1h6ZYf63+VJDb0xLs7ryQZiUSVsBlpThKX4v
 PfyLuqhwQ6UN1N4rbF/rM5NLdCLQ6rat3x8M7claAyBkDAxKuY9R6FhHE2KAhflZaF1D
 6sPl5ernAuDWw9WtWPeZVPzpwnpQ/nYk27+hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=trBOZeUZ42tXHraYvTz2rphVlhKTWLVThNKSv6QZHLQ=;
 b=ExMG2spixgri/3uSIDdzG5igSdk3F6Dze8UbifTbXkMYJ61mwSiAljRQE7yLxe4zQP
 FfQPUiIUmyIGed2hSlg1wpLcFEd2V4DPYyMyZn7P/2VUoOpxsnu3iC2kX/qd7RzgfB6E
 5N6dutsmf5c5yHF8ozmnCtks+MQ7CAXZZ6dGSNHZEhUb97tvQWOWiEnsjl38g9wZCtXI
 ++qPjpf18Oop2WLBDMW29+l3f1wfCbo5lethlknm89w6XlskL0yhbbRTSOaHKpYYtcy0
 D4TWTtbo56zxkq5WR9nuegDqQXZkBK5odZ+crrTzgGI2MWmROrP7pe8q3vfnNFf0Hyc1
 OwuA==
X-Gm-Message-State: AA+aEWYNklcpn+Xo/wlkSxlT0v4Ge2Fs8FfWsnFuPdqUMBcckNk2QIzg
 JaDCCcnyEha/+iyX8L34P0esvQ==
X-Google-Smtp-Source: AFSGD/UzwOvBjMk5OAnuhTgTLtekacbChin6HSwst6mWBMEinLXT29f0XoEfR9M5MgMwW7wd8+Vh2g==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr9993063wrq.15.1545040019026; 
 Mon, 17 Dec 2018 01:46:59 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.58])
 by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 01:46:58 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
 will.deacon@arm.com, mturquette@baylibre.com, jassisinghbrar@gmail.com
Subject: [PATCH 12/13] arm64: dts: qcom: qcs404: Add cpufreq support
Date: Mon, 17 Dec 2018 10:46:29 +0100
Message-Id: <1545039990-19984-13-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_014710_850550_1A78B293 
X-CRM114-Status: GOOD (  10.95  )
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

Support CPU frequency scaling on qcs404.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 2d9e70e..5a14887 100644
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
