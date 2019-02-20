Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAC6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6BC2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sUpxS0Fs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="rcZPB63i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6BC2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=norrbonn.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F/9GKIAonYsV8bv4ABCKFzhC8NS3VHfq/tVnFdIaQ4U=; b=sUpxS0Fs0FSaVB
	G5zGTwP2biBF0oNBEjU3T8Ss+QJ9oqQoBMclW2qbC1psZwCQYA7ayn4xmh3LjFlw1mTiEP4aQfPew
	lrGxotryjiOVomtKbVjPfM4+X48VpISUoQO30sJWzCa7+c+naD797MbzVzXZfN242v7s7NDOD8m2d
	iKH0p66dUFmfYSWmMZye6+rxgNgjxDiFjKy5cQJtS90fZM9oqEh/EnsR76ufNrXXAs8fud0YYef6O
	Eo0Pk9jVQmM4HdeijbVulZ1fP0m0LX6XltKljo9pA/QHnOrQUM1VRGV24C8ue0c0m9blCEaQEfDKN
	BrpYdbvtUlISi80zVaqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwQrV-00048I-F2; Wed, 20 Feb 2019 12:20:29 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwQrK-0003zP-3L
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 12:20:21 +0000
Received: by mail-lj1-x243.google.com with SMTP id d14so9429587ljl.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 04:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2tfaveN+cB7E5HOlJgyDgTMgL0/lTVFeedC/fRB32HM=;
 b=rcZPB63i2KLSDRTv4dfIm0pYaDVSEWk2ftBAFZ5fQiWWpsvgnugh0UFD8H/MAFQxoP
 WKvEA2nGC/KALsMZs59ZhZ4icC5kAL3EWINnB0ZOWUM1ts4K2685ou91VqDOkObqnd4Z
 +4O95qIJbKM+2UyjjQLYFComGRQDuSARUqX7Or7dR6bi88PdyQzxm8cxHcv6NLPkSS2P
 YpRP4i+q1pHuEWCnaWSBooey7eQvRpWhZcdg9BVGZrBq51luxbdk2dx0X9NdYzxIFld8
 2fPkQ50aPdFAH0zQ937IX/xiTgg+McFG5174MEfm4/4dsDa6Kbn80z0/IJUqP2nbfvCU
 HUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2tfaveN+cB7E5HOlJgyDgTMgL0/lTVFeedC/fRB32HM=;
 b=j0+i9zXbX1mr8Hs4FJpf07RFOR6UF6TFk/mkf+lBhqE94VUijmhlrtmfNfGNIdCAQR
 OankyCQJBmRRDTQV90Z2LqO89ScAQ5pjToDKN8pPGLtlB/+EFStNTUxN7wTH6n06GH74
 85iultaiLBPORG1xEwzK6qmhaB+9bbxvwsB9Ku+g1A1ABLOa7/Xf3Rj38jgRO5mhlxXy
 TXbr21wDkBXzripyzyHSLKRt5NWZTtBYAaANZHk1aczP1Ai5eBlpKjvbU/9d0HuLz4km
 DpSWkSzsbvGzxgGQwdJUSLO8xjl91GMnN5/l9uR6zpT8bvrjE5j0pN/9xGRtQXnSwFUx
 y+VQ==
X-Gm-Message-State: AHQUAuZ47gqdgzaJ5n/J6CD+s6zDqEyVcljVZvVFtxR2hjHMFT/UDfLh
 ORSdvx0JiE0Ip1w6FEMxXUNh5g==
X-Google-Smtp-Source: AHgI3IYrQCiIUhsZpbt8/7/4ODJ5cjLPuMl//ZxG1g9HQl9PseFR2rWgHZDdYv+Lfcg6hfP7jUYVww==
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr3226407lji.155.1550665215496; 
 Wed, 20 Feb 2019 04:20:15 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
 by smtp.gmail.com with ESMTPSA id r2-v6sm5270270lja.78.2019.02.20.04.20.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 04:20:15 -0800 (PST)
From: Jonas Bonn <jonas@norrbonn.se>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 1/3] usb: gadget: atmel_usba_udc: simplify setting of
 interrupt-enabled mask
Date: Wed, 20 Feb 2019 13:19:59 +0100
Message-Id: <20190220122001.5713-2-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190220122001.5713-1-jonas@norrbonn.se>
References: <20190220122001.5713-1-jonas@norrbonn.se>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_042018_190526_D5B09D5F 
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
Cc: Felipe Balbi <balbi@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonas Bonn <jonas@norrbonn.se>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 linux-arm-kernel@lists.infradead.org,
 Cristian Birsan <cristian.birsan@microchip.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds set and clear functions for enabling/disabling
interrupts.  This simplifies the implementation a bit as the masking of
previously set bits doesn't need to be so explicit.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Cristian Birsan <cristian.birsan@microchip.com>
CC: Felipe Balbi <balbi@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-usb@vger.kernel.org
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 29 ++++++++++++++++---------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 51a2b9232baa..9d18fdddd9b2 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -358,8 +358,20 @@ static inline u32 usba_int_enb_get(struct usba_udc *udc)
 	return udc->int_enb_cache;
 }
 
-static inline void usba_int_enb_set(struct usba_udc *udc, u32 val)
+static inline void usba_int_enb_set(struct usba_udc *udc, u32 mask)
 {
+	u32 val;
+
+	val = udc->int_enb_cache | mask;
+	usba_writel(udc, INT_ENB, val);
+	udc->int_enb_cache = val;
+}
+
+static inline void usba_int_enb_clear(struct usba_udc *udc, u32 mask)
+{
+	u32 val;
+
+	val = udc->int_enb_cache & ~mask;
 	usba_writel(udc, INT_ENB, val);
 	udc->int_enb_cache = val;
 }
@@ -629,14 +641,12 @@ usba_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
 	if (ep->can_dma) {
 		u32 ctrl;
 
-		usba_int_enb_set(udc, usba_int_enb_get(udc) |
-				      USBA_BF(EPT_INT, 1 << ep->index) |
+		usba_int_enb_set(udc, USBA_BF(EPT_INT, 1 << ep->index) |
 				      USBA_BF(DMA_INT, 1 << ep->index));
 		ctrl = USBA_AUTO_VALID | USBA_INTDIS_DMA;
 		usba_ep_writel(ep, CTL_ENB, ctrl);
 	} else {
-		usba_int_enb_set(udc, usba_int_enb_get(udc) |
-				      USBA_BF(EPT_INT, 1 << ep->index));
+		usba_int_enb_set(udc, USBA_BF(EPT_INT, 1 << ep->index));
 	}
 
 	spin_unlock_irqrestore(&udc->lock, flags);
@@ -680,8 +690,7 @@ static int usba_ep_disable(struct usb_ep *_ep)
 		usba_dma_readl(ep, STATUS);
 	}
 	usba_ep_writel(ep, CTL_DIS, USBA_EPT_ENABLE);
-	usba_int_enb_set(udc, usba_int_enb_get(udc) &
-			      ~USBA_BF(EPT_INT, 1 << ep->index));
+	usba_int_enb_clear(udc, USBA_BF(EPT_INT, 1 << ep->index));
 
 	request_complete_list(ep, &req_list, -ESHUTDOWN);
 
@@ -1713,7 +1722,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	if (status & USBA_DET_SUSPEND) {
 		toggle_bias(udc, 0);
 		usba_writel(udc, INT_CLR, USBA_DET_SUSPEND);
-		usba_int_enb_set(udc, int_enb | USBA_WAKE_UP);
+		usba_int_enb_set(udc, USBA_WAKE_UP);
 		udc->bias_pulse_needed = true;
 		DBG(DBG_BUS, "Suspend detected\n");
 		if (udc->gadget.speed != USB_SPEED_UNKNOWN
@@ -1727,7 +1736,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	if (status & USBA_WAKE_UP) {
 		toggle_bias(udc, 1);
 		usba_writel(udc, INT_CLR, USBA_WAKE_UP);
-		usba_int_enb_set(udc, int_enb & ~USBA_WAKE_UP);
+		usba_int_enb_clear(udc, USBA_WAKE_UP);
 		DBG(DBG_BUS, "Wake Up CPU detected\n");
 	}
 
@@ -1796,7 +1805,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 				| USBA_BF(BK_NUMBER, USBA_BK_NUMBER_ONE)));
 		usba_ep_writel(ep0, CTL_ENB,
 				USBA_EPT_ENABLE | USBA_RX_SETUP);
-		usba_int_enb_set(udc, int_enb | USBA_BF(EPT_INT, 1) |
+		usba_int_enb_set(udc, USBA_BF(EPT_INT, 1) |
 				      USBA_DET_SUSPEND | USBA_END_OF_RESUME);
 
 		/*
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
