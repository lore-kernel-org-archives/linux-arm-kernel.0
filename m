Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE427C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:34:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934B820850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cIyaljLS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="D+3a8+d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934B820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fU+BgW+nkS9EOw1IZpYvePEQqMgjVzt2N35WmN04GyE=; b=cIyaljLSwJ13uG
	kNaXH3uVSrA+EiwNcEIFWxI6ju4LyA9PAtYnVUQZ7kqKP0Uzt/Qo8w62RKejeZWc/GyxdanG7oD2k
	YlDwLrty6XrHGAsjqWaimNW/B2aRGLUkS+BZdweMJVlVB5re6I5LxumFye6ByYZPFF/6WwFc5Ngeq
	DwyqwF3t6xVlKoCBt4hGViiAIhfA/SjskVs1peffcFO47FHoap6FLYoRA3nmRWAytjWLnMISDHFmq
	8yvs358W+Z2fKMWXAlJgamOiAXEDZq8e29dZVeEf+W1jcwakDNo/puSF7YzJNHzVnQ3/QO2BMmg16
	onHLOFjCzIwLJHNodAmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkX6U-0007Rp-VA; Fri, 18 Jan 2019 16:34:46 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkX4I-0005Q1-Vv
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:32:34 +0000
Received: by mail-pl1-x643.google.com with SMTP id w4so6586851plz.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 08:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/BsYwI4MGKscqtd4fapjUVq4zzWRiadQNZwYTiXxWLI=;
 b=D+3a8+d+1MT0h2pdwphXLRMdk+66om07H04tXs+3CLjVZU5A/QqhvuGH2u2cPnResn
 gR05lHVX9lO5yh4MbmYCbxoc2huvjEh9leunG39Xo7y9wF/5DU+Aa+FloS0CqVC2OhG5
 6rhGOm5aYKv+RBykV4dAm7LPJDVHQPtyIavZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/BsYwI4MGKscqtd4fapjUVq4zzWRiadQNZwYTiXxWLI=;
 b=uflfKp4wUYBgpNXyPZuiqyAzXfCW+SgOHS+45kS64Avt/GusJAhkewaF3RnV88WLol
 pQhlOhwwVPEVzwTi6C4z7C9/xs4C5eQxTtO1lgzV4kKwrlfUNmFE+rvdyNyW5TtxHSEY
 +qMkkSiooH4Eue6ElwYQFxhcNursrWK5MtgZPczUjaR4/lddsvV0i6w0g4G8oPllkGIF
 SPap6YnnANQgEszIFIblg+4EZ5TCVEkt5cm0IGzExpvtdLhu4eq8YP41KEeqbB0HM1lq
 US8A2yUoNHKhpddjTpywBWQwzGhoCo+mah0mpxvEXEqNc3bfk7STL/1kUj+T/jQQkAA9
 CPFw==
X-Gm-Message-State: AJcUukcEEk6CghGB453EFQeE89tK3L7Po3GrcmVOlFxRU+ohVtguLm52
 ptJla6ly7A/itHIxrPW5ON6/tw==
X-Google-Smtp-Source: ALg8bN6mvpQp3YAX6GkW1M5KsfZsri3zQjDYciQGsdE6EzPzxtCuG2Y1UzZFFrJWaw+8/+vUvRXvkg==
X-Received: by 2002:a17:902:3f81:: with SMTP id
 a1mr19680460pld.258.1547829150371; 
 Fri, 18 Jan 2019 08:32:30 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
 by smtp.gmail.com with ESMTPSA id z13sm13967086pgf.84.2019.01.18.08.32.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 08:32:29 -0800 (PST)
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
Subject: [PATCH v6 5/6] arm64: dts: allwinner: a64: Add pinmux setting for CSI
 MCLK on PE1
Date: Fri, 18 Jan 2019 22:01:57 +0530
Message-Id: <20190118163158.21418-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190118163158.21418-1-jagan@amarulasolutions.com>
References: <20190118163158.21418-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_083231_413189_21C9B1C6 
X-CRM114-Status: GOOD (  11.49  )
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

Some camera modules have the SoC feeding a master clock to the sensor
instead of having a standalone crystal. This clock signal is generated
from the clock control unit and output from the CSI MCLK function of
pin PE1.

Add a pinmux setting for it for camera sensors to reference.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 89a0deb3fe6a..dd5740bc3fc9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -538,6 +538,11 @@
 				function = "csi0";
 			};
 
+			csi_mclk_pin: csi-mclk {
+				pins = "PE1";
+				function = "csi0";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
