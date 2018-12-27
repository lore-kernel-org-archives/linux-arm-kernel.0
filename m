Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B51C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:16:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A533421741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rugow7F5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJnW4UmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A533421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GA0t0/+SUg7dny1tD94y8bezK7z0fh+dg/Y7O7YT0oc=; b=rugow7F5UtVNDB
	VlEQxIQefJLFbfA1eZEPkN9qyEcF3IVQkQ/qWM1upK4BxzgSZUL5nZCtLhpD2ZNf1ayCxGreW+cvJ
	qgHgKTQmZsQ5VCy7Nlh1T056zQWVJ4QYLFETGoFwRGQQJZb52Z9xqnQyW2ftHW53DI3Hvixi4nLEt
	ow99x873oFVXxMbTrWEV1Om7OCFcLSFBHGBizK/iwfLnSdp2HFHG+clsQz2pSJGcasumtcgzmZjff
	fDRFq9P4ib0iVr52X6/Pik0ZihIv3rDR33Etsz2s5anLJ/I8vy0exflC6fwHlZlz9u1rw6jM0PFz5
	55fpGXzIi86h2CJrAG4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcb8g-0000Cu-Fi; Thu, 27 Dec 2018 19:16:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcb8a-0000Bc-PH; Thu, 27 Dec 2018 19:16:13 +0000
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2394921741;
 Thu, 27 Dec 2018 19:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545938156;
 bh=siPBobBc8ANH4OmhcEB4D7rA7WVJff/bLBSWLKVb3hc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=VJnW4UmVJIWyha0qlm7hNlC/qOnc8ecpqxeViWR6MedA1pK2KSTYEZ5l3HcKhVMB8
 Ez3q9x8adRP/6alBn1QfOFCxYjzZrdWg27I0g4p2zZ7LOroxldwpo1pxqCuWgvQp3L
 S9eiPqxm2k4+8Hn6ZxKCCRq7WcjbXU9kTHsqZjlc=
Received: by mail-wm1-f50.google.com with SMTP id d15so17445171wmb.3;
 Thu, 27 Dec 2018 11:15:56 -0800 (PST)
X-Gm-Message-State: AA+aEWbzKZMv6lrrODvWTBgVVdklYn7k5ol4IoIMKwOQWPKjdpk7777u
 ra22PvZJc19jkP0Ht2/atJaAjD5seLDier4N2CY=
X-Google-Smtp-Source: ALg8bN7Z0Enf3Jd1j2MB14s0qNayIYPSOCaKyOO6M9g+8FRePHkiBxXsTr97jNViED+kuQwmsr3gMQDv/6RyRgi1Kn8=
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr22911478wmu.52.1545938154592; 
 Thu, 27 Dec 2018 11:15:54 -0800 (PST)
MIME-Version: 1.0
References: <1545711838-20444-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1545711838-20444-1-git-send-email-chuanjia.liu@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 27 Dec 2018 11:16:09 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpRrXzikwn91oW_qZ76MK2RePR-npQsca9_Q3g38xdUpA@mail.gmail.com>
Message-ID: <CAGp9LzpRrXzikwn91oW_qZ76MK2RePR-npQsca9_Q3g38xdUpA@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl:mediatek:add EINT support to virtual GPIOs
To: chuanjia.liu@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_111608_841912_E6C50C41 
X-CRM114-Status: GOOD (  19.73  )
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
Cc: youlin.pei@mediatek.com, zhiyong.tao@mediatek.com,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
 hailong.fan@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 24, 2018 at 8:25 PM <chuanjia.liu@mediatek.com> wrote:
>
> From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
>

there are still some nitpicks

an empty char should follow the ':' char

> Virtual gpio only used inside SOC and not being exported to outside SOC.
> Some modules use virtual gpio as eint and doesn't nedd SMT.

s/nedd/need/

> So this patch add EINT support to virtual GPIOs.
>
> Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> ---
> change note:
> v3 : 1. modify subject and description
>       2. modify comments
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index 4a9e0d4c2bbc..a0db145f798d 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -290,7 +290,15 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
>                 return err;
>
>         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> -       if (err)
> +       /*

merge the second line to be consistent with the other comment blocks

> +        *SMT is supposed to be supported by every real GPIO and doesn't

an empty char should follow '*' char to be consistent with the other
comment blocks
and also in the other lines starting with '*'

> +        *support virtual GPIOs, so the extra condition err != -ENOTSUPP
> +        *is just for adding EINT support to these virtual GPIOs. It should
> +        *add an extra flag in the pin descriptor when more pins with
> +        *distinctive characteristic come out.
> +        */
> +

remove the blank line

> +       if (err && err != -ENOTSUPP)
>                 return err;
>
>         return 0;
> --
> 2.19.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
