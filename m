Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3714C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:45:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA0721726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ifazHC3P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lusticky.cz header.i=@lusticky.cz header.b="haxZlftE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA0721726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lusticky.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KmUxgXNIGczJvpgMNZlsyX5tu5KBzN/alCUaNCaKezA=; b=ifazHC3Pq94FwS
	IhZ8M/ljpmvjpBRWPIxYdtK/s2pVKme5oHEDv99yeiGhJCHpbef/gEhD5oJ0+WblTDvBzlXBCI4op
	oHND3ZvW4r16TgqtFP535wcrelFJfNUFWmihQqk3/bsWrhUG0cDAPisbkk302uEvXhFM1ZeM0flOX
	+MLNKanCZZULU1MYOe29Zj35XwCIsUsFgq277AKHR2ieudGWY+8EAcoS6RUFxYOpqJF8JjZVBynVZ
	FHyvMieLu8jqeJQu+yo5SHC6ozfQm8NXROqcjX793fDzHf4HveExSzNm+eyGco57DB4TXquVz65KW
	VDWH1sxJDnzX+m3bcwxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmF66-00009A-Lq; Wed, 23 Jan 2019 09:45:26 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmF5C-0006hb-UB
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 09:44:41 +0000
Received: by mail-wm1-x343.google.com with SMTP id b11so1302510wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 01:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lusticky.cz; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LAyE9iplVxZlfV0e0X7xILlXZS1umg4YVqUoUMI8JD8=;
 b=haxZlftExW2dM07CSQE2YQZPwDB9dTcuR9inAtBnH5xSFrXbGMBAGIxP5N805z8fR0
 P4VvzXcfTPtAB8z3DenI0cXwt7QCx3SLN3MCd7tuKMB/9FjkesJ8wtMmwaz92vh+Wvt2
 McYYaZ13CFHmT15U1t0ibWZMNMJODbhsUWGcJKkG1GLAP1BoZ+9GFBJHZ08ossi+NNHl
 a4oA9yqlYBr7es4+wAO7xkkW4l+45gCuFy6iHIY80Akzfn71phr6YUqclajb+6mcq3Dp
 9y6DfVnAkfKpvPZ3JS6GGOyPZ0V6ZBJBjYRuFOQ7LqkFCikqCecAr3Vnu3nn5VskN484
 iGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LAyE9iplVxZlfV0e0X7xILlXZS1umg4YVqUoUMI8JD8=;
 b=QN1PoSEtz3HCN3JkDCgntwbYZxtozzoCajxSwVDFuxr51yR+3hk0VWjMWUoMPV5Frn
 tB9TqWqUMQxbMraGo74Ue28xTPzxG6uS78GLg4YvxfRnOEgfFT+arK86WBuRr2ApDFiD
 cK0sxYpdg19Xs8JxEcIHNv/STV6TPvVFbeQszHMK5RjKtAFuJnQmH2wUoTZYbZGu/dDw
 uN9Tdym+zxInXjWSSVZWk0NEPO+sNcAOlPSVn/rlIfc+Wvnh9m6wclaLS8+59cscTn8d
 JP2oA5RB7Xy3UgpTK0j2GWMLklIrMHU1XE/vN5QygHJ0bnPrSWr3haih5/w6jGCQ5OeL
 mxEA==
X-Gm-Message-State: AJcUukcXEbW6GL79FoQnWnNQ7Bc+sRov+6xv8vgvUw+25DOph4SbO+CH
 MFCFJNvtd2DHl6ER/sm7SEffwehqsy1ruw==
X-Google-Smtp-Source: ALg8bN7qzYemx/0fcgNY4WFX47yLhGqZsLCJHDl6yK1yFYNCl+LOlXoIp/0U5nUWnwJzNJOX7h2sGw==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr2067726wmz.8.1548236665768;
 Wed, 23 Jan 2019 01:44:25 -0800 (PST)
Received: from e430.riomail.cz (188-175-152-238.client.rionet.cz.
 [188.175.152.238])
 by smtp.gmail.com with ESMTPSA id y1sm71939131wme.1.2019.01.23.01.44.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 01:44:25 -0800 (PST)
From: Josef Lusticky <josef@lusticky.cz>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] ARM: dts: sun5i: GR8: Add SPI2 PB pins
Date: Wed, 23 Jan 2019 10:43:33 +0100
Message-Id: <20190123094334.11030-3-josef@lusticky.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123094334.11030-1-josef@lusticky.cz>
References: <20190123094334.11030-1-josef@lusticky.cz>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_014431_681894_A50A38B7 
X-CRM114-Status: GOOD (  11.05  )
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
Cc: maxime.ripard@bootlin.com, wens@csie.org,
 Josef Lusticky <josef@lusticky.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a separate pinctrl nodes for the SPI2 pins on the GR8 PB bank.

Signed-off-by: Josef Lusticky <josef@lusticky.cz>
---
 arch/arm/boot/dts/sun5i-gr8.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-gr8.dtsi b/arch/arm/boot/dts/sun5i-gr8.dtsi
index 98a8fd5e89e8..a26a6a7d7c6b 100644
--- a/arch/arm/boot/dts/sun5i-gr8.dtsi
+++ b/arch/arm/boot/dts/sun5i-gr8.dtsi
@@ -119,6 +119,16 @@
 		bias-pull-up;
 	};
 
+	spi2_pb_pins: spi2-pb-pins {
+		pins = "PB12", "PB13", "PB14";
+		function = "spi2";
+	};
+
+	spi2_cs0_pb_pin: spi2-cs0-pb-pin {
+		pins = "PB11";
+		function = "spi2";
+	};
+
 	uart1_cts_rts_pins: uart1-cts-rts-pins {
 		pins = "PG5", "PG6";
 		function = "uart1";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
