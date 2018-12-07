Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6459DC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:47:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346F120850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BT+ZVMKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346F120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Z5MEb6pNUpgYw3LVNtWl4PKsPCkj/xk2RePrUTveuOI=; b=BT+ZVMKizxeJRz
	HKK2liGvwG5i03Kvr7AWjTa3cTp9NaxdlzGCgWc4s1TJYa11GGKdDD9QAgl4w7msLRVbnyCRzOeAE
	1FWruDA1WWE7T4F6V/zoTphgafUlDc6lfB4VK0KlGN1P1tLeIUSJ6cjFDcoxOOxXXhvfjO65XlYvl
	g0gkDCHcE7Xqcy31bqS1a8CemKAlpE9j9soimV1aYmaCu2+X+SxfRfCABrX+Fg4mkQAB5RpwCf5vR
	qZlZmYTgAPDpMaVVKsZthnvsGa/6R92lIr/8s3snjmhKgBss8zFwSP2O2wLFB6sY1fy2n8yxbG2RN
	b+m0Z2LB9Hpx9CKP8d8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVArc-00071f-D5; Fri, 07 Dec 2018 07:47:56 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVArO-0006iS-LI; Fri, 07 Dec 2018 07:47:47 +0000
X-UUID: 95ffd9d0e0cd46a4b5d1582e7a56c99d-20181207
X-UUID: 95ffd9d0e0cd46a4b5d1582e7a56c99d-20181207
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <long.cheng@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 600503054; Fri, 07 Dec 2018 15:47:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Dec 2018 15:47:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Dec 2018 15:47:26 +0800
From: Long Cheng <long.cheng@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/2] add uart DMA function 
Date: Fri, 7 Dec 2018 15:47:19 +0800
Message-ID: <1544168842-13860-1-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_234743_632155_CD346994 
X-CRM114-Status: UNSURE (   8.31  )
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
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
 srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 YT Shen <yt.shen@mediatek.com>, dmaengine@vger.kernel.org,
 Long Cheng <long.cheng@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In Mediatek SOCs, the uart can support DMA function.
Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.

This series contains document bindings, Kconfig to control the function enable or not,
device tree including interrupt and dma device node, the code of UART DM

Changes compared to v2:
-remove unimportant parameters
-instead of cookie, use APIs of virtual channel.
-use of_dma_xlate_by_chan_id.
Changes compared to v1:
-mian revised file, 8250_mtk_dma.c
--parameters renamed for standard
--remove atomic operation

Long Cheng (2):
  dmaengine: 8250_mtk_dma: add Mediatek uart DMA support
  arm: dts: mt2701: add uart APDMA to device tree

 arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   50 ++
 drivers/dma/mediatek/8250_mtk_dma.c       |  847 +++++++++++++++++++++++++++++
 drivers/dma/mediatek/Kconfig              |   11 +
 drivers/dma/mediatek/Makefile             |    1 +
 4 files changed, 909 insertions(+)
 create mode 100644 drivers/dma/mediatek/8250_mtk_dma.c

-- 
1.7.9.5



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
