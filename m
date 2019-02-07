Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:37:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4133C2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iKJioPbY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blv6a+Ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4133C2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uEkjQB8Y0Hku+5Qc31iQoR7EQ6oAbWdfVyBUpIxKd0Y=; b=iKJioPbYwULPNa
	XzmtOmYhMwnkpGoCiSdYvNiFUA7R9SPjNcDzokW7X5nhg8Z48Yg90sOwImyBh8xzD2a5ONWtRPb2q
	ROazYGhdd4pfHNK8MEpYPSCdhn2Cp8nh40PxqSQHQcjiefd8AkcQrfSXPYsqxoen+udcCpRwOwF8X
	j2K+wtoMoiqAytWmaWFIKOeepAPvwK2AY/C3ud25wIoQ0bQZyQuSzQmCuVFxeiHQDqSMng03XsnDT
	kXc92B7eCcqH9qWZKKIHMYa2//iG2S6jqg3bDMjhaKJq6jjziI2SI8m2TCXa1jM85TlqMKq79J4jP
	PPT69ADY9QwH2WKBc2WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfBi-0004vp-0L; Thu, 07 Feb 2019 08:37:38 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfBE-0004Q9-Cq
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 08:37:12 +0000
Received: by mail-lj1-x244.google.com with SMTP id t9-v6so8543060ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 00:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Fu6jwA0iS37MvRskgJ23dsfsdPcRAtL3/3qeNzCWH0I=;
 b=blv6a+JaT9u0qTOXyMuCygUfgEWsVpIgHxI/z/ihQ7gXOdgltzWCubC8R/KQU6F46H
 Ihcf4Eo95SS/i87l9nbfrPSwkSiWcEqeLrmNmfzi4TN7DE5l3IBWwFAutDcuLYwL9XCE
 yT8v7CNBTqUJbSYSAU+vzlSepsaNHbWW+vxfN0b+ruS0lArgVc3s/V/EX0kJqYOVlrLR
 K40UZ9xVlaBfTydt8G9sh9rbM6jF3MrVqdCn3Efm1VRbTzLa7fTsU8dj5OQXHH5d+kIM
 zJcDiZ9MhaPxDUSkGLCj8LPMdC+FMkIARxDs/yIfL8gbHETiugCd4JKieyQG5VSi6cxi
 juLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fu6jwA0iS37MvRskgJ23dsfsdPcRAtL3/3qeNzCWH0I=;
 b=Q4KUHoV2nUhwR9RqaIK1tR9y7xpx3js04afm4kYltSY5AVCKG5jMxYc9HCLLK7u9QP
 p5sDmM5C9bwBxownDvSPawH0t+NstOBNX1VuiFheHmRlFsW/bBtaJDqVb0+E474HOCIS
 ow7Rbb+sWQZ2n41pCj71h1uxCYGzImC9TF80r+C/FHpFyz+iHGQ+qDaT9CYosWZzbNfs
 wAqSNbHJAFy9jbDhqloeD7P7oQy386g4OROW7eVkbXSzmGXsrImDPZoqYtVN2RpHhzG7
 1HwzxTYrEusFOaU80mEHUxZTdULb9w2hJSUYj4NQxchHUkmK21XWGmXR+574H31Dr8kQ
 eing==
X-Gm-Message-State: AHQUAuYobzFfsNpKXDvzhP40j86CU5IENZOzWupkRSSO+HP0djQKAIbZ
 UHkjeuRooLAawYuNxERpj2a7XA==
X-Google-Smtp-Source: AHgI3Ia0S6lDA5tjE9ro2hCygTtLDn9qL/2SNJ0txJZgz/JW70C9cPObwDtJLPZNraK1tYLp2cg6Iw==
X-Received: by 2002:a2e:6503:: with SMTP id
 z3-v6mr9257434ljb.153.1549528625058; 
 Thu, 07 Feb 2019 00:37:05 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
 by smtp.gmail.com with ESMTPSA id l72sm470910lfg.75.2019.02.07.00.37.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 00:37:03 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>
Subject: [PATCH 2/4] drm/mcde: Add device tree bindings
Date: Thu,  7 Feb 2019 09:36:45 +0100
Message-Id: <20190207083647.20615-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207083647.20615-1-linus.walleij@linaro.org>
References: <20190207083647.20615-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_003708_595758_7E31526E 
X-CRM114-Status: GOOD (  14.93  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the device tree bindings for the ST-Ericsson
Multi Channel Display Engine MCDE as found in the U8500
SoCs.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/display/ste,mcde.txt  | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ste,mcde.txt

diff --git a/Documentation/devicetree/bindings/display/ste,mcde.txt b/Documentation/devicetree/bindings/display/ste,mcde.txt
new file mode 100644
index 000000000000..fc58aa5effb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ste,mcde.txt
@@ -0,0 +1,110 @@
+ST-Ericsson Multi Channel Display Engine MCDE
+
+The ST-Ericsson MCDE is a display controller with support for compositing
+and displaying several channels memory resident graphics data on DSI or
+LCD displays or bridges. It is used in the ST-Ericsson U8500 platform.
+
+Required properties:
+
+- compatible: must be:
+  "ste,mcde"
+- reg: register base for the main MCDE control registers, should be
+  0x1000 in size
+- interrupts: the interrupt line for the MCDE
+- epod-supply: a phandle to the EPOD regulator
+- vana-supply: a phandle to the analog voltage regulator
+- clocks: an array of the MCDE clocks in this strict order:
+  MCDECLK (main MCDE clock), LCDCLK (LCD clock), PLLDSI
+  (HDMI clock), DSI0ESCLK (DSI0 energy save clock),
+  DSI1ESCLK (DSI1 energy save clock), DSI2ESCLK (DSI2 energy
+  save clock)
+- clock-names: must be the following array:
+  "mcde", "lcd", "hdmi", "dsi0", "dsi1", "dsi0es", "dsi1es", "dsi2es"
+  to match the required clock inputs above.
+- #address-cells: should be <1> (for the DSI hosts that will be children)
+- #size-cells: should be <1> (for the DSI hosts that will be children)
+- ranges: this should always be stated
+
+Required subnodes:
+
+The devicetree must specify subnodes for the DSI host adapters.
+These must have the following characteristics:
+
+- compatible: must be:
+  "ste,mcde-dsi"
+- reg: must specify the register range for the DSI host
+- vana-supply: phandle to the VANA voltage regulator
+- #address-cells: should be <1>
+- #size-cells: should be <0>
+
+Display panels and bridges will appear as children on the DSI hosts, and
+the displays are connected to the DSI hosts using the common binding
+for video transmitter interfaces; see
+Documentation/devicetree/bindings/media/video-interfaces.txt
+
+If a DSI host is unused (not connected) it will have no children or ports
+defined.
+
+Example:
+
+mcde@a0350000 {
+	compatible = "ste,mcde";
+	reg = <0xa0350000 0x1000>;
+	interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+	epod-supply = <&db8500_b2r2_mcde_reg>;
+	vana-supply = <&ab8500_ldo_ana_reg>;
+	clocks = <&prcmu_clk PRCMU_MCDECLK>, /* Main MCDE clock */
+		 <&prcmu_clk PRCMU_LCDCLK>, /* LCD clock */
+		 <&prcmu_clk PRCMU_PLLDSI>, /* HDMI clock */
+		 <&prcmu_clk PRCMU_DSI0CLK>, /* DSI 0 */
+		 <&prcmu_clk PRCMU_DSI1CLK>, /* DSI 1 */
+		 <&prcmu_clk PRCMU_DSI0ESCCLK>, /* TVout clock 0 */
+		 <&prcmu_clk PRCMU_DSI1ESCCLK>, /* TVout clock 1 */
+		 <&prcmu_clk PRCMU_DSI2ESCCLK>; /* TVout clock 2 */
+	clock-names = "mcde", "lcd", "hdmi", "dsi0", "dsi1",
+		    "dsi0es", "dsi1es", "dsi2es";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	dsi0: dsi@a0351000 {
+		compatible = "ste,mcde-dsi";
+		reg = <0xa0351000 0x1000>;
+		vana-supply = <&ab8500_ldo_ana_reg>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port {
+			dsi0_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+
+		panel: display {
+			compatible = "samsung,s6d16d0";
+			reg = <0>;
+			vdd1-supply = <&ab8500_ldo_aux1_reg>;
+			reset-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+
+			port {
+				panel_in: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+		};
+
+	};
+	dsi1: dsi@a0352000 {
+		compatible = "ste,mcde-dsi";
+		reg = <0xa0352000 0x1000>;
+		vana-supply = <&ab8500_ldo_ana_reg>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+	dsi2: dsi@a0353000 {
+		compatible = "ste,mcde-dsi";
+		reg = <0xa0353000 0x1000>;
+		vana-supply = <&ab8500_ldo_ana_reg>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
