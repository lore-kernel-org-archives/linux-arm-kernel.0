Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3419C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:52:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747E420811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CCHroMkc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbp270yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747E420811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JE1pCD5Cm35ftEAlJgtL2+iqIKaM4rHG054G0NNzLg4=; b=CCHroMkcBm0U6l
	qtFqaP6o3waOSZoVmWHat+Sw0px8T36gvgp1eCla/o5zoAgGIkAeMzJ8pRhNJsHaZ/P9snassYbvI
	NcTzSUQ/8F8xQFMmViQxiDx3aV3HwqzC+DoTOUMZbhe9Ktwhv+zyOn9SpkWf4uQHIqk/E1Ig+AR2i
	MVdWJ4L1NNw+z8CHBQainRHyrisC4icVY/urOOlwbwQwoIa5wletoSTZ+7MMXguChgrlpYFIDpDDe
	djONH5P/LrJYmVd5nJlsn8nZ7lpTqrJArDc7yU5tp1WXdDL2VTPWyOg8TN8ruucSFUXeBnFIrXeU5
	KszRb9FKl8RwyMInikxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXX24-0007Hx-4S; Thu, 13 Dec 2018 19:52:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXX20-0007G3-NY; Thu, 13 Dec 2018 19:52:26 +0000
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 06B0620892;
 Thu, 13 Dec 2018 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544730734;
 bh=2i/AYWkFpEOlg+61T3YaTh6wAxl5PxRc41maMyWJSdI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Xbp270yxIQfjK7fnpEcEFLXY3rrvmtoYlTjrFPOI5D38VqBBTcmFIfNne21rQ63nf
 R4CuDV1mPLjeEDgGM0kb6o05XcWIwee42ropA9edH0NXFSCRJFYe0AtJKO1UpsMNRD
 ChbWegpQtOd7VMCL9bTg/zcSfY6YaU5x/HGq/4e0=
Received: by mail-wm1-f54.google.com with SMTP id m1so3579451wml.2;
 Thu, 13 Dec 2018 11:52:13 -0800 (PST)
X-Gm-Message-State: AA+aEWamQ93bHxIgUo/5kkzGlvSdLm5zsM0geJ0WsavMlmhu2QEqOK1B
 WxzUTx2JtNLE4wk65htDriV9yUC79SQFio7Nv4Q=
X-Google-Smtp-Source: AFSGD/VdKzErsmhgheAe4tPdHiaMdYZY63egoG/6rkOg2ATjLgHZOTebqJcMUFJM/049zlGxv5/3vDvS+xebT+lOLbU=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr749046wmh.92.1544730732499;
 Thu, 13 Dec 2018 11:52:12 -0800 (PST)
MIME-Version: 1.0
References: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 13 Dec 2018 11:51:40 -0800
X-Gmail-Original-Message-ID: <CAGp9LzrTZjEPLKEB+OwSVbLx=KBQRFVmN41KDqj_xTJ5oyU0KQ@mail.gmail.com>
Message-ID: <CAGp9LzrTZjEPLKEB+OwSVbLx=KBQRFVmN41KDqj_xTJ5oyU0KQ@mail.gmail.com>
Subject: Re: [PATCH] eint: add gpio vritual number select
To: chuanjia.liu@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_115224_796117_3FB6A2AA 
X-CRM114-Status: GOOD (  17.49  )
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
Cc: youlin.pei@mediatek.com, hongkun.cao@mediatek.com, zhiyong.tao@mediatek.com,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, hailong.fan@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

And the subject should be also corrected with prefix starting with
"pinctrl: mediatek:", typo fixup, and having a better subject close to
the content.

On Thu, Dec 13, 2018 at 1:36 AM <chuanjia.liu@mediatek.com> wrote:
>
> From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
>
> This patch add gpio vritual number select,avoid virtual gpio set SMT.
>
> Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/mtk-eint.h              |    1 +
>  drivers/pinctrl/mediatek/pinctrl-mt8183.c        |    1 +
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |    9 ++++++---
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
> index 48468d0..c16beaf 100644
> --- a/drivers/pinctrl/mediatek/mtk-eint.h
> +++ b/drivers/pinctrl/mediatek/mtk-eint.h
> @@ -37,6 +37,7 @@ struct mtk_eint_hw {
>         u8              ports;
>         unsigned int    ap_num;
>         unsigned int    db_cnt;
> +       unsigned int    vir_start;
>  };
>
>  struct mtk_eint;
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> index 6262fd3..bbeafd3 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> @@ -497,6 +497,7 @@
>         .ports     = 6,
>         .ap_num    = 212,
>         .db_cnt    = 13,
> +       .vir_start = 180,
>  };
>
>  static const struct mtk_pin_soc mt8183_data = {
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index 4a9e0d4..ca3bae1 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -289,9 +289,12 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
>         if (err)
>                 return err;
>
> -       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> -       if (err)
> -               return err;
> +       if (gpio_n < hw->eint->hw->vir_start) {
> +               err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> +                                      MTK_ENABLE);
> +               if (err)
> +                       return err;
> +       }
>
>         return 0;
>  }
> --
> 1.7.9.5

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
