Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888DAC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:52:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5811821900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="suBJ1E9K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uroXagWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5811821900
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0m0D9iy6FF+w6NEE9GAhgi/6PvACMKMNUSY8ycRibOM=; b=suBJ1E9KHQRVft
	/Exw7BTaSU18uazr94VAm4h3iGNHOQj2RK2eLLxL3Eq03+9Fu+Yjk6MfgBNXs0dHy8DAqLhjbYGL9
	JYXoNsN840keGUG5yUfLOuj5cCoM384YHItp5UtRvh9qlttwAfBbkI1C7sdpFNaoXlAYmUNaRbOZ5
	AL+B4PtSzfGkq7RLUwIDynnz1Fa/a4bex5CzmazFOak6o9dyz9ef2R5xGufKINd7PVOe4PHOtsqlR
	Ymi7tC4YAOii0yu6kBvHvKvUVquG2skaqj5XKUpC9iC9DrU+xQuSI//7sqSHh1KhH7Nb31PtTmMA0
	XYaQ7gMJv1l+rfaqSO8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfPo-00030K-T1; Thu, 07 Feb 2019 08:52:12 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfBJ-0004Uu-CV
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 08:37:19 +0000
Received: by mail-lf1-x143.google.com with SMTP id i26so7563173lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 00:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iFmmPc4bLcix+iB9KqTphgdxH8DV4tik6E4A8m4R3H0=;
 b=uroXagWr86WjI8Shk2Jp039YtWevKo6eApzyVWflRr/LXszlvkNXbqA9tB2EwddMCf
 A+zqQZKgZrGwgy0g/DGI5PcAn0/elugjjwZeY00Z7FFhrsEXao54O5OLoWnp2xdTEUOy
 +0buO4oxMHKaumzK1h7YezKtd1hPiEzpXX7VJ2Buy+qHBJr46F/1cV3tYagFSCWUhEpz
 bapSAwfEYom6LIJBxJ0KdQ+GEZ7WypN5nC1PuyWm3/S7F8waEnOrzedp3T+LLL7Zxtd+
 zbTRAYPB4D8hSTweqVcfeljV3+IJDPxatIWbny2j+IvOVi42yR04mIhZbV7A81xRxZT5
 TP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iFmmPc4bLcix+iB9KqTphgdxH8DV4tik6E4A8m4R3H0=;
 b=H9y8Lg0B5uMfXrKi30J3FDGaisuByw43ibe1A2z7+GBgJQI0QxSe596fVauphjNBRJ
 6Q1Ozt7nw7eVkBu6nH5TnC5cwA8pabpmxjcF3lEVd2O8wy53VL8X5Ms29jnM6r1y0wrF
 ntb6Gd4yepxDc0YTan6b7ophWlWudHPGiREjqQcFieu7+4Ytj7w6z6EzmVk/Lp8tsCuY
 94Fq1pkh1rVgFc73GVzIOO266YkQc3RMIaCNHOHXMSllRC2fp2oADT1I27EC0HF14H8b
 VwA4ax0TXEpO+h2YZBLBy3NlrEqXRfUWqocwi7Cc5VjfDsioHxlWkDLc6hXy9x6EK9es
 9RgQ==
X-Gm-Message-State: AHQUAuZXE7j7ok9wD02Hyj/8emIleLywJsm54PvmZJKUvyVjf6RHbckI
 QY7I36BEWXj5qE+A6YxAYwn+w5A+DN8=
X-Google-Smtp-Source: AHgI3IZttqHyLnXd1kj+f15bntC6W+lqoOXhui6U3bRddUUGQPs5L8gHyeHkrdKyBzZTRQ42PJN6Zg==
X-Received: by 2002:a19:9c81:: with SMTP id f123mr9201499lfe.96.1549528631265; 
 Thu, 07 Feb 2019 00:37:11 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id l72sm470910lfg.75.2019.02.07.00.37.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 00:37:10 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>
Subject: [PATCH 4/4] ARM: dts: Ux500: Add MCDE and Samsung display
Date: Thu,  7 Feb 2019 09:36:47 +0100
Message-Id: <20190207083647.20615-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207083647.20615-1-linus.walleij@linaro.org>
References: <20190207083647.20615-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_003713_906968_38DFFFF2 
X-CRM114-Status: GOOD (  15.04  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds and updates the device tree nodes for the MCDE
display controller and connects the Samsung display to
the TVK1281618 user interface board (UIB) so we get
nicely working graphics on this reference design.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi          | 36 +++++++++++++++++++---
 arch/arm/boot/dts/ste-href-stuib.dtsi      | 25 +++++++++++++++
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi | 25 +++++++++++++++
 3 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index e6ed7c0354a2..a33b36a8c879 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -1197,12 +1197,11 @@
 		};
 
 		mcde@a0350000 {
-			compatible = "stericsson,mcde";
-			reg = <0xa0350000 0x1000>, /* MCDE */
-			      <0xa0351000 0x1000>, /* DSI link 1 */
-			      <0xa0352000 0x1000>, /* DSI link 2 */
-			      <0xa0353000 0x1000>; /* DSI link 3 */
+			compatible = "ste,mcde";
+			reg = <0xa0350000 0x1000>;
 			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			epod-supply = <&db8500_b2r2_mcde_reg>;
+			vana-supply = <&ab8500_ldo_ana_reg>;
 			clocks = <&prcmu_clk PRCMU_MCDECLK>, /* Main MCDE clock */
 				 <&prcmu_clk PRCMU_LCDCLK>, /* LCD clock */
 				 <&prcmu_clk PRCMU_PLLDSI>, /* HDMI clock */
@@ -1211,6 +1210,33 @@
 				 <&prcmu_clk PRCMU_DSI0ESCCLK>, /* TVout clock 0 */
 				 <&prcmu_clk PRCMU_DSI1ESCCLK>, /* TVout clock 1 */
 				 <&prcmu_clk PRCMU_DSI2ESCCLK>; /* TVout clock 2 */
+			clock-names = "mcde", "lcd", "hdmi", "dsi0", "dsi1", "dsi0es", "dsi1es", "dsi2es";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			dsi0: dsi@a0351000 {
+				compatible = "ste,mcde-dsi";
+				reg = <0xa0351000 0x1000>;
+				vana-supply = <&ab8500_ldo_ana_reg>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			dsi1: dsi@a0352000 {
+				compatible = "ste,mcde-dsi";
+				reg = <0xa0352000 0x1000>;
+				vana-supply = <&ab8500_ldo_ana_reg>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+			dsi2: dsi@a0353000 {
+				compatible = "ste,mcde-dsi";
+				reg = <0xa0353000 0x1000>;
+				vana-supply = <&ab8500_ldo_ana_reg>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		cryp@a03cb000 {
diff --git a/arch/arm/boot/dts/ste-href-stuib.dtsi b/arch/arm/boot/dts/ste-href-stuib.dtsi
index 35e944d8b5c4..714c2fb758d4 100644
--- a/arch/arm/boot/dts/ste-href-stuib.dtsi
+++ b/arch/arm/boot/dts/ste-href-stuib.dtsi
@@ -190,5 +190,30 @@
 				};
 			};
 		};
+
+		mcde@a0350000 {
+			status = "okay";
+
+			dsi@a0351000 {
+				port {
+					dsi0_out: endpoint {
+						remote-endpoint = <&panel_in>;
+					};
+				};
+
+				panel: display {
+					compatible = "samsung,s6d16d0";
+					reg = <0>;
+					vdd1-supply = <&ab8500_ldo_aux1_reg>;
+					reset-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+
+					port {
+						panel_in: endpoint {
+							remote-endpoint = <&dsi0_out>;
+						};
+					};
+				};
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
index 0e7d77d719d7..84bb1e79168b 100644
--- a/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
+++ b/arch/arm/boot/dts/ste-href-tvk1281618.dtsi
@@ -274,5 +274,30 @@
 				};
 			};
 		};
+
+		mcde@a0350000 {
+			status = "okay";
+
+			dsi@a0351000 {
+				port {
+					dsi0_out: endpoint {
+						remote-endpoint = <&panel_in>;
+					};
+				};
+
+				panel: display {
+					compatible = "samsung,s6d16d0";
+					reg = <0>;
+					vdd1-supply = <&ab8500_ldo_aux1_reg>;
+					reset-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+
+					port {
+						panel_in: endpoint {
+							remote-endpoint = <&dsi0_out>;
+						};
+					};
+				};
+			};
+		};
 	};
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
