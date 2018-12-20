Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93405C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:55:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3CE2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MjuBX4Sn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KuwjOwsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3CE2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eb99a/fcFfP4br8vZiiZY1EpIbzUXe4UnL1ZSfr+SFc=; b=MjuBX4Snm4Mro5
	nGih7bCx5graxN0BCLAR5Kml7DB/aTeJMHpUk3OMKWeKWktebs9RCBwCpWHbYV065Qhxeuu8zMyNW
	t3EgFs1LQOCDxJSU8UDKFi2Fyr9q9eH1sMvGCpKGYqblJxg+/bUiZ7VI5mh3h9q9PCuZPOVlcKa7h
	a2k4cHn8an4XqGPUnX0A23sE86UtAzvtTem7AdK7eb56pPk6kOVHpBiryjEzRqimRMtyeYje47qt9
	cPU1LoIpO5o1JTYop4KaG4SZMKaxP/PpD9iokYPdpeeIp0SjFCZhHrhq2rrP3hoWkrwAQ9uMN9PrY
	RB2G6RLDFSHI3E4rDJVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZxrS-0004ID-SD; Thu, 20 Dec 2018 12:55:34 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZxqu-0002g1-Ko
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 12:55:05 +0000
Received: by mail-wm1-x341.google.com with SMTP id p6so2062020wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 04:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i+sX38c9cSRrT/+P6z3U+yEFrwV+FCNRU4fj085KJck=;
 b=KuwjOwszek352TtFJBBl/n/MzUH512/y0qTe+7lojuswGP/Lv1jUTJ+XBHt+h1OjXC
 Tkidz7Ho42OTctg0z04xNW5UbNEPscNSxUV65OjfFECCb3QGy3mQM5wO+4DPkeYcvjZ4
 MqjQ9TS0onrxr8FvALPrJ5IwcnL33MRBhTXk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i+sX38c9cSRrT/+P6z3U+yEFrwV+FCNRU4fj085KJck=;
 b=mt1lBk4s7dS8nG0oiYE3CpEulF3eHiyr3yqvcowXbJWgYHFRNNzHM8jI8yakc12t2X
 4EOsY+sYxABM2n+C+ns+gM4W8NJwhY3Td249eAq0ydQmCFSU5fziZmvDlV53jblG9hKO
 GIJoL9ljhyrJ+2UyH9TPFHcRnFKeWte9Om0jMp2ZXSKfPyv4Lm7LvGVBE+5oAXRzsp4i
 mKWD6VBzq11fidhQDuQgyj1VQp7nse9+Q+7EsG6Bkel4Ws646odn/ZixT7tx9XX9CjDv
 j+wuEHOyQT8qySTS61cLubtzGc+QQ2D5yW2WTSlzFFKbOHCMRqjcmaM6iXnzw5l7q9J/
 iV4g==
X-Gm-Message-State: AA+aEWYp/Diu6TPFbCIFR+XmeGgNoQwNw+xu6eHDAE+T/YJ6oZcvN3gp
 MvRpPgVKfOnA5ho2HI853HsjEZKp7Vg=
X-Google-Smtp-Source: AFSGD/UrUUuEeGEqMJRANi0h2sU7UVGWvEG7qvhB+ZIFZAHUbiColEvrk/bJTB3CDLaWfH2J6q5zYw==
X-Received: by 2002:a1c:864f:: with SMTP id i76mr11106358wmd.83.1545310496157; 
 Thu, 20 Dec 2018 04:54:56 -0800 (PST)
Received: from localhost.localdomain (ip-163-240.sn-213-198.clouditalia.com.
 [213.198.163.240])
 by smtp.gmail.com with ESMTPSA id o4sm8732756wrq.66.2018.12.20.04.54.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 04:54:55 -0800 (PST)
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
Subject: [PATCH v5 4/6] arm64: dts: allwinner: a64: Add A64 CSI controller
Date: Thu, 20 Dec 2018 18:24:36 +0530
Message-Id: <20181220125438.11700-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181220125438.11700-1-jagan@amarulasolutions.com>
References: <20181220125438.11700-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_045500_684842_74FFA256 
X-CRM114-Status: GOOD (  12.77  )
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

Add dts node details for Allwinner A64 CSI controller.

A64 CSI has similar features as like in H3, but the CSI_SCLK
need to update it to 300MHz than default clock rate.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 384c417cb7a2..89a0deb3fe6a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -532,6 +532,12 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			csi_pins: csi-pins {
+				pins = "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
+				       "PE7", "PE8", "PE9", "PE10", "PE11";
+				function = "csi0";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
@@ -899,6 +905,20 @@
 			status = "disabled";
 		};
 
+		csi: csi@1cb0000 {
+			compatible = "allwinner,sun50i-a64-csi";
+			reg = <0x01cb0000 0x1000>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CSI>,
+				 <&ccu CLK_CSI_SCLK>,
+				 <&ccu CLK_DRAM_CSI>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_CSI>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&csi_pins>;
+			status = "disabled";
+		};
+
 		hdmi: hdmi@1ee0000 {
 			compatible = "allwinner,sun50i-a64-dw-hdmi",
 				     "allwinner,sun8i-a83t-dw-hdmi";
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
