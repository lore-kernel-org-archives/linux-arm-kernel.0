Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D7BC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:06:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6697920882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nmts/5H9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gn+DXnir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6697920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NwBzMQKOuekQqhP4aX6QtKBhUGxbxiclpB7y8LWfyIQ=; b=nmts/5H9Ag8tIY
	0vxKfNiySkJDMi+Z8gbJqvm+nWyIKQDpcIycH4DYz//z02sVCTdjLNdzhZggKDKx/87uEcHUEWhIC
	Bv59vnxsEV2kSdG+7wr4oSQopNwtT0t0NxN79tjokVk3iWQOh9LaDs853qwLiSOcaOkqCq8+Q25+c
	4Qc2TnjYH66CdF7/BjnTtccVnfzSz5QUUNxNtvPKYVjHbXnirjpWAePKir5nbWdtxabFKQYV+QcNv
	tw0LeCthQLlhoOZqaoF8W72Zsk1AMJagqE1aBEmw2bZzO6UuMmrZyj2SW/e3YKYkt68KxxXk22K1J
	ONzTAQw0B04gRCbiQhXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonh4-0002qJ-Ak; Wed, 30 Jan 2019 11:06:10 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonfg-0000YL-JS
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 11:04:50 +0000
Received: by mail-wr1-x444.google.com with SMTP id s12so25535969wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 03:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C9cOt5ITDVopsgviHrr1V3PGSqn/anQnP2GxQeP5Cxg=;
 b=gn+DXnir9piDYexpCWGL7lc3abIZ/CDJAP+BGByt5jD3f5f97v9WT6TktBgljAnZsD
 Ao4rZdOXsEr2adImVGzZz43IxI++0tSWE1K6c2y/QA09wlQs8oAlJHekQ/atH8AY4tPG
 4vFGUImC7rBGj1dnktqds8sMRKRMLArH9XFIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C9cOt5ITDVopsgviHrr1V3PGSqn/anQnP2GxQeP5Cxg=;
 b=VMhPCkIvfH27OSdCthxZOoiGQ73P7GMSSh9WPobdOfbFzqFmMnByScnPkjgRZcUESY
 g2ROkhm38ICegjn85nzNZkVuvflOUV7LX81nCqQp9SONLDaHJdqH5qTUIub1u6TiVG4l
 GVb9NCgJrcTgrVNcCfAH2FMM/NrL8ViFvxIgsrqZG4OKiPAeM2DuOMvPjVJJdyesVZd7
 Wzz7g3Yb793/9D6H21EDfHPxSYMF8e6vgGqKIlJck+BjBhBuCLrfK2tfqRDAjJ4hQEKK
 cesXcYP5XttsNtNMZctQJ9jEoi34TSt7QIDWbeRkUqoheNUR5ixV2dQ82aqRHBV6x3hX
 Rtfg==
X-Gm-Message-State: AJcUukdLHdgpwGs7x6c5sqgnkUt6OWZl/Ojh43Ju3h86+1AnBqx1GzWJ
 V3wCVwSY3Io8xFevDxSttx2jKTCkUp4=
X-Google-Smtp-Source: ALg8bN6Oj+tXLt+D8MKeFgavoVxd9htD59ACHcR9LOoiD98cfOUNfpiUhwTgxO5pS80w48YPu0Nbzw==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr30787619wrm.218.1548846282881; 
 Wed, 30 Jan 2019 03:04:42 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w16sm1138208wrp.1.2019.01.30.03.04.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 03:04:41 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH v2 1/6] arm64: dts: msm8996: Add graphics smmu node
Date: Wed, 30 Jan 2019 11:04:32 +0000
Message-Id: <20190130110437.5424-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
References: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_030444_634729_E30034F1 
X-CRM114-Status: GOOD (  10.04  )
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
 Jordan Crouse <jcrouse@codeaurora.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Jordan Crouse <jcrouse@codeaurora.org>

Add device node for graphics smmu, aka. adreno_smmu.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6ba96916c66d..c9b80d175fd4 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1138,6 +1138,23 @@
 			};
 		};
 
+		adreno_smmu: arm,smmu@b40000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0xb40000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+
+			clocks = <&mmcc GPU_AHB_CLK>,
+				 <&gcc GCC_MMSS_BIMC_GFX_CLK>;
+			clock-names = "iface", "bus";
+
+			power-domains = <&mmcc GPU_GDSC>;
+		};
+
 		agnoc@0 {
 			power-domains = <&gcc AGGRE0_NOC_GDSC>;
 			compatible = "simple-pm-bus";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
