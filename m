Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED43FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:40:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFC020834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aA2WXdtt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9iKNK98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFC020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=1ut95PfJJD/aK+R0h+49Zy4O+9eERlw0dUF6mFJkeqs=; b=aA2WXdttHOe5pbp8SCm+8c0hbm
	oDd7Wjv3ccMau48NdZpOolL1+AybdgyLD1Ts8XcZK1TenvaACtwhk4ZxbsqnwWepT2HMsk/FvgdWi
	kDXG0YWP8OaYKu5lm4oTL8J2RFf+7uDlLIrzLpB1b16+XfDs+gbQaoM/pmTJ07CCvshKnnj6EBS7G
	rk4NuoO0CgcAR4W8OUEzaNCwNpyBcugug65+oYGchV//C4lTG5gQ5aNAmNAddHT+4rf5WwnvBYRxh
	VAB0xMH0dhDLYrFFf9BiDTSIW41ywDzNqwxWhSBKL5n5pHmdu93gX+pVzBQUoONr0HzW0/GDMP4Wp
	6YrWHBMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYXH-0003ts-Jb; Sun, 02 Dec 2018 20:40:15 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYHz-0001wh-FY
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:36 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so10059217wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PqiSTLwl5WXrDtWtjcIXDjRJSUqIIl0Us7oauuCOk9k=;
 b=e9iKNK98m11pgSa/BPEv8VvGiLNUd1ZlXI9Y3Yo90vq9Fjau0IsbrlkKLAeu0ePix1
 W445CLoeL3/XFiA6y64V21KVljl/vZaMyuiufxyZ8Oo1P5QEfEE1Lfqavavq+2iHOZVG
 KUSvcEX4jqDc5zfzRZnX1zBJs4PTUlkOmSecW/2iMAaMOh7u4s9TaxkqyhJoQ+7w4DGF
 WPSbBnoF2vVg0lOmhWKIO1x/C/AERgYpPQwuF5WG9zrOwCDitJlJ5xGMnbgi+WZMhJ01
 WxlCaKSEXITINCZXxTGGJfU9ofzk1JK5DnTjkUo0JTZouA1PIUKmiS1pEwhYNCktqwkr
 n7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PqiSTLwl5WXrDtWtjcIXDjRJSUqIIl0Us7oauuCOk9k=;
 b=Y/YDzPWp4N5k4NTQ7i88hprI/fTQp69GOLUxcyOkzpDIxYS2hbpV6FeNVfTspOyxPn
 eovK+s8rJyNAcAEufYvXaDM3/MOdrOdO+gPZjGxcsWlDh+Xuzu4zbm1y0PQF3SQ5//UJ
 UcZUTj4loD9GCndP7arA0dVQYqLs61P4LtK48pItHw61oGtKJU8WFXZxerB2YgAVTJf2
 fDMwyf6Vi0YO/okf7HoLsqMT/dS+BYSpGPreQZ8hee7N1sO0T01UsOy71/rr57DRw7tX
 N0/pU0sk2DSaaS4FpfFjc148UB6WAV7DGCYYY9aU+4xi3TMhrekgEw7ONmXmTOQvpK8J
 YwcA==
X-Gm-Message-State: AA+aEWbZyNAfCoRPfQ3I5HBgrI/IFhb5NmU2dpPiRZmZHOiAbtB2GBhb
 2WNKFwU421BSk/cfKAmqHuc=
X-Google-Smtp-Source: AFSGD/UqijtIBCI4InCgJ2A+px76jgUgOs52e/O3u9GKyFEmb6OwmrQkEnOqP4xOnrZx74oUzsLkhg==
X-Received: by 2002:adf:891a:: with SMTP id s26mr11571267wrs.44.1543782257366; 
 Sun, 02 Dec 2018 12:24:17 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:16 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 04/17] dt-bindings: interrupt-controller: Add suniv
 interrupt-controller
Date: Sun,  2 Dec 2018 23:23:38 +0300
Message-Id: <0d15ef1e424f0f9627b4e278273c7e77239869af.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122427_559933_0FCDCCB9 
X-CRM114-Status: GOOD (  12.86  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Marc Zyngier <marc.zyngier@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add compatible string for Alwinner suniv F1C100s SoC interrupt
controller which is stripped version of sun4i

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt   | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
index b290ca1..4043525 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
@@ -2,7 +2,9 @@ Allwinner Sunxi Interrupt Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-a10-ic"
+- compatible : should be one of the following:
+              "allwinner,sun4i-a10-ic"
+              "allwinner,suniv-f1c100s-ic"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
