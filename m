Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A5C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:36:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAB820881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uuFpfoqP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SWu1KohV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAB820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XHJRulKntXMEMgUG2YdFVWJp+/Y3hEz8rPP7KVORDjU=; b=uuFpfoqPEPLsf62uHFA6nMIltN
	yXEb1SfvAD05C7uFDxm3xJaq1bQ59B+Yz58dqsROxKB5Z0o6G99Vtza4DFpjXjsqxIBj30zdXn9mz
	lU6tyzX7BF0FrOh5MEc7uv1dvyoQxQ2vJIKGVQW2qGOm1vTMB9uqAYEfVU+oWfFVo5Vn/fYaFlx1n
	jTSXcx2yL+tG6VOadbBHU6ZZbD1xjQhAm3AHShI4nfsbeFF8+2Js5/UjYjczZQXmQzRgBWVjuDmbx
	7QgYarl/Bb+c5Fla5kPEGXUS7UddmANWV4LaMc0hODj6zzmpU782DaDGx9RZN7CrEYoh3r+jtGG/p
	nf4iiBIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBmA-0001RS-4H; Mon, 28 Jan 2019 18:36:54 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBj1-0005q7-KG
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:33:42 +0000
Received: by mail-wm1-x343.google.com with SMTP id g67so15022111wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eKEG4PSnkdw0wbmM3EXS4MNpW9S0VVzPeVsDCYH9cC0=;
 b=SWu1KohVPEDN62e9GI7Pp9rkyz0nPsSFiKPFv5EbE5rqlP7N4qpbH7R2yCb18KZwcx
 NoRVga7pQsCg6LhBCy/KapUGZIHkw1Qv65vnXLNJvM0I25SbbcFJeTFK3lF4mlW/GTkc
 XMwIv5ApWAIvUUyhHR1BVNjTEUDdv08dIyDYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eKEG4PSnkdw0wbmM3EXS4MNpW9S0VVzPeVsDCYH9cC0=;
 b=CMQyEOBGK3PdPUt8Yju6DXqyqcK0DlQFseDEiiz3ZG17MV7WUrGqiqZIr4mGktmgHX
 lBi9f09wXhjQJj1t/TFfctW4u7JN7Umvevb6ZuSFFfHT109Q5oHZknxIg2IaliXDi1LE
 xrWWXpxZpckkQdTm8qHyJcZxd7qkWfWJh1MKAaYwVXsenQZ0danYEiiPNH8Nr4xoLqgO
 o6/sqPCDfG/DJPX3mS1QC9S1EwI9y5ZV+2Xzc/YB5xz0o5iVhz48pxZyIxDanxxQ8NMB
 7ACicll8c3sMvZYKxlc6vQsK65kt9sN+dgohoCIe2CYXGEbcG9gg6gyc/Jib6MmD140R
 2ZIw==
X-Gm-Message-State: AJcUukfuyXfZwDAnyOgtp95EXdYUA2tZrWguNzxCL48Z7sWAzTgFloa4
 1KyCJ6TkOqNNrqc7HEKcw9Ao6g==
X-Google-Smtp-Source: ALg8bN5HBg/3AVwE/R6LQ+V2d+N3KCdQA1GJ9B3JemX+Vubhhdq3SbgrKeSRBV9X2irshm3zsM7/1Q==
X-Received: by 2002:a1c:6e01:: with SMTP id j1mr17759452wmc.103.1548700418085; 
 Mon, 28 Jan 2019 10:33:38 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 10:33:37 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
 bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org,
 jassisinghbrar@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com, arnd@arndb.de,
 horms+renesas@verge.net.au, heiko@sntech.de, sibis@codeaurora.org,
 enric.balletbo@collabora.com, jagan@amarulasolutions.com, olof@lixom.net
Subject: [PATCH v2 12/14] arm64: dts: qcom: qcs404: Add the clocks for APCS
 mux/divider
Date: Mon, 28 Jan 2019 19:32:59 +0100
Message-Id: <1548700381-22376-13-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103339_667469_BFAAE140 
X-CRM114-Status: GOOD (  11.84  )
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

Specify the clocks that feed the APCS mux/divider instead of using
default hardcoded values in the source code.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 6a4f8a2..948ba3c 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -373,6 +373,9 @@
 			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
 			reg = <0x0b011000 0x1000>;
 			#mbox-cells = <1>;
+			clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
+			clock-names = "aux", "pll";
+			#clock-cells = <0>;
 		};
 
 		apcs_hfpll: clock-controller@b016000 {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
