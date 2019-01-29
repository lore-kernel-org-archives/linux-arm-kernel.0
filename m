Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0620CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:24:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C059E2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hUB7fzcb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="itYg1ZnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C059E2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GeKPJlTuP0qysOJdYckX5RTkQ/DDUZB4jTiHbztt10w=; b=hUB7fzcb2GiIfi
	0uSnSgMW8p/6tX6mWuvzGMNitQBcHM0xLeqc5WUc6gUlrpPcNApeh5EJUunuC2v4skLmsiYn9H5Lu
	sDXckx1bqBJNt/Vl5omiEFadtncJ47hLEQtj0eLvPb+BgkDMZINYVH39KEq71DY/Ta8WIFcT9S2B4
	Jy5dD8e2ydVRqSu9LzlFBNq6wXDR2uoAD6YBpllEWhFZk91aGUMpSbQoDDSnsKcgPQQIpSCcIs7Dy
	PtPjF3Qma2JnnuKB//GyxaK33ucBf3U7LBlfCUW2/Jxmuc+sp6OH1zcJE1IscSBWYOs05VRdOuDwN
	DD2Ad/flNsWBYectXg8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goTNf-0003kL-Rr; Tue, 29 Jan 2019 13:24:47 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goTMp-00036F-6h
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 13:23:59 +0000
Received: by mail-wr1-x443.google.com with SMTP id t6so22001904wrr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 05:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+iUaGMGKWn9N83ma0ITcBvsEGTsrPVKtGMn9CVZ2yxg=;
 b=itYg1ZnBFqTT8OEIbW6NsGc8XTFUE4zxH8Me1Q2KohBZ8RHYlDfZ9JpxIZFXPaSoqb
 LRYSqugdWDsFlrCHrmkNbvl5M9NXShdm9KIgoh+IMFROAIYDv9Tq5sB1oL02vqZhg0GG
 ur8+Q2MxvdTVP858MqQqCNZ5x9yJCKMIyvLm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+iUaGMGKWn9N83ma0ITcBvsEGTsrPVKtGMn9CVZ2yxg=;
 b=cb57Jda2dXPxxswGBN8ah69wgmiqCzeDD6HBfGrWbbJEK3fn2MvOKpHPuQ+9BBEeO+
 zQYXpd29eKQ8dkPUOxaShNeSP3hanrVblxz0peLd3rmjmNLWAgshZuhJnrHoF2V/1hfE
 O3MBPLzuEWK6Sd5QM67EeOF6zDb+z3dZktFhrnQO1h6zey0BgsdT1/Js3elFdStg+uKy
 Dje5Ej2ZvVrLt6HWcOnGXi+f89RX3T1F0Sf/vCwOtK6sShbqSNcuPxGokpnxnHIiMlJp
 DV/Yz9ok4EHZ1NcMNDmyUzyU+wvFPTeL84ZSVMTOi9od7vlqST3Fiiks0Ry57FmVR+R+
 pkWA==
X-Gm-Message-State: AJcUukfms5aW4zHl1ue1tHaFUXwUE4pWLOwrCSwkrxlVxUgchR3R/DVs
 8eQxQr3xBgU3pWSniBmwI7KKHbP2srM=
X-Google-Smtp-Source: ALg8bN4R2UjjjzQwle8+n4l73Ie84+eu9E/FU0tDbIKDEd/JPn4L5EI3x0aGvigsF9jTh1TjrQkI4Q==
X-Received: by 2002:adf:fe11:: with SMTP id n17mr25308535wrr.329.1548768232946; 
 Tue, 29 Jan 2019 05:23:52 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w80sm3739628wme.38.2019.01.29.05.23.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 29 Jan 2019 05:23:52 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH 2/6] arm64: dts: msm8996: Add display smmu node
Date: Tue, 29 Jan 2019 13:23:31 +0000
Message-Id: <20190129132335.30695-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
References: <20190129132335.30695-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_052356_789742_AAB9D0ED 
X-CRM114-Status: GOOD (  10.24  )
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

Add device node for display smmu, aka. mdp_smmu.

Signed-off-by: Archit Taneja <architt@codeaurora.org>
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index c9b80d175fd4..96adda520bd5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1155,6 +1155,23 @@
 			power-domains = <&mmcc GPU_GDSC>;
 		};
 
+		mdp_smmu: arm,smmu@d00000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0xd00000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+
+			clocks = <&mmcc SMMU_MDP_AHB_CLK>,
+				 <&mmcc SMMU_MDP_AXI_CLK>;
+			clock-names = "iface", "bus";
+
+			power-domains = <&mmcc MDSS_GDSC>;
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
