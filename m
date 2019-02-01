Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19799C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09E020855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Sf37bEWm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n9ixxPdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09E020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BN+AU9Y3z2dTjaMDn2+jIUjhXclr1asyfidw+F+MxS8=; b=Sf37bEWmwei0RS
	CSNajdddw7WG5ZzS3NZh/1gpfsz9RKXhXkTFlvEbs+CIus5wUcNwoY+2KvhNmDMPcv2tfr5SWy/jn
	d9a9XWHKWREQXk8zGgtYYmheqFsOhSxi2SrG2/25BXi37jDRNmXXZtiGXbZ6yxE1lvEARD0EPsaF1
	UpZqceefQQIUcXv8sHdUHJeVwB7fsycshtlQ6bKgxSvVF+TUCqoB5L/UZwdBhtBR94rKgsaeNDHKj
	Po/lI/3khZ6e89LD34vYLonZbgKCnLukV218BguduIfhAmrxU4qRXCJqrkxAroLEGISKtOUSqBilj
	jy8e2CR8QC9ZX/WNet5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb2c-0007xh-N3; Fri, 01 Feb 2019 15:47:42 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpayK-0002U7-F2
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:43:44 +0000
Received: by mail-lj1-x241.google.com with SMTP id x85-v6so6211393ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F1gStgTkjk6tlJJTMM1N5dKth21S5Be68oRPAzV2+nA=;
 b=n9ixxPdApi8UuB1AQqAGMEY9pdrNlRpfeuMUYW57T5ST2Z+yKssUlv66PFgx13N6xg
 eaX2GSalvY9KhqJWiBQSuBRxAfCAfWTcF1PaQsjoH8UKUnTE+S3/2i5f5Xdg1K3t0wWR
 QP9IlCVjErmqroMITEmXXVez6bBUR3UEM3NRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F1gStgTkjk6tlJJTMM1N5dKth21S5Be68oRPAzV2+nA=;
 b=VMZhO4n1Yj3+c+og1PqyEx0U8+UP3gYv79fr0a/PGxrEX2OURghnAcCp5Q+qoN6RoR
 IA6wCk7AfEWlJ65zRprNYHM6L1GyHQE5+kmVcC3BBbqHOqm6FZduxi30tMEwNsGAszwN
 jRb4rUwctESVsc5vBLgZaUnJvUqs4Oltq1N8i/+4UXUBgqzhuEPZLpLwBgyY9eiGs17u
 gtlmYLP96+NC9u2u3Jv0P0J2/vW08TU0SVyt9OR+RYRscxaNWq5qwJt3ZceSF+Ociiwc
 lP5FSqoI5jJXBFdixIQD7ujJIWHYab91SmmMPcphyuCZo93+WbWk5QHa9Yl8MlRSfKLY
 1BBw==
X-Gm-Message-State: AJcUukf9wX18HoADEKR4hRsrM+zIFZCeNcrqtBPb7X+cqX2kmkJ62NqC
 31yElb23NkA9LXn1lQ1MQFRlhw==
X-Google-Smtp-Source: ALg8bN5jd+gqm3EcT4dz5zpwlEiLl+nt4W4qPpnoXcRR46dD9NrUl0Gf8gPpVsaNSzhzwU/nfUkLRA==
X-Received: by 2002:a2e:8007:: with SMTP id
 j7-v6mr32273423ljg.50.1549035794201; 
 Fri, 01 Feb 2019 07:43:14 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:43:13 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 17/23] arm64: dts: allwinner: a64: Add MIPI DSI pipeline
Date: Fri,  1 Feb 2019 21:12:26 +0530
Message-Id: <20190201154232.10505-18-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074317_065864_D19925FD 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add MIPI DSI pipeline for Allwinner A64.

- dsi node, with A64 compatible since it doesn't support
  DSI_SCLK gating unlike A33
- dphy node, with A64 compatible with A33 fallback since
  DPHY on A64 and A33 is similar
- finally, attach the dsi_in to tcon0 for complete MIPI DSI

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 6e5a608f56f2..f221c50e7fd4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -359,6 +359,12 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <1>;
+
+					tcon0_out_dsi: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&dsi_in_tcon0>;
+						allwinner,tcon-channel = <1>;
+					};
 				};
 			};
 		};
@@ -936,6 +942,45 @@
 			status = "disabled";
 		};
 
+		dsi: dsi@1ca0000 {
+			compatible = "allwinner,sun50i-a64-mipi-dsi";
+			reg = <0x01ca0000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			phys = <&dphy>;
+			phy-names = "dphy";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					dsi_in_tcon0: endpoint {
+						remote-endpoint = <&tcon0_out_dsi>;
+					};
+				};
+			};
+		};
+
+		dphy: d-phy@1ca1000 {
+			compatible = "allwinner,sun50i-a64-mipi-dphy",
+				     "allwinner,sun6i-a31-mipi-dphy";
+			reg = <0x01ca1000 0x1000>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&ccu CLK_DSI_DPHY>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			status = "disabled";
+			#phy-cells = <0>;
+		};
+
 		csi: csi@1cb0000 {
 			compatible = "allwinner,sun50i-a64-csi";
 			reg = <0x01cb0000 0x1000>;
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
