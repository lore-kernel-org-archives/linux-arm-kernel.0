Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9D8C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:58:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED962087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IQehW2Gl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UhHvXy/h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GVonx3/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED962087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=44LVXJtN28uzSOTg7eXHitLCuPkp1MV3MmBR7iGBP4Y=; b=IQehW2GlPJec2fJ6z68PZzhhrV
	ttUoBEv7RoNqIJkH98rJqU3hhdHDw39zlEvhDvPXV5lDM6VVYGjQ2acwWCSpmy3PeIYVmFyxJlMca
	Y+XAmau7FcMTKgmOcyaS16rMz9GJ10lPRJyTu1zwzr0lhS34GagRvvfSVp/DCDa/gMbM02tEWgZIr
	T8YUIt9gddxOQYWx3nQnO9riNVx9Z9gp3R6izQTFOZakLpNJ2BEvwp0rljld4DtdFJ/qLOJp9/Sur
	lrbfVXATBwDGiK2hvFZSReVl7wl4azqJhUrHA22Cbsxi0BXdlGTvRk8ygs7tPcUxq5faCp7ucLfJe
	nH5iBYwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1godH9-0004LK-AC; Tue, 29 Jan 2019 23:58:43 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1godH5-0004Ky-L3
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 23:58:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 0360C6086A; Tue, 29 Jan 2019 23:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548806319;
 bh=TFeXFeJqUiZeXmdhfW4qtXXuxyR/0wVRifb6XPiV5Qo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UhHvXy/hbi9gAihM21fU3/zLhkzeZqnSEfokKW0f3/A7Pr7g3AGNbKMVrgQDLqqoa
 N6jJcKhwDrD9pEOu5zprbu4YaXO8IuK7JntwqgET+53qd+geuJMwkrQtBY6OjKECWG
 rq/GjDBwB7DbtyuATCNfPM8Yt16H3QhaUQeNN4WU=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: jcrouse@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A89D8602F8;
 Tue, 29 Jan 2019 23:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548806318;
 bh=TFeXFeJqUiZeXmdhfW4qtXXuxyR/0wVRifb6XPiV5Qo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GVonx3/teCd98QitGqH9AgSQZBsu3DkylPL/3CdaphdurKJ5A64d8f/cLUOkERi/J
 RzsPiZ/H1PmXjmI2O9yJ/LVqNsewc9A7CcLsFfdYiXMf08UYErH6+PNdY1eiOgkOHX
 ASRBRQpCuX1piDy9G/KUSI3fCG1JI7dkoz97uHJY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A89D8602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: srinivas.kandagatla@linaro.org
Subject: [PATCH] arm64: dts: Add Adreno GPU and GPU smmu definitions
Date: Tue, 29 Jan 2019 16:58:34 -0700
Message-Id: <1548806314-31788-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190129132335.30695-5-srinivas.kandagatla@linaro.org>
References: <20190129132335.30695-5-srinivas.kandagatla@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_155839_725949_636AD1E5 
X-CRM114-Status: GOOD (  13.20  )
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
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
 vivek.gautam@codeaurora.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add an initial node for the Adreno GPU and it's companion
SMMU.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---
This is slightly updated version of [1] to include a correct OPP table and other
such stuff. I didn't know the best way to send it, so I attached it to the
original email and hopefully Andy forgives me. Otherwise, Srinivas can resend
it correctly.

[1] https://patchwork.kernel.org/patch/10786185/

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 86 +++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0d0b948..0950415 100644
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
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
