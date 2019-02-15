Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08861C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:52:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C514621916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ee3Q2+KT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C514621916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=olimex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VrFjYKnp6785DCn3duNXXqSaTxyAPOrkj8sTuJEH5lQ=; b=Ee3Q2+KTGGELwoT9G67hFNFva5
	wKeOAHN8Z7ZJx++zxdqFjKMSlG/PcGcUcEQGudIm3x1GAvXrmDzgdCCQiD0b8Imxj5Bg2rcJST1U+
	CLuL2HuouyD7LcBf1leGdpIL3YTtUWFmVrI5VvcImFe8tiCp6omEb6uDjmKm75J5f1G4CprfHKdlw
	dzdwLCCHiI+ve+AA7lnRcKve6/A8aEYR4/EAJA2wyYqQl/VWUMuwloLnTLqPN7SHTRnhybpE/ScNb
	58Zhw4I1XBSzt5bX1VZ2L1kP7SuiHu8JByXsMfl9XuH0iMs1epk1mMNACfTNpnFRR45E1DDtQVtcW
	3EMtaoqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guc2e-0000e8-Np; Fri, 15 Feb 2019 11:52:28 +0000
Received: from olimex.com ([184.105.72.32])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guc1B-0007OU-LE
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 11:51:03 +0000
Received: from localhost.localdomain ([195.238.85.143])
 by olimex.com with ESMTPSA
 (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD)
 (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
 for <linux-arm-kernel@lists.infradead.org>; Fri, 15 Feb 2019 03:50:51 -0800
From: Stefan Mavrodiev <stefan@olimex.com>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Lee Jones <lee.jones@linaro.org>,
 linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), 
 linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC DEVICE
 DRIVERS), 
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC
 support)
Subject: [PATCH v2 5/8] arm64: dts: allwinner: Enable AXP803 CHGLED for Olimex
 boards
Date: Fri, 15 Feb 2019 13:50:10 +0200
Message-Id: <20190215115013.11098-6-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215115013.11098-1-stefan@olimex.com>
References: <20190215115013.11098-1-stefan@olimex.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_035058_049937_2CE7287A 
X-CRM114-Status: UNSURE (   8.49  )
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
Cc: Stefan Mavrodiev <stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Teres-I and A64-OLinuXino commes with populated LED connected
to AXP803. So to be used as battery indication, pass the LED control
to the charger itself in mode 0 ( FULL while charging, OFF no battery
or completed).

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts   | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index f7a4bccaa5d4..7d6930319fba 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -177,6 +177,12 @@
 
 #include "axp803.dtsi"
 
+&axp_led {
+	label = "a64-olinuxino:yellow:chgled";
+	status = "okay";
+	x-powers,charger-mode = <0>;
+};
+
 &reg_aldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <2800000>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index c455b24dd079..cdffdd4e4561 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -145,6 +145,12 @@
 
 #include "axp803.dtsi"
 
+&axp_led {
+	label = "teres-i:yellow:chgled";
+	status = "okay";
+	x-powers,charger-mode = <0>;
+};
+
 &reg_aldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <2800000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
