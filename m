Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3022DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:41:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC56B20651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kxkRk1jM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LWXRqneI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC56B20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z7tJSj7Uhl6Wo/5Q+TsusRN8PV4Nn4TP5djge7z4xyE=; b=kxkRk1jMFWGDtF
	WfP640WOJfWg7YFZw5Mwa6ksMibpZeZS6iY0f74y9NMA5dbeGQ45Y7FPgM0c4gCNwcoTzyhyVpJLa
	c1XOPqIqvya6Bp/HbMQhyWFC/ZBM2sWeLuEiVWd4ckt/sJnfJD4BrBfqI3W0zfeRcEPZIZ9HIkRA1
	uCCjNUuerZEv0MiiFxSmu6kPEM2D3rOSLmZHJzvBaQWDBLF39Agtm7CpTuDuLLMs6HrHDy/cSqKw4
	xY7tDkYFWPnNZabyXiQwb0UvXJ54wJ5pkWNp1zeHSXqtwee4PJbfnbb2pFWek7uCmh+lApPvjJJXI
	y8OU3mdubg0wP8llEAWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkVK-0000kt-DW; Wed, 16 Jan 2019 12:41:10 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkV2-0000Rd-OQ
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:40:54 +0000
Received: by mail-wr1-x442.google.com with SMTP id s12so6766553wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 04:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eVs0Nbg/JAhKmVo9NPvM4dEM8xg5pTYJjP6q4kBu8To=;
 b=LWXRqneIHEn3vagEfIheY/sgCa2folY+5yVAgjQ/BSv7krw6Uvdj9MlyZWdR70RjFk
 ugHDUs/9WhZlpF8E4l1fx8bJ5Lk2qg/gdsd3MWZl2IbimJcep+h22DxKeGEeyCj+giq9
 7AzeCjNX7icg9s5/XcJf45kOtipQluNLoZ91sX6S4c+LIDnO1Qvbx4Xt6iI4QARNTQrN
 6c7kAgztheoEAUv/My6tk7izrhRaK6luZYP+bEH6VHTqHcoFsYDlbIOty6kYjDfSEuU2
 TX5x7qSJsqIZrWIU9zjRS0/JETcedbuz7hnz3IGcm/JcBoV4pvDhDtpAYR/m2KFj2TCx
 AKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eVs0Nbg/JAhKmVo9NPvM4dEM8xg5pTYJjP6q4kBu8To=;
 b=OsrvsiDvcdvgKWecWlog13vhc2QceEN4wCZ8T3zj60GfN178aEpqUqxJ070iFcSRSu
 VRA2ULrIJN/re2BTDBMamM+DTOAUwugjvzQ9yVC6Mi231hbw5Edhd1uNJd3FbAXFPH8u
 aSOrKYbs8m5RUCHvqZ2GoHt1LlJTbTymX7xj0tseEaz07m0pL9wQore9NPlqnEF5vQTN
 Yt5awBRvrle14AHLIJGdQy7/qBl/BP8CVMXONXs2FzDGdckfkioQQ+W8jPbFnFWWvOr+
 RT9PeeCZxwGydCIK12Qjx9J4Z2+s86vpV+QdS83pPpaKOdBm8LSmfjdMN5azznyX92rB
 K7Tw==
X-Gm-Message-State: AJcUukczPI+urVOwyeOmmfzvNyIK1Omuze+B+Vylj9dJOaaKJoWH+GsW
 lNbcxdQFzf79uCxE/Pc+uaJK/w==
X-Google-Smtp-Source: ALg8bN6ZKAuWqrOQJP9AIpFjvad4/9NfanEv3nTCFZZVz9nZ1zMrWPCOEo83+0jPTXEvWUpwY0OkYA==
X-Received: by 2002:adf:ab51:: with SMTP id r17mr7460441wrc.62.1547642450280; 
 Wed, 16 Jan 2019 04:40:50 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr.
 [85.68.183.99])
 by smtp.gmail.com with ESMTPSA id q3sm80304040wrn.84.2019.01.16.04.40.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Jan 2019 04:40:49 -0800 (PST)
From: Maxime Jourdan <mjourdan@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v3 1/2] dt-bindings: meson: add specific simplefb bindings
Date: Wed, 16 Jan 2019 13:40:29 +0100
Message-Id: <20190116124030.16882-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116124030.16882-1-mjourdan@baylibre.com>
References: <20190116124030.16882-1-mjourdan@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_044052_793644_54C5BEDB 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: Maxime Jourdan <mjourdan@baylibre.com>, Rob Herring <robh@kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Similar to simple-framebuffer-sunxi, we support different display pipelines
that the firmware is free to choose from.

This documents the "amlogic,simple-framebuffer" compatible and the
"amlogic,pipeline" extension.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 .../display/amlogic,simple-framebuffer.txt    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt

diff --git a/Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt b/Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt
new file mode 100644
index 000000000000..aaa6c24c8e70
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt
@@ -0,0 +1,33 @@
+Meson specific Simple Framebuffer bindings
+
+This binding documents meson specific extensions to the simple-framebuffer
+bindings. The meson simplefb u-boot code relies on the devicetree containing
+pre-populated simplefb nodes.
+
+These extensions are intended so that u-boot can select the right node based
+on which pipeline is being used. As such they are solely intended for
+firmware / bootloader use, and the OS should ignore them.
+
+Required properties:
+- compatible: "amlogic,simple-framebuffer", "simple-framebuffer"
+- amlogic,pipeline, one of:
+  "vpu-cvbs"
+  "vpu-hdmi"
+
+Example:
+
+chosen {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	simplefb_hdmi: framebuffer-hdmi {
+		compatible = "amlogic,simple-framebuffer",
+			     "simple-framebuffer";
+		amlogic,pipeline = "vpu-hdmi";
+		clocks = <&clkc CLKID_HDMI_PCLK>,
+			 <&clkc CLKID_CLK81>,
+			 <&clkc CLKID_GCLK_VENCI_INT0>;
+		power-domains = <&pwrc_vpu>;
+	};
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
