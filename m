Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43027C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 01:17:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118E021741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 01:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fyy/DXCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118E021741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EgffnXwPIaPZh8mVd6uMawG/yEJ/rbyfzhubRd/C1/E=; b=Fyy/DXCuP1l0sl
	KPIHdsgW3K9Ivvcjo56BPCNEriuwVGkrSDHy58TQ2yvR+2k6ROdeegiI/+Bcyp3mnhZCvl7GHBBfV
	g29HHlXGhdzv+eE8VT5MHf1pFmW4IL64IOWvVb4Y9MpVJjOcRjUd5xLAc/25nn8l23vGHQhFZsAFw
	6KwRSPh8RWg8zwuaRRW00j4I9P2BbnyAUxRZwunimGJSbnrC26VQZtHt44tNpDKqR0sFTAFIGE2q7
	dq4aPVnU7ZasdiCa1xZmEssoVBOazVLE6yxS1JL2QrsboyfxjOJkkMR4oY43oLEui7htU50niIN2e
	WO7d0nBNQzqAE8VqGq2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcKIP-00029K-2R; Thu, 27 Dec 2018 01:17:09 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcKIJ-00028L-3c; Thu, 27 Dec 2018 01:17:07 +0000
X-UUID: 6c0a9899b77d4df2b0ff991fab78289b-20181227
X-UUID: 6c0a9899b77d4df2b0ff991fab78289b-20181227
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 588625557; Thu, 27 Dec 2018 09:16:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Dec 2018 09:16:39 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Dec 2018 09:16:39 +0800
Message-ID: <1545873399.31506.2.camel@mtksdaap41>
Subject: Re: [PATCH 11/18] drm/medaitek: add layer_nr for ovl private data
From: CK Hu <ck.hu@mediatek.com>
To: Yongqiang Niu <yongqiang.niu@mediatek.com>
Date: Thu, 27 Dec 2018 09:16:39 +0800
In-Reply-To: <1545638931-24938-12-git-send-email-yongqiang.niu@mediatek.com>
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
 <1545638931-24938-12-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_171703_366020_D71878ED 
X-CRM114-Status: GOOD (  15.43  )
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
> This patch add layer_nr for ovl private data
> 

I think you do this because ovl-2l and ovl share the same driver and the
ovl layer is different, so this patch is a preparation for ovl-2l and
ovl share the same driver. Describe more information for this patch.

Regards,
CK

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index afb313c..a0ab760 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -60,6 +60,7 @@
>  struct mtk_disp_ovl_data {
>  	unsigned int addr;
>  	unsigned int gmc_bits;
> +	unsigned int layer_nr;
>  	bool fmt_rgb565_is_0;
>  };
>  
> @@ -137,7 +138,9 @@ static void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
>  
>  static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
>  {
> -	return 4;
> +	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
> +
> +	return ovl->data->layer_nr;
>  }
>  
>  static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
> @@ -342,12 +345,14 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
>  static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
>  	.addr = DISP_REG_OVL_ADDR_MT2701,
>  	.gmc_bits = 8,
> +	.layer_nr = 4,
>  	.fmt_rgb565_is_0 = false,
>  };
>  
>  static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
>  	.addr = DISP_REG_OVL_ADDR_MT8173,
>  	.gmc_bits = 8,
> +	.layer_nr = 4,
>  	.fmt_rgb565_is_0 = true,
>  };
>  



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
