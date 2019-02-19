Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFCEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:37:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BEA217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jccMKCM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BEA217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9/+YCrN+Ojem3lGuptrY/K2nNa97NrvmqLyrlj8+awY=; b=jccMKCM+K0l48U
	+7LVhzRVy+1M6JYFhsG1xd0z3lqiySRkTETzHInoj2Vl66Fhu5aFR0cMf+DQ8TKSDY2VApk7YeCzG
	POv+tqNfz4zDlvVUIWanD8U3epW5bhNsrO122zduvlLSZ6GofaV7QAjRk12CBwQkrGB3CZPcmbwcR
	zZQFsJ7Mc93+dEcLQYZP40X539wS5UKAO1GIbS0hieaXzB+C4TnsIUehtaYZYv77Mlyyreq+b0V+T
	nu9mNuU9k8Zm0VIEXa6abhH34VIHbdx7Mq9wBT656kHzFdLoIAzKboNbbA6mPDw7jnO9iYtONSZcF
	esnHS6YzTz/JzjBq8vKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvzyO-0008Gl-9f; Tue, 19 Feb 2019 07:37:48 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvzyB-00083A-QU; Tue, 19 Feb 2019 07:37:37 +0000
X-UUID: 24492fb28fbc46fbacac654bbfc0ea35-20190218
X-UUID: 24492fb28fbc46fbacac654bbfc0ea35-20190218
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1899303419; Mon, 18 Feb 2019 23:37:09 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 18 Feb 2019 23:37:07 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 15:37:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 15:37:04 +0800
From: <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 4/6] usb: musb: Add noirq type of dma create interface
Date: Tue, 19 Feb 2019 15:36:33 +0800
Message-ID: <1550561795-31132-5-git-send-email-min.guo@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1550561795-31132-1-git-send-email-min.guo@mediatek.com>
References: <1550561795-31132-1-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_233735_857452_29232212 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 hdegoede@redhat.com, tony@atomide.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, Min Guo <min.guo@mediatek.com>,
 chunfeng.yun@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Min Guo <min.guo@mediatek.com>

Add noirq type of dma create interface for platform which do not
have dedicated DMA interrupt line, move musbhsdma macro definition
to musb_dma.h

Signed-off-by: Min Guo <min.guo@mediatek.com>
---
changes in v5:
1. no changes

new patch based on v4:
---
 drivers/usb/musb/musb_dma.h  |  9 ++++++++
 drivers/usb/musb/musbhsdma.c | 54 ++++++++++++++++++++++++++++++--------------
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 8f60271..05103ea 100644
--- a/drivers/usb/musb/musb_dma.h
+++ b/drivers/usb/musb/musb_dma.h
@@ -35,6 +35,12 @@
  *    whether shared with the Inventra core or separate.
  */
 
+#define MUSB_HSDMA_BASE		0x200
+#define MUSB_HSDMA_INTR		(MUSB_HSDMA_BASE + 0)
+#define MUSB_HSDMA_CONTROL		0x4
+#define MUSB_HSDMA_ADDRESS		0x8
+#define MUSB_HSDMA_COUNT		0xc
+
 #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
 
 #ifdef CONFIG_MUSB_PIO_ONLY
@@ -191,6 +197,9 @@ static inline void musb_dma_controller_destroy(struct dma_controller *d) { }
 extern struct dma_controller *
 musbhs_dma_controller_create(struct musb *musb, void __iomem *base);
 extern void musbhs_dma_controller_destroy(struct dma_controller *c);
+extern struct dma_controller *
+musbhs_dma_controller_create_noirq(struct musb *musb, void __iomem *base);
+extern irqreturn_t dma_controller_irq(int irq, void *private_data);
 
 extern struct dma_controller *
 tusb_dma_controller_create(struct musb *musb, void __iomem *base);
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index a688f7f..b2394a7 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -10,12 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include "musb_core.h"
-
-#define MUSB_HSDMA_BASE		0x200
-#define MUSB_HSDMA_INTR		(MUSB_HSDMA_BASE + 0)
-#define MUSB_HSDMA_CONTROL		0x4
-#define MUSB_HSDMA_ADDRESS		0x8
-#define MUSB_HSDMA_COUNT		0xc
+#include "musb_dma.h"
 
 #define MUSB_HSDMA_CHANNEL_OFFSET(_bchannel, _offset)		\
 		(MUSB_HSDMA_BASE + (_bchannel << 4) + _offset)
@@ -268,7 +263,7 @@ static int dma_channel_abort(struct dma_channel *channel)
 	return 0;
 }
 
-static irqreturn_t dma_controller_irq(int irq, void *private_data)
+irqreturn_t dma_controller_irq(int irq, void *private_data)
 {
 	struct musb_dma_controller *controller = private_data;
 	struct musb *musb = controller->private_data;
@@ -382,6 +377,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 	spin_unlock_irqrestore(&musb->lock, flags);
 	return retval;
 }
+EXPORT_SYMBOL_GPL(dma_controller_irq);
 
 void musbhs_dma_controller_destroy(struct dma_controller *c)
 {
@@ -397,18 +393,10 @@ void musbhs_dma_controller_destroy(struct dma_controller *c)
 }
 EXPORT_SYMBOL_GPL(musbhs_dma_controller_destroy);
 
-struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
-						    void __iomem *base)
+static struct musb_dma_controller *
+dma_controller_alloc(struct musb *musb, void __iomem *base)
 {
 	struct musb_dma_controller *controller;
-	struct device *dev = musb->controller;
-	struct platform_device *pdev = to_platform_device(dev);
-	int irq = platform_get_irq_byname(pdev, "dma");
-
-	if (irq <= 0) {
-		dev_err(dev, "No DMA interrupt line!\n");
-		return NULL;
-	}
 
 	controller = kzalloc(sizeof(*controller), GFP_KERNEL);
 	if (!controller)
@@ -422,6 +410,25 @@ struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
 	controller->controller.channel_release = dma_channel_release;
 	controller->controller.channel_program = dma_channel_program;
 	controller->controller.channel_abort = dma_channel_abort;
+	return controller;
+}
+
+struct dma_controller *
+musbhs_dma_controller_create(struct musb *musb, void __iomem *base)
+{
+	struct musb_dma_controller *controller;
+	struct device *dev = musb->controller;
+	struct platform_device *pdev = to_platform_device(dev);
+	int irq = platform_get_irq_byname(pdev, "dma");
+
+	if (irq <= 0) {
+		dev_err(dev, "No DMA interrupt line!\n");
+		return NULL;
+	}
+
+	controller = dma_controller_alloc(musb, base);
+	if (!controller)
+		return NULL;
 
 	if (request_irq(irq, dma_controller_irq, 0,
 			dev_name(musb->controller), &controller->controller)) {
@@ -436,3 +443,16 @@ struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
 	return &controller->controller;
 }
 EXPORT_SYMBOL_GPL(musbhs_dma_controller_create);
+
+struct dma_controller *
+musbhs_dma_controller_create_noirq(struct musb *musb, void __iomem *base)
+{
+	struct musb_dma_controller *controller;
+
+	controller = dma_controller_alloc(musb, base);
+	if (!controller)
+		return NULL;
+
+	return &controller->controller;
+}
+EXPORT_SYMBOL_GPL(musbhs_dma_controller_create_noirq);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
