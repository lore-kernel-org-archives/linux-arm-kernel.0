Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAA1C282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:46:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75F520855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xw5+76XD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T9xbKLou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75F520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jFHgN+iu5MyPabQmEf52OyONTPzSneJ/s0ek45oeh58=; b=Xw5+76XDTBk8Y2
	V6NGYUyudMajvzwMlFb/p/nWLXFYds4O2lqtkViOXFaOaM9WGiWZS4QiFg4OM5xhDgD1StwBqOHO+
	5my00yYIkG8XtRsX0vJpo3h/c3ovT84CMDl0fjPZT2uRiusJHtynK3q2IjkZOkM9s41Dgc25xlIIW
	hdHekjxMjK0voQs5yqsbFfS58D4RNVVyUe+FhmfbvuuZWAxYsG8xit6N54Ju5Ua5D4B88IaFNuWvR
	LqSUIu3gwA+HX9R8k7pfOksKN4iVj1wxGW9bmcxG/Inhaq6D8rREncuVqabdk0AHyfpc8kwJL1Qnw
	c7qqiodNfdoizBIjFXzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb1C-0006UP-QN; Fri, 01 Feb 2019 15:46:14 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpay9-0002It-OQ
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:43:13 +0000
Received: by mail-lf1-x143.google.com with SMTP id z13so5358840lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LwL9AwGWtKYUFgkk+kHgF189NcSW5g0gFHkQNio/TBM=;
 b=T9xbKLou+YYzTb7vsInTFQ4hJHJKIgaD6jdrOH/x7BqslOkfMjcR80XTmg5zuTRnbH
 J379SJC1zUanC/pjMN1iSliblVoSm5UcZRiouZ9eDOGbt1SjF5LSd4f4Oj681beyenSb
 XpAnZoqJb/w5NkTjk0Z5e0Clfcn9p1iJB8nOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LwL9AwGWtKYUFgkk+kHgF189NcSW5g0gFHkQNio/TBM=;
 b=lDymodmIBocDwmVVGWElLr8fjjDXn//2X9h2IU5rNWihZeprAD4xfPk/7acXrSywTh
 NPKzszmI8Qj0INe+PZ23unHLoj86nnoY04HlEw3LzkkywzfmVlBkbUxkEjkWM2PERVMD
 Z7FTMCBib7yK2m8ggBjE1ddFs2KoyhFq4SS1h91LqUDi59T5JTyn3QSwGI78dVqnt/vZ
 jfaPd3ucgN72GZk8MSrqWyRdOd9HFf0qCPkTJbKElhXptHW+KXhp7t2mr47Uo+8iOgL6
 1vS8uXmW/dUkUpAI5Uc8z3ROrwOUvKyNkgvaSKWqcE94gur7oBaY+biaxw13PlRmMKOr
 abjg==
X-Gm-Message-State: AJcUukf3NiYBPlHoyxJBc995U6d7SQVF5WXONs8Hmx7P0tKtWEjlSVUK
 f/BO82Gg3zhjhRIMPQjhlGFmrA==
X-Google-Smtp-Source: ALg8bN7W0afO2/5f8oyYpC6gy6IJMm1inSnlPS3TXUKEJJL4w7yiydvNGX5mlUum3341zT/+a7DOFw==
X-Received: by 2002:ac2:42c5:: with SMTP id n5mr22488995lfl.115.1549035784118; 
 Fri, 01 Feb 2019 07:43:04 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:43:03 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 11/23] dt-bindings: sun6i-dsi: Add VCC-DSI supply property
Date: Fri,  1 Feb 2019 21:12:20 +0530
Message-Id: <20190201154232.10505-12-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074306_637288_EE7172BE 
X-CRM114-Status: GOOD (  12.22  )
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

Allwinner MIPI DSI controllers are supplied with SoC DSI
power rails via VCC-DSI pin.

Some board still work without supplying this but give more
faith on datasheet and hardware schematics and document this
supply property in required property list.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 6a6cf5de08b0..1cc40663b7a2 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -21,6 +21,7 @@ Required properties:
   - phys: phandle to the D-PHY
   - phy-names: must be "dphy"
   - resets: phandle to the reset controller driving the encoder
+  - vcc-dsi-supply: the VCC-DSI power supply of the DSI encoder
 
   - ports: A ports node with endpoint definitions as defined in
     Documentation/devicetree/bindings/media/video-interfaces.txt. The
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
