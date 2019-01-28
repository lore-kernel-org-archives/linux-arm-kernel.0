Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD500C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:46:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E042086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="spNuIiCw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QFAkdXtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E042086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kxPSr+RwIpz5djIvlEWPQ9XFAcQsIOWcG4zqau/Ba5w=; b=spNuIiCw4I5hgFBZxr7GVkYzyc
	XMM3Gwt9GzqpmmyzlM4+RusR2qeUZQuqLY+N3VdvAePgN1XNMx4gly6fa5VA5UaATSl+wYGbCcaol
	GfvQu68ayMVA21L4BrQgq8lzvrC3vRoG2DBmi+EV0KTET6wr5zrMhTkNB/Zbw9fvGA3KTgbhzBB/L
	RqnNAIAi8/mgBuxCb9HkurzKL0+WeC7tUoZT/JZ/e8Cj7aVE8vv49caPutvTYPggq6hIEQc+dg0/X
	SNfc6FICnLSQIseVMe4mw/8Um4lTYL071oT1Dcy6BujQluIbexu4ysP0vlsgAZtY893q9sMuq9FG1
	rqzKGzAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5Mb-0004pA-QF; Mon, 28 Jan 2019 11:46:05 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5Lr-00048J-Bs
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 11:45:22 +0000
Received: by mail-wr1-x442.google.com with SMTP id q18so17659275wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2gNvmDs3vCdOhRLOPNjOrr4p1fKxmGZTEdGsMe8hCo4=;
 b=QFAkdXtWd050TwoTegdEMbPl5/cb7Ej2bG9FxckLttf25SeT1yiZiIAAqPSeadyF/c
 8crg1BiOvFHr0tHdZ6fq1EPi8wIGAL536DP2a05uUx0Kj8WWbuFqYbmZwpdwr4gU6G3k
 cYu9/da5qQov7rxgj9S8OF6En08rYNaOkO064=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2gNvmDs3vCdOhRLOPNjOrr4p1fKxmGZTEdGsMe8hCo4=;
 b=WkkKegKOPsBh99iW/sc9Gt4Lu8FkwDMNwaE7ginXByXhRst3wPmaYctOErGW3DTgOE
 gE7HeOcEyoq8xQ/JvSuNOVAkBb8Z8HyD0AzzCWXz7/uuA+YAXZ5+SIws4TUW3IllGD2q
 uB+u0lfzyd6zICWgCDOvawfilrhyByLN56xll0lipuzK/juDiU6FFpjEvSLjrDCzvXLJ
 4Oum83dc3P080+XlEEwwRvqLLZnNyUklfCKYXwWr/EOInsmE2uauONnPYa789LwwdgVp
 s0DvxDsCPhJf48Sez4GCRmlYhJFoJXFOPBX9U9sFb2n4iCfcxelv+uP+6/FhjaL6SB0/
 ECCg==
X-Gm-Message-State: AJcUukfN7Zi+253m0YPWMo+btQoQnuriGDvPzv+ZaEVbM1YZNCZMdDQp
 vYa2OElCdBuZBQ4qFG5zt6sQMg==
X-Google-Smtp-Source: ALg8bN6BGZsCuwASfqXlpxEOCs2Vy2ZlU2twy93qHgQNQJQAkcnMzXRuKazQyjafvS1+QJ4qCNEWzQ==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr22181171wrs.117.1548675917529; 
 Mon, 28 Jan 2019 03:45:17 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id z9sm122968775wrs.63.2019.01.28.03.45.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 03:45:17 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCH 3/3] arm64: dts: qcom: pms405: add spmi regulators
Date: Mon, 28 Jan 2019 12:45:04 +0100
Message-Id: <1548675904-18324-4-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548675904-18324-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_034519_569123_644927CC 
X-CRM114-Status: GOOD (  10.50  )
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
Cc: devicetree@vger.kernel.org, vinod.koul@linaro.org,
 linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 niklas.cassel@linaro.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The PMS405 sports 5 SMPS and 13 LDO regulators.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index ad2b62d..6fbdb1e 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -52,4 +52,24 @@
 			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
 		};
 	};
+
+	pms405_1: pms405@1 {
+		compatible = "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		regulators {
+			compatible = "qcom,pms405-regulators";
+			vdd_s3-supply = <&pms405_s3>;
+
+			pms405_s3: s3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vdd_cpu";
+				regulator-min-microvolt = <1048000>;
+				regulator-max-microvolt = <1352000>;
+			};
+		};
+	};
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
