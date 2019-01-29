Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3942CC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:25:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021562147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gcBMNtiu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BngKv3PV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021562147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LpRGiIR+F6KKbQ92Tvp+SPydHBBs+qFqE5V3EFgsrs0=; b=gcBMNtiuHjPTDX
	piCF539EnUwW25dx9ZnoUF20eqMXgJcP0l7XTJBkcr3wV2nDHAHVh4wn1Ng2TSJOnjlLwdO+lyUNK
	hFi/Q9FIVNuY6O2cmK87DIXAntLVc4YriRM/kYc3oSqxt8o7YPVOrf8gITgAw4pOkr6Odm4wFPQuH
	t6z+V7z87sI1ZN2Zj1PvTyFwXqzLeKHn8BnMZvtIA8Eu4qmv6LNljdVJVq3OhDxcCdXXzu0XaoAkP
	v1isfz6+ojY6NU5qif7hPHlMD3D7TjzktRau7PWzHix8AumATWi/oQRdzRvumGT3yVwOjayZFtcgx
	0wZM2mc9lEQpmcjWD0/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTOI-0005PZ-T2; Tue, 29 Jan 2019 13:25:26 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTMq-00036T-UX
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:24:00 +0000
Received: by mail-wm1-x343.google.com with SMTP id d15so17836784wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 05:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SDgDFPrkTA9qfo23o9Li/MtHbx/Thbm07i4c1CfCSpI=;
 b=BngKv3PVYF0FRPSQpkCQQ1Aa5XFzeWfypO4D4ukCchwkNIEFc2dsZrzhV3DqLuC9sn
 kTkvQeRCapFMiSix4RbAk3SyRqOcUjB6hhdCe9269bKyYNuW4/CjAUkrQJuvHB2wHbdX
 X80lJXz98eZMzrGxmOu32TYhwUjOWMGCq0GYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SDgDFPrkTA9qfo23o9Li/MtHbx/Thbm07i4c1CfCSpI=;
 b=aIhx/KZKlASgAwhzWA6FlBqPZ/mIrPaLuWhk0dWwqOVkJ+wW9+z9gmqoHtvX1cbH87
 TGskK+cp5gw/0u0BndX/7EJS+t7/1SilQRYZAatPmSkMn1wAddCIRGBzbA6mQljgNnxb
 R16/paHpA9rQtD3ID1EdJQ3uBh55/6STWk4+R+30hGI0ZdTSV3Oca81FvVzf8ZT0iq4o
 1CkGFZi+sMrQr68TyS1iIdai1s1weupOKUlsofz0jYRNC9qQfcWZ0rp2VglAwWx/sAYi
 n/AK4XBH3aiWXFwMAvAYBYflvKKHWfqH7tLCCT2iSGSSVJ55pYGd4YFMmQHQJpbIanTS
 W5ZQ==
X-Gm-Message-State: AJcUukcT529Bofn592IfSgC5zrQXZDJdRchMT0NPxSRPtyqWjaAt2bR6
 L+xUdan94D4qHjFiDqeaCgjI2Q==
X-Google-Smtp-Source: ALg8bN5e0yOGtsbQt25BH7kXcgWXwY7RIGpFS8haQyv+nafZohGkAXAUIMVpPWQEyW5a5bTkbD9JYA==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr20447767wmj.129.1548768235552; 
 Tue, 29 Jan 2019 05:23:55 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w80sm3739628wme.38.2019.01.29.05.23.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 29 Jan 2019 05:23:54 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH 4/6] arm64: dts: Add Adreno GPU and GPU smmu definitions
Date: Tue, 29 Jan 2019 13:23:33 +0000
Message-Id: <20190129132335.30695-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
References: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_052356_994943_A07E48DA 
X-CRM114-Status: GOOD (  12.33  )
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

Add an initial node for the Adreno GPU and it's companion
SMMU. The GPU node is mostly complete except for a bare
bones power table that will be filled out more completely
later.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
[Remove mmagic clocks from GPU/smmu nodes]
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0d0b9482aa4d..b5f23594905c 100644
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
@@ -1338,6 +1344,52 @@
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
+			interrupt-names = "kgsl_3d0_irq";
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
+			qcom,gpu-quirk-two-pass-use-wfi;
+			qcom,gpu-quirk-fault-detect-mask;
+
+			/* This is a safe speed for bring up in all bin levels.
+			 * This isn't the fastest the chip can go, but we can
+			 * get there eventually */
+			qcom,gpu-pwrlevels {
+				compatible = "qcom,gpu-pwrlevels";
+				qcom,gpu-pwrlevel@0 {
+					qcom,gpu-freq = <510000000>;
+				};
+				qcom,gpu-pwrlevel@1 {
+					qcom,gpu-freq = <27000000>;
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
