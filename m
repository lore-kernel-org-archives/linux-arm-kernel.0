Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F7EC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:07:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C880B217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oQKBjfhQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elgzuhqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C880B217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NZJBkUd+GqTRkGED6RqZthRj5b/nH74B2uiT6YqGZsI=; b=oQKBjfhQ0HQQ7L
	R54BuifttIUGwjZls8lHswDQbiRQMVzVN7Tjyrvw9kAvc7vGWZdkK0sI9l2wFMtcthOUZIauZFmOG
	oymsU+I6YGHlO7cB5GahiK3OL3YPREdkSe9bxA//LQ08TQ2DlGKVNlgxVspfHvX7l0Y/ixw6GMaJV
	0wA5oOrfuUNXeDC/xAFtxsDdCS+SiUluc72d6IgNqWaLngozwJQ5txJqepq0cufb4pW7IKhak3T02
	GG+ipU+JqED2XghiFKP9e6fc7dl4oc0uiv6rRtjYKGYpKfw8OexnNGVZb783XNSmRhD80dgs3Uptg
	67TEp101Iq4OSFZWEb2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqN6T-00031A-My; Sun, 03 Feb 2019 19:06:53 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqMvk-0005M0-KT
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 18:56:09 +0000
Received: by mail-pf1-x444.google.com with SMTP id w73so5710613pfk.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VSquxcgUN/Y3I5MYDZFPo3KJfmyDEJKVoJ4n42fBAN0=;
 b=elgzuhqgcwEWw/3DIN2zrtjoALYUm4v0XlUAkIULIhMPSYtxoTGi/W3otdXiYeQi4L
 SQFxVXavFkQi9q0qX9hOTMClrBmJxBpqNBk95W2NgETFp5gh7/yhFkxHKZQYBSHXL5CN
 VAGtAOvf4YbdTrHLthKhTZhQwsETHOlXKbjDVdn2E9fEMAftXAk6zVu8Y/E5IIPT6iUk
 YnbOUUzfHTuL/KNGYhn7QNUVEJ/M/PXisHfkvFlkMAgPsWxu1alk28Pn1YbMxvNYJ0tZ
 JgDVWZQgoa4q6UjDwO1Q8Q3DRKlAJqKWzU0Qcbg4hj7VLViT88g1b17YL0xcYzs+F4Yf
 c1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VSquxcgUN/Y3I5MYDZFPo3KJfmyDEJKVoJ4n42fBAN0=;
 b=YVWMixpf9UZdK975huFf8RwTbmd2urHKQvnYs6yC0OsWlSlFqcz51pXDg4kBX82SFL
 guoqGgIL7R1ktybr+ug9+nCK9V9U3LAfsIJi7o07HnxGlX8OrHUT6P67VlyBKPrwaTsy
 u65h7QPXOTyDSwXlMxk78WOEDayMsk9iDLp2PGoP898rs/r3OfyF4dxlBYBYzDvKt4Fb
 iC6y3koWB4IStiScfC5/nWsCKE7DUe2e8w89oYjCG6Vj9NKAlXeePwsyd7zdMWugIsLD
 nTenFnGpZKcQcVEyxM2d77mdFv3PBDmj7TXMFOG4/+gkgLm4k75O0iQlKHFXqgLCPxOA
 qUmQ==
X-Gm-Message-State: AJcUukcte+z2Dyj9zybInioLKVgBKtwVLei2iHDAN2mOlanAcb+NOO1s
 6hLzwF/pKH56d2+7F7Sv3aw=
X-Google-Smtp-Source: ALg8bN4I/Y5UgCCt6bXaQB/y1vBO0rTxQahEd2ZuoAeWd10E8AiFkEu5WJzGKwC4r8uh2ienVKdBPQ==
X-Received: by 2002:a62:f247:: with SMTP id y7mr48203540pfl.25.1549220147876; 
 Sun, 03 Feb 2019 10:55:47 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id g28sm19524553pfd.100.2019.02.03.10.55.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 10:55:47 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: [PATCH RESEND v2 12/12] arm64: allwinner: a64: enable LCD-related
 hardware for TERES-I
Date: Sun,  3 Feb 2019 10:55:01 -0800
Message-Id: <20190203185501.8958-13-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203185501.8958-1-anarsoul@gmail.com>
References: <20190203185501.8958-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_105549_706204_DAE692DC 
X-CRM114-Status: GOOD (  15.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

TERES-I has an ANX6345 bridge connected to the RGB666 LCD output and
eDP panel input. The bridge is controlled via I2C that's connected to
I2C0 bus.

Enable all this hardware in device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts | 71 +++++++++++++++++--
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index c455b24dd079..6c4090f59bed 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -56,6 +56,17 @@
 		};
 	};
 
+	edp_panel: edp-panel {
+		compatible = "panel-edp", "simple-panel";
+
+		port {
+			panel_in_edp: endpoint {
+				remote-endpoint = <&anx6345_out_panel>;
+			};
+		};
+	};
+
+
 	reg_usb1_vbus: usb1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1-vbus";
@@ -72,20 +83,58 @@
 	};
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
 
 
-/* The ANX6345 eDP-bridge is on i2c0. There is no linux (mainline)
- * driver for this chip at the moment, the bootloader initializes it.
- * However it can be accessed with the i2c-dev driver from user space.
- */
 &i2c0 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
+
+	anx6345: anx6345@38 {
+		compatible = "analogix,anx6345";
+		reg = <0x38>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+		dvdd25-supply = <&reg_dldo2>;
+		dvdd12-supply = <&reg_dldo3>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			anx6345_in: port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				anx6345_in_tcon0: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&tcon0_out_anx6345>;
+				};
+			};
+
+			anx6345_out: port@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+
+				anx6345_out_panel: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&panel_in_edp>;
+				};
+			};
+		};
+	};
+};
+
+&mixer0 {
+	status = "okay";
 };
 
 &mmc0 {
@@ -258,6 +307,20 @@
 	vcc-hdmi-supply = <&reg_dldo1>;
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_rgb666_pins>;
+
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_anx6345: endpoint@0 {
+		reg = <0>;
+		remote-endpoint = <&anx6345_in_tcon0>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
