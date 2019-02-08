Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3135C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:43:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805A520863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P0gDgHD4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CHEhOsHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805A520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tsci1EIWXxYNlr1y8om1V5bV6CO3AbbGU717LMtDu8c=; b=P0gDgHD4Mk2e2q
	3/NW4Hmj5gOifyw49LnHLSbDC3mfg5EolopZF1HDgIrgn3lIgQTBZ9X2WOLp7vyKmzqJ0sJHFCtUK
	C7Ofh5EuKbjNe5cR5WJwqt7JcT+wGGhds3NkP8CGGhwTEkuOOebNZG5mn7IiWUUuhKjgRJikuCptM
	Dbm2qQLQYGCfpNqnbiMjts72D1SnwevL2fypaPfDVc6tSl+FC7GlHl2PZAF+tKexnV/ir3kEVXZ/y
	uuGG3XCoX2u8u0VBpTyQqShsiIER9TphyoCNHP4h0J3oWHy7mbpTOXGwQPCyziOrsXQTQWGTBmteW
	Mt4wvu76pegTOACSvQeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsAAw-0006uP-FM; Fri, 08 Feb 2019 17:42:54 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3v-0007YO-Ux
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:36:06 +0000
Received: by mail-wm1-x342.google.com with SMTP id v26so4298740wmh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7gYlfZ8dUsAGabZoJfnAkrezi2SLK3ltNashAmxc40Y=;
 b=CHEhOsHabB7Q+6g5PY7G1rt2tDzK2yhHLHGcseDpNpkQ6wqvMxrT9x40ZBku6JOaF7
 UmYugNCiguchqLVd6zhJiOQy3y0sfK8L02uNTBy34eLKTIxwWsS4cxg1SeRLd4MhQ7Mo
 K8B8drtKOWqf5Qn3dPeD78FjMdicMl6TwATOuP1Uy8kiLYzHM4I8a/4RL2EJoxUuYVYb
 YbJ2wzY+zhb/JzBxfYlRAZWKRbxH+Dbob5BS25oRhGRvS3QzggBDro8yZEgYsVsydZJ0
 7uHcgvi/SLljW6Yzh7TYCfHUkfjBrZwV80S6sv9C7OFCf1T8DccimuSl2K5eSPYnb51k
 BkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7gYlfZ8dUsAGabZoJfnAkrezi2SLK3ltNashAmxc40Y=;
 b=VU9sJRTZNJ6WF6PVBqOXcj0tu97GzNPXR9gjS6DD1V1YRhe99F7R5g8DC4KeVk7Ema
 XILQ31btJgwj7IdCHIg6vX/DnGYHLcQ5aEKYw2PZgOvxi5xaqaLS8PyEXMdtCiFTYMKW
 9f43+TDFlxV7BdlpTCrsIWtMcGU+Q2wYVf0CVvaSRNXZLBbHFAskwfqbLfZs/DaYbOZH
 w0C3p0TGT3K0MwQtbVRK4Sja5ogzmSVhcIrh59NqusbZD7FGJklx4ljiI50/o9gzz9Ui
 or5QG2UzEHbWnwKpSgtjsCmhdXRgepN2+dwWpo9qf77ARca/GPSE29MF32H8UvhMLv50
 yN9Q==
X-Gm-Message-State: AHQUAuZyM3MigYHF22VPaWOdht06e9DUCZGvOChl5XyYg2gWib6wgw+S
 4cA2FUr1AoALKNvTMO6BvaUMnA==
X-Google-Smtp-Source: AHgI3IZgs+fjNhBDwGb2s1NzdQV46SnE16xwpXpDN/pEJxUE8p0ixxLgaAc0UCKdA2OgF2EBY015EA==
X-Received: by 2002:a1c:2547:: with SMTP id l68mr12459136wml.11.1549647338508; 
 Fri, 08 Feb 2019 09:35:38 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 27/33] ARM: davinci: cp-intc: improve coding style
Date: Fri,  8 Feb 2019 18:34:52 +0100
Message-Id: <20190208173458.4801-28-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093540_974876_07C17C70 
X-CRM114-Status: GOOD (  13.28  )
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
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Drop tabs from variable initialization. Arrange variables in reverse
christmas-tree order. Add a newline before a return.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index faf3d74d3719..f3787ae4cdbd 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -77,12 +77,12 @@ static void davinci_cp_intc_unmask_irq(struct irq_data *d)
 static int davinci_cp_intc_set_irq_type(struct irq_data *d,
 					unsigned int flow_type)
 {
-	unsigned reg		= BIT_WORD(d->hwirq);
-	unsigned mask		= BIT_MASK(d->hwirq);
-	unsigned polarity	= davinci_cp_intc_read(
-					DAVINCI_CP_INTC_SYS_POLARITY(reg));
-	unsigned type		= davinci_cp_intc_read(
-					DAVINCI_CP_INTC_SYS_TYPE(reg));
+	unsigned int reg, mask, polarity, type;
+
+	reg = BIT_WORD(d->hwirq);
+	mask = BIT_MASK(d->hwirq);
+	polarity = davinci_cp_intc_read(DAVINCI_CP_INTC_SYS_POLARITY(reg));
+	type = davinci_cp_intc_read(DAVINCI_CP_INTC_SYS_TYPE(reg));
 
 	switch (flow_type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -150,6 +150,7 @@ static int davinci_cp_intc_host_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip(virq, &davinci_cp_intc_irq_chip);
 	irq_set_probe(virq);
 	irq_set_handler(virq, handle_edge_irq);
+
 	return 0;
 }
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
