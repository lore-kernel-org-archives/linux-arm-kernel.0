Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F892C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:32:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417C021872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D9iGMa4/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcBMPq0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417C021872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AuPDU71elGfYgL8itK2hegQQzogAeUIxLv2Ba7Gd2Tw=; b=D9iGMa4/dt6boA
	4+1EnaNYnhTc7MV6a8ISKItDEHv7Uw+S58PxiapAkhoJWXQpTo4xEu/mBwdnMyoHZedjk1uuw8RRi
	fWXCDeUD1Wz94qb8BdGkn3N9rT3B2iOROmeFyW4lDyjCxii/HvdaeqH4Nn5rbMa9gXXLiva7uwrtF
	8IwFWBoTu2dWDpDgp36R0t7ZYjEDg5BCUvDpgf/qgx3T+28vYeoqMO2FAAwQsAh4/TiY0l+N0s9yb
	MQh7d+6CbhGzW3PqUEtwSP6aLdqr4ZF4hy42iFqJ0Nq+KR6gMh371PeOkYnG+yhQ568YjHYf+o1FU
	iGmpwMkcbKdWVpdNeUcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmbNM-0008Dz-Fe; Thu, 24 Jan 2019 09:32:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmbNI-0008DV-6z; Thu, 24 Jan 2019 09:32:42 +0000
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 38A77218A4;
 Thu, 24 Jan 2019 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548322359;
 bh=fhy1RiMMv7O0B8kgR+D7cbta1wJy/Rqf55vbyr6oGlk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=BcBMPq0uMSMX4b3ncEzSSKlAHQd5iz+vpgrvVe6fWU8KFgE1Q2kMS0CiW7nPX1oX5
 1Gnyj9VnksqPQlzcm658hmAPPAqKHM3lP0BMDAJvGJj3/qR9W8ir3DYH3pHTDmT+jU
 eA61/fuUfOj9yNDvUJD3T59qceyyyybsDeneOUrk=
Received: by mail-wr1-f46.google.com with SMTP id s12so5659247wrt.4;
 Thu, 24 Jan 2019 01:32:39 -0800 (PST)
X-Gm-Message-State: AJcUukcUAVBn9lUq3i64BCx4+rYxockCfNTjKsF9QmY9GZITtdxVtKoO
 l+7XNDo6m+3C4Sd7Hdofn9TW3mTIf3WbW/NcQrE=
X-Google-Smtp-Source: ALg8bN4aUHzg3ISzP/wUfub2hpAjEJh3tf4xOVOq9ajY467CUvzkM4YRQCi1jgBZjh55ND3KCNbk/Ke8L8FP+9sACZ8=
X-Received: by 2002:adf:f28d:: with SMTP id k13mr6634956wro.78.1548322357680; 
 Thu, 24 Jan 2019 01:32:37 -0800 (PST)
MIME-Version: 1.0
References: <1548314060-4833-1-git-send-email-shun-chih.yu@mediatek.com>
In-Reply-To: <1548314060-4833-1-git-send-email-shun-chih.yu@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 24 Jan 2019 01:35:01 -0800
X-Gmail-Original-Message-ID: <CAGp9LzqMbYOXCEmHOEcCboQLfpXwxH7zcJ3snj4a8NBLiHhQdg@mail.gmail.com>
Message-ID: <CAGp9LzqMbYOXCEmHOEcCboQLfpXwxH7zcJ3snj4a8NBLiHhQdg@mail.gmail.com>
Subject: Re: [PATCH v5] add support for Mediatek Command-Queue DMA controller
 on MT6765 SoC
To: shun-chih.yu@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_013240_289981_55FA50EA 
X-CRM114-Status: GOOD (  16.67  )
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
 dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Shun-Chih,

the driver seems already be applied since v5.0-rc1

I suggest these improvements you made in the recent version can be
split into several patches and then be applied on the top of the base
driver.

On Wed, Jan 23, 2019 at 11:15 PM <shun-chih.yu@mediatek.com> wrote:
>
> This patchset introduces support for MediaTek Command-Queue DMA controller.
>
> MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated to memory-to-memory transfer through queue-based descriptor management.
>
> There are only 3 physical channels inside CQDMA, while the driver is extended to support 32 virtual channels for multiple dma users to issue dma requests onto the CQDMA simultaneously.
>
> dmatest result:
> dmatest: dma0chan0-copy2: summary 5000 tests, 0 failures 3500 iops 28037 KB/s (0)
> dmatest: dma0chan0-copy4: summary 5000 tests, 0 failures 3494 iops 27612 KB/s (0)
> dmatest: dma0chan0-copy1: summary 5000 tests, 0 failures 3491 iops 27749 KB/s (0)
> dmatest: dma0chan0-copy7: summary 5000 tests, 0 failures 3673 iops 29092 KB/s (0)
> dmatest: dma0chan0-copy6: summary 5000 tests, 0 failures 3763 iops 30237 KB/s (0)
> dmatest: dma0chan0-copy0: summary 5000 tests, 0 failures 3730 iops 30131 KB/s (0)
> dmatest: dma0chan0-copy3: summary 5000 tests, 0 failures 3717 iops 29569 KB/s (0)
> dmatest: dma0chan0-copy5: summary 5000 tests, 0 failures 3699 iops 29302 KB/s (0)
>
> Changes since v4:
> - remove redundant queue structure in mtk_cqdma_pchan
> - remove redundant completion management
> - fix wrong residue assignment in mtk_cqdma_tx_status
> - fix typos
>
> Changes since v3:
> - simplify the ISR and management on descriptors by removing tasklet and ASYNC_TX_ENABLE_CHANNEL_SWITCH
> - remove useless field in mtk_cqdma_vdesc structure
> - change dev_info to dev_dbg
> - fix typos
>
> Changes since v2:
> - fix build warning for kernel with DMA address in 32-bit
>
> Changes since v1:
> - remove unused macros, typos
> - leverage ASYNC_TX_ENABLE_CHANNEL_SWITCH to maintain DMA descriptor list
>
> Shun-Chih Yu (2):
>   dt-bindings: dmaengine: Add MediaTek Command-Queue DMA controller
>     bindings
>   dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for
>     MT6765 SoC
>
>  .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 +
>  drivers/dma/mediatek/Kconfig                       |   12 +
>  drivers/dma/mediatek/Makefile                      |    1 +
>  drivers/dma/mediatek/mtk-cqdma.c                   |  748 ++++++++++++++++++++
>  4 files changed, 792 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt
>  create mode 100644 drivers/dma/mediatek/mtk-cqdma.c
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
