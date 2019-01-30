Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5FAC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:05:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DEEA20882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nF8ztfTf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWr9Rc2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEEA20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OV1h0SLcoUaiht52EcXdxCBtz+PyRXxy8kgL8gOy4rs=; b=nF8ztfTfhdJ4mI
	02hwW8BgINceFVEGQp5QtNHDupkA4gsGO7oHuWmBhdBIaSOAi8+gPOywLQBm5r8QFoibf/RZQKt+p
	eytQ/OfmdNF5kSTJk9GW5IjnHkRR+mqPj8SIIUY7qNDwqzJW9WeFRzLyVokB3c587h4wxY76BP85f
	9pvfVIPC55FkHWui3LZCFzPgVtN1nCZwaZ58uBzzZfV/I4Dg6ap7kJ9/Kl1YoYaGErfsjO4z/Dzd9
	UFt2C89I86Q06CPrRvNfqCXJorCVMUO0gpisLRKEs9B3NWS4lot2Sgq4I1R0obuRwBZBxLGuyqLT2
	GvObD8VtZTSuQWFiBdgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gongP-0002J3-89; Wed, 30 Jan 2019 11:05:29 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonfi-0000ZG-BX
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 11:04:48 +0000
Received: by mail-wm1-x341.google.com with SMTP id n190so21190150wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 03:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cJVPwkmiIQelbKGNm2p5QIWk1VCEgPV2Jz4v/peH4c0=;
 b=IWr9Rc2jF2+43aD07+VNUHZD1wZmOftjZqSq1yIRCCEOZTuTKk/Yy5taHsOI7un8Or
 5NT3tjbDv5XULb7UCpJxBvkpgZbHdmsrbPLb1TRmPWgcbiISOIzzMa/DB3sVExDf/xg2
 PaKSvRQHAA9+rHGy/fxyUwRaFD+/MdhiyutOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cJVPwkmiIQelbKGNm2p5QIWk1VCEgPV2Jz4v/peH4c0=;
 b=AUMQ048GRLu6j63e9RBXEhkz/ZPMRDwlti5D+id4XHz8aKIthjVTSHqow19R0Fd1xZ
 IcIuowQQRnIEFbjrZRr14lSFlFSsGWGLUDtc9g38RfcPb46dF3TqRUPV/tlZBoQtzfiB
 +Wn7dSPZpUA0d4FGBHKciM3iOJtBi6d99pMPVP3kwcie5E2Zgk6KYSbbfNcAlCoS7Cs7
 bg5JDIMhushQn8WUXjwQPSdU+/XDHBtnXPESYK2vGDUE56UhsqLV8NNbeM0VnwKassAg
 tjrUojHpkYw0CUkX52oIp+8V/ZcsRQcVLacQ17uVL0cVhL+rZ0c9ZylE/5jTe2LILa3O
 zNkg==
X-Gm-Message-State: AJcUukeQgxXYwtc4ZRUOo6D6Pvjcdi8k3vDW9QcSwfkto25gJsoMYI1k
 Om89dT3tZXjJt9sQWZh3G5sVuw==
X-Google-Smtp-Source: ALg8bN51hT0HXrUqUo5gKSH5xaw8wdDFsacE/DMKuogy1/jGKRNDNjHZM2WxUmM/sZ0iMNZYZfAKkg==
X-Received: by 2002:a1c:2d42:: with SMTP id t63mr26100138wmt.9.1548846284978; 
 Wed, 30 Jan 2019 03:04:44 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w16sm1138208wrp.1.2019.01.30.03.04.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 03:04:44 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH v2 3/6] arm64: qcom: msm8996.dtsi: Add Display nodes
Date: Wed, 30 Jan 2019 11:04:34 +0000
Message-Id: <20190130110437.5424-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
References: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_030446_392981_86D82EC6 
X-CRM114-Status: UNSURE (   9.52  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
 linux-arm-msm@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Archit Taneja <architt@codeaurora.org>

Signed-off-by: Archit Taneja <architt@codeaurora.org>
[Removed instances of mmagic clocks;
Use qcom,msm8996-smmu-v2 bindings]
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 120 ++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 96adda520bd5..0d0b9482aa4d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1337,6 +1337,126 @@
 						"bus_slave";
 			};
 		};
+
+		mdss: mdss@900000 {
+			compatible = "qcom,mdss";
+
+			reg = <0x900000 0x1000>,
+			      <0x9b0000 0x1040>,
+			      <0x9b8000 0x1040>;
+			reg-names = "mdss_phys",
+				    "vbif_phys",
+				    "vbif_nrt_phys";
+
+			power-domains = <&mmcc MDSS_GDSC>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			clocks = <&mmcc MDSS_AHB_CLK>;
+			clock-names = "iface_clk";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			mdp: mdp@901000 {
+				compatible = "qcom,mdp5";
+				reg = <0x901000 0x90000>;
+				reg-names = "mdp_phys";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc SMMU_MDP_AXI_CLK>,
+					 <&mmcc MDSS_VSYNC_CLK>;
+				clock-names = "iface_clk",
+					      "bus_clk",
+					      "core_clk",
+					      "iommu_clk",
+					      "vsync_clk";
+
+				iommus = <&mdp_smmu 0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdp5_intf3_out: endpoint {
+							remote-endpoint = <&hdmi_in>;
+						};
+					};
+				};
+			};
+
+			hdmi: hdmi-tx@9a0000 {
+				compatible = "qcom,hdmi-tx-8996";
+				reg =	<0x009a0000 0x50c>,
+					<0x00070000 0x6158>,
+					<0x009e0000 0xfff>;
+				reg-names = "core_physical",
+					    "qfprom_physical",
+					    "hdcp_physical";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_HDMI_CLK>,
+					 <&mmcc MDSS_HDMI_AHB_CLK>,
+					 <&mmcc MDSS_EXTPCLK_CLK>;
+				clock-names =
+					"mdp_core_clk",
+					"iface_clk",
+					"core_clk",
+					"alt_iface_clk",
+					"extp_clk";
+
+				phys = <&hdmi_phy>;
+				phy-names = "hdmi_phy";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						hdmi_in: endpoint {
+							remote-endpoint = <&mdp5_intf3_out>;
+						};
+					};
+				};
+			};
+
+			hdmi_phy: hdmi-phy@9a0600 {
+				#phy-cells = <0>;
+				compatible = "qcom,hdmi-phy-8996";
+				reg = <0x9a0600 0x1c4>,
+				      <0x9a0a00 0x124>,
+				      <0x9a0c00 0x124>,
+				      <0x9a0e00 0x124>,
+				      <0x9a1000 0x124>,
+				      <0x9a1200 0x0c8>;
+				reg-names = "hdmi_pll",
+					    "hdmi_tx_l0",
+					    "hdmi_tx_l1",
+					    "hdmi_tx_l2",
+					    "hdmi_tx_l3",
+					    "hdmi_phy";
+
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&gcc GCC_HDMI_CLKREF_CLK>;
+				clock-names = "iface_clk",
+					      "ref_clk";
+			};
+		};
 	};
 
 	adsp-pil {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
