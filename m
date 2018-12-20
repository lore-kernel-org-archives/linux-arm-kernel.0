Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D943C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:04:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF01221741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CndAU6bO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF01221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o5u2w5v7DJEa9ZV1O5sFAQ0uz3KpWzWNVnTaw4u8uRE=; b=CndAU6bOpWJKwA
	0nIqAh3BXaYwc77EmlJ+BDQ0dWUHED4/+D5DrNZFpWeHkkMsysoTIRfSIAIDqGgS8YpqbgkkLiSjR
	8vW1/Olri9D6NM1YxSZ22I9IBgFeo+dn0XwDCwr4s6xEVzajbmgvxOyMssl756wBseT27J8Cdjtra
	Ha3hCrJcWmjpukMdJXw12CPGQZjnKmFjMDTr3aWGwONv/NAbwYGavWM9lsW9lVZKl4/B50WgS5KyL
	MVETz5ulseaQ20xZk2E7UqNEDpTMJK3fmU1DtgFKscPavJOpAY7EzRU9campCXlD9uDRE6ME+xHxU
	SEhoWG2QvkP+zwsvcXtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZw8F-0006xF-DP; Thu, 20 Dec 2018 11:04:47 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZw8C-0006vd-TZ
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 11:04:46 +0000
Received: by mail-oi1-f196.google.com with SMTP id c206so1252583oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 03:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ir0envVVH0hSP6+Lnkse77QqFdAXZk5hEs4bcky0ZQc=;
 b=uWiWwBdTumPsBxfMkv9Kf/Dlqyx/R4REKA6EaIzlnVkcDGziP8zfGDpO14U16MaClp
 25w4GlMGn6oOLmBmCPZgEbpKUg0cLFVIHS4sYjuNvaC/x6yNTeU0Sp9vz84/2uVbonKm
 Azgv2z3otm+hV6sQYpWNaH8C/PNF+dwRFUHj08VRsRgpITfp2laTfnRO/39zj+jpkWnN
 tzw/cRqub7hltLrz0gtHImEF2OB/RhKZ8yG0jNrRiePdXFrpw/i/FBOkttJGr8S0li6c
 61tyH9SbBrvlTzoNFGc71678ffpQTBsZNTDMLCQNxres+ZgcLoVchfF6JHzgzYfPGnUo
 qZsg==
X-Gm-Message-State: AA+aEWaC4id3jsO8u27GPNkRM92v3JzoXSoKUnzHSgSp+R0uQ7/i+J0o
 TtCl4sCBmsen3mZGh+xg2J89q9TUddShs+tRYtw=
X-Google-Smtp-Source: AFSGD/XBMKcRLYfmek0EtOz39gnxt7uxaPRa/MPzaqACkHxZjnEDaMkSx5Bdv12Ubh/SRyLGHUnndQC7xHmit1C1R8E=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr1730457oic.33.1545303872421; 
 Thu, 20 Dec 2018 03:04:32 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a@eucas1p1.samsung.com>
 <20181220102247.4911-1-a.hajda@samsung.com>
 <20181220102247.4911-3-a.hajda@samsung.com>
In-Reply-To: <20181220102247.4911-3-a.hajda@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Dec 2018 12:04:20 +0100
Message-ID: <CAJZ5v0jW3qu+ctS8h3BwZeQBD_6sF+yCPoQ1P-hEBidmOyWRkw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] driver core: add deferring probe reason to
 devices_deferred property
To: Andrzej Hajda <a.hajda@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_030444_958479_094C12A7 
X-CRM114-Status: GOOD (  18.29  )
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, javierm@redhat.com,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 20, 2018 at 11:23 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is probe_err function introduced recently,
> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred
> property.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v4:
>   - removed NULL check before kfree,
>   - coding style tweaking.
> v3:
>   - adjusted deferred_devs_show, to accept newline ended messages,
>   - changed conditonal check to positive,
>   - added R-b by Andy.
> v2:
>   - changed __deferred_probe_set_msg args - like in __dev_printk, fits better,
>   - use kasprintf instead of bunch of code,
>   - keep consistent format of devices_deferred lines,
>   - added R-Bs (again I hope changes above are not against it).
> ---
> ---
>  drivers/base/base.h |  3 +++
>  drivers/base/core.c |  9 +++++----
>  drivers/base/dd.c   | 21 ++++++++++++++++++++-
>  3 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7a419a7a6235..effbd5e7f9f1 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -75,6 +75,7 @@ struct device_private {
>         struct klist_node knode_driver;
>         struct klist_node knode_bus;
>         struct list_head deferred_probe;
> +       char *deferred_probe_msg;

Many drivers will never use this, so is the memory overhead justified?

>         struct device *device;
>  };

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
