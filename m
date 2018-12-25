Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD32BC07520
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:23:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE38218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kJImmcWR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DMPGJSJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE38218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TmbTsaHXJxGRJ5Y3AOGFvITc6qUANrgXkZGpkKt7fBg=; b=kJImmcWRqtPnOQ
	Jx2/ZwNPsJmTWt8yzKlPUa+6DdtHvuwNP4TzK384eXxqQleExHM49NBpvFpAfIHOqU8oF0D/6kHyU
	kkiD5bEOqKBrcIvX0PkJ8M2uatyGQMSLbS88DfbNPZ0TvgwzuVh5nXUgnrv+U1DJGYTsjMEzwZIMh
	4A0PlkW5f/3aJv1jWQAaznqv0zGIFlS3vbwZuw7S3jF3o9G49SeQk/cwLiJNmp+L3VcU1DpIR5Smn
	68Zlu5i4MK2Afz//p8IR5wYii6t4H7fpovK5kl4wzu4jLf4bOdVl/7cYzlypeLRuM9XnJTpcxxIET
	pgJu70J/sioADYCznNyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbeFJ-00089j-27; Tue, 25 Dec 2018 04:23:09 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbeFD-00088P-3K
 for linux-arm-kernel@lists.infradead.org; Tue, 25 Dec 2018 04:23:07 +0000
Received: by mail-qk1-x741.google.com with SMTP id a1so7780145qkc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 20:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XyxR0p07RGp1qlnLQ+PYw01EN8P7tHAtKVYSKm8bAL4=;
 b=DMPGJSJtRdiZv99OCfBQos18OkHHDteY+guhhAdn1ZMq4HDXHgQ206cLCrMt3qf8nw
 8vfqD1vINezlalGqZWrBIQT7CXRAd+abfmlvESEKCCKOFQ/snvPpVXImYsAmln0e9aD2
 bHQW4i+yYIQQzYdR/WbmsSKxCPEaAFYdqN2l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XyxR0p07RGp1qlnLQ+PYw01EN8P7tHAtKVYSKm8bAL4=;
 b=n3zvCsmg8tWIm/0LD8P87IZtUJGddg7S43sxyH/Q2gVj31NtZsymwqXfoxPD48AIPr
 0ga1SbTN8a1HMPjddqY79SyefL6Mdx+ND31bGKz5hj/rh60LSeM1XiXfxVkdAMEc6wbb
 qGIQuoXEJRF4cgsfs+W7mtS0XgSjYkuL5AeFBkgEajYyShc7BiVF2tk2kerxYVISV5nV
 06aiRRaYEhdRZoVzmWxZEWk13zeBiDpiQTy9aFecDVc1AeiGdq1nh4vsNnTRfZQyBeZ9
 VDgYnMs8Bh7cb+KfhMsMIq/VfR0cNjDsYoJIU/K2V1gIgPfb48SkNFIwX2UpxPT+mwbP
 4d6g==
X-Gm-Message-State: AJcUukd5ALTxGSHaQ8bPHggcvwv7iJWWImyc+W7bsPW8cM0opiKYJsc/
 IbsT/xcWxCMxmCPjZWhxq9YoC34RgW6wFUi63lEIgQ==
X-Google-Smtp-Source: ALg8bN54nsGswSAzKhafoH8Zx/smpqhn+S5WbjR+AQZ8TyP/RYFXzsSuWTKn5IwKWvibC7uZMM/pf9JJ+QpWCq7TtnM=
X-Received: by 2002:a37:5107:: with SMTP id f7mr14268124qkb.124.1545711771863; 
 Mon, 24 Dec 2018 20:22:51 -0800 (PST)
MIME-Version: 1.0
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
 <1545638931-24938-18-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1545638931-24938-18-git-send-email-yongqiang.niu@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Tue, 25 Dec 2018 12:22:41 +0800
Message-ID: <CANMq1KBtkd8yMHppMDV1OYocB70L-UxrF0cnYiWMjQLA9NWbvQ@mail.gmail.com>
Subject: Re: [PATCH 17/18] drm/mediatek: add ovl0/ovl0_2l usecase
To: Yongqiang Niu <yongqiang.niu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_202303_143743_E7990EB7 
X-CRM114-Status: GOOD (  20.47  )
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

On Mon, Dec 24, 2018 at 6:52 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> This patch add ovl0/ovl0_2l usecase
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 38 ++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index a5af4be..25cf063 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -283,6 +283,15 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>
>         for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
>                 struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
> +               enum mtk_ddp_comp_id prev = DDP_COMPONENT_ID_MAX;
> +
> +               if (i > 0) {
> +                       struct mtk_ddp_comp *comp_prev;
> +
> +                       comp_prev = mtk_crtc->ddp_comp[i - 1];
> +                       prev = comp_prev->id;

Just

if (i > 0)
  prev = mtk_crtc->ddp_comp[i - 1]->id;
else
  prev = DDP_COMPONENT_ID_MAX;

> +               }
> +               mtk_ddp_comp_connect(comp, prev);
>
>                 mtk_ddp_comp_config(comp, width, height, vrefresh, bpc);
>                 mtk_ddp_comp_start(comp);
> @@ -292,10 +301,19 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>         for (i = 0; i < mtk_crtc->layer_nr; i++) {
>                 struct drm_plane *plane = &mtk_crtc->planes[i];
>                 struct mtk_plane_state *plane_state;
> +               struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
> +               unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> +               unsigned int local_layer = 0;

No need to init to 0.

>
>                 plane_state = to_mtk_plane_state(plane->state);
> -               mtk_ddp_comp_layer_config(mtk_crtc->ddp_comp[0], i,
> -                                         plane_state);
> +
> +               if (i >= comp_layer_nr) {
> +                       comp = mtk_crtc->ddp_comp[1];
> +                       local_layer = i - comp_layer_nr;
> +               } else {
> +                       local_layer = i;
> +               }
> +               mtk_ddp_comp_layer_config(comp, local_layer, plane_state);
>         }
>
>         return 0;
> @@ -340,6 +358,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>         struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
>         struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
>         unsigned int i;
> +       unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
> +       unsigned int local_layer = 0;

ditto, don't init to 0.

>
>         /*
>          * TODO: instead of updating the registers here, we should prepare
> @@ -362,7 +382,15 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>                         plane_state = to_mtk_plane_state(plane->state);
>
>                         if (plane_state->pending.config) {
> -                               mtk_ddp_comp_layer_config(comp, i, plane_state);
> +                               if (i >= comp_layer_nr) {
> +                                       comp = mtk_crtc->ddp_comp[1];
> +                                       local_layer = i - comp_layer_nr;
> +                               } else {
> +                                       local_layer = i;
> +                               }
> +
> +                               mtk_ddp_comp_layer_config(comp, local_layer,
> +                                                         plane_state);
>                                 plane_state->pending.config = false;
>                         }
>                 }
> @@ -604,6 +632,10 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>         }
>
>         mtk_crtc->layer_nr = mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[0]);
> +       if (mtk_crtc->ddp_comp_nr > 1 &&
> +           mtk_ddp_comp_get_type(mtk_crtc->ddp_comp[1]->id) == MTK_DISP_OVL)
> +               mtk_crtc->layer_nr +=
> +               mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[1]);
>         mtk_crtc->planes = devm_kcalloc(dev, mtk_crtc->layer_nr,
>                                         sizeof(struct drm_plane),
>                                         GFP_KERNEL);
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
