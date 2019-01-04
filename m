Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97ECC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:26:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A960920874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TAxAjv5A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsVGpWcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A960920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+sg2JTxySooBY7fHz2q941YCSlVILf+zy68dSvXOMMg=; b=TAxAjv5A8uVf4P
	HxHkLKSNJSt5nw2sgHmtX7M6hqBNyLDIXPVjMxZohKNhVuCv0ReavaHxf6SKhB3HSHcgnWmGA2a+m
	kKFkZlwwPM/6VYBMYqhcR1rEnOCkJvGqRujcLKZNUcu/Bne6kIPUSeDk2qDEYftWTItyk9eS4WQwY
	JOA2V02UUZld78KjCN4cuYQ5CifXT7DXEJ4S/zbqkUHfy0an8sPENX9rr9q8vC1ytsQzUQ9aFJLVQ
	7UWEfsId+/dtOD2/ZygPD7bYwaXBzJqBjSTxfwbu1NUD/94Y/jWfy63gY778815fE2G0ZX4Ahp6po
	k2b4JPX9ntxCdLmw4UaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfMfv-0001qc-AM; Fri, 04 Jan 2019 10:25:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMfr-0001qC-Kx; Fri, 04 Jan 2019 10:25:57 +0000
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 96AC720874;
 Fri,  4 Jan 2019 10:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546597554;
 bh=CH83fWi6aXHDbkfbQ8crdcBsK6AL/E+/iMFA7cyrKRE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DsVGpWcs5k7cq3wJ9GUCTkgSHdbek49EzjpRrtdjP52yCkwFL77AM8O02s4eD83Du
 TzmWf48ytuBrfKB0246jdx6zOpEg6atV8qmOYYc9rZ9ac8TiPUVuQhXIpSXR8CExEj
 s+YVv7fP1Quc1KfyQWgCRnOyN4uG46JK3adY5EvY=
Received: by mail-wm1-f46.google.com with SMTP id n190so707995wmd.0;
 Fri, 04 Jan 2019 02:25:54 -0800 (PST)
X-Gm-Message-State: AJcUukfHcaebtA3Ri6M7l9RWyBnmCAET0zJjYfVjEHBaWlq7CYpLCrOr
 M5J9GpO0QRfinZ3T4xyTLk9bcqJmmWjBIQ4N7So=
X-Google-Smtp-Source: ALg8bN58ntAz8LOaWcaQRSeGseKr3DsG3+PZJM9xMfaJzSiqys5fg8KNo62LnHp26TeEc+p2WgMmSgQ6DDJfzfS3sEM=
X-Received: by 2002:a1c:6607:: with SMTP id a7mr859765wmc.129.1546597553112;
 Fri, 04 Jan 2019 02:25:53 -0800 (PST)
MIME-Version: 1.0
References: <1546486635-16829-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1546486635-16829-1-git-send-email-chuanjia.liu@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Fri, 4 Jan 2019 02:26:46 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzop3UaUt8Kx4LsPxkoo_4uZF-7bv2BOqHgwmurmEA9CLA@mail.gmail.com>
Message-ID: <CAGp9Lzop3UaUt8Kx4LsPxkoo_4uZF-7bv2BOqHgwmurmEA9CLA@mail.gmail.com>
Subject: Re: [PATCH v5] pinctrl: mediatek: add EINT support to virtual GPIOs
To: =?UTF-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= <chuanjia.liu@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_022555_725946_6BF5E3E7 
X-CRM114-Status: GOOD (  19.97  )
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
Cc: youlin.pei@mediatek.com, Zhiyong Tao <zhiyong.tao@mediatek.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
 hailong.fan@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= <eddie.huang@mediatek.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 2, 2019 at 7:38 PM <chuanjia.liu@mediatek.com> wrote:
>
> From: "chuanjia.liu" <Chuanjia.Liu@mediatek.com>
>
> Virtual gpio only used inside SOC and not being exported to outside SOC.
> Some modules use virtual gpio as eint and doesn't need SMT.
> So this patch add EINT support to virtual GPIOs.
>
> Signed-off-by: chuanjia.liu <Chuanjia.Liu@mediatek.com>

Acked-by: Sean Wang <sean.wang@kernel.org>

BTW, if you were worried about a patch is lost, you could use RESEND
in the tag is fine.

> ---
> change note:
> v5: This patch is the same as v4,re-upload due to
>       mail permissions issues
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index 4a9e0d4c2bbc..b1c368455d30 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -290,7 +290,13 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
>                 return err;
>
>         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> -       if (err)
> +       /* SMT is supposed to be supported by every real GPIO and doesn't
> +        * support virtual GPIOs, so the extra condition err != -ENOTSUPP
> +        * is just for adding EINT support to these virtual GPIOs. It should
> +        * add an extra flag in the pin descriptor when more pins with
> +        * distinctive characteristic come out.
> +        */
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
