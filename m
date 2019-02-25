Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D85EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:51:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD6620842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EyYniqzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD6620842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=S7P6M3WHI4OjhdIiUuvJNlNI00oQfPno+dHC5AsoUtk=; b=EyYniqzFjCtNO1
	VhqEhSZoXuy0iZUi6i0heXsKDPjqFJoxY+DQH3sIKVa7CNalUVrq3Bn+xwFSqeD9eTIjy9TZWB4ko
	yiABMqOOngr5i2A+DaezUYOQTlCwkV20De1BPfhaJSJFL4HaZCub7W62AkZQCEp/58x50Zmw00i6M
	9g/YiiMHyMmBUHKczGZQDG8awMrraDglmtqUr0voMeGMBMfcumxzpOLkzZ8y22mRMAhIcUOw37ebm
	rdBtPJK4tPbbX/566VOjE14kIAGNADIL0DqLPO0RcJGjlmRJRJBlqmmVpRMv2pJ3NRlSZVMKzIW0f
	VZYDESIZflPGLA/sctaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyA6p-0006gD-G7; Mon, 25 Feb 2019 06:51:27 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyA6k-0006fO-E9; Mon, 25 Feb 2019 06:51:25 +0000
X-UUID: 035849d1b3c94e2eaee2cb9c060f6b84-20190224
X-UUID: 035849d1b3c94e2eaee2cb9c060f6b84-20190224
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <seiya.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1601844458; Sun, 24 Feb 2019 22:51:19 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 24 Feb 2019 22:51:17 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 25 Feb 2019 14:51:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Mon, 25 Feb 2019 14:51:15 +0800
From: Seiya Wang <seiya.wang@mediatek.com>
To: Stephen Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/2] arm64: dts: mt8173: correct cpu type of cpu2 and cpu3
 to cortex-a72
Date: Mon, 25 Feb 2019 14:51:11 +0800
Message-ID: <20190225065112.3400-1-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
X-TM-SNTS-SMTP: D4815F38D40999078CAB70650911AA5B8D56B15C9BA3C22BDACA295779A004672000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190224_225122_485110_6D7CB1C7 
X-CRM114-Status: UNSURE (   9.72  )
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
Cc: devicetree@vger.kernel.org, Seiya Wang <seiya.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The cpu type of cpu2 and cpu3 should be cortex-a72, not cortex-a57.

Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 44374c506a1c..99675c51577a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -178,12 +178,12 @@
 
 		cpu2: cpu@100 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a57";
+			compatible = "arm,cortex-a72";
 			reg = <0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			#cooling-cells = <2>;
-			clocks = <&infracfg CLK_INFRA_CA57SEL>,
+			clocks = <&infracfg CLK_INFRA_CA72SEL>,
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster1_opp>;
@@ -191,12 +191,12 @@
 
 		cpu3: cpu@101 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a57";
+			compatible = "arm,cortex-a72";
 			reg = <0x101>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			#cooling-cells = <2>;
-			clocks = <&infracfg CLK_INFRA_CA57SEL>,
+			clocks = <&infracfg CLK_INFRA_CA72SEL>,
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cluster1_opp>;
-- 
2.14.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
