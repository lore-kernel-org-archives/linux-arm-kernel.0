Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C19C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:41:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6192082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RfP3s5VZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sdNmOfjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6192082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=34ti0aW0wkihjH7799Q2dnyMEMGXWrJyI8gNPIgLf4g=; b=RfP3s5VZGStjGk
	eJSUF3r8REndGSdre2CgR65lNWjFM7ugKAlDBY11KaBXOYsLEw/HQ9QSvzipPMnjlr9ZojBST0Mc7
	efYGh+KUEpUXv3qKuckowgJ0NQG8G/V9GGwJIachxftzaOBx3KAYGwB12wMobWIntGX8yF781hdB6
	qdqWux9R9/c9VJBqjnmashFFS/1LXICF5qSHsSrGF1i3neJldcneQHfRS5a595VSlQhiIbXt2OSPv
	02VxQCvC8gpkP1wV16yA7cZ02vEtZhFkefwu5qe3uRq+4aGHsvDHG0m8TZ/CISSxQamA7r6qLvKpg
	fvrZytRyJNu9jhEoV6dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkVf-00013m-9n; Wed, 16 Jan 2019 12:41:31 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkV3-0000Rl-BO
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:40:57 +0000
Received: by mail-wr1-x444.google.com with SMTP id p4so6741773wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 04:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7SKzOiXnEB8V8kNaFY7oKymTvoiedc8KfN1lhPOUJLQ=;
 b=sdNmOfjysUBiHQzQOlVgU9thQydqg7F9721m/P1nntU/bI87Q05/SdSZPbtinWIhvw
 YB/cfPs/Xic9YIF45uUf0Ledm7NaJXEanw2hrwp/22RG8s4Vs8jYevkn10iDOtG6Lopf
 Gne5XMBYU1FJM1HrpznZnwRpjepE9EZu6Obyo2cUQnBg+Lc9D68J4D+cCEcDzD3b8FyU
 FwUFeDf7N7cgMixQhAFXhP4t4WvqmhtHcWbF1Muqk0X8j8ycwOMnPmwbMtd+c9n6tNwe
 nVSegEppOLUWzhYNRRe834fre/pmExe4UI/JivQ0AHnO5LGA6qVLWlKCb8qiA1mqFA2N
 doyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7SKzOiXnEB8V8kNaFY7oKymTvoiedc8KfN1lhPOUJLQ=;
 b=ZUiZSbj0FcvTzbYJJGVu1BqGfFcZRi6E/8k0ICfifeuAh3t8/3B5Jj8MS+Z0NZFsDb
 Xr4HUFvemrPlp0Ib1GTfKTQ5oKDg9fQg4ENEdsBsT2CFXDzOfhRbwxKhSW+h93Fgm6eo
 /eV7+lOktiSiu0Xokk14ZjWhgkajaEPQQCtNpZZDz5N5yU00VK25MvPz2lD3zFkFxgQK
 sBJvJVm3ZUYjYKwW+bOOlk6t2zlkQlBdxHX4UIkocLAeM0QRuF7spaQz1lrghcmaXVtH
 fIvmwSIb7fzA+Ovt5V0u0Hw9ufMWn0icxaaU/mYZEs7TT/QdV2rWRPdDPLZ8A34UWQzP
 i/DA==
X-Gm-Message-State: AJcUukc0OK/E+v7BpqbofPSB9JjrfUHJ8VV89QakcC4ppin/aDM+hFBd
 X+4K/7+xePooHcCT6jqHcLMbAA==
X-Google-Smtp-Source: ALg8bN6yLrI0OTJGtrbuy9q9DabN1JFPLpuKV1aLSXgp6noeMQiOcpXxpCoePzh9jihsnvankH7iMA==
X-Received: by 2002:adf:9382:: with SMTP id 2mr7302974wrp.269.1547642451498;
 Wed, 16 Jan 2019 04:40:51 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr.
 [85.68.183.99])
 by smtp.gmail.com with ESMTPSA id q3sm80304040wrn.84.2019.01.16.04.40.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Jan 2019 04:40:50 -0800 (PST)
From: Maxime Jourdan <mjourdan@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v3 2/2] arm64: dts: meson-gx: add support for simplefb
Date: Wed, 16 Jan 2019 13:40:30 +0100
Message-Id: <20190116124030.16882-3-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116124030.16882-1-mjourdan@baylibre.com>
References: <20190116124030.16882-1-mjourdan@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_044053_393986_C1F53973 
X-CRM114-Status: GOOD (  11.13  )
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
