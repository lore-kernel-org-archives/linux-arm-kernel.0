Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36B4C282ED
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:00:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8239321741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NIIH/Gmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8239321741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hFWThC6oN7JTs5aScuptvxyfsCYUe9PXgWYLOgMVdoY=; b=NIIH/GmtCL+BeR
	DN7i3OsenkDUFmqW7YTNBdkwWgQtUwJNgRpfOnED2R2XZrvK1P8Zc9q/nBdYYWbe3UTpyeXliRxKV
	93VP+6OEn5FSKg4/HsjafZVRf5dth3pPkhen2ud0khO8CeOcOJ0WDwMA5/3XwywL5DxKixOIDKPkW
	37G+JdRPkg8F3l8XIgpn3raFizdnqZBi9IMznL09dWYcy+gWTsRSmSGqPacNwElC7O42uJT/YWryi
	kbZ4ntnobzHqb6hPwEpiLC6RAMKzTdwh6zaFUJAu2U60COQ7AXz3fyjM/K4RE01h80CM4hdVDwsfr
	/O/rqGKwu/3anGxcn6Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUVm-0001Um-J0; Mon, 21 Jan 2019 08:00:50 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUVj-0001Tw-6Y; Mon, 21 Jan 2019 08:00:48 +0000
X-UUID: 9dfd6707089f47bf94572f533c847c0c-20190121
X-UUID: 9dfd6707089f47bf94572f533c847c0c-20190121
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <qii.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1827203960; Mon, 21 Jan 2019 00:00:43 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 00:00:41 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 16:00:39 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 21 Jan 2019 16:00:38 +0800
From: qii wang <qii.wang@mediatek.com>
To: <wsa@the-dreams.de>
Subject: [PATCH v3 1/6] dt-bindings: i2c: Add Mediatek MT7629 i2c binding
Date: Mon, 21 Jan 2019 15:59:29 +0800
Message-ID: <1548057574-8061-2-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 87C4199F01EBD6EF568BF9DCC1338C6B409F7B3CCCB4F1D81D914D8896B9E4352000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_000047_251407_56D0B71B 
X-CRM114-Status: UNSURE (   7.56  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com, qii.wang@mediatek.com,
 srv_heupstream@mediatek.com, leilk.liu@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add MT7629 i2c binding to binding file.

Signed-off-by: qii wang <qii.wang@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index e199695..ee4c324 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
@@ -10,6 +10,7 @@ Required properties:
       "mediatek,mt6589-i2c": for MediaTek MT6589
       "mediatek,mt7622-i2c": for MediaTek MT7622
       "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
+      "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
       "mediatek,mt8173-i2c": for MediaTek MT8173
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
