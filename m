Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EF3C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:16:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E215D218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YnA2bVF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E215D218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X+EmB3Gcsk1SyiOq3wVeGU8Bu+I7Y9L61bHGlP3GCtk=; b=YnA2bVF/VyFMCD
	4UZ/pFo/812JW0sLPHZtjLx9iLXS5M2nASe6eNPWHe/FoO9a0VySWW/7yaaJ3viVhsW6eokpSpLYk
	tVz+KwkPUZIxyv0wxSq2Be6PTsGVmrZhqiyzeWSmHJYicWUw/BbllErOaG6dAywRS5b9n02HDxAvA
	+sM5EcUGktx1rZCkZBWHFu41G4xq85TievofQtJnVnF/Sr982ZwFnZXZUaZYecKZ/5OwWW4BSiwxV
	Sm5VL0HlulZkdFPMkkbNtKulx2LtKcvUXEN1Y+RNXnIU+TAjV0DhpUwhnN99NuC4OTX1JdJr530MY
	zYL7xdCCDWgedZesIUYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmc44-0004Dv-Pl; Thu, 24 Jan 2019 10:16:52 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmc40-0004Cp-B5; Thu, 24 Jan 2019 10:16:50 +0000
X-UUID: 31d2191c0b644733b2e4b15ccce7ca71-20190124
X-UUID: 31d2191c0b644733b2e4b15ccce7ca71-20190124
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <shun-chih.yu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 564504293; Thu, 24 Jan 2019 02:16:46 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 02:16:44 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 18:16:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 24 Jan 2019 18:16:36 +0800
Message-ID: <1548324996.26017.2.camel@mtkswgap22>
Subject: Re: [PATCH v5] add support for Mediatek Command-Queue DMA
 controller on MT6765 SoC
From: Shun-Chih.Yu <shun-chih.yu@mediatek.com>
To: Sean Wang <sean.wang@kernel.org>
Date: Thu, 24 Jan 2019 18:16:36 +0800
In-Reply-To: <CAGp9LzqMbYOXCEmHOEcCboQLfpXwxH7zcJ3snj4a8NBLiHhQdg@mail.gmail.com>
References: <1548314060-4833-1-git-send-email-shun-chih.yu@mediatek.com>
 <CAGp9LzqMbYOXCEmHOEcCboQLfpXwxH7zcJ3snj4a8NBLiHhQdg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_021648_382978_44B4C1EE 
X-CRM114-Status: GOOD (  19.63  )
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
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
 linux-kernel@vger.kernel.org, srv_wsdupstream@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sean,

I would send a patch based on v5.0-rc1 for the changes, thanks for your
kind reminder.

thanks,
Shun-Chih

On Thu, 2019-01-24 at 01:35 -0800, Sean Wang wrote:
> Hi Shun-Chih,
> 
> the driver seems already be applied since v5.0-rc1
> 
> I suggest these improvements you made in the recent version can be
> split into several patches and then be applied on the top of the base
> driver.
> 
> On Wed, Jan 23, 2019 at 11:15 PM <shun-chih.yu@mediatek.com> wrote:
> >
> > This patchset introduces support for MediaTek Command-Queue DMA controller.
> >
> > MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated to memory-to-memory transfer through queue-based descriptor management.
> >
> > There are only 3 physical channels inside CQDMA, while the driver is extended to support 32 virtual channels for multiple dma users to issue dma requests onto the CQDMA simultaneously.
> >
> > dmatest result:
> > dmatest: dma0chan0-copy2: summary 5000 tests, 0 failures 3500 iops 28037 KB/s (0)
> > dmatest: dma0chan0-copy4: summary 5000 tests, 0 failures 3494 iops 27612 KB/s (0)
> > dmatest: dma0chan0-copy1: summary 5000 tests, 0 failures 3491 iops 27749 KB/s (0)
> > dmatest: dma0chan0-copy7: summary 5000 tests, 0 failures 3673 iops 29092 KB/s (0)
> > dmatest: dma0chan0-copy6: summary 5000 tests, 0 failures 3763 iops 30237 KB/s (0)
> > dmatest: dma0chan0-copy0: summary 5000 tests, 0 failures 3730 iops 30131 KB/s (0)
> > dmatest: dma0chan0-copy3: summary 5000 tests, 0 failures 3717 iops 29569 KB/s (0)
> > dmatest: dma0chan0-copy5: summary 5000 tests, 0 failures 3699 iops 29302 KB/s (0)
> >
> > Changes since v4:
> > - remove redundant queue structure in mtk_cqdma_pchan
> > - remove redundant completion management
> > - fix wrong residue assignment in mtk_cqdma_tx_status
> > - fix typos
> >
> > Changes since v3:
> > - simplify the ISR and management on descriptors by removing tasklet and ASYNC_TX_ENABLE_CHANNEL_SWITCH
> > - remove useless field in mtk_cqdma_vdesc structure
> > - change dev_info to dev_dbg
> > - fix typos
> >
> > Changes since v2:
> > - fix build warning for kernel with DMA address in 32-bit
> >
> > Changes since v1:
> > - remove unused macros, typos
> > - leverage ASYNC_TX_ENABLE_CHANNEL_SWITCH to maintain DMA descriptor list
> >
> > Shun-Chih Yu (2):
> >   dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller
> >     bindings
> >   dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for
> >     MT6765 SoC
> >
> >  .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 +
> >  drivers/dma/mediatek/Kconfig                       |   12 +
> >  drivers/dma/mediatek/Makefile                      |    1 +
> >  drivers/dma/mediatek/mtk-cqdma.c                   |  748 ++++++++++++++++++++
> >  4 files changed, 792 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
> >  create mode 100644 drivers/dma/mediatek/mtk-cqdma.c
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
