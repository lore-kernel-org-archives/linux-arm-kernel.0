Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD337C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:27:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBC220851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dRFjJ/pL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj+80Ode"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBC220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DRQnDsWDBCaCaukcXWELd0SpkuVprGKhxh8yF26btpI=; b=dRFjJ/pLYJR8NMzKzx/gNDK+F5
	xOSe3LGvSRVC/M+4JvYkZgg74jEo2UgFCroH+vMHxd2LT/hznxzsF0G134xQ+VRlWiHV19LkSoHKU
	fD2aEfpCN+3mkiu752/opruSPAkYo+updRReJoaKpQWRK+asGn8LX46Ljos7qZX9FsupI5z27kHCw
	r6Hkr/+/OarMcUh+AI2kpLJQzVnT5BsP+8VEYxy+8m8ZI8ZT+CWaXyiRndNlwwGD3XRJcEOA0314H
	J0WbfAxt+YtJ+IWtcGT+53BVPw/b6oTeI1a/HmaD2OVjL4sgbSV1WQ4GHUjv0VkMKcZovTlnT/R7D
	ptorhPIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYKQ-0005nJ-K5; Sun, 02 Dec 2018 20:26:58 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYIB-00020r-7u
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:24:45 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so10059453wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 12:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tGbSsIW2SbVXCg2177J/dhUcc17dCh4iHBqaTiJQmZQ=;
 b=gj+80OdebSSVq5nefzz3NW171uHq85/iL3ZzgkH8altvMKjQqGTaQMu4z+nbvSKCPP
 4A5kkAhOzJOf8PYGQmDfVs1PRDVJEne2d965qhxeMJtv3qY7+ItYIkzom6S2qvokP3tR
 wpDr0FIo1k7F7fK7Nm7svwptMgykTa5TeBzpuv2wRsIvzC0xjWZU1LEWp/31yVot3/+T
 t1+rCWJeIQHxYm1izibJAkZpq7l1m74z3v+GoqUVUfwRZsttzeOz5cnbL23PthnFu8HY
 HAKTaV9IKPYgi/OUuzIoyJOGC2CHPq9o+bHh0eNrHWcCl+vvO6uGB2APN1Ig+p7DOLPK
 ZTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tGbSsIW2SbVXCg2177J/dhUcc17dCh4iHBqaTiJQmZQ=;
 b=lwxQTuDRKzLYMlK3bqvGcoLAI46cd2DnH5vvS2ZIX0wvsUP47ni3QIoHT3X7+WZ4VL
 ngWBe12f34IXL/wmGyNm+ym6aLo+8YNMutUYpcUnha0JE2hV2CYatUb1ymHZAglY3Ynq
 453jTb5hGbmr2UC+aLCebo56OdqxkH84lkTM2HaKlbSKuDTMwqhiob4Gd8XSHhu0tqEe
 GhFN0pfUB4Tn9F7Ba4EkqTLH801uIsZQWjHpUidG6tCOur84Ic/LTt0s1TAdTKZ+sm28
 Y11CJrPgwqAplrCAdeit8ewl4aS8/2zqI05MFL8+tSKoLxLXR6IIUTf1fy5iwxBohxTn
 nxtg==
X-Gm-Message-State: AA+aEWbs577+tL9Vw9lXxGtZwH8Oo9IuOw8nReHDV+k3EeT+BBNhbldk
 nvEXU7UL+YCsKHapf6+nFqI=
X-Google-Smtp-Source: AFSGD/UDZGcVXa7xLpVupO30EWsZ/e6ViKVGcMCI0S3Z7YAkyXlUSnC2Lcb246MQfkxU4uJgO+N8cg==
X-Received: by 2002:adf:8421:: with SMTP id 30mr12119622wrf.153.1543782267898; 
 Sun, 02 Dec 2018 12:24:27 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
 by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 12:24:27 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v6 10/17] dt-bindings: pinctrl: Add Allwinner suniv F1C100s
 pinctrl
Date: Sun,  2 Dec 2018 23:23:44 +0300
Message-Id: <9e222e14e31fd28fd5400d50259f77fc89273f5d.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_122440_458410_7D1507B5 
X-CRM114-Status: GOOD (  12.12  )
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

Add compatible string for Allwinner suniv F1C100s SoC's pinctrl.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Patch applied to the pin control tree for v4.21.
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 258a464..a7f7133 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -29,6 +29,7 @@ Required properties:
   "allwinner,sun50i-h5-pinctrl"
   "allwinner,sun50i-h6-pinctrl"
   "allwinner,sun50i-h6-r-pinctrl"
+  "allwinner,suniv-f1c100s-pinctrl"
   "nextthing,gr8-pinctrl"
 
 - reg: Should contain the register physical address and length for the
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
