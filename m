Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6103AC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:53:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3025520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sib2S50Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVC0MFJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3025520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=86OrSYYaVhrdzsSSsbZJfttL3p0QUjiVtHi/G9o/J6E=; b=sib2S50YIxb8Yw
	/zLpe7x3KyvUWO5Pj+qecC1Ef+gkxI2YpakErhFGDVLmkmMFBSUBjJOXj9RP86sHL57bGIVSnN8p9
	FKtITssQNmaJ5SPAU+QWoPRgRhZus4XYIW4YFUSEbhEs6jLB8C0Qy+R1U0wykKYutMfO268cYHd1Z
	sMXompVBlTzYbnPOXqH1w1xXlc2wGYMfHefKjjGGVH7TsSMTsWSbB3mARovCVPmeyN5QKMo4K8Soq
	LbC+uyHYuWWEgLlC24SADuXOPgQoRKYIy00rozq8fjfI4pIFzLFNT2KFWpOrWKwtOljXnSrq6iPpy
	07hCHyVXdqdSpW792Y5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmDLf-00021q-V4; Wed, 23 Jan 2019 07:53:23 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmDLc-00021W-9v
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 07:53:21 +0000
Received: by mail-lf1-x142.google.com with SMTP id n18so861308lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 23:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oqv2XD8qFrsHBfPMr+my5xIa0qL/Be0Xcd4T5xckPkc=;
 b=AVC0MFJmf0i+ZuhexwY0Y1XbSbIYbGkp4AWDMGG3qSrFpUwlFLeD4jxG/D1Ugri+0r
 AJzsT834BsDHjNpTyZJdV7VvZP7qTln2PfViWQTcHMkPBlIju20mCQ7Ow0HvUNash8qf
 RbNsFGqOx/K9Wu+++bcb7JnlWVXduGK3eVNH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oqv2XD8qFrsHBfPMr+my5xIa0qL/Be0Xcd4T5xckPkc=;
 b=TjJDqxM2THoznx5z0X1I2I3H+vbWPNz6/vY9nwkBLSPDvenxUKxR7PxjNsKdLVJdNp
 vpfB0NV7bZBsb5fseIg2/qRik1sOgXdfW4uWF1umEXDlWT1SFrZvtvx7pq/KoUWAEnji
 534Omf7I5aepfoFQ9MzPn0WwlUtpmpUVszP4gX/flJ6itofzPbrAr2Yz3Bxnu07RwIZ/
 2yjn7BzArFB1pZuI5JNW+MXB7rLpGXd2szjcrRTlhaDFsKF04hxWa3/pI+TJh2D9vO6Z
 pXYBmevNnXGJjG4aY9jiFiP57mfWT+I16vbq1nQJXv5kw8rnNDlHgslgPp5dkGFbJlKJ
 sq4g==
X-Gm-Message-State: AJcUukee3S9QHx9qn8EvGRoWsUXNKhwXhidlfqVC0zHNyElDeXG/nv8b
 icskdxGwUNiuiRtPIKUyDkoig5ZLoGg=
X-Google-Smtp-Source: ALg8bN4oq4A0so4TcBbQGKr8vpDPKKgkz1afPxV14WHL8IjgpxLSUX2UdbKAVdnUJOsq+r+fVdjZ9g==
X-Received: by 2002:a19:be16:: with SMTP id o22mr1006089lff.22.1548229997600; 
 Tue, 22 Jan 2019 23:53:17 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id s127sm361172lfe.8.2019.01.22.23.53.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Jan 2019 23:53:16 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: Augment panel setting for Integrator/CP
Date: Wed, 23 Jan 2019 08:53:14 +0100
Message-Id: <20190123075314.3384-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_235320_346711_504E5B8F 
X-CRM114-Status: GOOD (  14.10  )
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
Cc: Mali DP Maintainers <malidp@foss.arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the actual VGA DAC bridge that is used in the
Versatile AB, and sets the mode to 640x480 VGA and
routes the CLCD pads appropriately.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mali DP Maintainers <malidp@foss.arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorcp.dts | 89 +++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index a185ab8759fa..01fa229e1bd0 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -192,6 +192,43 @@
 		interrupts = <27>;
 	};
 
+	bridge {
+		compatible = "ti,ths8134a", "ti,ths8134";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				vga_bridge_in: endpoint {
+					remote-endpoint = <&clcd_pads_vga_dac>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				vga_bridge_out: endpoint {
+					remote-endpoint = <&vga_con_in>;
+				};
+			};
+		};
+	};
+
+	vga {
+		compatible = "vga-connector";
+
+		port {
+			vga_con_in: endpoint {
+				remote-endpoint = <&vga_bridge_out>;
+			};
+		};
+	};
+
 	fpga {
 		/*
 		 * These PrimeCells are at the same location and using
@@ -254,39 +291,27 @@
 			interrupts = <22>;
 			clocks = <&auxosc>, <&pclk>;
 			clock-names = "clcdclk", "apb_pclk";
+			/* 640x480 16bpp @ 25.175MHz is 36827428 bytes/s */
+			max-memory-bandwidth = <40000000>;
 
-			port {
-				/*
-				 * The VGA connected is implemented with a
-				 * THS8134A triple DAC that can be run in 24bit
-				 * or 16bit RGB mode.
-				 */
-				clcd_pads: endpoint {
-					remote-endpoint = <&clcd_panel>;
-					arm,pl11x,tft-r0g0b0-pads = <1 7 13>;
-				};
-			};
-
-			panel {
-				compatible = "panel-dpi";
-
-				port {
-					clcd_panel: endpoint {
-						remote-endpoint = <&clcd_pads>;
-					};
-				};
-
-				/* Standard 640x480 VGA timings */
-				panel-timing {
-					clock-frequency = <25175000>;
-					hactive = <640>;
-					hback-porch = <48>;
-					hfront-porch = <16>;
-					hsync-len = <96>;
-					vactive = <480>;
-					vback-porch = <33>;
-					vfront-porch = <10>;
-					vsync-len = <2>;
+			/*
+			 * This port is routed through a PLD (Programmable
+			 * Logic Device) that routes the output from the CLCD
+			 * (after transformations) to the VGA DAC and also an
+			 * external panel connector. The PLD is essential for
+			 * supporting RGB565/BGR565.
+			 *
+			 * The signals from the port thus reaches two endpoints.
+			 * The PLD is managed through a few special bits in the
+			 * FPGA "sysreg".
+			 *
+			 * This arrangement can be clearly seen in
+			 * ARM DUI 0225D, page 3-41, figure 3-19.
+			 */
+			port@0 {
+				clcd_pads_vga_dac: endpoint {
+					remote-endpoint = <&vga_bridge_in>;
+					arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
 				};
 			};
 		};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
