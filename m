Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25453C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:00:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E352C20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u+mSvQoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E352C20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S3NdffLa1OXk+rV/TIVamGsvcjrmjBRYdIgczYFGA3I=; b=u+mSvQoqBdoIwt
	22wXu5RIp74Y3CMJfYv4R81R5RdWV05BHHn6Y+Ixlh7J3XGEs8CuSk3OiljQcYGUywzpP86L4lN72
	6BMYtdRA29PFS6uHmrqFj2J2QJ6PUxi6opwwAxNpJ4kAyMDc9Azcgx4b9vBFdF0+egokB21hQBU43
	3URb0Qobar/bfr5qg7ZL+SvXXnKeXAXXRCgWuPeNSQPt8KzIQNOlyJskf4NAdYMAnm2Xl9sHUo/lI
	NTesq47irq61GbrRsiFCVG2HBHcUFMEDNQX8MUdPieY9KAidscXEMxMrvTxdIiIyy0IQti9JZ8sX6
	nOlf9ug+XAyLkAtP+uTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqlLZ-0001su-UO; Mon, 04 Feb 2019 21:00:05 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqlLW-0001ZH-6s
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 21:00:03 +0000
Received: by mail-ot1-f65.google.com with SMTP id t5so2291786otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 13:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8t/eRETEyRCUgiUcijbzoazp4Z0jlyKbgONQXdnpznM=;
 b=bgQk5YzoXnjtRmYe8KMIuPS7e3twIF/tURB3z9PrB0leny0DT9Vn8eFKph99sKQZCl
 6tydPmxzkOE/KVgfKlACxRCBbR2EW431fvzLzvPl7tPplXcKW0AJ1FOZYXpYVPDFWLbG
 nxZQLwic5yl7j6DdFbYB4vwVh6gMFQBQRsJFgV36ZLKAhe2/G9gFQviwcpW3EyWBVCOr
 1uSl/oBNZ+Vf1/tY98uf5TIdyQjd1GKoWn23WLQyo3sQHAQ4StCfor3pDcPajxVg50AU
 EzhMi8rI9Mh5li4KqLApWe15huiUmRkU08zwdpDV1/F6GD9MAvME+8T0YOyK3HC1KQ57
 UBfA==
X-Gm-Message-State: AHQUAuaSuKtxWWFTcSeB99/7fzJEUpKfePWWNwn1NGJxWIL9vvlw+zt2
 H8Zf96CPgrB8xBYdrW2nb7qwTE0V
X-Google-Smtp-Source: AHgI3IYm3cgfTAkRGch2edkMaW6Oh4PR9+k8ruPsy1H6yVT5XGeTtar3eYM8YUGLVamEqyatH4U+CA==
X-Received: by 2002:a9d:2248:: with SMTP id o66mr770172ota.61.1549314000856;
 Mon, 04 Feb 2019 13:00:00 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com.
 [209.85.210.47])
 by smtp.gmail.com with ESMTPSA id n8sm7241665otl.40.2019.02.04.12.59.59
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Feb 2019 13:00:00 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id t5so2291668otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 04 Feb 2019 12:59:59 -0800 (PST)
X-Received: by 2002:a9d:4549:: with SMTP id p9mr708724oti.51.1549313999678;
 Mon, 04 Feb 2019 12:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20190204141005.GA915@kadam>
In-Reply-To: <20190204141005.GA915@kadam>
From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 4 Feb 2019 14:59:48 -0600
X-Gmail-Original-Message-ID: <CADRPPNTM2_Ds7-BVbKWf87m+vMjkmT6XQQgKgzmWLn3JvUsX+Q@mail.gmail.com>
Message-ID: <CADRPPNTM2_Ds7-BVbKWf87m+vMjkmT6XQQgKgzmWLn3JvUsX+Q@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: Use after free in dpaa2_dpio_remove()
To: Dan Carpenter <dan.carpenter@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_130002_343880_00955617 
X-CRM114-Status: GOOD (  15.86  )
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Roy Pledge <Roy.Pledge@nxp.com>, kernel-janitors@vger.kernel.org,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Ioana Ciornei <ioana.ciornei@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 8:12 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The dpaa2_io_down(priv->io) call frees "priv->io" so I've shifted the
> code around a little bit to avoid the use after free.
>
> Fixes: 991e873223e9 ("soc: fsl: dpio: use a cpumask to identify which cpus are unused")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  Thanks.

> ---
>  drivers/soc/fsl/dpio/dpio-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index 2d4af32a0dec..a28799b62d53 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -220,12 +220,12 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
>
>         dev = &dpio_dev->dev;
>         priv = dev_get_drvdata(dev);
> +       cpu = dpaa2_io_get_cpu(priv->io);
>
>         dpaa2_io_down(priv->io);
>
>         dpio_teardown_irqs(dpio_dev);
>
> -       cpu = dpaa2_io_get_cpu(priv->io);
>         cpumask_set_cpu(cpu, cpus_unused_mask);
>
>         err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
