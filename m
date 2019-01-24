Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A631FC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:23:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EA0217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZGJ1Qhr+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxSMfGsS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XX85W9JM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EA0217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TWe7p3O8nBjWTUbsHu8TlfOZ5UMmxjIkvhi+6DeSikI=; b=ZGJ1Qhr+QK0Eak
	uZjisgdE1PMK7E/iQO4kuRi3WrbIzZxG4dNzv6o56oxUbxf5z4/jkHTQPkyw0qTlyibAWhjOpfp6A
	wsESUBHzeeiZNopSFYlHulyfg9PYjl4mjWQN3/e7+I6k9/n5g/Y4K1WVSxf6qnomuAqi0InVKIdV5
	1hsMh//A7NdHSX3nPL4NRjejxt4x5G3hDwVr3pBDXf5ooZsG6D1AVWxEcEh3HW0uJDO0P6kHkNLrb
	PNo+NAyR/eF5jgZ0MtGKRdtWLKsvQfoBcO9HqU+BdCmAT2WR2MmjhohYYdE8/jC8TwD4Kfg9ZJIuD
	Y5j7jDqV1Tjb6QQovS9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlWV-0005dx-6N; Thu, 24 Jan 2019 20:22:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlPl-0001KH-Pc
 for linux-arm-kernel@bombadil.infradead.org; Thu, 24 Jan 2019 20:15:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gRegVC+JR56IFWmVyKDLRuzzRXdOa660M3yO267QTPA=; b=oxSMfGsSe679z2JuKZQWiYg4IZ
 yqcgc3XFXBmyVmatEl5flZWCCFTiXmnONNwznLGxmGYgENDZsevGyW2ncPQUvvdkvz+2EiftYq11y
 g35qGWU+H4Rs0b/JGQ+Mh/vHM7l1eWOHdD2501VcOzlEc0ADusoHJ5/8OpVD2R5ovWckpWmJj6vZK
 ldoXSjPgDwMZtIKTYpQOTT6mzZEpPatgxNOvD+msfUkZ6xYswtPn4EpkfI+k6pNU12lLwOURjNuMC
 WndZ+DKSdPFZYGa5HesrmMK813uVdlC1wNr/cDAQpXSmq3afq7w78r6hnoNFkqYmqvc/9qXY2I+9w
 mF2LEoWA==;
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlAm-0001ug-Ho
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:00:26 +0000
Received: by mail-pl1-x643.google.com with SMTP id u18so3380420plq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gRegVC+JR56IFWmVyKDLRuzzRXdOa660M3yO267QTPA=;
 b=XX85W9JM3QzoUOQIUKI7V8K9T+EZDaVppVDplpV+yN1RPAMtaDZrW/AyjORDOjI8R2
 oeVCvGNdLCTdca/8je/awH7tFatX6ja4JUCYXSCk0A7RlqPgtsbBRY2O68UN/0AVVcNl
 boDqEEXIrUS6d884VQIkLDAhxC0fi+LAMUjMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gRegVC+JR56IFWmVyKDLRuzzRXdOa660M3yO267QTPA=;
 b=qteP3f9FKKS4H7pTELVhw5yu/pOAISfvRymiCdwjCCRAHG/9afz7z5/kW1F2UaQNo4
 MHFYdYwlaUAhbxMFG6+PQPVmQARsd9UMqRtLAr1DDtOhL8jlivhD1rhyxGHFLnYrUQ7L
 gSZyrrlW9g+uvNHolAKYUk2yd6STNquynq8swHOtsH1WZAPZjJrtjCNTSZ0ki4JXzd9X
 EW0B/kJ8EUIAbt1AKATTUc1uri9rRCiuvA7nAy5aZap98JN5aUgPkUl0qkWvZtktwFfD
 Sg6RCaXPZIvAQ8M19C/JpyEwqw3rS87ssVeBitZz1/GfVjmNgKZJH19GDMD5dVi4BV0l
 vPSw==
X-Gm-Message-State: AJcUukfslvHzBWY62Pi7F9+S4Sy3mf+mlixiCFTyG8NXJNTkfQYO0yAK
 kYFpDCUfIN6Y5JkjZunnndzi8A==
X-Google-Smtp-Source: ALg8bN7GxiLQI9M5eT3P6PNQeyDSKSr75K/UljM/ECi4BQLWX9qt+fR+VTx5SODUcxnpR82iuSKXHg==
X-Received: by 2002:a17:902:584:: with SMTP id f4mr8117719plf.28.1548360022788; 
 Thu, 24 Jan 2019 12:00:22 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:00:22 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 12/22] dt-bindings: sun6i-dsi: Add VCC-DSI supply property
Date: Fri, 25 Jan 2019 01:28:50 +0530
Message-Id: <20190124195900.22620-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_200024_736199_12ECBFBE 
X-CRM114-Status: GOOD (  14.34  )
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

Most of the Allwinner MIPI DSI controllers are supply with
VCC-DSI pin. which need to supply for some of the boards to
trigger the power.

So, document the supply property so-that the required board
can eable it via device tree.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 6a6cf5de08b0..69e233e8fad1 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -27,6 +27,9 @@ Required properties:
     first port should be the input endpoint, usually coming from the
     associated TCON.
 
+Optional properties:
+  - vcc-dsi-supply: the VCC-DSI power supply of the DSI encoder
+
 Any MIPI-DSI device attached to this should be described according to
 the bindings defined in ../mipi-dsi-bus.txt
 
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
