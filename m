Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF89C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:25:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985A52147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g53uCnak";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="imGOnd4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985A52147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OV1h0SLcoUaiht52EcXdxCBtz+PyRXxy8kgL8gOy4rs=; b=g53uCnakdPHXKc
	He9SM4aQA5U6k57B4IpL54JRl75CniJSJJUcluvwllMHu849nLBpw3BgWH5mCw7afeF4/Pp8QfUU8
	+V5avQ2mcdrzGHVwEP2FfqvTQv6u7DS/HQN/PuUzpX6xnHuRQt1v0PO/1CWZES42J5pU3lIpXimOX
	1RF1LhKKhMJkzcADtDL1kMcvYUc8e9kkde3YBIpFyIPp9Py6Ut75T0xZj6IUW1EugqO2YKoxpCFAB
	yVo0mPMf1KxLO4xGp4idGdWEup1hcM9hfzYrCPn/T/gXCzWhY4gNA6fBhI2lQjjtLLLP+uZHCauzp
	rspGwpagT4AngrdV2zCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTO6-0004Yz-KL; Tue, 29 Jan 2019 13:25:14 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTMq-00036M-9S
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:23:59 +0000
Received: by mail-wr1-x442.google.com with SMTP id t6so22001990wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 05:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cJVPwkmiIQelbKGNm2p5QIWk1VCEgPV2Jz4v/peH4c0=;
 b=imGOnd4xYHw7xLkRLPA4lgqDpncHIIKu2AQdnXEMbU+4x0h7mJSwF/pVxC6qUeVyRt
 Bgy58LZ6QBcY1j8frbUMg1SuLU+Xx/TPLgxXHO1XF+6+FihDAhqI4V/+SwKAO7uOO0i9
 +V96ptKufbrdpE7IEgDGw3QN9V7tktrNCCEFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cJVPwkmiIQelbKGNm2p5QIWk1VCEgPV2Jz4v/peH4c0=;
 b=NT6Eac8E9lm9pK8WS63C1ZFW4hrAe+YrdihPEDIEeDHNZNX40HKQYWIKsXxjxFUn9x
 hp95An5ZeF9/fAUCdNMzc4l4pPoOJe0lAafNAjKhdpLW1wYADIq4CPo9es98oNwYWVEd
 uW5tkBnt8ECrUUk8Sa4x4DdJCh7ZiOrRKNG7+KVhmjClpWraF6V12dTqAxTByFULnVTT
 Zd6E134mZUHXYUX73a6nOWtHv6yhU1PPKEQthuNs1KZRCxqA9Dsfs5JMPjA6P//MQ+DD
 G6QVXdTBhLyXJtDBca4wqmCt4sCqrx1k7aLeQyQGYyugt3BkQ73Yye0u1taOEYe+fnC+
 mH2A==
X-Gm-Message-State: AJcUukegNxJLHt4Y7LntEaaZCPG4+xvC+1FZs+aYnGg3TrIm/scZmTaH
 Bdo9gwmF3Y0+iL8jOdGiOP2/oQ==
X-Google-Smtp-Source: ALg8bN6H2O6S+DgjvlJxLwdrvmqRTs6WaXE7z/QfJnss67fMh6N1TAkxmZ/M2jFSW2kHnrI222Ah2g==
X-Received: by 2002:adf:d243:: with SMTP id o3mr26911673wri.66.1548768234046; 
 Tue, 29 Jan 2019 05:23:54 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w80sm3739628wme.38.2019.01.29.05.23.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 29 Jan 2019 05:23:53 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH 3/6] arm64: qcom: msm8996.dtsi: Add Display nodes
Date: Tue, 29 Jan 2019 13:23:32 +0000
Message-Id: <20190129132335.30695-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
References: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_052356_777538_B3AC679B 
X-CRM114-Status: UNSURE (   9.71  )
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
