Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62892C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:22:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A8320821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZZL3b/A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aqPbNxfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A8320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zz0K6oD7Z+BsycCtYCPjEjawgrgkut5iAi9JqcQykvA=; b=ZZZL3b/Av6RGqC
	QtkXwnQeDJsYtLNoKwU+KWcX9Colm7g/mE+ib3Z/0gajwQIq5+ORIeWfTMmhEyn/tiMa1HX2eLTb1
	D8LxzHABX+8TCaOEJ7b2dm9ZskqIpqfUogAf2JGgZB4zYvpKxwPb5y07iEBQxhCfsQ6ZLw5u7Ncgi
	PmPeltRVCEF88r+S1Gb/Gu2pObYHwus8nXjGv5wagE+yulz2P83jKFOJ7hWGXz9YhHmblfyb15Dh/
	UbjF0e52Dz1UnvGmmK0wxT1xbdrXyy1VfkpRb+swJVPuKdUtesCJzQtgVy5PCRsX03GDzInJZxXL6
	AmFQd0mcAHv8a7BOfELQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOK4-0004tx-Qo; Mon, 10 Dec 2018 16:22:20 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOGG-0007vT-K3
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:18:35 +0000
Received: by mail-wm1-x343.google.com with SMTP id g67so11837872wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FjGhPpG8sG9uBklMCJSskhFh/huEKC/N4BLQs4vEQZ4=;
 b=aqPbNxfJVW0/xjfottM/ES1pxezCOVjUQ2wAkUXTBOKqfUJUIK5AJ0C3SKuV3Ajp/Q
 CxaRLB/C6QeFwmz5BsgCj47v0HyyD6E7HU+nuNMaTkdIxhlkI9V4znXKSXCQc+MIcpBf
 AzffqZ9bvrC9Z5NgxF1OZ1gu431eOchzQvR94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FjGhPpG8sG9uBklMCJSskhFh/huEKC/N4BLQs4vEQZ4=;
 b=DcdukvVCfO+nXrne/ePYgB3wPnMJ2+BxfnlthYMY8Wg2O/WvDUdRF83ozbgh6bYOSK
 cWg/C78oAkbbWV7k5TC+AvmrUqatO/gtQzNz3r2irp91GjmrCmx4Nn1rtnVQndjDfJPb
 LjrJPZFiy6h775ajsfSDEqtmHmAxj8X/piBL0CdkvInDn16xfmASgmoUMYHQ6V6O50Sm
 Qk033EQJSsNve8ut8TglrPH0F4PhryyrpwA2QiQfXU73rKtlGPuWFHynNnRnLC1GI6fs
 2Ml9z9JXAqAKGXNpVHn4JvjGYTMQn/P02NuVRT6jT8elGzRjEJIxIbL0mXMpwZ39yTJr
 eCaA==
X-Gm-Message-State: AA+aEWZpleVdfy5YJykXIjLkIByU6YOv/4XqOoSO8dk2gg7AwXtuKy5x
 TUdehRkdmUiVfrJYYOfAQA64Rg==
X-Google-Smtp-Source: AFSGD/XofnVFXaIamGKZrCl8m9R2W57jrmtIYgZOTKF+Z01pEg48PsY16QkLyN3oPdocX2J4piqR4g==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr10923948wmg.55.1544458693211; 
 Mon, 10 Dec 2018 08:18:13 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com.
 [213.198.162.59])
 by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:18:12 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 17/17] arm64: dts: allwinner: a64: Add DSI pipeline
Date: Mon, 10 Dec 2018 21:47:29 +0530
Message-Id: <20181210161729.29720-18-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_081825_168327_F184A525 
X-CRM114-Status: GOOD (  12.37  )
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
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The A64 has a MIPI-DSI block which is similar to A31
without mod clock.

So, add dsi node with A64 compatible, dphy node with
A31 compatible and finally connect dsi to tcon0 to
make proper DSI pipeline.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index dd5740bc3fc9..dd5c7ad55149 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -344,6 +344,12 @@
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
@@ -910,6 +916,45 @@
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
