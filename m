Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434BEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:10:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1358F208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="joee16yt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1358F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RdNA6IyAeBohRSY8CTbA9/OzW3JoVuXOAMtQzWhK4Sc=; b=joee16yt6qtBj1
	//M7Gqg44DNWv4dx6ODrb0tBFGi9dNyKIBVyLiKwfyrAdnOXtF9fabjP3GC4VuKYaKYr4qLSsXvyV
	xHg7b5N/roXjPk6gCx7DoBi9IZ4nBo+f5kn8YG/U3PlBhGKiSCLgYAgOKhp2YRmlO+WjMjZ1Xm0mB
	dnLjnZNl6GY4umLq9ylfm13xLla8AIqYyqSExM+H2DJqD6dhtosJxsg2Z9328D7fOcsonMsbA0WMW
	SvJX04K2MkHc51vL8riVl1z9EY7OE9Uts1bLf03sz+o9dqe5qGF39MHBsEtEJ6tMLEvwI+aQHFqAt
	E/SYwA5ThXIx44RgJJBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUdUk-0001jY-Je; Wed, 05 Dec 2018 20:10:06 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUdUe-0001MT-Re
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 20:10:02 +0000
Received: by mail-oi1-f194.google.com with SMTP id y23so18707411oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 12:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S8ZhQTd5ZYFVNr+fp/33hqBP5kxJlkpMr3IgxwjyEBI=;
 b=XQcO6pOuwt++NYrzyFHeUQm9FPUAsRbPKEzs8lDSMBat5S9WFZm/E76wAQC4yJvCjk
 2Ja8A9VMKFALraU9/aCPXi++eBZ3RjZ1PafeUeikSP82ZPaux0rWgiifnkAU2w+NZIlf
 aa+Cce38i6YEtRxdcNwh5ekEpDNxfcl3h+hAIFncXUZccRhOJg65IOd/rkVyefp0fXra
 P2rfJwRN24Qbe5vvUSVdW6XpK8xxEGl1UiDSS2hrMfmNiTvFXWSi7HOFLKbuo41yplaI
 d9ee2nUyiQ1hQlp9MqiGqW01KoYiYqZeXeqMPFJP3Y0ElHuBuSVbVt4+XakimedA7Mfw
 0P+g==
X-Gm-Message-State: AA+aEWY4LPdc2oU3CvkCCdoF8aWGKQ3HpxjoGUyiz0EXPGz97kZ7LTve
 cTwzSNmuHZwgFw19C2odzLoT+ukwoTw=
X-Google-Smtp-Source: AFSGD/Wwf8EuixisFmFJEiLJyoXkqrg1KlQTcJkiV5eVtfxhKXgEvafUJ2yneU1fyeUzoAVmB4ryCQ==
X-Received: by 2002:aca:4fc5:: with SMTP id
 d188mr15026027oib.138.1544040589824; 
 Wed, 05 Dec 2018 12:09:49 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com.
 [209.85.167.173])
 by smtp.gmail.com with ESMTPSA id t8sm8621033otp.69.2018.12.05.12.09.47
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 12:09:47 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id i6so18671514oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 12:09:47 -0800 (PST)
X-Received: by 2002:aca:31cb:: with SMTP id
 x194mr15145275oix.213.1544040587072; 
 Wed, 05 Dec 2018 12:09:47 -0800 (PST)
MIME-Version: 1.0
References: <1542869385-48337-1-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1542869385-48337-1-git-send-email-wang.yi59@zte.com.cn>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 5 Dec 2018 14:09:35 -0600
X-Gmail-Original-Message-ID: <CADRPPNQ97rNJPPL8f0yqhEqTRJw9FnR0U4YCCLxrx5nDB4Ydkg@mail.gmail.com>
Message-ID: <CADRPPNQ97rNJPPL8f0yqhEqTRJw9FnR0U4YCCLxrx5nDB4Ydkg@mail.gmail.com>
Subject: Re: [PATCH] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
To: wang.yi59@zte.com.cn
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_121000_902220_94B53F80 
X-CRM114-Status: GOOD (  21.49  )
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
Cc: zhong.weidong@zte.com.cn, lkml <linux-kernel@vger.kernel.org>,
 julia.lawall@lip6.fr, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 wen.yang99@zte.com.cn,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Zhao Qiang <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 22, 2018 at 2:42 PM Yi Wang <wang.yi59@zte.com.cn> wrote:
>
> From: Wen Yang <wen.yang99@zte.com.cn>
>
> Currently there are 2 problems with the ucc_of_parse_tdm function:
> 1,a possible null pointer dereference in ucc_of_parse_tdm,
> detected by the semantic patch deref_null.cocci,
> with the following warning:
> drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.
> 2,dev gets modified, so in any case that devm_iounmap() will fail even when
> the new pdev is valid, because the iomap was done with a different pdev.
> This patch fixes them.

While we are at this, I think this logic need more serious fixing.  I
see there is no driver bind with the "fsl,t1040-qe-si" or
"fsl,t1040-qe-siram" device.  So allocating resources using devm_*()
with these devices won't provide a cleanup path for these resources
when the caller fails.  I think we should probably allocate resource
under device of caller (e.g. ucc-hdlc), so that when caller probe
fails or is removed it will trigger the cleanup.

>
> Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> CC: Zhao Qiang <qiang.zhao@nxp.com>
> ---
>  drivers/soc/fsl/qe/qe_tdm.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
> index f78c346..9a29f0b 100644
> --- a/drivers/soc/fsl/qe/qe_tdm.c
> +++ b/drivers/soc/fsl/qe/qe_tdm.c
> @@ -47,7 +47,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>         struct resource *res;
>         struct device_node *np2;
>         static int siram_init_flag;
> -       struct platform_device *pdev;
> +       struct platform_device *pdev_si, *pdev_siram;
>
>         sprop = of_get_property(np, "fsl,rx-sync-clock", NULL);
>         if (sprop) {
> @@ -129,16 +129,16 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>         if (!np2)
>                 return -EINVAL;
>
> -       pdev = of_find_device_by_node(np2);
> -       if (!pdev) {
> +       pdev_si = of_find_device_by_node(np2);
> +       if (!pdev_si) {
>                 pr_err("%pOFn: failed to lookup pdev\n", np2);
>                 of_node_put(np2);
>                 return -EINVAL;
>         }
>
>         of_node_put(np2);
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       utdm->si_regs = devm_ioremap_resource(&pdev->dev, res);
> +       res = platform_get_resource(pdev_si, IORESOURCE_MEM, 0);
> +       utdm->si_regs = devm_ioremap_resource(&pdev_si->dev, res);
>         if (IS_ERR(utdm->si_regs)) {
>                 ret = PTR_ERR(utdm->si_regs);
>                 goto err_miss_siram_property;
> @@ -150,8 +150,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>                 goto err_miss_siram_property;
>         }
>
> -       pdev = of_find_device_by_node(np2);
> -       if (!pdev) {
> +       pdev_siram = of_find_device_by_node(np2);
> +       if (!pdev_siram) {
>                 ret = -EINVAL;
>                 pr_err("%pOFn: failed to lookup pdev\n", np2);
>                 of_node_put(np2);
> @@ -159,8 +159,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>         }
>
>         of_node_put(np2);
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       utdm->siram = devm_ioremap_resource(&pdev->dev, res);
> +       res = platform_get_resource(pdev_siram, IORESOURCE_MEM, 0);
> +       utdm->siram = devm_ioremap_resource(&pdev_siram->dev, res);
>         if (IS_ERR(utdm->siram)) {
>                 ret = PTR_ERR(utdm->siram);
>                 goto err_miss_siram_property;
> @@ -174,7 +174,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>         return ret;
>
>  err_miss_siram_property:
> -       devm_iounmap(&pdev->dev, utdm->si_regs);
> +       devm_iounmap(&pdev_si->dev, utdm->si_regs);
>         return ret;
>  }
>  EXPORT_SYMBOL(ucc_of_parse_tdm);
> --
> 2.9.5
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
