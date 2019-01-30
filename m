Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A9C282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:05:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D8420882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hFnmI63W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfbF5XBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D8420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GeKPJlTuP0qysOJdYckX5RTkQ/DDUZB4jTiHbztt10w=; b=hFnmI63W1/7Nz9
	HSy27xvEBL8LIH+eUOwGYKv7rTm35NSzQlXOLorGzd/r8naj5ivjqWk1UEXtqAf0nfxvoetA7qMGV
	ZhjmzbQlQNp/zWIBOHXi5yBz7+PkqgdK6MI3al+5Np8LGa/Ngq0kAsEVV0LjrlY5RVwGZHl+MboDQ
	571UgdGX5ynlNr5fVDURLNstvLPTJ4TwsCFuOxYGjncF2S4PCBVaiAVvmYAvcK/Sb0sGozXM+1qwf
	Upr5fe2ku8I/SXYXJ84lziONPlXgeH04v1QTEMHQgPigAR87L8Pl2HoD/+Gx8X43+i11rc3PZ50He
	xMxOKhAToIsf5rcXRbUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gongA-0001Uq-40; Wed, 30 Jan 2019 11:05:14 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gonfh-0000Ya-BP
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 11:04:48 +0000
Received: by mail-wm1-x341.google.com with SMTP id y8so21067232wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 03:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+iUaGMGKWn9N83ma0ITcBvsEGTsrPVKtGMn9CVZ2yxg=;
 b=WfbF5XBMRna8PBjOw1kiuRybais6eBiE1p4zmhpnbDEZP1jEAI7lWWxJzA7TC62BUi
 SLFUdrK5SEwvCBsqy7TXs23BU5/c3GsYp8+oRXBt6D+pV3I64oFXOBaMeY2cBdv1EWc3
 RB5Avfdntxw73yu1Z1Kn7pRyEVi+7rJy0J1RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+iUaGMGKWn9N83ma0ITcBvsEGTsrPVKtGMn9CVZ2yxg=;
 b=AufQGTCTupslLS7YCWUjb/vQLmFcDXZQ7KB2EaVT66RMqGSRMQV1VTMGVKUROntJuQ
 bdXjt1loUnmwIF9EVDMeSRCwpNZcwipNrTGCv8pybNnWan3ruXZUFLQ/uvrWGuCe0Jtq
 yMgkvqxfFYPQ/7xF9/FWPCFh0X/qrPuoxcIb/wzlovrqErfNdTBmPluwEQStgUzyKD1u
 pouE7sAvjulhUY33VtmeJxF6m9ozQ1wyeZdiaB2MUu+esGqdwHholyOQVIyXpSAFHngG
 MQSSpt5gOF1AUBqgxde3s8uE/RYNu965SmQcI0mQhjp3MnSSGmxuhpvaNVJ9wyDXB4dE
 H8vw==
X-Gm-Message-State: AJcUukdxUX8rrMdfX2tzrFv7sxBAEsw++E19GCUGJn3/XyEcMT27QJmJ
 UkbSu7DxGEWPQFDN76sE5y6ZjltTPdA=
X-Google-Smtp-Source: ALg8bN5TBtQeG8qt7wXZ21M7Lnl5V1FgUGgIT+v2fVmH5DKoJAC5PoT8lt+qOpwcNCCxu4gYqJfteQ==
X-Received: by 2002:a1c:b456:: with SMTP id d83mr25907487wmf.115.1548846283905; 
 Wed, 30 Jan 2019 03:04:43 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.gmail.com with ESMTPSA id w16sm1138208wrp.1.2019.01.30.03.04.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 03:04:43 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org
Subject: [PATCH v2 2/6] arm64: dts: msm8996: Add display smmu node
Date: Wed, 30 Jan 2019 11:04:33 +0000
Message-Id: <20190130110437.5424-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
References: <20190130110437.5424-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_030445_382947_7A8D8A52 
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
