Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D739C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:45:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1F3218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V2dpuL8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1F3218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2ZNY5FR2bxOUT11dlWUTsx0qJXwu+FlGJ0ZKkB0IDtk=; b=V2dpuL8x1YzMiz
	vEV2wwYq/pWpfr3VjQwpvL0fYpVkZ5zRGiA3Dm/Ud9/SzWMYXPrhjFte3XLmgubsw3ugMB0u0i1H8
	gpaW2eMXddD3FmLaML4w3xPhLMAf2mWthPpyBOlF+XIMatKOcU4jnP3QXQRsTfqbRpgvYUJgvbIRT
	+5GNetrsJPIfS0ft0A2JEnMrA7Cuh2gbS5GFCEViPpnwMZNMzyjfKnjl6BQlLxhuEEdwbhhkeIucP
	XTQD3spoxsjdMvOXtTq4GvjCpfQCY+G69Bu1EIH1U9LIcQonPELN5O1jeUavL0jrhTnYJ94eDcdhl
	K2IxN5MxIiNsGFxNzstw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmcW1-0001X4-1r; Thu, 24 Jan 2019 10:45:45 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmcVy-0001WZ-6i; Thu, 24 Jan 2019 10:45:43 +0000
X-UUID: 741839d879474a25872c5490c02e63c2-20190124
X-UUID: 741839d879474a25872c5490c02e63c2-20190124
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <shun-chih.yu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 992016102; Thu, 24 Jan 2019 02:45:38 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 02:45:36 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 18:45:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Thu, 24 Jan 2019 18:45:34 +0800
From: <shun-chih.yu@mediatek.com>
To: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH] remove redundant queue structure for Mediatek Command-Queue
 DMA controller
Date: Thu, 24 Jan 2019 18:44:38 +0800
Message-ID: <1548326680-16454-1-git-send-email-shun-chih.yu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-TM-SNTS-SMTP: 29A1CBC80D30C4C1786840970F8100F513FF59606270EDED170F51BB7A09873C2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_024542_250854_60528744 
X-CRM114-Status: UNSURE (   5.87  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 srv_wsdupstream@mediatek.com, linux-mediatek@lists.infradead.org,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset introduces support for MediaTek Command-Queue DMA controller in dt-bindings, and simplifies the controller by removing redundant structures.

Main changes to the initial version:
- remove redundant queue structure in mtk_cqdma_pchan
- remove redundant completion management
- remove redundant tasklet management
- fix wrong residue assignment in mtk_cqdma_tx_status
- fix typos

The result of dmatest shown below:
dmatest: dma0chan0-copy2: summary 5000 tests, 0 failures 3500 iops 28037 KB/s
dmatest: dma0chan0-copy4: summary 5000 tests, 0 failures 3494 iops 27612 KB/s
dmatest: dma0chan0-copy1: summary 5000 tests, 0 failures 3491 iops 27749 KB/s
dmatest: dma0chan0-copy7: summary 5000 tests, 0 failures 3673 iops 29092 KB/s 
dmatest: dma0chan0-copy6: summary 5000 tests, 0 failures 3763 iops 30237 KB/s 
dmatest: dma0chan0-copy0: summary 5000 tests, 0 failures 3730 iops 30131 KB/s
dmatest: dma0chan0-copy3: summary 5000 tests, 0 failures 3717 iops 29569 KB/s
dmatest: dma0chan0-copy5: summary 5000 tests, 0 failures 3699 iops 29302 KB/s

Shun-Chih Yu (2):
  dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller
    bindings
  dmaengine: mediatek-cqdma: remove redundant queue structure

 .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 ++
 drivers/dma/mediatek/mtk-cqdma.c                   |  399 +++++---------------
 2 files changed, 129 insertions(+), 301 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
