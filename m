Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:38:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7277920851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UvLq/xc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7277920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Eyp67RnyZoUu9qvsX+LsgDKiVwDavJhM6cJxabVUYCM=; b=UvLq/xc941JtA5
	ZNPJjLLMT07IsVO9u3BkdlAOsYqpVMKwtNQ63GEpTHRlrcXST7l5ziHExyyX/Cn1HST2KAtJMwqlM
	mrChN/FwxU2Mi5jD8TAAt2sR8864SfIwXPwyjHeAylfjqPkDpeSts4+QDWpHjrmuOd3F7QPe/NrHn
	jPbmGU5hTesJKSM/h9JFb3cJep6+9rI6arVXxThhrutVj5cC528/eEspk8kqZSAD17RPkKNx65m6K
	K45GBM7RC1iJrhbfA9axu0qQxPEPg0kuDRstsT2yR2elsNgBeFyOYl7PhGJqnBl0T/JICW4g7NCGi
	yQuSHlmQpcMh+RXX9DNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmYm-0006py-A5; Mon, 03 Dec 2018 11:38:44 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmWr-0004lr-03; Mon, 03 Dec 2018 11:36:49 +0000
X-UUID: 5597227dba774bf7b7ee081506a8b3e2-20181203
X-UUID: 5597227dba774bf7b7ee081506a8b3e2-20181203
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw01.mediatek.com (envelope-from <yt.shen@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 287662571; Mon, 03 Dec 2018 19:36:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 19:36:28 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Mon, 3 Dec 2018 19:36:28 +0800
From: YT Shen <yt.shen@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 5/8] arm64: dts: add pwm nodes for MT2712
Date: Mon, 3 Dec 2018 19:35:59 +0800
Message-ID: <1543836962-18293-6-git-send-email-yt.shen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
References: <1543836962-18293-1-git-send-email-yt.shen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_033645_770174_20FBCAC8 
X-CRM114-Status: UNSURE (   8.13  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 YT Shen <yt.shen@mediatek.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 4843376..e9856fe 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -418,6 +418,34 @@
 		status = "disabled";
 	};
 
+	pwm: pwm@11006000 {
+		compatible = "mediatek,mt2712-pwm";
+		reg = <0 0x11006000 0 0x1000>;
+		#pwm-cells = <2>;
+		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_PWM_SEL>,
+			 <&pericfg CLK_PERI_PWM>,
+			 <&pericfg CLK_PERI_PWM0>,
+			 <&pericfg CLK_PERI_PWM1>,
+			 <&pericfg CLK_PERI_PWM2>,
+			 <&pericfg CLK_PERI_PWM3>,
+			 <&pericfg CLK_PERI_PWM4>,
+			 <&pericfg CLK_PERI_PWM5>,
+			 <&pericfg CLK_PERI_PWM6>,
+			 <&pericfg CLK_PERI_PWM7>;
+		clock-names = "top",
+			      "main",
+			      "pwm1",
+			      "pwm2",
+			      "pwm3",
+			      "pwm4",
+			      "pwm5",
+			      "pwm6",
+			      "pwm7",
+			      "pwm8";
+		status = "disabled";
+	};
+
 	i2c0: i2c@11007000 {
 		compatible = "mediatek,mt2712-i2c";
 		reg = <0 0x11007000 0 0x90>,
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
