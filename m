Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1268C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:13:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C4A217D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TRtU7LTS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/tk8Ju7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C4A217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yuf8+RNB3jOXw3hro4/lvaJC6jIBR+H2qwYZysAqWC4=; b=TRtU7LTSIVXY2r
	f7VM0WwSr/xwljkN9V3H1QSrhAPGPC5EBk+1R8odQYMQKHaaL37P9hFAm+3MgGxrmEW/Cyd6dMnzu
	iGaZ7Z/ZS6VnQO1ceJgW4tB5N9oAZpI0sR3y0XdfzNEoF2vdHkUbLsPZ6PpTXBw/1aOamQ/nxSq/z
	QkoJ/FW2zmZ0wGcPUb/ZWZ2Z6Dn+YEf6byiGBZPmw+TFuXKHWOxQrUoIYgLOocx0kqdedHHVRiAPM
	qxjdnhEId5r0I3g9eo9a4eHleF7/fD8tAohlxNwecxgD37DZt/S2gLVXY47jiDuI1schQoL/bsSXD
	D7BiIeFhihPGSMvqszIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmKDD-0004BS-Pq; Wed, 23 Jan 2019 15:13:07 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmKCq-0003ss-Oq; Wed, 23 Jan 2019 15:12:52 +0000
Received: by mail-pl1-x641.google.com with SMTP id g9so1326030plo.3;
 Wed, 23 Jan 2019 07:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pfLooB/O2lngy8XNJ7ymPuTZs17F4K8WiubH/3VL7po=;
 b=U/tk8Ju764NMOYteaqMOFJvaQFTLli7pnMauiw+GFwORrMtDA/dg9zEx4i0zLdR6Sb
 o6O0YPX+pW3XGGi1ts6l+zGX63JLk1Mg2qvBsuzxByw+NRojdf2fUgZPDo86GXAuru05
 IEjP8ids0Mpn6zactF/SyiDnt64nX1ZtHzI8g4Mj0F3fdBSBhlwoUGm2m+YNXhjppmf/
 9+V+Vw8P6+NXFuTwCRVl8XeMGU3rVH0uYCDfGY8t1yIXxufdkJaVyMvDQyJRia8wezOu
 NnDxPLkojBScp0ERfQ2kH493YZNUU6TjDsAd1D2MZynWoASUjqMYsujPiM1fbsjSA8h8
 zYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pfLooB/O2lngy8XNJ7ymPuTZs17F4K8WiubH/3VL7po=;
 b=ZRpD0hJnAj8tGBsORMD0Hri88g/MrJAdpAvPfQYaSS0av6kKDBZnWbg9wP2PEztfh9
 jDW5atwmN6eFgfwVnbet+5EqwaPM+r1jQNFzC0WeV9Fq7MR4pwiDwstVLM3hpqe01OnV
 UdbI0098Bb1tg5f1UaLfY3J5AAqSBaXfRu8MRAteznwILCKJxVxob8NEC2d9QxUouR+P
 leMqfovTSi1BTi7n9gWlnaUl3zuJikrzkPcz5So4HgQy+1/FoyNVYmUWgYPiFQ2vRIgE
 nMLej8nLaP8WHT/RQdRyqAMMu7T3Q5O0G+YaX1thrJYSnlOnxI62TL1N0kG79IuHVbW0
 TcFQ==
X-Gm-Message-State: AJcUukfVIGHY26j9iaCtIZh/IeNKkmkkLhEVU8/aw5JFSgDCbAndahq2
 9MCiYKUna4dsn5cGZIAoU3pugMRh
X-Google-Smtp-Source: ALg8bN5bU+iHdNinzeAQuQUW5nOYLv8kZqVuIB34AyJdAS/Tv08UM08whGcuUq6Rzvj2cFEWWDbvSQ==
X-Received: by 2002:a17:902:2dc3:: with SMTP id
 p61mr2521996plb.166.1548256363733; 
 Wed, 23 Jan 2019 07:12:43 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.133])
 by smtp.gmail.com with ESMTPSA id v9sm24772468pfe.49.2019.01.23.07.12.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 07:12:43 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org
Subject: [RFCv1 2/3] ARM: dts: meson8b: odroidc1: fix USB power supplies for
 phy
Date: Wed, 23 Jan 2019 15:12:08 +0000
Message-Id: <20190123151209.2080-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123151209.2080-1-linux.amoon@gmail.com>
References: <20190123151209.2080-1-linux.amoon@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_071245_106373_778CC828 
X-CRM114-Status: GOOD (  12.35  )
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Rob Herring <robh+dt@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch enables the USB Host controller (USB0) and the relative USB0 PHY.
From the shematics GPIOAO.BIT5 gpio input for the PWREN signal of the
USB_OTG controller (usb0) which is also linked to USB_HOST controller (usb1).
Add missing phy-supply link to both  USB0 and USB1 phy controller
This changes fixed the power issue on usb ports. Changes help fix usb reset warning.

[  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2

Fixes: 2eb79a4d15ff ("ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board")
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes from previous patch.

Fix the subject and commit message as per Martin's request
 --Add the signal name in the comment
 --Replace vbus-supply with phy-supply linking the power supply to phy node as pointed by Marine
   which a PWREN signal in the USB_HOST controller (usb1)

USB_VBUS                      4    2      0 unknown  5000mV     0mA  5000mV  5000mV
   phy-c1108820.phy.1         2                                 0mA     0mV     0mV
   phy-c1108800.phy.0         2                                 0mA     0mV     0mV
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 58669abda259..bfa472a679d9 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -83,6 +83,22 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
+	usb_vbus: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		vin-supply = <&p5v0>;
+
+		/*
+		 * signal name from schematics: PWREN
+		 */
+		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	tflash_vdd: regulator-tflash_vdd {
 		/*
 		 * signal name from schematics: TFLASH_VDD_EN
@@ -295,8 +311,18 @@
 	pinctrl-names = "default";
 };
 
+&usb0_phy {
+	status = "okay";
+	phy-supply = <&usb_vbus>;
+};
+
 &usb1_phy {
 	status = "okay";
+	phy-supply = <&usb_vbus>;
+};
+
+&usb0 {
+	status = "okay";
 };
 
 &usb1 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
