Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E616EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:17:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B478820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uXQkfqvf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="QrohxhwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B478820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ap0Ej5LVwWrhy1sMMlTQekisj+D+0+9XmZgsGnwdU8g=; b=uXQkfqvfgVilfk
	rCT2H9ZJEIRParG7EloCgukrCzU3pX4melXgytL935lxyCct22lHTkL9xWPVF0KzjebBa/WODatJF
	rtwFrIRwRacXPjDOSq7K4cga8pFMIBddLi9w7aGt/XxnzHMDrq2w7iDK1JrecBfFz7yEfFfBIQnq9
	tLwGgptVhxcYNRV0oPg2tMiOxi7oDN87e++qEncL2l0Gm1Uf/Gr5NZbGiWXjuapBQCL2SUXvKCoxI
	oUSKh1Axf7UyWEsnfS/2wkgxED/WkkJaIZU0h0GZndXj2ddaFUFFkjvof/7NTDCxx3V7sykP0bN0o
	k+KdQDv9wa4L6Z9z9O+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk0ze-0002vg-29; Thu, 17 Jan 2019 06:17:34 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk0za-0002vF-7h
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 06:17:31 +0000
Received: by mail-qt1-x841.google.com with SMTP id e5so10138581qtr.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 22:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FKfY06XBvP+7+lbG+bUd4k8JgUNDe4s1OC2BG4+aqNQ=;
 b=QrohxhwH+D46iYBRsQWtmMIQDDPdVNdtow+/ApAd/32mCnidizUfQOmFMdAIe8fcLw
 y8frZX0ZFffmR+9hEtWESUAUy0cOu4N0QsyVJYh8wikeRI4TYnk5i138YQW30SjCPYKp
 7N63THQsW+z6Z+Qz9ut5aTs7kFbJHp87ul2yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FKfY06XBvP+7+lbG+bUd4k8JgUNDe4s1OC2BG4+aqNQ=;
 b=ZrmL/i9jZCGl6NDGGfgliBrx0WQtVZaGSw1UPxeIQIuIo3P6mxedqT/uO4UiD5q28p
 lVZiHOItWUShDfedIAByF63BG8NwKaMxuJwK5F04LyV+IsICk0CgpnbcZpCQ0e7WZAxj
 hk1acRC28EfIqN/Y0IQibowTsQ2qEAAWwV7vlp3V4HtX5uPu9P4zze04GaAAp8Tfo5Zz
 XaKU2WtqljdhiuVxOSR8ocB/FeOaRAx8nX3YUdyBMK0XZMM5yWNhx9dyd11oqeSYAdth
 L3/p0bbPFQiMVO/bcVV1MfL/0rNc77RsTpUp1CSVXVTt7I/At8Taq865Fw1iZ2uJ5I20
 3iCg==
X-Gm-Message-State: AJcUukchNMOREAJMks/SOoB5tuQSKOmqZ8stDqk3ibdBoDFMgBznErxW
 yeBpF9HFRoch4H+bNYgkI53Lux4evyN53SpNe0g=
X-Google-Smtp-Source: ALg8bN5JkY1m/cQon+3Je4qTIUqCns1PRy7wSqDPtkx1aQq/lr6LJ3SkBE7UsuAG3vxioE1AKMPRT5667+U/NQFoX7g=
X-Received: by 2002:ac8:748:: with SMTP id k8mr10223752qth.235.1547705847795; 
 Wed, 16 Jan 2019 22:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20190116220154.1026171-1-vijaykhemka@fb.com>
In-Reply-To: <20190116220154.1026171-1-vijaykhemka@fb.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Jan 2019 17:17:16 +1100
Message-ID: <CACPK8XdCVvUaCFsMXdEkc9KG0TQCGpYV55u-X7pY7vBLLHuQtw@mail.gmail.com>
Subject: Re: [PATCH v2] misc: aspeed-lpc-ctrl: make parameter optional
To: Vijay Khemka <vijaykhemka@fb.com>, Andrew Jeffery <andrew@aj.id.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_221730_469583_F0C007D1 
X-CRM114-Status: GOOD (  19.77  )
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

On Thu, 17 Jan 2019 at 09:02, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Makiing memory-region and flash as optional parameter in device
> tree if user needs to use these parameter through ioctl then
> need to define in devicetree.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Thanks! This looks okay to me. I tested it on one of our systems which
uses both flash and reserved memory and it was fine.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Can you also send a patch to update the bindings at
Documentation/devicetree/bindings/mfd/aspeed-lpc.txt ? I think the
only change you need to make is to move the memory region and flash
properties to optional (instead of required).

Cheers,

Joel

> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 58 +++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> index a024f8042259..332210e06e98 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -68,6 +68,7 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                 unsigned long param)
>  {
>         struct aspeed_lpc_ctrl *lpc_ctrl = file_aspeed_lpc_ctrl(file);
> +       struct device *dev = file->private_data;
>         void __user *p = (void __user *)param;
>         struct aspeed_lpc_ctrl_mapping map;
>         u32 addr;
> @@ -90,6 +91,12 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                 if (map.window_id != 0)
>                         return -EINVAL;
>
> +               /* If memory-region is not described in device tree */
> +               if (!lpc_ctrl->mem_size) {
> +                       dev_err(dev, "Didn't find reserved memory\n");
> +                       return -EINVAL;
> +               }
> +
>                 map.size = lpc_ctrl->mem_size;
>
>                 return copy_to_user(p, &map, sizeof(map)) ? -EFAULT : 0;
> @@ -126,9 +133,18 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
>                         return -EINVAL;
>
>                 if (map.window_type == ASPEED_LPC_CTRL_WINDOW_FLASH) {
> +                       if (!lpc_ctrl->pnor_size) {
> +                               dev_err(dev, "Didn't find host pnor flash\n");
> +                               return -EINVAL;
> +                       }
>                         addr = lpc_ctrl->pnor_base;
>                         size = lpc_ctrl->pnor_size;
>                 } else if (map.window_type == ASPEED_LPC_CTRL_WINDOW_MEMORY) {
> +                       /* If memory-region is not described in device tree */
> +                       if (!lpc_ctrl->mem_size) {
> +                               dev_err(dev, "Didn't find reserved memory\n");
> +                               return -EINVAL;
> +                       }
>                         addr = lpc_ctrl->mem_base;
>                         size = lpc_ctrl->mem_size;
>                 } else {
> @@ -196,17 +212,17 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>         if (!lpc_ctrl)
>                 return -ENOMEM;
>
> +       /* If flash is described in device tree then store */
>         node = of_parse_phandle(dev->of_node, "flash", 0);
>         if (!node) {
> -               dev_err(dev, "Didn't find host pnor flash node\n");
> -               return -ENODEV;
> -       }
> -
> -       rc = of_address_to_resource(node, 1, &resm);
> -       of_node_put(node);
> -       if (rc) {
> -               dev_err(dev, "Couldn't address to resource for flash\n");
> -               return rc;
> +               dev_dbg(dev, "Didn't find host pnor flash node\n");
> +       } else {
> +               rc = of_address_to_resource(node, 1, &resm);
> +               of_node_put(node);
> +               if (rc) {
> +                       dev_err(dev, "Couldn't address to resource for flash\n");
> +                       return rc;
> +               }
>         }
>
>         lpc_ctrl->pnor_size = resource_size(&resm);
> @@ -214,22 +230,22 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>
>         dev_set_drvdata(&pdev->dev, lpc_ctrl);
>
> +       /* If memory-region is described in device tree then store */
>         node = of_parse_phandle(dev->of_node, "memory-region", 0);
>         if (!node) {
> -               dev_err(dev, "Didn't find reserved memory\n");
> -               return -EINVAL;
> -       }
> +               dev_dbg(dev, "Didn't find reserved memory\n");
> +       } else {
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
> @@ -258,8 +274,6 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>                 goto err;
>         }
>
> -       dev_info(dev, "Loaded at %pr\n", &resm);
> -
>         return 0;
>
>  err:
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
