Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A78C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:27:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF01B206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rnadFmYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF01B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RHBkhhRFvuisj5gbZ0xKKV+l8C2GGMGW9j9zWDnJGGo=; b=rnadFmYYlePnlv
	N2QgxfBUZqLvR/YwA+AyVFwkjbhSFk2Az9LNdOOPPUvjQMaeVfECMqBpNjO5malF76LB0D8/q3ZeK
	iigmvNZMVkIqOEsWNerIrSyzlu7wajnmRADSQPvNZTUnrJW+1tUJE8FbajlJTQUcTSzjjZBn/yQPm
	I093rc+EwRIoT++nXSQvHsmHqrcPmsiy/Y5DPJWri548i7WmWuN/SPHUfftit/q9YoMhs91ZrHpxp
	qdI1vWEGnkFma+MedWuhYzIT/CFXYudbMkyeHcP2TTw1LlgBHxTe+fXB81Id4FAEc7ezoIokZJeWN
	+6fzOmJaoMMtSEABnbCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTetU-0005rP-W8; Mon, 03 Dec 2018 03:27:37 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTetR-0005oj-16; Mon, 03 Dec 2018 03:27:35 +0000
X-UUID: 58567d1b71d8435eae3b1b003a4e96a8-20181203
X-UUID: 58567d1b71d8435eae3b1b003a4e96a8-20181203
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1972276798; Mon, 03 Dec 2018 11:27:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 3 Dec 2018 11:27:00 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 3 Dec 2018 11:27:00 +0800
Message-ID: <1543807620.11594.2.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: Only try to attach bridge if there is one
From: CK Hu <ck.hu@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>
Date: Mon, 3 Dec 2018 11:27:00 +0800
In-Reply-To: <1543210200.1796.2.camel@mtksdaap41>
References: <20181126040737.138682-1-drinkcat@chromium.org>
 <1543210200.1796.2.camel@mtksdaap41>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_192733_198501_E0B62A18 
X-CRM114-Status: GOOD (  15.30  )
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi, Nicolas:

On Mon, 2018-11-26 at 13:30 +0800, CK Hu wrote:
> Hi, Nicolas:
> 
> On Mon, 2018-11-26 at 12:07 +0800, Nicolas Boichat wrote:
> > Even if dsi->bridge is NULL, we still try to call drm_bridge_attach,
> > and print out an error message, before creating the connector.
> > 
> > When no bridge is provided, let's skip these 2 steps and directly
> > create the connector.
> 

Applied to mediatek-drm-fixes-4.20 [1], thanks.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-4.20

Regards,
CK

> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> 
> > 
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index 66df1b17795921..27b507eb4a997d 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -818,10 +818,13 @@ static int mtk_dsi_create_conn_enc(struct drm_device *drm, struct mtk_dsi *dsi)
> >  	dsi->encoder.possible_crtcs = 1;
> >  
> >  	/* If there's a bridge, attach to it and let it create the connector */
> > -	ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL);
> > -	if (ret) {
> > -		DRM_ERROR("Failed to attach bridge to drm\n");
> > -
> > +	if (dsi->bridge) {
> > +		ret = drm_bridge_attach(&dsi->encoder, dsi->bridge, NULL);
> > +		if (ret) {
> > +			DRM_ERROR("Failed to attach bridge to drm\n");
> > +			goto err_encoder_cleanup;
> > +		}
> > +	} else {
> >  		/* Otherwise create our own connector and attach to a panel */
> >  		ret = mtk_dsi_create_connector(drm, dsi);
> >  		if (ret)
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
