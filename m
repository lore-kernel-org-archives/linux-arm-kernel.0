Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0473C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:24:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAF52086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="elC2Goys";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5DWwx0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAF52086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NwBzMQKOuekQqhP4aX6QtKBhUGxbxiclpB7y8LWfyIQ=; b=elC2GoysiRL0Hy
	9ffUksWvz8Jslq1LUoBUbc/NliDFOWVQ4uaZyjFTu4Rh/7S0z8VRPCbfrBNTto6a3/meHCPSeyqbD
	FmTs36LnK7JLascjCrntyeny3kE3US4v8bYDpsyIQbfSoYxWHjinCfNaeA8A0J0EPMwvFJjZM0tgt
	dkRXezYyRGLjM/P96Fq3arqjljzg2zWbBI7tRsP69LY+67/qXiDgT9YVTG9fYunEVUuzbWKl5SUBd
	mklI0fDVkozykKvmNzQx87MrZLo5qibBNt08G7lbpOPcrEq6ZwoRc2FaEd3ekeFHgqD3ngHa6Yisy
	iibV3U6bmQRHrVR+Nj7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTMu-00038H-UE; Tue, 29 Jan 2019 13:24:00 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTMp-00036B-6e
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:23:58 +0000
Received: by mail-wm1-x343.google.com with SMTP id n190so17857218wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 05:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C9cOt5ITDVopsgviHrr1V3PGSqn/anQnP2GxQeP5Cxg=;
 b=V5DWwx0nuHbq+tHes4yn81mU2X7chix9xGALjVonp505GJuevkUXoz5CspYma5be3X
 94/ZkVb3sqVEr+QKfz5ngQlP/4niZeyyILdtRux5Wdqi4/dVnhBgEW2a1Es1HQ6yQQww
 BKXPk8t6RUpH5Hv4ESoQoN68e4TrQJFGZWg80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C9cOt5ITDVopsgviHrr1V3PGSqn/anQnP2GxQeP5Cxg=;
 b=sGvf+rgYyAQ2bz1PQBecRRb5A4BlWxm2OpXOlf/JrMsjbY1iTpOZHcfV5iCbEnvHlM
 dOZhy20I9ecI9VTyqtfMJNwC+Y8dqDUBa/PAj2iW2VLyBX6GZzT4byn8MpGtXsvF2Z8Q
 OQfowdXArqMbT7iwKwzid30x3ceA/nfZzKmYwqH5x1F6VuXFE4s8MnSEoOOs0OwoJDxi
 51+lNsvz1obuvb0DN88z4gSP4bUCcSZo32MUVHNFL2+fg9zv91/mWlxdKs57ZgjehZQS
 QMa6g9k+J8UTyMd5jQR8yZkqI9suAdfrQ8S7rHl/8KBkCY7LsHGoao8IIZlw4+YneXYC
 +p3g==
X-Gm-Message-State: AJcUukeTp2zTBFvYPZV162MP2Zg3rRNRPKcTkt/bZoC6fuDMHW3/3HQm
 DptmR+GzmOy6mno8oop1Panxdg==
X-Google-Smtp-Source: ALg8bN6gySsAn5g0IUpGFKVAtROKVFgU44X8GOl0tfCC4/dBNpueYF81NhVHcSdDI9wtc7n6SQnJuQ==
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr20720209wmd.98.1548768231741; 
 Tue, 29 Jan 2019 05:23:51 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w80sm3739628wme.38.2019.01.29.05.23.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 29 Jan 2019 05:23:50 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH 1/6] arm64: dts: msm8996: Add graphics smmu node
Date: Tue, 29 Jan 2019 13:23:30 +0000
Message-Id: <20190129132335.30695-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
References: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_052356_775175_277FAD4F 
X-CRM114-Status: GOOD (  10.02  )
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
