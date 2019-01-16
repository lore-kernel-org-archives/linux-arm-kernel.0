Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34F0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:11:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83791206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H0eAYXZb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="nmFSGF5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83791206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0zaN+YdmqmT4kz91VgXrDEztAUZd8o50zN6fhND6agQ=; b=H0eAYXZb8hvsSd
	bJdjML6EF3ehlMcvbv/lgLOv5di7prYXLfDFFgIiG9c10kG+JWUEAIn+fDqRhzSbx7B99mCs9wQbp
	z1E6k0nl8Rcz7Qy8ST8vOLFCqZFEh1bW0LURZvJ1a9yBJHbqszdanoeaM8aN3Blzi9SgtTLpeo7ix
	Uqr9a6dgH5YlPb0hWNjLXiJLymLC2IYsvh4bN72IZn1ZxPeRuR9Mp+Gb1+tbYDPQIBFPLGildWWoO
	kqUCOJO42e+gejr2+a82Vkf4R7WWiR5ovgCZHdZ2+e4k3xW2mmnBVRf/qEJMz75sClyzwD1f3F4OE
	dIxrN4Hh3Ptlde0iJgmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjYnf-0002nC-As; Wed, 16 Jan 2019 00:11:19 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjYnb-0002mS-Ef
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 00:11:17 +0000
Received: by mail-qt1-x841.google.com with SMTP id u47so5185733qtj.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 16:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9UWxkyK0epyPeU314jsRls3vNFn1c0AujvqZOvXdHDM=;
 b=nmFSGF5+YkIzhYrqbNwAkkJsJfCkjt4oSwtmOTJEido0I6J3ojm6ipVIn3MJdHxhJj
 9Y2FylhgPGO2V7mJzP3IEkPKSVPgOV1aPQlSW8YMod+NNBQsQAKUeVPrCFxov8y/aUTd
 bdfRFdh931J+3XUvq1oGcF3vvxbaV7504yAEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9UWxkyK0epyPeU314jsRls3vNFn1c0AujvqZOvXdHDM=;
 b=KUqjDHUkrR4SUt9yxJ2I2VlePqIhlu/7+4bxjKeQrZjH3vP/gy4vQDW6OFSF9MCcRh
 Tea1CniVBc5ri+HY8vDJDAPFxbL0iQj43Na7gj6PPG9C9L25qu/ze+LY3PBrN3gGGBH/
 XFB/XB52uUoejioPZkz3tp5Hf8PAOZxeNhwRBDX+XGoxRTW1fdqagKbPyxs882R2yMKc
 HN8C4qYH8h1p3cUzaYCvFavs+qy7Vfz2+0U4TzBega0eShPIsO/gqfhNMBpM2e8lEObS
 1q0oKZk8uYqLqwSZhQTfEHJjf5vp+6B/I23h+eReWi9ItVicVKFX8vXyqlo+ax9jZw/W
 XW4w==
X-Gm-Message-State: AJcUukcJCXaXcQ45x2zNQnK22zP7E2c500SdDsH6lWFTkM89TwzQishe
 5HuzptvLWE5U1dG8wu8SBI+5Dg+8QHf4d2ElVbs=
X-Google-Smtp-Source: ALg8bN4QOX2GrSFP9TsPFlPxQIvJb5FHhVnrwz3LVEvABZFa80Qz14Xsq6181xv66iH5XLoPQV3FbKMcbfw3EV3lghM=
X-Received: by 2002:a0c:e751:: with SMTP id g17mr5083778qvn.160.1547597472528; 
 Tue, 15 Jan 2019 16:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20190115015146.2412785-1-vijaykhemka@fb.com>
In-Reply-To: <20190115015146.2412785-1-vijaykhemka@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Jan 2019 11:11:01 +1100
Message-ID: <CACPK8Xesi2tQzH1d=Ow6VucO3qo6ptosKb-WDi-Cw1vg5FXGzg@mail.gmail.com>
Subject: Re: [PATCH] misc: aspeed-lpc-ctrl: make memory-region optional
To: Vijay Khemka <vijaykhemka@fb.com>, Andrew Jeffery <andrew@aj.id.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_161115_487049_E5C64AB1 
X-CRM114-Status: GOOD (  22.54  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-aspeed@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vijay,

On Tue, 15 Jan 2019 at 12:51, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Makiing memory-region as optional parameter in device tree if
> user needs to use memory-region then define in devicetree.

Thank you for finding the time to do this work. You're not the first
to be blocked by this limitation, but you are the first who found the
time to propose a patch.

I think we should complete the rework to make the flash device
optional too. Can you do a v2 with a proposal for that?

>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> index a024f8042259..20507f0764fb 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -90,6 +90,10 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                 if (map.window_id != 0)
>                         return -EINVAL;
>
> +               /* If memory-region is not described in device tree */
> +               if (!lpc_ctrl->mem_size)
> +                       return -EINVAL;
> +
>                 map.size = lpc_ctrl->mem_size;
>
>                 return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
> @@ -129,6 +133,10 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                         addr = lpc_ctrl->pnor_base;
>                         size = lpc_ctrl->pnor_size;
>                 } else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
> +                       /* If memory-region is not described in device tree */
> +                       if (!lpc_ctrl->mem_size)

Should it print a message here? I think a dev_dbg makes sense.

> +                               return -EINVAL;
> +
>                         addr = lpc_ctrl->mem_base;
>                         size = lpc_ctrl->mem_size;
>                 } else {
> @@ -214,22 +222,20 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>
>         dev_set_drvdata(&pdev->dev, lpc_ctrl);
>
> +       /* If memory-region is described in device tree then store */
>         node = of_parse_phandle(dev->of_node, "memory-region", 0);
> -       if (!node) {
> -               dev_err(dev, "Didn't find reserved memory\n");
> -               return -EINVAL;
> -       }
> +       if (node) {

Print a debug message when we didn't find the node.

> +               rc = of_address_to_resource(node, 0, &resm);
> +               of_node_put(node);
> +               if (rc) {
> +                       dev_err(dev, "Couldn't address to resource for reserved memory\n");
> +                       return -ENOMEM;
> +               }
>
> -       rc = of_address_to_resource(node, 0, &resm);
> -       of_node_put(node);
> -       if (rc) {
> -               dev_err(dev, "Couldn't address to resource for reserved memory\n");
> -               return -ENOMEM;
> +               lpc_ctrl->mem_size = resource_size(&resm);
> +               lpc_ctrl->mem_base = resm.start;
>         }
>
> -       lpc_ctrl->mem_size = resource_size(&resm);
> -       lpc_ctrl->mem_base = resm.start;
> -
>         lpc_ctrl->regmap = syscon_node_to_regmap(
>                         pdev->dev.parent->of_node);
>         if (IS_ERR(lpc_ctrl->regmap)) {

Down below here is this line:

>        dev_info(dev, "Loaded at %pr\n", &resm);

As resm is first used for the flash resource and then the memory
region, it will display the location of the flash when the memory
region is not present. This is confusing. You should either print out
the regions separately, or consider removing this dev_info completely.

> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
