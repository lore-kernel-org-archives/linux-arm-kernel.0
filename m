Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7369920989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hqv3HMiV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itLsYDix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7369920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7EmOL/IbgOpqAROu92UK9aVbyIlaeFNAJYnGqRw1vIw=; b=hqv3HMiVOYVC+X
	OuQJD3I5HqM0LViN7M3cfArcoMiBLw5CyCx8t929UkqopstRFbMD7lTJ8cdDyoDqGKrqk6RJ14glN
	xG8C2O2fiEq0y2tHcCUKKBjUN8IyJpHHmBUWrKIMLcyGCnaUVmuLxQEeUhzJjucl65RgcrzsABgDY
	Ka98ymVEFmnEYbI/Csj4bru7n+u+j1sS7mx5pCn89DPju0yLnw2dMwFGhprl6OI0xGLmIoLaaGDxA
	mssm/l2ilMM7CweL7x5bYbdby4kVJ2rAVU7dfH0lrXxm8zEP+9cIJVZ5AEUJGH4/CXEFNFFMvBt8G
	TOEJVp817ti/yIJtavkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUo90-0006BA-5T; Thu, 06 Dec 2018 07:32:22 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUo8Z-0005cA-Ba
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:32:01 +0000
Received: by mail-pg1-x542.google.com with SMTP id t13so10230533pgr.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eq5c2aoTlNEBR4vdJDWHcTDFFsOiMSh4dwP893bAFFA=;
 b=itLsYDixH1lxNOkZCJZU3ssPt76bbfN2Gf9zw/9e5hCowL668OI9eUmNB1IgFaM7hV
 YFdvv7WqujooxOrUiAT08WsSJl4kjJUm7ddwMpx7vK41IwXKaK70vwo/BQptTNXordMz
 oSvFfB/1pwRSnFUvLk6PWVrdUXJipOcJ8qILaYaIqZeFyD+0nFsC3P2/IfoJ3O430rkv
 0slHeOMlvndyYABf5X8pEbmG9HD7mb280OagMGGqYNsSjh/XfuQU9kpgZNG/Kl8WSjE8
 C5ukhJxE1t6ExkFS1LTTrc4n940XysL2t1DD1qMXLfyGGO7lLg9H/PXnVwZHPouAZzMj
 9qsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eq5c2aoTlNEBR4vdJDWHcTDFFsOiMSh4dwP893bAFFA=;
 b=P3aNn19JDZRihU6OGDsL1uT+l3lF6XaWYf5xpQqb7nTVZIXgiBECKk8shYYatS+bGX
 sLAjVGyWWAFxxcPUhGpNkfjYrd6v1OXGABiOI4bBOYAuYUAdlRUTyaZ+r8qjFdYt+EEJ
 RhFU2bIjT0Vgg424diZLIemJ61ZWisjDepdZUjq5gHksAK27T8eGnSP5L3AGsGjaXOQr
 uCapbFB1TmSx567+b9H67fM7xuQt3Grw3UZiUUrR5LccUiMIHP1BYWBPEblWQic/tqtq
 X4/84wfoqBjHwqt/2FDB2IoCDo1269S7ZOpwDMCc8HAM3gHdJjWRNnPJvJDeMvSR93DK
 A03w==
X-Gm-Message-State: AA+aEWYhJXfzQxMUYTdHiYUmCd7lmZKEq0YG6uuyALILOiqj6omXdFw4
 OnSHP2eRk04LUlX9HCVAL+4=
X-Google-Smtp-Source: AFSGD/Vk71MzVErNZdxcJxTjtnNjqD0bf7umupJNTUU4aNmsA8EAsnQs0mAlf+qvLO7QVbF8ANsf2A==
X-Received: by 2002:a65:57cb:: with SMTP id q11mr23293739pgr.60.1544081504614; 
 Wed, 05 Dec 2018 23:31:44 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 23:31:43 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 1/5] irqchip/irq-imx-gpcv2: Remove unused code
Date: Wed,  5 Dec 2018 23:31:21 -0800
Message-Id: <20181206073125.7255-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073125.7255-1-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233155_855873_F1D53D1C 
X-CRM114-Status: GOOD (  12.43  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Varaible 'reg' in imx_gpcv2_irq_set_wake() has no users. Remove it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 4760307ab43f..cbed00319315 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -73,11 +73,9 @@ static int imx_gpcv2_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct gpcv2_irqchip_data *cd = d->chip_data;
 	unsigned int idx = d->hwirq / 32;
 	unsigned long flags;
-	void __iomem *reg;
 	u32 mask, val;
 
 	raw_spin_lock_irqsave(&cd->rlock, flags);
-	reg = cd->gpc_base + cd->cpu2wakeup + idx * 4;
 	mask = 1 << d->hwirq % 32;
 	val = cd->wakeup_sources[idx];
 
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
