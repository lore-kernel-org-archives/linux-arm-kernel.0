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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E04C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3472146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DIW/amc4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyNKRWAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3472146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G2Bnb8ZUrIKsGFmx65gGZPwJNUMbtU9f02npkdI4n/A=; b=DIW/amc4AFop6/
	rJKJZmk6KXdlGF9EcHjMXmaGD45DRjk6cMjje3QqEW41zUtUgI7cejjWmdySJQg1EK41HsLnpT5k8
	579PoUryIpi2XbqFTTw9Lcrmwtiz982x/dBLHOn97nQI3vDbdhZ8xwq4DsMOX8IMEsrOX9bPTF+DH
	ZeBzFI5Tg9/F5d/WuhX2ByLVVAawRyMjOkeBY+mYN/sNsuGOqywKgdJBPiHTt8OQSh4GXdNrmghi+
	INhWUXQvJvYUcbscfPGkBIzmpBmpHV8TWJyj2+JMfBPAn05SkqGXnIetT/D5MYjS3kfFntKPrPzyj
	0Prsa6XkqBNkvTuZGufg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUo9l-0006wm-H2; Thu, 06 Dec 2018 07:33:09 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUo8f-0005gz-0J
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 07:32:07 +0000
Received: by mail-pf1-x433.google.com with SMTP id b7so11347461pfi.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 23:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+/QmRvqqSNqT4d/eAE++l7YofJ1lKOQigAYWENYxaOI=;
 b=IyNKRWAOr5pKVwfoTxXwpzLr0QwRJE9m2q2Okjf7QAhtCPDe7rf+vHWY0KsWee6qmX
 UPFvnIfy/9G7oQyLDozZ9SCYvoO9QvrebssBDi+yZX+8kKWjaKJNMQVN6K7qkp6o4ctE
 XI6o47yWEwaim6rY2w2Nx4O5vQvQngkW6A/jNfwEnDSFkXDLGCDSDAae/oRA63pAU/F2
 HaiFthRVORTvkyCn7Mv/RICBXbYbu3JNMtsBqJx9YB/Jlvkt1EJFu/IrWIpPxa9Lzx+H
 fqiprcSBzO7Qfh+N2zcT9kpEaG1INfvNKNSK6JuPZDjSaZAVBn50FaKUPVZBiXAUkqHQ
 GzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+/QmRvqqSNqT4d/eAE++l7YofJ1lKOQigAYWENYxaOI=;
 b=obGX/Cn3aCEuUOOHtrqW5u/NXz0o3SufagV/a9AV3PMpiLESsn/Y1aKyQzZ+GsvcIP
 66lDKJsIhgGNTIrSPp5zcfBccXTsjAKHXrXmLijN0c8ZDmq+qhFYnih/DFBska3QZZv2
 d9rz2ttgFAluLm4V0DhtddA1gjxhHoWmgLjHe/j6ud+2k3knuDNdLrP4P+fWF8nijquy
 qO1AoEo9FCxX7Q1RcxqtGmMuFjmGBCeUQdauzIUT3Y5uqaSbGhzOI90WQ2HAaW82ScAZ
 lFUZ77HCi8jo7axRpc4trIxy9DR1H8a87pIoTlhXruUd/sN5T78a8Ah5LH26r9jl3VGT
 XD6w==
X-Gm-Message-State: AA+aEWYCYmCzwrM9U4uj80j9VMTuu+E/2LsyR0KdYEd4Vypn9pHDa9P+
 1DJMeDPmgruKKr0xZk3uY2M=
X-Google-Smtp-Source: AFSGD/Wa9mdeLmI7KZDw62UJwvBDn8ds+J8+PLv/7me8kzkLfxM4Oci/hajdzDuDlHuQsGYx7Jp98g==
X-Received: by 2002:a63:1f4e:: with SMTP id q14mr22251175pgm.88.1544081510018; 
 Wed, 05 Dec 2018 23:31:50 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id o8sm55023141pfa.42.2018.12.05.23.31.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 05 Dec 2018 23:31:49 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4/5] irqchip/irq-imx-gpcv2: Make error messages more consistent
Date: Wed,  5 Dec 2018 23:31:24 -0800
Message-Id: <20181206073125.7255-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206073125.7255-1-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_233201_315856_0E80320E 
X-CRM114-Status: GOOD (  13.33  )
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

Make error messages more consistent by making sure each starts with
"%pOF:".

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
 drivers/irqchip/irq-imx-gpcv2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 077d56b3183a..c2b2b3128ddd 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -212,7 +212,7 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 
 	cd = kzalloc(sizeof(struct gpcv2_irqchip_data), GFP_KERNEL);
 	if (!cd) {
-		pr_err("kzalloc failed!\n");
+		pr_err("%pOF: kzalloc failed!\n", node);
 		return -ENOMEM;
 	}
 
@@ -220,7 +220,7 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 
 	cd->gpc_base = of_iomap(node, 0);
 	if (!cd->gpc_base) {
-		pr_err("fsl-gpcv2: unable to map gpc registers\n");
+		pr_err("%pOF: unable to map gpc registers\n", node);
 		kfree(cd);
 		return -ENOMEM;
 	}
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
