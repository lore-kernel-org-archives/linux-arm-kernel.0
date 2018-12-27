Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AFCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:36:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D1320856
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aZhMgaBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D1320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kJ6iVPP9RHyUV7IsTlj4fmfDZ7ohA5PkhvAl/wuTM1s=; b=aZhMgaBlgSxpa+
	6bujT8yyhBP7wQB2deEK3IYtPCfhLD037xoL3J+tZ1mP8e3HdWwCPdFWusiRZlm6tJdhif72LXZ5c
	bI2SjDaooX9GzxLpIvbSkRtAJf/BVqVHt0CXtSTV7zsA8yvMY/uPs/ai/prFdn6O0NAejGbmC8F6e
	JlUwo1mcdoTNxSEsEpg+YZJ6WSSA9MKzhJU26mgm2qn/3tdxxDo64daQPn7qBrmWqWUYPPkmEH7gp
	P+T4V/IoN58ZWjYb94w+BtKvI44J/ZwcTeXULBm1kcvClNWrgHznGOXlYQjMMnTZ0DYhWtpq3tAPH
	jy4GeWBIFnrQT60t4EBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcQCv-0000ws-RH; Thu, 27 Dec 2018 07:35:53 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcQCp-00083H-Mr; Thu, 27 Dec 2018 07:35:51 +0000
X-UUID: ce4a430f9fce4327b15afbcec40d852c-20181227
X-UUID: ce4a430f9fce4327b15afbcec40d852c-20181227
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 829140371; Thu, 27 Dec 2018 15:34:50 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Dec 2018 15:34:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Dec 2018 15:34:47 +0800
From: <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 3/4] usb: musb: Move musbhsdma macro definition to musb_dma.h
Date: Thu, 27 Dec 2018 15:34:25 +0800
Message-ID: <1545896066-897-4-git-send-email-min.guo@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_233547_957982_2BD6D3ED 
X-CRM114-Status: UNSURE (   8.77  )
X-CRM114-Notice: Please train this message.
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

Because the MediaTek musb controller dose not have a
separate DMA interrupt, these macros are required to
access the dma registers

Signed-off-by: Min Guo <min.guo@mediatek.com>
---
 drivers/usb/musb/musb_dma.h  | 6 ++++++
 drivers/usb/musb/musbhsdma.c | 7 +------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_dma.h b/drivers/usb/musb/musb_dma.h
index 8f60271..281e75d3 100644
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
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index a688f7f..824adcb 100644
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
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
