Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACFFC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:34:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C76A20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jS4QEufw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="183oY3Mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C76A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a0FO0JvEWwBO0Yh2DS2A7j/49veZjATnaOljMnA0AUY=; b=jS4QEufwFEmP16
	RDwwFWXeSBYQCXzqyVnxuW4G2OoAqjFZHxy0pWVDw6kzU+NDLynJK6NPSoVDe8r76NoN5Gsi14kKu
	W1vSxYQZlgNkYgoJpZ7Wt0tJELAwwOwCfXNFjEAwDByPaeD3+t5Ax0ypa3bXhW0+6qs1aOrbRxZSY
	kU3NQ1Q0+CwtpA2IysL0NV+ZzognExRATh1TM+Pvq7ZdL5A9c8WT/bMVENGqNxgzl2gGhqsOp7GZT
	daRBrK7Q8Ti5kNESlzs6mkD20FS6NovG7E8HxrrSZGHlo+pZXkysdK2I/WQti+faS2tnsHOpDpune
	itue+I4m7X4OMoSRM7vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXWkX-0000kb-DB; Thu, 13 Dec 2018 19:34:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXWkT-0000gC-Rd; Thu, 13 Dec 2018 19:34:19 +0000
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 606D920851;
 Thu, 13 Dec 2018 19:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544729646;
 bh=+2DwOz/MH+BB+HkI8y/EmWLob9eNm41yKPZRvzwGPgc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=183oY3MkNSyTam6gDEc+TnWQ5fXXTU7i0tMLCKRR5Fqx39ACy5YFSm4+JFDjOP1DJ
 OrHzpqsO3BgK7XW7AMHuwruRWxvGeyKONzi/VMHnXKyg7h2iyTYg6F3N71H1aS3+/c
 cFiGw2dzoW7cPKsHowDtfnczld4h73oU4WT2x2LE=
Received: by mail-wm1-f45.google.com with SMTP id y185so14615759wmd.1;
 Thu, 13 Dec 2018 11:34:06 -0800 (PST)
X-Gm-Message-State: AA+aEWYWVOP2r5m7pEhSpBwV4gjUZ+4T2c5I2TXYaVvuqn08QcZWVYr3
 Nzm0Sti06bemU1QTkVUeXHYXl8uenIhQ8du1D7k=
X-Google-Smtp-Source: AFSGD/WCM5TQMRZLYmU/DT5Vcx2iAEN58rY6k1Sj9drFCxAh1iwNp4t+ljPwQ3rilA3Sz8jVW6L2sESO8zdFcXrEHZY=
X-Received: by 2002:a1c:66c5:: with SMTP id a188mr605099wmc.129.1544729641513; 
 Thu, 13 Dec 2018 11:34:01 -0800 (PST)
MIME-Version: 1.0
References: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 13 Dec 2018 11:33:29 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpcRCMWSn-u6K6+eRT=Zr8PR22Vd381miyhVYbF87N02g@mail.gmail.com>
Message-ID: <CAGp9LzpcRCMWSn-u6K6+eRT=Zr8PR22Vd381miyhVYbF87N02g@mail.gmail.com>
Subject: Re: [PATCH] eint: add gpio vritual number select
To: chuanjia.liu@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_113417_927288_7876F240 
X-CRM114-Status: GOOD (  20.71  )
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

On Thu, Dec 13, 2018 at 1:36 AM <chuanjia.liu@mediatek.com> wrote:
>
> From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
>
> This patch add gpio vritual number select,avoid virtual gpio set SMT.

s/gpio/GPIO/
s/vritual/virtual/

Virtual GPIOs you said here that means these pins only used inside SoC
and not being exported to outside SoC, right? It seems this kind of
pins doesn't need SMT.

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

The changes will break these SoCs without a properly configured vir_start.

If SMT seems unnecessary for these kinds of virtual GPIOs pin in the
path, we can do it as

err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
                                        MTK_ENABLE);
/* please add comments for the exclusion condition */
if (err && err != -ENOTSUPP)
        return err;

If there is getting much special on certain pins between SoCs, and
then we can consider creating a desc->flag to split logic.

>
>         return 0;
>  }
> --
> 1.7.9.5

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
