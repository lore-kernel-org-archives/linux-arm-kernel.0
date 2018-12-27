Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBF1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:09:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9A621741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CcmtRFsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9A621741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nr8/vMadvqiwJD9sSPUv3SswfuC/iabVdfFO6PmniW8=; b=CcmtRFsWC8T8Bs
	1MzPav9WqSZK1A3MOl57dgjpxWi7rk9yNiQ0IV+XXOOgbYkQaIUVi31NZedVKfcQDxgQV4bXdiymN
	rchubn3CMhfUKcpUQ7LgoQvxWg7iY2jfHw2UaoE9QO84H2WhNCdSg4DYyODpBkxU9p+nYpGQfWtYL
	SNmJyk1WCd87NGsFDKCShcF63aOurB1HMzPzoQlAE1Ap9nus/4aquXZzVD+J4xG0JKHSHKrwMFN/8
	FAHFKMbKNVSiAIVgGeKwzEBEaxReKON5O0qfHwX3B0O9GC4vKM5WSiDp+05a31Tb3EMgOoUpzLO8j
	zdGwjdRSOE3Cm3GKBV+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcQjN-0003Hr-Ay; Thu, 27 Dec 2018 08:09:25 +0000
Received: from [1.203.163.81] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcQjF-0003GH-VB; Thu, 27 Dec 2018 08:09:22 +0000
X-UUID: 20354ebc75064bbd9129fb237b52616d-20181227
X-UUID: 20354ebc75064bbd9129fb237b52616d-20181227
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1059708300; Thu, 27 Dec 2018 16:08:57 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Dec 2018 16:08:56 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Dec 2018 16:08:56 +0800
Message-ID: <1545898136.19450.5.camel@mtksdaap41>
Subject: Re: [PATCH 15/18] drm/mediatek: add RDMA1 fifo size into RDMA
 private data
From: CK Hu <ck.hu@mediatek.com>
To: Yongqiang Niu <yongqiang.niu@mediatek.com>
Date: Thu, 27 Dec 2018 16:08:56 +0800
In-Reply-To: <1545638931-24938-16-git-send-email-yongqiang.niu@mediatek.com>
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
 <1545638931-24938-16-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_000918_561476_6430D01A 
X-CRM114-Status: GOOD (  17.70  )
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
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Yongqiang:

On Mon, 2018-12-24 at 16:08 +0800, Yongqiang Niu wrote:
> This patch add RDMA1 fifo size into RDMA private data
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index b0a5cff..3f9b4d4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -53,12 +53,14 @@
>  #define RDMA_FIFO_PSEUDO_SIZE(bytes)			(((bytes) / 16) << 16)
>  #define RDMA_OUTPUT_VALID_FIFO_THRESHOLD(bytes)		((bytes) / 16)
>  #define RDMA_FIFO_SIZE(rdma)			((rdma)->data->fifo_size)
> +#define RDMA_FIFO_SIZE1(rdma)			((rdma)->data->fifo_size1)
>  #define DISP_RDMA_MEM_START_ADDR		0x0f00
>  
>  #define RDMA_MEM_GMC				0x40402020
>  
>  struct mtk_disp_rdma_data {
>  	unsigned int fifo_size;
> +	unsigned int fifo_size1;
>  };
>  
>  /**
> @@ -137,11 +139,17 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  {
>  	unsigned int threshold;
>  	unsigned int reg;
> +	unsigned int rdma_fifo_size;
>  	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
>  
>  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
>  	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
>  
> +	if (comp->id == DDP_COMPONENT_RDMA1)
> +		rdma_fifo_size = RDMA_FIFO_SIZE1(rdma);
> +	else
> +		rdma_fifo_size = RDMA_FIFO_SIZE(rdma);
> +

It looks like that mt81830-rdma0 and mt8183-rdma1 are different in
hardware, so I think fifo_size should be decided by something from
device tree rather than from its name. Maybe add a property 'FIFO_SIZE'
in rdma device node or create an additional compatible string for
mt8183-rdma1.

Regards,
CK

>  	/*
>  	 * Enable FIFO underflow since DSI and DPI can't be blocked.
>  	 * Keep the FIFO pseudo size reset default of 8 KiB. Set the
> @@ -149,8 +157,12 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
>  	 * account for blanking, and with a pixel depth of 4 bytes:
>  	 */
>  	threshold = width * height * vrefresh * 4 * 7 / 1000000;
> +
> +	if (threshold > rdma_fifo_size)
> +		threshold = rdma_fifo_size;
> +
>  	reg = RDMA_FIFO_UNDERFLOW_EN |
> -	      RDMA_FIFO_PSEUDO_SIZE(RDMA_FIFO_SIZE(rdma)) |
> +	      RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
>  	      RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
>  	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
>  }
> @@ -330,10 +342,12 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
>  
>  static const struct mtk_disp_rdma_data mt2701_rdma_driver_data = {
>  	.fifo_size = SZ_4K,
> +	.fifo_size1 = SZ_4K,
>  };
>  
>  static const struct mtk_disp_rdma_data mt8173_rdma_driver_data = {
>  	.fifo_size = SZ_8K,
> +	.fifo_size1 = SZ_8K,
>  };
>  
>  static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
