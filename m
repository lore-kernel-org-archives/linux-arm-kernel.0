Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F11DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:35:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E872F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AABXRc5b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="keXb1I5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E872F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OpS2CspzOJGJT4k0n1VkMyEQuG6KY2SbYH7bgV26ZKw=; b=AABXRc5bLlwh4N
	D5RInE1HPL+cBREenk/l/7bHjSTGRQqzpIbBX3m86W4iVgqBj8JdfCfyHGkrgZUvC3rK/vTwDGh1A
	H97QW+w1wNIPuyI9rPaE7vkdec9iL6DRVOTy2g4p9K0gP5altu+GZkb8gvfRCwJrThQ39KlOh3t1Q
	WIElmvucJlH/5SEnqRevXs4qUZI/PhmYJBW5AlXDomBzVVQekAKCYUpjxBdYwrQHILwtGuxl6tLwC
	ArveG0solDn6NdQs18ohrXbPn7ItnsgLYeQEqGoOnZGITrWwgVvJ9th5ujpnCLbuKq0I30EjIXmk3
	rFHRi5IKuHV4Zt9y2X4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX6g-0007ec-OG; Fri, 18 Jan 2019 16:34:58 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX4N-0005Zj-Lp
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:32:42 +0000
Received: by mail-pl1-x642.google.com with SMTP id b5so6583804plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jEijnCjicnGILwhFrMB461TXW1hBMByoFGuErMag6m8=;
 b=keXb1I5xHNipIFO8YRYvl5Nyt0I+bizBTULJaWrA4rQm1UTphElVztLCeiyRPWnDZa
 gfmjgAbgCkzsmg9UeMmSyFfb5E19kz331Byl3LWtd9d7W83CzwOfnQJoSgiG+kzeFmI0
 dOZCDgF+AqyC/+HvzloFyrp2j+F7q7Ec8NdoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jEijnCjicnGILwhFrMB461TXW1hBMByoFGuErMag6m8=;
 b=ADtQPF/i7jYluFSoBs2p7oMxm9NQBw2gc7GNwDajrYIqInbTqnx3/AkX/sSTJYc/33
 5k5uKKZeQPqk8NxahXe5o7JxKGhXDQM4nCdOVLHrS+z9IYOPXRXNTtaflLaMihqOF/Ys
 msaZVbAeaXzClgTWlgky1TnphCKzF37/RCd/USIScdSDssTCc4Q6PeYn99xuqfVS7lCP
 //MWufUuRUuK5maAUkK/FzElqGJP7LpMXiwRLAZ4JSUxqk+tUSnjRAvRpAPhCgph3Mof
 NsniGXm+AFq1lYduGsrCjmR+Dte82K6lmaL/P9qHnTEiRQCqpEvTZYvtdsc/EC4Ux6Ta
 XuZg==
X-Gm-Message-State: AJcUukdGE8CsQ8f5OVrMonotfYwYyw9Tb9Sn4CjEKtU4EhUglMRcqdkQ
 f5pNmL1PP1os67iLAB7EHlonhg==
X-Google-Smtp-Source: ALg8bN6fHwMOirgmCp/MatwdUw0W+yNrleJqgmFxCrB5I1IkCJEvbH9Fhfua8S0ST+/g3+MHqA9YEA==
X-Received: by 2002:a17:902:4601:: with SMTP id
 o1mr19802483pld.243.1547829154895; 
 Fri, 18 Jan 2019 08:32:34 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
 by smtp.gmail.com with ESMTPSA id z13sm13967086pgf.84.2019.01.18.08.32.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 08:32:34 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v6 6/6][DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Add
 HDF5640 camera module
Date: Fri, 18 Jan 2019 22:01:58 +0530
Message-Id: <20190118163158.21418-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190118163158.21418-1-jagan@amarulasolutions.com>
References: <20190118163158.21418-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083236_286720_0C856F4E 
X-CRM114-Status: GOOD (  12.60  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Bananapi M64 comes with an optional sensor based on the ov5640,
add support for it with below pin information.

- PE13, PE12 via i2c-gpio bitbanging
- CLK_CSI_MCLK as external clock
- PE1 as external clock pin muxing
- DLDO3 as AVDD supply
- ALDO1 as DOVDD supply
- ELDO3 as DVDD supply
- PE16 gpio for reset pin
- PE17 gpio for powerdown pin

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 83e30e0afe5b..c185ceec8c81 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -60,6 +60,41 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	i2c-csi {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 4 13 GPIO_ACTIVE_HIGH>; /* CSI0-SDA: PE13 */
+		scl-gpios = <&pio 4 12 GPIO_ACTIVE_HIGH>; /* CSI0-SCK: PE12 */
+		i2c-gpio,delay-us = <5>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ov5640: camera@3c {
+			compatible = "ovti,ov5640";
+			reg = <0x3c>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&csi_mclk_pin>;
+			clocks = <&ccu CLK_CSI_MCLK>;
+			clock-names = "xclk";
+
+			AVDD-supply = <&reg_dldo3>;
+			DOVDD-supply = <&reg_aldo1>;
+			DVDD-supply = <&reg_eldo3>;
+			reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* CSI0-RST: PE16 */
+			powerdown-gpios = <&pio 4 17 GPIO_ACTIVE_HIGH>; /* CSI0-PWDN: PE17 */
+
+			port {
+				ov5640_ep: endpoint {
+					remote-endpoint = <&csi_ep>;
+					bus-width = <8>;
+					hsync-active = <1>; /* Active high */
+					vsync-active = <0>; /* Active low */
+					data-active = <1>;  /* Active high */
+					pclk-sample = <1>;  /* Rising */
+				};
+			};
+		};
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -106,6 +141,24 @@
 	status = "okay";
 };
 
+&csi {
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		csi_ep: endpoint {
+			remote-endpoint = <&ov5640_ep>;
+			bus-width = <8>;
+			hsync-active = <1>; /* Active high */
+			vsync-active = <0>; /* Active low */
+			data-active = <1>;  /* Active high */
+			pclk-sample = <1>;  /* Rising */
+		};
+	};
+};
+
 &dai {
 	status = "okay";
 };
@@ -296,6 +349,12 @@
 	regulator-name = "vcc-wifi";
 };
 
+&reg_dldo3 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "avdd-csi";
+};
+
 &reg_dldo4 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <3300000>;
@@ -313,6 +372,12 @@
 	regulator-name = "cpvdd";
 };
 
+&reg_eldo3 {
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "dvdd-csi";
+};
+
 &reg_fldo1 {
 	regulator-min-microvolt = <1200000>;
 	regulator-max-microvolt = <1200000>;
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
