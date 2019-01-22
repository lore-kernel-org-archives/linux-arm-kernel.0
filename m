Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86DDC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:39:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAA920870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r4W65DmN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nkVG9U8C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UEUyJLez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAA920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s/tuMfY5w+dYIufkof+uKhFFwlO9aEi/zNmLoFrrYso=; b=r4W65DmNRk8ull
	BkfQ4Dvt/krr3ty4WCdOeoVR4+ZLF8TmBrlxVosdn1Pf3i327U+D4uLCoOQvQFa3uGILvw6ylMnod
	XLvJIgsXoMSYzqXjom705dCk1JU2pCC12+NnxDIn/sKGP7Ug7j8VP9vBS68cmz/4LYt02YlIz3Ubs
	nyJdZzqp3XV2qOOm0HLIS8iz7f/dzWUlLF4fnXEiavv/k2ALF0ZlV5ODobtmXttpOLqiky/ColPYZ
	JlpXoVsqDXtA/iF4t6lPBVAMT3bDJTRPSsLDR1s7tyAVAk+j2Tw8BQsxvwgrBeu+crOt4ylIAgkPb
	8+G5lWFinGEVnYNHol1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glwGg-00058V-Uu; Tue, 22 Jan 2019 13:39:06 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glwGL-0004vo-Lt
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 13:38:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id B9B0C609C2; Tue, 22 Jan 2019 13:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548164324;
 bh=DV2KgDzAe3arN8FP1ZGH1Uu7zoMeGlPZUBqztwg5WIU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nkVG9U8CkhdIyrtOoqinOmiMkJMdi+xDnUCud9zjK8QvMYdJ0pE6Al7K4iVwjZEJK
 GYAH3IGAk2l09/S3jSAu2QRnsHfYnfv4tgXG7pQi6w2n/ToAndJsG3f9kgGmO4SPor
 pfEqQLqrM1IIk8S6k72k1h61W8GrokbI83XSxD+w=
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan@codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 952FD60740;
 Tue, 22 Jan 2019 13:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1548164322;
 bh=DV2KgDzAe3arN8FP1ZGH1Uu7zoMeGlPZUBqztwg5WIU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UEUyJLezxJoCd7XdplWmllWbMUg97tTLkIe+3krgpPqAenIEms4YxaH8Ylk2TW1Vh
 cLRSVj+FWX7b2ojGnihFuopNCz+n4/oIQRG0SBoCCMYQGxIp9isEgosElExAIauPmJ
 DzloW/hejVLANt/NEW8+vogdPBVJ8D2BxDMKKwM0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 952FD60740
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Rob Herring <robh+dt@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Doug Anderson <dianders@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, devicetree@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>
Subject: [PATCHv4 1/4] arm64: dts: qcom: sdm845: Add Coresight support
Date: Tue, 22 Jan 2019 19:07:54 +0530
Message-Id: <ad16cfb9b6f5efb85149458d5f5a1abf43fa027c.1548133311.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1548133311.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_053845_908428_A1E3CB09 
X-CRM114-Status: GOOD (  11.61  )
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
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add coresight components found on Qualcomm SDM845 SoC.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

---
Depends on AOSS QMP side channel patches and AMBA bus pclk change
by Bjorn Andersson [1][2].
Also depends on patch ("arm64: dts: qcom: sdm845: Increase address
and size cells for soc") [3].

[1] https://lore.kernel.org/lkml/20190106080915.4493-1-bjorn.andersson@linaro.org/
[2] https://lore.kernel.org/lkml/20190106080915.4493-7-bjorn.andersson@linaro.org/
[3] https://lore.kernel.org/lkml/20190117042940.25487-2-bjorn.andersson@linaro.org/
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 448 +++++++++++++++++++++++++++
 1 file changed, 448 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c27cbd3bcb0a..2c589f7f13a8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1348,6 +1348,454 @@
 			};
 		};
 
+		stm@6002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0 0x06002000 0 0x1000>,
+			      <0 0x16280000 0 0x180000>;
+			reg-names = "stm-base", "stm-stimulus-base";
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint =
+						  <&funnel0_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@6041000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0x06041000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					funnel0_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in0>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@7 {
+					reg = <7>;
+					funnel0_in7: endpoint {
+						remote-endpoint = <&stm_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6043000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0x06043000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					funnel2_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in2>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@5 {
+					reg = <5>;
+					funnel2_in5: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_out>;
+					};
+				};
+			};
+		};
+
+		funnel@6045000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0x06045000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					merge_funnel_out: endpoint {
+						remote-endpoint = <&etf_in>;
+					};
+				};
+			};
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
+				port@2 {
+					reg = <2>;
+					merge_funnel_in2: endpoint {
+						remote-endpoint =
+						  <&funnel2_out>;
+					};
+				};
+			};
+		};
+
+		replicator@6046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0 0x06046000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					replicator_out: endpoint {
+						remote-endpoint = <&etr_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					replicator_in: endpoint {
+						remote-endpoint = <&etf_out>;
+					};
+				};
+			};
+		};
+
+		etf@6047000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x06047000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etf_out: endpoint {
+						remote-endpoint =
+						  <&replicator_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+					etf_in: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_out>;
+					};
+				};
+			};
+		};
+
+		etr@6048000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0 0x06048000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+			arm,scatter-gather;
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint =
+						  <&replicator_out>;
+					};
+				};
+			};
+		};
+
+		/*
+		 * On QCOM SDM845, we bypass the normal AMBA bus discovery
+		 * method by forcing the peripheral ID because of the wrong
+		 * value read from ETM PID registers.
+		 */
+
+		etm@7040000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			arm,primecell-periphid = <0x000bb95d>;
+			reg = <0 0x07040000 0 0x1000>;
+
+			cpu = <&CPU0>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		etm@7140000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			arm,primecell-periphid = <0x000bb95d>;
+			reg = <0 0x07140000 0 0x1000>;
+
+			cpu = <&CPU1>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		etm@7240000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			arm,primecell-periphid = <0x000bb95d>;
+			reg = <0 0x07240000 0 0x1000>;
+
+			cpu = <&CPU2>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		etm@7340000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			arm,primecell-periphid = <0x000bb95d>;
+			reg = <0 0x07340000 0 0x1000>;
+
+			cpu = <&CPU3>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in3>;
+					};
+				};
+			};
+		};
+
+		etm@7440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			arm,primecell-periphid = <0x000bb95d>;
+			reg = <0 0x07440000 0 0x1000>;
+
+			cpu = <&CPU4>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in4>;
+					};
+				};
+			};
+		};
+
+		etm@7540000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			arm,primecell-periphid = <0x000bb95d>;
+			reg = <0 0x07540000 0 0x1000>;
+
+			cpu = <&CPU5>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in5>;
+					};
+				};
+			};
+		};
+
+		etm@7640000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			arm,primecell-periphid = <0x000bb95d>;
+			reg = <0 0x07640000 0 0x1000>;
+
+			cpu = <&CPU6>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in6>;
+					};
+				};
+			};
+		};
+
+		etm@7740000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			arm,primecell-periphid = <0x000bb95d>;
+			reg = <0 0x07740000 0 0x1000>;
+
+			cpu = <&CPU7>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@7800000 { /* APSS Funnel */
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0x07800000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					apss_funnel_out: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&etm1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					apss_funnel_in2: endpoint {
+						remote-endpoint =
+						  <&etm2_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					apss_funnel_in3: endpoint {
+						remote-endpoint =
+						  <&etm3_out>;
+					};
+				};
+
+				port@4 {
+					reg = <4>;
+					apss_funnel_in4: endpoint {
+						remote-endpoint =
+						  <&etm4_out>;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+					apss_funnel_in5: endpoint {
+						remote-endpoint =
+						  <&etm5_out>;
+					};
+				};
+
+				port@6 {
+					reg = <6>;
+					apss_funnel_in6: endpoint {
+						remote-endpoint =
+						  <&etm6_out>;
+					};
+				};
+
+				port@7 {
+					reg = <7>;
+					apss_funnel_in7: endpoint {
+						remote-endpoint =
+						  <&etm7_out>;
+					};
+				};
+			};
+		};
+
+		funnel@7810000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0 0x07810000 0 0x1000>;
+
+			power-domains = <&aoss_qmp AOSS_QMP_QDSS_CLK>;
+
+			out-ports {
+				port {
+					apss_merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&funnel2_in5>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					apss_merge_funnel_in: endpoint {
+						remote-endpoint =
+						  <&apss_funnel_out>;
+					};
+				};
+			};
+		};
+
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sdm845-qusb2-phy";
 			reg = <0x88e2000 0x400>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
