Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FF5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:54:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7338120859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HMM4EFWb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y9L8sBmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7338120859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=34ti0aW0wkihjH7799Q2dnyMEMGXWrJyI8gNPIgLf4g=; b=HMM4EFWbaFK3RE
	ZigDB55x5Kd0bnIYBJGTz4JpLgOtNBKjjc9APH8kV0l1fCipgTXAh59J9xsozE/F149cK+9twss75
	EIZ+kWMNypXALiRtxR6a0jtIa/iLak6/kh16qyE7jBEmGoRBi5z3W//btYLJ+CExZSF5xh4jT8Ud+
	WvWphDy/jusg2KP1QeeM8WL851TCP9jmD/NE1balMnMFqyZ8FrEbX1PnmT86NmhQHRMYOj5s94KdF
	nUTxmaxRU9ZbGrXxGkIcSDyamAmTgbMx3VcOiZQ1DsHfgmyo+7pRAIt3ATIqKNSBpOZfZ/a7sVmFI
	6IX2YhbU8xAjUNWfYgYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggRbZ-0000pK-5Z; Mon, 07 Jan 2019 09:53:57 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggRaz-0000FD-Kf
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 09:53:23 +0000
Received: by mail-ed1-x543.google.com with SMTP id h50so261591ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 07 Jan 2019 01:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7SKzOiXnEB8V8kNaFY7oKymTvoiedc8KfN1lhPOUJLQ=;
 b=Y9L8sBmEUN0ssnruN1jgw0AIE0tp2H1pffnw2gT/arl0ktarhfuXwpE1/QgyXQoMQD
 naiDwBew62y9TlHWhboXrcpQ8pMhwGkV/Sfc6N6TJiftPc+BtMupzxtIeC7g+YlAAnHi
 B2vs04jImVZ96RoUJopKX7Y7JeMmjmnocng2hrpKR+peOKqRpMeyTSKxemDGUZsx0dn0
 bagXDRaiqNWVB+xJriYjRRzg9N6uk0DeiPiDnxEdYPl73lXmYI8WVUdydVAsAdBiVIpE
 +8x5IEePR3U7YFwNH8RwuFKehhuNhnz1KvUuuaXuaAYPi/nPMxeNdcGKbgUCGD7gWjet
 2hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7SKzOiXnEB8V8kNaFY7oKymTvoiedc8KfN1lhPOUJLQ=;
 b=j296aAMLLHdB033gmoeaeMOGaJgu68YPzW2tIrlW4Vkqdgx4VciFKspGqonCw9UM7h
 jktIJlVwSDo/BYcsdIlBMojpDb4x37nqwFJren8QYZe6Ik0VSaNxKV/HfFA9jGRF8Z7f
 0jfi7pLZjeyZYEc7bbwhHmS5Om8pA06IO0GUDYyMwLGTDZTINi5NhmDzSg+y7bqICZjV
 hf/ZoMbSillP7S8LgPNrm0pT4vDe6oihMTeGOcxTwSkm1uHUVG2z5+llcpCHNBdQKV9J
 cDCUebKGX5lXXPMbkp0V1OBbI/muL5tRCO3PD82FeJHqX26VKryHjqZnhV3nlyRMV8fV
 04YA==
X-Gm-Message-State: AA+aEWZoqY9hbWvdxa7ZdoilX2Ye8PJwU6qEOEV500jZ9IG6jrO8tiTm
 rxJ1QRotiaB1YA+QMdnlBVIhoi3vg+Vhng==
X-Google-Smtp-Source: AFSGD/UouQf+f6JhSLbTJ6InMkLtv/eLnEguNHKAaQBHw2rmmmUtjEgi9dofj3ItJ8A6Of1kOqDa5g==
X-Received: by 2002:a50:f098:: with SMTP id v24mr55022704edl.78.1546854800261; 
 Mon, 07 Jan 2019 01:53:20 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr.
 [85.68.183.99])
 by smtp.gmail.com with ESMTPSA id f6sm35737049ede.53.2019.01.07.01.53.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 01:53:19 -0800 (PST)
From: Maxime Jourdan <mjourdan@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 2/2] arm64: dts: meson-gx: add support for simplefb
Date: Mon,  7 Jan 2019 10:53:07 +0100
Message-Id: <20190107095307.15233-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107095307.15233-1-mjourdan@baylibre.com>
References: <20190107095307.15233-1-mjourdan@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_015321_680201_3EFFF77E 
X-CRM114-Status: GOOD (  11.84  )
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
Cc: Maxime Jourdan <mjourdan@baylibre.com>, devicetree@vger.kernel.org,
 Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SimpleFB allows transferring a framebuffer from the firmware/bootloader
to the kernel, while making sure the related clocks and power supplies
stay enabled.

Add nodes for CVBS and HDMI Simple Framebuffers.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 22 +++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 44c5c51ff1fa..a6ffdbba37b9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -50,6 +50,28 @@
 		};
 	};
 
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		simplefb_cvbs: framebuffer-cvbs {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-cvbs";
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+
+		simplefb_hdmi: framebuffer-hdmi {
+			compatible = "amlogic,simple-framebuffer",
+				     "simple-framebuffer";
+			amlogic,pipeline = "vpu-hdmi";
+			power-domains = <&pwrc_vpu>;
+			status = "disabled";
+		};
+	};
+
 	cpus {
 		#address-cells = <0x2>;
 		#size-cells = <0x0>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index a7b883ced0a8..a60d3652beee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -784,6 +784,12 @@
 	resets = <&reset RESET_SD_EMMC_C>;
 };
 
+&simplefb_hdmi {
+	clocks = <&clkc CLKID_HDMI_PCLK>,
+		 <&clkc CLKID_CLK81>,
+		 <&clkc CLKID_GCLK_VENCI_INT0>;
+};
+
 &spicc {
 	clocks = <&clkc CLKID_SPICC>;
 	clock-names = "core";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index d5c3d78aafeb..3093ae421b17 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -787,6 +787,12 @@
 	resets = <&reset RESET_SD_EMMC_C>;
 };
 
+&simplefb_hdmi {
+	clocks = <&clkc CLKID_HDMI_PCLK>,
+		 <&clkc CLKID_CLK81>,
+		 <&clkc CLKID_GCLK_VENCI_INT0>;
+};
+
 &spicc {
 	clocks = <&clkc CLKID_SPICC>;
 	clock-names = "core";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
