Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5991FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:34:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF42218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q6XSOt59";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NVMQhoGw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X/lzBw/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF42218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=u9IDcYX4blmzHaXBWVwNzQp4TTWEF/zcdUuAon6oiUc=; b=q6XSOt59BbQfj+DiTajexjqqIb
	luMqH4d6CZ2lffBD+DjyGGHmMG9bBFVlrU/QMKQRcLjeRI/8pLkk5ePa4HFzaoF7WJNoXHKeYf6Xy
	xcgqImxfRHqT9KLviLkTSn0CGEN2vj7uineFXsNnl8vZcc1QC/bRl4nVElSkhb+cEHEmwnJRKrSmr
	dE4Jj4sU4lF71VdxsqXEBdE/NHaeCnCX/iunMgVsSi1FU+mFuoiltHkfveLUTiK5MwBRqbuAFOfmO
	TED6USr03Gax9k34jeCp36bFW2HmSkoHQIOdPmYPW51LwQOVnhZOLRgJd8cL7iWMxXB2j6zyjpzH7
	oTSX07vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKCK-0000qM-Ln; Tue, 18 Dec 2018 18:34:28 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKB3-000811-2w
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:33:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 72C1060A71; Tue, 18 Dec 2018 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157978;
 bh=nFY1qTEU5oJHMPFCaUE8wFs6vqjJqe+jQm8wSw6Oq+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NVMQhoGwojtKrOD+4kt6S5u/jVBokVmwoiPZwPumwqnIkUSTwQW+bA9Iedk8uXdx4
 2TGjpPI5J3WLX4iBqRNYIdmpQzYiNcShTbcpyaQAJGPoMgvtlAQnwT2eqo2M2551BG
 1OGlqOlhj8dy008f3t5quqFJx6r2Fg9j7s1E0ZGc=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id BA583609C3;
 Tue, 18 Dec 2018 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545157974;
 bh=nFY1qTEU5oJHMPFCaUE8wFs6vqjJqe+jQm8wSw6Oq+4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X/lzBw/yUxnEFpasz4LYcKftpI319lZfeTlVdJwY0kyXDsr76m0CRQ/bHnJQyKXja
 Mr00yCHzYXvTc4vGCbHf+nkb8NxM6FccU4851Z1J9PoHUbxN3SBwBT6Oe+Pni2wWnJ
 ZU0W2myfKsGKBSVqFZLVPoXDWS/Lpb/xvmJqt29A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA583609C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: freedreno@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v7 6/6] arm64: dts: sdm845: Add gpu and gmu device nodes
Date: Tue, 18 Dec 2018 11:32:41 -0700
Message-Id: <20181218183241.12830-7-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181218183241.12830-1-jcrouse@codeaurora.org>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_103309_784345_BA828BEC 
X-CRM114-Status: GOOD (  11.28  )
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
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org,
 vireshk@kernel.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the nodes to describe the Adreno GPU and GMU devices.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

v7: Updated the GMU compatible string and removed interrupt-names

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 122 +++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 233a5898ebc2..4779014e4a05 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
@@ -1349,6 +1350,127 @@
 			};
 		};
 
+
+		gpu@5000000 {
+			compatible = "qcom,adreno-630.2", "qcom,adreno";
+			#stream-id-cells = <16>;
+
+			reg = <0x5000000 0x40000>, <0x509e000 0x10>;
+			reg-names = "kgsl_3d0_reg_memory", "cx_mem";
+
+			/*
+			 * Look ma, no clocks! The GPU clocks and power are
+			 * controlled entirely by the GMU
+			 */
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			iommus = <&adreno_smmu 0>;
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			qcom,gmu = <&gmu>;
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2-qcom-level";
+
+				opp-710000000 {
+					opp-hz = /bits/ 64 <710000000>;
+					qcom,level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+				};
+
+				opp-675000000 {
+					opp-hz = /bits/ 64 <675000000>;
+					qcom,level = <RPMH_REGULATOR_LEVEL_TURBO>;
+				};
+
+				opp-596000000 {
+					opp-hz = /bits/ 64 <596000000>;
+					qcom,level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+				};
+
+				opp-520000000 {
+					opp-hz = /bits/ 64 <520000000>;
+					qcom,level = <RPMH_REGULATOR_LEVEL_NOM>;
+				};
+
+				opp-414000000 {
+					opp-hz = /bits/ 64 <414000000>;
+					qcom,level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+				};
+
+				opp-342000000 {
+					opp-hz = /bits/ 64 <342000000>;
+					qcom,level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-257000000 {
+					opp-hz = /bits/ 64 <257000000>;
+					qcom,level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+				};
+			};
+		};
+
+		adreno_smmu: iommu@5040000 {
+			compatible = "qcom,sdm845-smmu-v2", "qcom,smmu-v2";
+			reg = <0x5040000 0x10000>;
+			#iommu-cells = <1>;
+			#global-interrupts = <2>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 370 IRQ_TYPE_EDGE_RISING>,
+					<GIC_SPI 371 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				<&gcc GCC_GPU_CFG_AHB_CLK>;
+			clock-names = "bus", "iface";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+		};
+
+		gmu: gmu@506a000 {
+			compatible="qcom,adreno-gmu-630.2", "qcom,adreno-gmu";
+
+			reg = <0x506a000 0x30000>,
+				<0xb280000 0x10000>,
+				<0xb480000 0x10000>;
+			reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
+
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+
+			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
+				<&gpucc GPU_CC_CXO_CLK>,
+				<&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				<&gcc GCC_GPU_MEMNOC_GFX_CLK>;
+			clock-names = "gmu", "cxo", "axi", "memnoc";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+			iommus = <&adreno_smmu 5>;
+
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2-qcom-level";
+
+				opp-400000000 {
+					opp-hz = /bits/ 64 <400000000>;
+					qcom,level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					qcom,level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@5090000 {
 			compatible = "qcom,sdm845-gpucc";
 			reg = <0x5090000 0x9000>;
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
