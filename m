Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40232C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:36:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB14620881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bgikbepF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FP7HwM2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB14620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=oz/QpGa1V4vu/5MK1mK50ghc+gZ37hYjfLdkFbQyOIc=; b=bgikbepFmYG1IVUWU9EbXXoBEd
	EokaYwORZtRaUCcdpYGikLwfRWOcKIZZPdz3oNz/Q++0h/7oQgnYwM+YHGsTwn/+SPNZaPZlp1lb1
	Q0icIgMev03UfMUS86euHj30wDr1zq2RUi85jUd+hLJzzf05F66EakuBwk+2Qbr0ewRylE6uLXWZp
	fzeO+Fhm9rEiX1HhL/Z5NprY4p7LxItsrhyF8y2lVuEQOoVyE5dlXVsTt9Qh5p+3CkNkW72/QtgLI
	kjgdMOjCHKDVnv2sTmNF/njij95S9cWM5xU8r7Z2oWdnN6/J1DpP4gPcxShjiwKTgm/+RACVXX8ld
	luIxEozg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBlo-00019G-6P; Mon, 28 Jan 2019 18:36:32 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBiz-0005oz-Dt
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:33:40 +0000
Received: by mail-wr1-x444.google.com with SMTP id p7so19288894wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OVxxzmEh7O/wpeFAQp3T6SExbMI3Aurwjiqrjgi1z+A=;
 b=FP7HwM2TSUkrIzNgUgG81sDzpBy1MOMEoPvqCecdfRPpDpVQ5LmCEuFQKYFV9eBd12
 /O3Il73uqXfnJ+Y7g4nX3CpLkaCZm2o4JRrFE+4B2Quez8vvqQN1bIdW86sjujlDMt3b
 riz5HTi3W5KUdadChQakj9B/2+sw+7Hfj6BLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OVxxzmEh7O/wpeFAQp3T6SExbMI3Aurwjiqrjgi1z+A=;
 b=BPej8IhP3nMud7SYT1BLzUrggwk8R4+Q/7l0XYRTTmeWfh0k2G/+hpG8muqsAg69qt
 6VRQ6jfO+/YEPQ7f5L4GbmDCrEODtH306S+0Bj6BEB8GVSvIaC0ff3ozkuoPp+KO0wy/
 dWJXgEV77UPmWuqVEQh07YkSxtWC4CdqV5TRrOwABeLNetQ/wV5eQhcJ7U/KTuhzJvED
 dP3UZ431DklyYaRNfzu6ZaIK/0bSmFFkeN8iHdZMHi/xCqfl+a6FDqv+3wTy+e9rVIUv
 138HNBBFFi/z3s0NYJF1k/S/zieks/yNBdtEF4Q/3464efTJjGooA6diCbAEQhwNxKdP
 bqrA==
X-Gm-Message-State: AJcUukfOacVxap3kdNqF0MSjoOOe6NZgsKVlKHThsJBbwL9lVDJAj92x
 H5NhH8/v01nLpWUvpXGhoqFvPg==
X-Google-Smtp-Source: ALg8bN4SXh1T9ga64YDOTO69/f0UDKj9oqz1dD6hdFF1PkvJnEnxBBXmTr4nQlg7jzgMSnBfwyKZVA==
X-Received: by 2002:adf:e7d0:: with SMTP id e16mr23945970wrn.142.1548700416145; 
 Mon, 28 Jan 2019 10:33:36 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 10:33:35 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
 bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org,
 jassisinghbrar@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com, arnd@arndb.de,
 horms+renesas@verge.net.au, heiko@sntech.de, sibis@codeaurora.org,
 enric.balletbo@collabora.com, jagan@amarulasolutions.com, olof@lixom.net
Subject: [PATCH v2 11/14] arm64: dts: qcom: qcs404: Add HFPLL node
Date: Mon, 28 Jan 2019 19:32:58 +0100
Message-Id: <1548700381-22376-12-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103337_696173_0C9A918E 
X-CRM114-Status: GOOD (  11.86  )
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

The high frequency pll functionality is required to enable CPU
frequency scaling operation.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 4594fea7..6a4f8a2 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -62,7 +62,7 @@
 		};
 	};
 
-	cpu_opp_table: cpu_opp_table {
+	cpu_opp_table: cpu-opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -375,6 +375,15 @@
 			#mbox-cells = <1>;
 		};
 
+		apcs_hfpll: clock-controller@b016000 {
+			compatible = "qcom,hfpll";
+			reg = <0x0b016000 0x30>;
+			#clock-cells = <0>;
+			clock-output-names = "apcs_hfpll";
+			clocks = <&xo_board>;
+			clock-names = "xo";
+		};
+
 		timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
