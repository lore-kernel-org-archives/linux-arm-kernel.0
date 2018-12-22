Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E002FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:50:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFE521934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CmrNQGCy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjnT/BUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFE521934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KFKx/rhOUIEQvcah9dCZvTHm+iz1rE03VFl+1VLezeE=; b=CmrNQGCyqOMI1G
	fLZaAuhH+5ikDLnnoNqnh8vvojeaDCPHbgwYCl0xYqhSRNPrO2DNY76AOBQcIcK+xVGAPtgNT2Jxg
	wVDUhaMrO+0Wf43dDSSPpw9VtL6HdCQ6M0eg7WeOxWqz7iHrMamBevCNMwJArkg6n1SK1yAk/VkIg
	FK1cZOMQ0wEcfd7ABLJ1h4I1xUNc5DXctupoy/WwXtVjbNBKz7jyv+03m7GpFTG5bDAcWpoyutR5U
	j4PbS6oZxukUTJOpdZY1e1tmwnantnxuPEeUlWSPNG3vqpvgsFyJqHmdAjiJoS9q2DQXkE3nTb17A
	8uvmSDwtqg4uwGccamlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gamLw-0005jh-I1; Sat, 22 Dec 2018 18:50:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gamLt-0005ii-W1; Sat, 22 Dec 2018 18:50:23 +0000
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 55D8D21934;
 Sat, 22 Dec 2018 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545504610;
 bh=EXOANm6tkF2VD+tusHpxMKU/XXyEeaq1YvVk9+PsR00=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=IjnT/BUShlBgikHhMQLg+sH3RlMO7frzPfTSNuVzGbVipnr7dpDk/V10vH0qch2PQ
 MOiDwz3V2GQRoVnvrsAiKuxC4hT4V+2wKxKtWg+qe+zWNE+FeizauxJAeD5jaxQurk
 yZz70wuj6FQKifDcloWEGLkGXzWmLz1lgO9n+Qhw=
Received: by mail-wr1-f52.google.com with SMTP id z5so8288654wrt.11;
 Sat, 22 Dec 2018 10:50:10 -0800 (PST)
X-Gm-Message-State: AJcUukcVjXZVpMcLIP4DY985yhcRm6r4bAtU9pelP2kkP/4x03MNWf80
 Kai7EeKjnJ6Z3Whf1muHaNTcEBzM+UvPCXSDEQQ=
X-Google-Smtp-Source: ALg8bN5lX4dZDF6anLCJlQsv8WTedtCVif7l7EUPUCJupBT0ZhY6oI2B03/yp2mobzDw6+eDiDQOys68duHtxfjBaZ0=
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr6691953wrw.132.1545504608825; 
 Sat, 22 Dec 2018 10:50:08 -0800 (PST)
MIME-Version: 1.0
References: <1545100282-15756-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1545100282-15756-1-git-send-email-chuanjia.liu@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Sat, 22 Dec 2018 10:50:01 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzoo6bw-3Hr56rgbL6EhrRvXX2y5pajaOo13c5MV9FsO7Q@mail.gmail.com>
Message-ID: <CAGp9Lzoo6bw-3Hr56rgbL6EhrRvXX2y5pajaOo13c5MV9FsO7Q@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl:mediatek:add judgment conditions
To: chuanjia.liu@mediatek.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_105022_050665_06AC4E07 
X-CRM114-Status: GOOD (  18.69  )
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

On Mon, Dec 17, 2018 at 6:32 PM <chuanjia.liu@mediatek.com> wrote:
>

I thought the subject still is much general, it should be further
improved with something like "add EINT support to virtual GPIOs" and
should say more about what virtual GPIOs means by MTKers in the patch
description because "virtual" is a usual term used throughout the
kernel and that would easily cause others to fail to interpret
correctly.

> From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
>
> This patch avoid return err when virtual gpio set SMT.
>
> Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> ---
> change note:
> v2 : 1. delete virtual gpio number
>      2. add judgment conditions
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index 4a9e0d4c2bbc..a576e417744a 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -290,7 +290,11 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
>                 return err;
>
>         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> -       if (err)
> +
> +       /* SMT doesn't support virtual GPIO, add err != -ENOTSUPP is used for
> +        * avoid return err when virtual gpio set SMT.
> +        */

I'd prefer to the comments as the below

/*
SMT is supposed to be supported by every real GPIO and doesn't support
virtual GPIOs, so the extra condition err != -ENOTSUPP is just for
adding EINT support to these virtual GPIOs. It should add an extra
flag in the pin descriptor when more pins with distinctive
characteristic come out.
*/

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
