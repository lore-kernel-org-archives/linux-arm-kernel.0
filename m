Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1DFC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7C320651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gG4x1lyZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fBNrSvoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7C320651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qE6o5JBwNTLUY9/O1Wu35UNkpPArhsM1h6//9iFhE8Q=; b=gG4x1lyZgASxhe
	Hvaho7UDk2HLI9CNr9Wv6Y2wPhdFLvmIILhmkxJcBN09u6L6fkZLu2eOrO1pNR+CmwyQo0/FIxqCf
	cG2ZM64qORQW4b5kwFXQLWR3BrIU9nQqOgIM1W+BQytlIGZhKhPO1bljbVzx1noFKsN2EYST9i2/n
	8FlXQ73+bdTD26KhIrvUmOYkogS/snXdSNrqsPyLiz98w55Ti2KQhsrp45EdqzIPSHx4kFGVQMhOQ
	PfGgz6zcJBILLV4Ssu18GbC8k8mjPiY/nw6ms05jBOHh77v9AyHyTI4FIVmXFUuK75SLF5BZCMB0+
	rkpbS0rn3gc+MtFwyy3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxJi9-0000sN-HC; Fri, 22 Feb 2019 22:54:29 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxJhj-0000LT-5o
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 22:54:08 +0000
Received: by mail-pf1-x443.google.com with SMTP id u9so1752675pfn.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 14:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8BXw3ZHIYVqI7gUabwMIYanS3N5oJSBfJnmbDn81unQ=;
 b=fBNrSvoTwca7CmmLOXS7hVF9dXkptUNho4FX1YtIQbBYx4j3ThWKRtAMvcWBG9viSx
 8YGW6iPJDKHqdIj9FUdlVP2pS/kR6C10jG26iddZfZqSoBWzPsprKh3srU39Bp+9IKtd
 RbRvWV5U3/MY3RSmE8kvSPzMYpVuto6i3ReB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8BXw3ZHIYVqI7gUabwMIYanS3N5oJSBfJnmbDn81unQ=;
 b=AQf3QhaI69frtRbD5BIOxU8eszfAD6jG1OlAX0bKQritqWeTxOdmZmxCMn2IgIvmT/
 2EOCncy/5moxzAwhQ9jXHPmFPgC8/i50UBiGUNC0yggnr/d5mKnRGlL0rtTk7uBu06B+
 kjA2dwxZCE3z0MmOsFeigOK3StD/FE0bihYzb19X0DMA02gKdS33LGSmqny1hzb50Wbw
 0jTdono9Fa9GgZ8gOVfGH0oVRQLlMo+qrNDZF8xCeB7kOkHIDroQSt03a4mbuiSv4GeR
 3WAGd6a+h5SCvoP8JP/6Wz1eIq8pufEPthIye4rqTVLYVkIxFjrWnVjJ3NgDkhTsdvFj
 FCSg==
X-Gm-Message-State: AHQUAuaU0HhlpubOv8e26O1owHsaUdByNDCNwc0UaYglJChry99n48IL
 7oEmJ4EZQzNoZJaC8JzLiN1g4A==
X-Google-Smtp-Source: AHgI3IbfKc/mdIHLhW/nIrPvqnp6/k2674ZMTQLwTY9Oj+x7/526fXdLzLzAAFq3iPEcP8QkZZkwlg==
X-Received: by 2002:aa7:9255:: with SMTP id 21mr6663437pfp.8.1550876042694;
 Fri, 22 Feb 2019 14:54:02 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id g185sm3994995pfc.174.2019.02.22.14.54.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 14:54:01 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Heiko Stuebner <heiko@sntech.de>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: move QCA6174A wakeup pin into
 its USB node
Date: Fri, 22 Feb 2019 14:53:45 -0800
Message-Id: <20190222225345.69084-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190222225345.69084-1-briannorris@chromium.org>
References: <20190222225345.69084-1-briannorris@chromium.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_145403_564234_223FC96E 
X-CRM114-Status: GOOD (  16.45  )
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
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Brian Norris <briannorris@chromium.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rajat Jain <rajatja@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Currently, we don't coordinate BT USB activity with our handling of the
BT out-of-band wake pin, and instead just use gpio-keys. That causes
problems because we have no way of distinguishing wake activity due to a
BT device (e.g., mouse) vs. the BT controller (e.g., re-configuring wake
mask before suspend). This can cause spurious wake events just because
we, for instance, try to reconfigure the host controller's event mask
before suspending.

We can avoid these synchronization problems by handling the BT wake pin
directly in the btusb driver -- for all activity up until BT controller
suspend(), we simply listen to normal USB activity (e.g., to know the
difference between device and host activity); once we're really ready to
suspend the host controller, there should be no more host activity, and
only *then* do we unmask the GPIO interrupt.

This is already supported by btusb; we just need to describe the wake
pin in the right node.

We list 2 compatible properties, since both PID/VID pairs show up on
Scarlet devices, and they're both essentially identical QCA6174A-based
modules.

Also note that the polarity was wrong before: Qualcomm implemented WAKE
as active high, not active low. We only got away with this because
gpio-keys always reconfigured us as bi-directional edge-triggered.

Finally, we have an external pull-up and a level-shifter on this line
(we didn't notice Qualcomm's polarity in the initial design), so we
can't do pull-down. Switch to pull-none.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
v2:
 * drop leading zeroes from VID
 * rename 'bt' node to 'bluetooth'
---
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 13 ++++++
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 46 ++++++++++++-------
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 13 ------
 3 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index c400be64170e..931640e9aed4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -200,6 +200,19 @@
 		pinctrl-0 = <&bl_en>;
 		pwm-delay-us = <10000>;
 	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l>;
+
+		wake_on_bt: wake-on-bt {
+			label = "Wake-on-Bluetooth";
+			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
 };
 
 &ppvar_bigcpu {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index fc50b3ef758c..62ea7d6a7d4a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -175,6 +175,21 @@
 		pinctrl-0 = <&dmic_en>;
 		wakeup-delay-ms = <250>;
 	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pen_eject_odl>;
+
+		pen-insert {
+			label = "Pen Insert";
+			/* Insert = low, eject = high */
+			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+			linux,code = <SW_PEN_INSERTED>;
+			linux,input-type = <EV_SW>;
+			wakeup-source;
+		};
+	};
 };
 
 /* pp900_s0 aliases */
@@ -328,20 +343,6 @@ camera: &i2c7 {
 		<400000000>;
 };
 
-&gpio_keys {
-	pinctrl-names = "default";
-	pinctrl-0 = <&bt_host_wake_l>, <&pen_eject_odl>;
-
-	pen-insert {
-		label = "Pen Insert";
-		/* Insert = low, eject = high */
-		gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
-		linux,code = <SW_PEN_INSERTED>;
-		linux,input-type = <EV_SW>;
-		wakeup-source;
-	};
-};
-
 &i2c_tunnel {
 	google,remote-bus = <0>;
 };
@@ -437,8 +438,19 @@ camera: &i2c7 {
 	status = "okay";
 };
 
-&wake_on_bt {
-	gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
+&usb_host0_ohci {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	qca_bt: bluetooth@1 {
+		compatible = "usbcf3,e300", "usb4ca,301a";
+		reg = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "wakeup";
+	};
 };
 
 /* PINCTRL OVERRIDES */
@@ -455,7 +467,7 @@ camera: &i2c7 {
 };
 
 &bt_host_wake_l {
-	rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_up>;
+	rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_none>;
 };
 
 &ec_ap_int_l {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index ea607a601a86..da03fa9c5662 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -269,19 +269,6 @@
 		#clock-cells = <0>;
 	};
 
-	gpio_keys: gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_host_wake_l>;
-
-		wake_on_bt: wake-on-bt {
-			label = "Wake-on-Bluetooth";
-			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
-			linux,code = <KEY_WAKEUP>;
-			wakeup-source;
-		};
-	};
-
 	max98357a: max98357a {
 		compatible = "maxim,max98357a";
 		pinctrl-names = "default";
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
