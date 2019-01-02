Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56D6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:11:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AECA218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rTkRvgGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AECA218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o0YV6PZJTITnqlEt40y4gLhyqKuCC3CWZwgfm/Tr8I4=; b=rTkRvgGPpTjp2y
	yymXmG/IxIhB53nZ/7XKp17RCbSLEOfRE6dUWrTU2NX0WZnzZRRdPuFYxMSdsNjENxVvW2KSYE1sL
	vUiCmU2VyUK3OkeJ5+qkGwAef5YvLhG4FxgARX5wxcAIcrU4HYMCkU4/pzCJaQMrnPddJc5yVVq7G
	AY/tJVYWpXm7yckQc49UoU+Av3aZrXJi7wI/ruX/f0eoZZGJzP1fYwRDSJr/vmedelGM5pzRvg0o9
	wiSGB5ZkIqsxMvE2CmN+cU6s3QHYYQOH+PTjtHjIC3ZoCLeJFJuD+gGbfBDcaL5LLeZnYFcOOIRJq
	jb//GF0fL98S5St2SCDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gehFH-0007KW-Rr; Wed, 02 Jan 2019 14:11:43 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gehE9-00062E-Ct; Wed, 02 Jan 2019 14:10:40 +0000
X-UUID: 19e28fa6221b4e99b9fb31dc42cd8311-20190102
X-UUID: 19e28fa6221b4e99b9fb31dc42cd8311-20190102
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <henryc.chen@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 252567244; Wed, 02 Jan 2019 22:10:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 2 Jan 2019 22:10:26 +0800
Received: from mtkslt205.mediatek.inc (10.21.15.75) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 22:10:26 +0800
From: Henry Chen <henryc.chen@mediatek.com>
To: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ulf
 Hansson <ulf.hansson@linaro.org>
Subject: [RFC RESEND PATCH 2/7] dt-bindings: soc: Add opp table on scpsys
 bindings
Date: Wed, 2 Jan 2019 22:09:53 +0800
Message-ID: <1546438198-1677-3-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_061033_872450_9E2B3B13 
X-CRM114-Status: GOOD (  12.80  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>,
 Kees Cook <keescook@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Henry Chen <henryc.chen@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add opp table on scpsys dt-bindings for Mediatek SoC.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 Documentation/devicetree/bindings/opp/mtk-opp.txt  | 24 +++++++++++++
 .../devicetree/bindings/soc/mediatek/scpsys.txt    | 42 ++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/mtk-opp.txt

diff --git a/Documentation/devicetree/bindings/opp/mtk-opp.txt b/Documentation/devicetree/bindings/opp/mtk-opp.txt
new file mode 100644
index 0000000..036be1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/mtk-opp.txt
@@ -0,0 +1,24 @@
+Mediatek OPP bindings to descibe OPP nodes with level values
+
+OPP tables for devices on Mediatek platforms require an additional
+platform specific level value to be specified.
+This value is passed on to the mediatek Power Management Unit by the
+CPU, which then takes the necessary actions to set a voltage rail
+to an appropriate voltage based on the value passed.
+
+The bindings are based on top of the operating-points-v2 bindings
+described in Documentation/devicetree/bindings/opp/opp.txt
+Additional properties are described below.
+
+* OPP Table Node
+
+Required properties:
+- compatible: Allow OPPs to express their compatibility. It should be:
+  "operating-points-v2-mtk-level"
+
+* OPP Node
+
+Required properties:
+- mtk,level: On Mediatek platforms an OPP node can describe a positive value
+representing a level that's communicated with a our power management hardware
+which then translates it into a certain voltage on a voltage rail.
diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index b4728ce..299b526 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -63,6 +63,10 @@ Optional properties:
 - mfg_2d-supply: Power supply for the mfg_2d power domain
 - mfg-supply: Power supply for the mfg power domain
 
+- operating-points-v2: Phandle to the OPP table for the Power domain.
+	Refer to Documentation/devicetree/bindings/power/power_domain.txt
+	and Documentation/devicetree/bindings/opp/mtk-opp.txt for more details
+
 Example:
 
 	scpsys: scpsys@10006000 {
@@ -75,6 +79,27 @@ Example:
 			 <&topckgen CLK_TOP_VENC_SEL>,
 			 <&topckgen CLK_TOP_VENC_LT_SEL>;
 		clock-names = "mfg", "mm", "venc", "venc_lt";
+		operating-points-v2 = <&dvfsrc_opp_table>;
+
+		dvfsrc_opp_table: opp-table {
+			compatible = "operating-points-v2-mtk-level";
+
+			dvfsrc_vol_min: opp1 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_1>;
+			};
+
+			dvfsrc_freq_medium: opp2 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_2>;
+			};
+
+			dvfsrc_freq_max: opp3 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_3>;
+			};
+
+			dvfsrc_vol_max: opp4 {
+				mtk,level = <MT8183_DVFSRC_LEVEL_4>;
+			};
+		};
 	};
 
 Example consumer:
@@ -82,4 +107,21 @@ Example consumer:
 	afe: mt8173-afe-pcm@11220000 {
 		compatible = "mediatek,mt8173-afe-pcm";
 		power-domains = <&scpsys MT8173_POWER_DOMAIN_AUDIO>;
+		operating-points-v2 = <&aud_opp_table>;
+	};
+
+	aud_opp_table: aud-opp-table {
+		compatible = "operating-points-v2";
+		opp1 {
+			opp-hz = /bits/ 64 <793000000>;
+			required-opps = <&dvfsrc_vol_min>;
+		};
+		opp2 {
+			opp-hz = /bits/ 64 <910000000>;
+			required-opps = <&dvfsrc_vol_max>;
+		};
+		opp3 {
+			opp-hz = /bits/ 64 <1014000000>;
+			required-opps = <&dvfsrc_vol_max>;
+		};
 	};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
