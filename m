Return-Path: <SRS0=E6tZ=PC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FC1C07520
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:16:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EE6218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 04:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nn9abpWo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KEfh6oir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EE6218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SSD7boGWurvmBg8bTwja5IMZitzuuuD230C6gKzKw/U=; b=Nn9abpWo64DiQ7
	Lx/cGLXSFs9f/sXQY4jvzr3ufD5jNbmKfY5V5p50ScYhI21NUZVIRNExhJe84847c5EWfLkiaTic5
	+YkfUXHpXTp9Kp/EnA84xZVVHZ6TN8wOzjXe1IuUb1c7uHK7PcGsgpUlMJgnp5cEZVfatx5Qoqod5
	333OeVBhwA5MWGqfaOUbsH3mIDEv/7VcbM9jKoiczUW3NEpxCEPxZyCjIOnAkZs2tqzbOrzICSb7f
	+czH01kY4XQVyCP5f+Ua8ONORMbGBRv3ljFxhTldyNs7jgelznTRYdKPaRelGfo4bRYsCT9ozK9H+
	C6SyqbchVPdKygtGa/BQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbe8a-000634-6C; Tue, 25 Dec 2018 04:16:12 +0000
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbe8T-00061r-Gq
 for linux-arm-kernel@lists.infradead.org; Tue, 25 Dec 2018 04:16:09 +0000
Received: by mail-qk1-x741.google.com with SMTP id r71so7755172qkr.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 24 Dec 2018 20:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4fLaJ9WArwsfvNaLAZ8iEKft++hOrau5AV7vS/wxgZw=;
 b=KEfh6oirEOs7YwLIvfEoKJ/f9+ivNg3AZXMEeU2TqFQ8v0JH+X3GVJ3W4sLKttZnsR
 oZLgO3MLwpJi/+CwDQKnbTmMG7H1nNZqZ2VWPvG/3Cr1fLSOS/hPoQO1rGUS54s2ldhF
 kxlRMFULW4cZw4oNaCWnbu0O0cQIVldWdjImQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4fLaJ9WArwsfvNaLAZ8iEKft++hOrau5AV7vS/wxgZw=;
 b=fH4qreXUsZWk824a/J3ophmKKpvQblzi8GtMp963MbA90CFkwhxR3VMMitwqjYnJDO
 Bcq5eoyEJvujzVqe+wP3wHX7ccUClbvEHP8IzaNHMlRuCT299VMJTOy1iDPGlWeoahVq
 skmFPUI/Pldn5tXUXqcFSV054RjA1THvFNCa8EoyOxpJTVhvlyn+XkqyvVYIFZo/8Jze
 I1JV8J1rw0aLPJ9rzYU7mTOGr3qD5hgZRBfygJ7V1cLPwyHbtGi0PYgnrogxuPfPH6tO
 5pA1J9bNxQYmwoCGmHa32u3J97hukA/vpikb79QMh7SaLQkjMxOeVeWGiVj8dAaZOZET
 se8Q==
X-Gm-Message-State: AJcUukfiYZODmld1+sJdaIjVdMKtuHUQdA9ZVs8VPtZxiOC/5lHwSoS6
 kQeR7gUo1iIW0y3z2jWN8V92vyDDdvvPFyw6eOtWbQ==
X-Google-Smtp-Source: ALg8bN5QE7B8DqfMGmo68JsdDxoWuPqrpXJeDayRTJjMK0XXZGW+9ZHVpZ9L4OWdnouJENVHWbG7S5BLpDuYy4p9SQg=
X-Received: by 2002:a37:7885:: with SMTP id
 t127mr14062107qkc.323.1545711353630; 
 Mon, 24 Dec 2018 20:15:53 -0800 (PST)
MIME-Version: 1.0
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
 <1545638931-24938-11-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1545638931-24938-11-git-send-email-yongqiang.niu@mediatek.com>
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Tue, 25 Dec 2018 12:15:42 +0800
Message-ID: <CANMq1KC_JwVfvFd46_gP_wK_QNO0LTZOcwRAbotF6MghYivJYw@mail.gmail.com>
Subject: Re: [PATCH 10/18] drm/mediatek: add gmc_bits for ovl private data
To: Yongqiang Niu <yongqiang.niu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181224_201605_585047_64E4EEC3 
X-CRM114-Status: GOOD (  19.36  )
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
> This patch add gmc_bits for ovl private data
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 28d1911..afb313c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -39,7 +39,9 @@
>  #define DISP_REG_OVL_ADDR_MT8173               0x0f40
>  #define DISP_REG_OVL_ADDR(ovl, n)              ((ovl)->data->addr + 0x20 * (n))
>
> -#define        OVL_RDMA_MEM_GMC        0x40402020
> +#define GMC_THRESHOLD_BITS     16
> +#define GMC_THRESHOLD_HIGH     ((1 << GMC_THRESHOLD_BITS) / 4)
> +#define GMC_THRESHOLD_LOW      ((1 << GMC_THRESHOLD_BITS) / 8)
>
>  #define OVL_CON_BYTE_SWAP      BIT(24)
>  #define OVL_CON_MTX_YUV_TO_RGB (6 << 16)
> @@ -57,6 +59,7 @@
>
>  struct mtk_disp_ovl_data {
>         unsigned int addr;
> +       unsigned int gmc_bits;
>         bool fmt_rgb565_is_0;
>  };
>
> @@ -140,9 +143,23 @@ static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
>  static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
>  {
>         unsigned int reg;
> +       unsigned int gmc_thrshd_l;
> +       unsigned int gmc_thrshd_h;
> +       unsigned int gmc_value;
> +       struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
>
>         writel(0x1, comp->regs + DISP_REG_OVL_RDMA_CTRL(idx));
> -       writel(OVL_RDMA_MEM_GMC, comp->regs + DISP_REG_OVL_RDMA_GMC(idx));
> +
> +       gmc_thrshd_l = GMC_THRESHOLD_LOW >>
> +                     (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
> +       gmc_thrshd_h = GMC_THRESHOLD_HIGH >>
> +                     (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
> +       if (ovl->data->gmc_bits == 10)
> +               gmc_value = gmc_thrshd_h | gmc_thrshd_h << 16;

I don't really get what this does, but is it intentional that you
don't use gmc_thrshd_l here?

Also, if you only ever use 8 or 10 bits gmc, maybe it's easier to
hard-code the 2 values?
if (ovl->data->gmc_bits == 10)
  gmc_value = OVL_RDMA_MEM_GMC_10BIT;
else
  gmc_value = OVL_RDMA_MEM_GMC_8BIT; //0x40402020

> +       else
> +               gmc_value = gmc_thrshd_l | gmc_thrshd_l << 8 |
> +                           gmc_thrshd_h << 16 | gmc_thrshd_h << 24;
> +       writel(gmc_value, comp->regs + DISP_REG_OVL_RDMA_GMC(idx));
>
>         reg = readl(comp->regs + DISP_REG_OVL_SRC_CON);
>         reg = reg | BIT(idx);
> @@ -324,11 +341,13 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
>
>  static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
>         .addr = DISP_REG_OVL_ADDR_MT2701,
> +       .gmc_bits = 8,
>         .fmt_rgb565_is_0 = false,
>  };
>
>  static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
>         .addr = DISP_REG_OVL_ADDR_MT8173,
> +       .gmc_bits = 8,
>         .fmt_rgb565_is_0 = true,
>  };
>
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
