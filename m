Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADD0C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:16:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6AB21741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gwqN+ui2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cWe9z/1h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="U7MnYW+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6AB21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Di94vSLVSEGH6pCllG7pTN8vjt8FAsA4ZB2NFhYxoP4=; b=gwqN+ui2wynxsp
	bCaznKD9KvNHDXup2afo9YH3foQAPFxKdiVmcWeLc7+V5Maff8w4X49h9BOne5VPqcXMs5yLqKm0n
	t/7Xr+w1LhRIOnTES14ur/8qwLNVmGE/Zp7hBXoLMynQnnqMTmonAGSDq9Mfa5oFJK0YZiB148YlV
	K/BHPhDar2f/xh921X4Uv859hOsvZYk46u8/gkmrpe2UURKJHImFW+Y+WEAXBWW6xY9tLFN7Wi1do
	zeCXTZz1tVPTZBkQbg48Ek+hEgW3FQK6qcPVFVZ+1+cGml48PoxPLA2Fwzl8Lk7PvkcfAka7ikW2j
	ahYJzCIiYjDuduUlTR2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCNy-0000mC-BW; Mon, 28 Jan 2019 19:15:58 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCNE-0007aS-6u
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:15:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 0850B60E3D; Mon, 28 Jan 2019 19:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548702911;
 bh=bjy9NnbyIFJcxKEtIbzWqDVNtvbtUvUhhDEcOZAi0hg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cWe9z/1hxLrKxLYhyGNIv7gccstOBFJOE8fffwgfFUWGnEP/eGj8nX4IOyWWithrZ
 culAuvSMlPA3y5IH4kFgNjZ266WYG0NZWSE9Bd8WoK04OjlpnbefKnaNMvcbihAF3H
 ifq3nqa+9kHzzSEybs1FmxVWDn31lDHyJZo4e9PA=
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 1EC1360D4C;
 Mon, 28 Jan 2019 19:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548702900;
 bh=bjy9NnbyIFJcxKEtIbzWqDVNtvbtUvUhhDEcOZAi0hg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U7MnYW+rxLEhZrb7cPH1U6dYYgJ0XhI6ga7vbIL1oN3t5QcS6F4CW99j6w8/RbGv6
 d+RMNNjq8eoZDr8pB2Rwk4i+WJyVYnOUaj1PG+9w+Uzu1YB4IlLiO54XcX1aTsHfW7
 gDeN3Q/oKnaaIeEtQiU2zFwYRlU+4ribKCWZb0eo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1EC1360D4C
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Rob Herring <robh+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>, Doug Anderson <dianders@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, devicetree@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCHv5 3/7] arm64: dts: qcom: msm8996: Add Coresight support
Date: Tue, 29 Jan 2019 00:44:00 +0530
Message-Id: <6813e9d39150fb2c874abd986a8e134f8a10fba7.1548419933.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_111512_957363_29A88217 
X-CRM114-Status: GOOD (  11.43  )
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
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>,
 Tingwei Zhang <tingwei@codeaurora.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Vivek Gautam <vivek.gautam@codeaurora.org>

Enable coresight support by adding device nodes for the
available source, sinks and channel blocks on msm8996.

This also adds coresight cpu debug nodes.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 434 ++++++++++++++++++++++++++
 1 file changed, 434 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 99b7495455a6..3406a10f40db 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -429,6 +429,440 @@
 			reg = <0x300000 0x90000>;
 		};
 
+		stm@3002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0x3002000 0x1000>,
+			      <0x8280000 0x180000>;
+			reg-names = "stm-base", "stm-stimulus-base";
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint =
+						  <&funnel0_in>;
+					};
+				};
+			};
+		};
+
+		tpiu@3020000 {
+			compatible = "arm,coresight-tpiu", "arm,primecell";
+			reg = <0x3020000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					tpiu_in: endpoint {
+						remote-endpoint =
+						  <&replicator_out1>;
+					};
+				};
+			};
+		};
+
+		funnel@3021000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x3021000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					funnel0_in: endpoint {
+						remote-endpoint =
+						  <&stm_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					funnel0_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		funnel@3022000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x3022000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					funnel1_in: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					funnel1_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@3025000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x3025000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					merge_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&funnel0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					merge_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&funnel1_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&etf_in>;
+					};
+				};
+			};
+		};
+
+		replicator@3026000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x3026000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					replicator_in: endpoint {
+						remote-endpoint =
+						  <&etf_out>;
+					};
+				};
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					replicator_out0: endpoint {
+						remote-endpoint =
+						  <&etr_in>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					replicator_out1: endpoint {
+						remote-endpoint =
+						  <&tpiu_in>;
+					};
+				};
+			};
+		};
+
+		etf@3027000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x3027000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					etf_in: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etf_out: endpoint {
+						remote-endpoint =
+						  <&replicator_in>;
+					};
+				};
+			};
+		};
+
+		etr@3028000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x3028000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+			arm,scatter-gather;
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint =
+						  <&replicator_out0>;
+					};
+				};
+			};
+		};
+
+		debug@3810000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3810000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU0>;
+		};
+
+		etm@3840000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3840000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU0>;
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_in0>;
+					};
+				};
+			};
+		};
+
+		debug@3910000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3910000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU1>;
+		};
+
+		etm@3940000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3940000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU1>;
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@39b0000 { /* APSS Funnel 0 */
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x39b0000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_funnel0_in0: endpoint {
+						remote-endpoint = <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_funnel0_in1: endpoint {
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					apss_funnel0_out: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		debug@3a10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3a10000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU2>;
+		};
+
+		etm@3a40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3a40000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU2>;
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_in0>;
+					};
+				};
+			};
+		};
+
+		debug@3b10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3b10000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU3>;
+		};
+
+		etm@3b40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3b40000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU3>;
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@3bb0000 { /* APSS Funnel 1 */
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x3bb0000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_funnel1_in0: endpoint {
+						remote-endpoint = <&etm2_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_funnel1_in1: endpoint {
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					apss_funnel1_out: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@3bc0000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x3bc0000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_merge_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_merge_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					apss_merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&funnel1_in>;
+					};
+				};
+			};
+		};
+
 		kryocc: clock-controller@6400000 {
 			compatible = "qcom,apcc-msm8996";
 			reg = <0x6400000 0x90000>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
