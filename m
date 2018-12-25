Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7682AC07520
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:20:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AD6218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tMvzFgwi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bp+/YmZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AD6218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TowJg4TxLKUw/oFr6p3VGfIQOsow7nWNRImYrGGk6Is=; b=tMvzFgwiKhTMaD
	dVWEUffAnC5yvXof/TOJk5mLFL0Jn2fUKHkK5BgVCbUZ/L3IIQX/MRtN9x/WLYRwXKZD0+ym1NqKP
	9P2nPXkPQ21HoL8ULmTmWagC1+A4T8FuOCYL0BnWD5FNm0Vcyz3rOD+Se02enJ5vVKEfx0bAP7XJi
	W6vjgFfvBB3C+cRchNy+PS46pot4wmVP523jA8ya+RUs4MYpOUUantMD5AjXuP4gMPFYN0RYSvnbF
	gc0cGiO7kJ1OuJT/0uQffQo60/qJA1a2sk3r58gjxs8rGDklgo7XeugwD53aQfoWPYBjccyHajqVE
	d3L76wKoTfHVZ2a0+kwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbeCL-0006bp-1b; Tue, 25 Dec 2018 04:20:05 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbeCC-0006Tz-I2
 for linux-arm-kernel@lists.infradead.org; Tue, 25 Dec 2018 04:20:00 +0000
Received: by mail-qt1-x842.google.com with SMTP id n32so14322230qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 20:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hRltAEGdhdJSlbSLKF4x4jRfCNGMuHVTLWedpYRw1p8=;
 b=Bp+/YmZH2iQSQxajUYpcSgggriNdHEphMLv4FmM8sl+tDILAa49yg6uxlTVHTTqb2V
 q12YvoNFl/3/LjlCswoN8h6JJ1vJZt3mUffCtcn1vhMwOiRFuhxL6q97N2FuiVwQvis4
 R2xecFTAcGfwO1JiCfmO+CivlGDarR2DH9uIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hRltAEGdhdJSlbSLKF4x4jRfCNGMuHVTLWedpYRw1p8=;
 b=WhaTAm3DYp+Syb421b9ZUuuKoswCbYbx1uuVP3vdLcMWoYBLTLjgm3hMEdv0xceXVr
 J1zm4Gc1o0fwCTZ9fXqOfDq38gD/bxYLeTFR0uaJx66DWOsdMqA1afNztOX5O6JQ6NkQ
 nEh2NBSxwE5NQsVYwjI5CynNpeCKTCX5vyG7yKLp4AxMGFEId0105+M+AFc5C6YHdcuG
 VRaQZclyLh1EoDgjN57FX6ni90MSCSFW1zIaewrbrn37beCS4EA5jyY02JREIM+L3Pji
 Ztfpq93h7K5RT3Wu3las9g8R2uQRzS71gtTN4Uh4IW0RV5KDvs+tA6qZchTrjUk96qzS
 kHjA==
X-Gm-Message-State: AA+aEWakW6dfbGtjN/162NReaPGvXrUYxTpzEXjqqalj05M7Luvg+JLK
 ZTZzlzoUy2s9i6L5pFzNb9lYJdL1E1NAAcPooF2Kfw==
X-Google-Smtp-Source: AFSGD/WiWuKdqXnBY1d4PChmVEr/pLLqCS21n1XNZB6O7T15NrPJ7Tn+xv5ZUZLSR01Y4IPTEmTUVvoVRsFdMrqpUfs=
X-Received: by 2002:aed:3442:: with SMTP id w60mr14405639qtd.339.1545711585226; 
 Mon, 24 Dec 2018 20:19:45 -0800 (PST)
MIME-Version: 1.0
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
 <1545638931-24938-17-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1545638931-24938-17-git-send-email-yongqiang.niu@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Tue, 25 Dec 2018 12:19:34 +0800
Message-ID: <CANMq1KAerBM7Z+hNkfQj1R=Fou_Vcnsu5AStBuZeaH4vC6i2ag@mail.gmail.com>
Subject: Re: [PATCH 16/18] drm/mediatek: add function mtk_ddp_comp_get_type
To: Yongqiang Niu <yongqiang.niu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_201956_593758_244D97A2 
X-CRM114-Status: GOOD (  16.60  )
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
 David Airlie <airlied@linux.ie>, lkml <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Philipp Zabel <p.zabel@pengutronix.de>, CK Hu <ck.hu@mediatek.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 24, 2018 at 6:53 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> This patch add function mtk_ddp_comp_get_type
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 10 ++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index 1c0f9cc..71b565c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -350,6 +350,16 @@ int mtk_ddp_comp_get_id(struct device_node *node,
>         return -EINVAL;
>  }
>
> +enum mtk_ddp_comp_type mtk_ddp_comp_get_type(enum mtk_ddp_comp_id comp_id)
> +{
> +       enum mtk_ddp_comp_type comp_type = MTK_DDP_COMP_TYPE_MAX;
> +
> +       if (comp_id < DDP_COMPONENT_ID_MAX)
> +               comp_type = mtk_ddp_matches[comp_id].type;

return mtk_ddp_matches[comp_id].type

> +
> +       return comp_type;

return MTK_DDP_COMP_TYPE_MAX

> +}
> +
>  int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>                       struct mtk_ddp_comp *comp, enum mtk_ddp_comp_id comp_id,
>                       const struct mtk_ddp_comp_funcs *funcs)
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index b908172..599e293 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -198,5 +198,6 @@ void mtk_ddp_write_mask(unsigned int value,
>                         struct mtk_ddp_comp *comp,
>                         unsigned int offset,
>                         unsigned int mask);
> +enum mtk_ddp_comp_type mtk_ddp_comp_get_type(enum mtk_ddp_comp_id comp_id);
>
>  #endif /* MTK_DRM_DDP_COMP_H */
> --
> 1.8.1.1.dirty
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
