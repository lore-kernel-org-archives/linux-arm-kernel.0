Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92747C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:06:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6505720882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ib4VqARh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="diXVS6PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6505720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VK8gf88K3DGYTPLHA89pgpeDdo1uGC/w5vLUayBuYPI=; b=ib4VqARhFvHp0c
	A5mZilKd3NJzhURrKYwuXP08lT5iqaZzT430WEWxf+zCCqwtOEbEuXdUIA2hl1STvvX6XycrSZ130
	BGtsmW8iJ1EmWAyYEiQwkUcY31z0/5dfo6mahcMyInTGJU8b8Sjuo9l1xYMSq9f2UdGgQEohdm3Wb
	OQ/XLzF1EHZeg3OIEkBuaOVIvvxp8/KTLumMcifv+FLuxsXCOTiKel9u0TjFGrtsS/S8nKUdB0fN8
	WXep8M+5CjdSnqcLoPApEc8CZu6aSquXPV92COZi//PJYLw2kSdtQJhyiNY1rkTioB4WqniTCbzhP
	tGE/7+1mZ2AZMyzmamzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gonhI-00035s-TP; Wed, 30 Jan 2019 11:06:24 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonfl-0000Ze-WE
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 11:04:55 +0000
Received: by mail-wr1-x441.google.com with SMTP id f7so25648060wrp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 03:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EqtbkSQo7L/mANhknVJMLP+N/PdTpbVp8wiFd5sS1F4=;
 b=diXVS6PJBdiMcOYaOG/ZY3fIgtF55Dr3OKVSfizpuVp2CdlATsN2/QrFRWWbwOktBB
 wCJKa3koHcTuAcZJ/xzTco+eZzHXPuR4/yfce2YskejIieKZHsCITJezxzpTdu+uphwm
 xZJnBB84S3ka3smS+BTvqC6yRdhucpjr+226M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EqtbkSQo7L/mANhknVJMLP+N/PdTpbVp8wiFd5sS1F4=;
 b=jdG/xkDLKUmNdiDEpx0Y4BPwIZVyFotL1qLxi7tSN3oAp0liM/1zNdpKCxH07gdo88
 eDbZCehgCVC8J6F1eAyDSyvSkNf1Ciy0W6a9TESBhsv/moItnchARS7q9RP8ippIp3ch
 /U3mCjfVC+hIXEqq9XLrscgbjYwUu52qgEBsO1/zaucuV7B43zwBnHNga5wYSraXPJsJ
 JQloTYuLlLyHg5hk6GssnBWuTIUr1+O9B8FYjxAcSVq3rqexpv5DbTfPZ9jNk+v6lJaq
 aYiXB6OcqKb8GVqAOYPKvSGFYJacFnA1lOzj53bU6tt5+dMJTt0CCjT48KDyJO2HY5YQ
 f//w==
X-Gm-Message-State: AJcUukdIgQftKRdiXYILyZQ1/ZYuxbQSDcC09MbBDSXGr3ecGkMMxduQ
 DK5IJJG12lUH1/v8xe2e2dyGEg==
X-Google-Smtp-Source: ALg8bN69ecBVATvgzM0eUK+4q6/ufUQGsgWiXf3HdmFnIWINbcGdnFoTrg3MIEq2EEn48xs3pBoFwQ==
X-Received: by 2002:adf:c108:: with SMTP id r8mr30891283wre.233.1548846286387; 
 Wed, 30 Jan 2019 03:04:46 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w16sm1138208wrp.1.2019.01.30.03.04.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 03:04:45 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH v2 4/6] arm64: dts: Add Adreno GPU definitions
Date: Wed, 30 Jan 2019 11:04:35 +0000
Message-Id: <20190130110437.5424-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
References: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_030450_396774_871FB221 
X-CRM114-Status: GOOD (  12.36  )
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

Add an initial node for the Adreno GPU.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 86 +++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0d0b9482aa4d..095041589954 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -84,6 +84,12 @@
 			qcom,client-id = <1>;
 			qcom,vmid = <15>;
 		};
+
+		zap_shader_region: gpu@8f200000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x90b00000 0x0 0xa00000>;
+			no-map;
+		};
 	};
 
 	cpus {
@@ -796,6 +802,11 @@
 				reg = <0x24f 0x1>;
 				bits = <1 4>;
 			};
+
+			gpu_speed_bin: gpu_speed_bin@133 {
+				reg = <0x133 0x1>;
+				bits = <5 3>;
+			};
 		};
 
 		phy@34000 {
@@ -1338,6 +1349,81 @@
 			};
 		};
 
+		gpu@b00000 {
+			compatible = "qcom,adreno-530.2", "qcom,adreno";
+			#stream-id-cells = <16>;
+
+			reg = <0xb00000 0x3f000>;
+			reg-names = "kgsl_3d0_reg_memory";
+
+			interrupts = <0 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&mmcc GPU_GX_GFX3D_CLK>,
+				<&mmcc GPU_AHB_CLK>,
+				<&mmcc GPU_GX_RBBMTIMER_CLK>,
+				<&gcc GCC_BIMC_GFX_CLK>,
+				<&gcc GCC_MMSS_BIMC_GFX_CLK>;
+
+			clock-names = "core",
+				"iface",
+				"rbbmtimer",
+				"mem",
+				"mem_iface";
+
+			power-domains = <&mmcc GPU_GDSC>;
+			iommus = <&adreno_smmu 0>;
+
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
+			qcom,gpu-quirk-two-pass-use-wfi;
+			qcom,gpu-quirk-fault-detect-mask;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			gpu_opp_table: opp-table {
+				compatible  ="operating-points-v2";
+
+				/*
+				 * 624Mhz and 560Mhz are only available on speed
+				 * bin (1 << 0). All the rest are available on
+				 * all bins of the hardware
+				 */
+				opp-624000000 {
+					opp-hz = /bits/ 64 <624000000>;
+					opp-supported-hw = <0x01>;
+				};
+				opp-560000000 {
+					opp-hz = /bits/ 64 <560000000>;
+					opp-supported-hw = <0x01>;
+				};
+				opp-510000000 {
+					opp-hz = /bits/ 64 <510000000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-401800000 {
+					opp-hz = /bits/ 64 <401800000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-315000000 {
+					opp-hz = /bits/ 64 <315000000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-214000000 {
+					opp-hz = /bits/ 64 <214000000>;
+					opp-supported-hw = <0xFF>;
+				};
+				opp-133000000 {
+					opp-hz = /bits/ 64 <133000000>;
+					opp-supported-hw = <0xFF>;
+				};
+			};
+
+			zap-shader {
+				memory-region = <&zap_shader_region>;
+			};
+		};
+
 		mdss: mdss@900000 {
 			compatible = "qcom,mdss";
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
