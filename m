Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA162C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:06:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851EA21741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l9RmI3/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851EA21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HaEBnkXR5XmfAGMsVKCuTC40LsdWMOowCAYPE9gAV0g=; b=l9RmI3/CoVMhPI
	gjtIk5lzwX54yNgDDRSIYcYo+HcwWgEOb6pXlGIUvI/FFd/RAXodK9HUfq6ikkxwgtxUaWo7G+Y2+
	5VvKtheqBW5IudUP92aoifAiA8GM0csLf2e57PsHfYxp/tJ1EXw/z2+zaatB6PoBhJFlszuqy4Noc
	LC0HC4c0KtbuFfIP+2Fcd6TzQ9Ihv0etzk09TE6zMKog7HuHGDM/JwkT2TfJaPrYhb1QHvv/NrUa7
	iBgnqk4r/PFNpse59ihkUEFnifrwoES6J1zrhkT2fv+pw7hUbDpJM46nLch6Obt9Vl3fWG5eFkHqj
	fE8MeKUM21XQeCzEJ6Nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZw9S-0000Ze-5A; Thu, 20 Dec 2018 11:06:02 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZw9H-0000KL-UE
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 11:05:55 +0000
Received: by mail-ot1-f67.google.com with SMTP id w25so1249231otm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 03:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nq8d07HAa0tURcA9JYcwKrgnNSA4HwhiWl3XqEL59Zc=;
 b=NIZBrN9hK163ZIPK1GHclR/it7xjHy/1vrqe/umViRvZbyYYVR7yibC4GG+7c1jAJd
 iRvUE8i+3QGLgHNZ4hxGJon2sZ2j9PbpofFaiQqyEV9wOgy5ndia++7a0qpN4G6IteiI
 +BZUaMu1AHDpFxg9Thdkypi+KE2ffOcLqZFvZvw/QUi3uCDtrXFp+BABcqPDzI353Mvk
 Sy4z6ikeUVlNkRu7gpxGR+0x5drp8fmUIdMDIUZnqjyGFXghJ8Aqz1+m8IHk74MRpnZS
 +sS2GYhSiSS8zLn8r4n7vRBG3Py05FZUDBYfNzxnD63UEWzxBP+eyRts2S3x5ipPRJSJ
 XH3Q==
X-Gm-Message-State: AA+aEWbai6qfLe2EGfJBlb42Er/5fG2X4Oasjz9K1xIgw7uxXETLw95w
 rS7KVhRy7z+trVM63Sew6uzcWXXRqc9MClRqR3s=
X-Google-Smtp-Source: AFSGD/XBUlS0ADGlXz9kg54sao9pZE5paZ6+97pw61rIIxgIojgvRKmkFuaLFikqMe3TYsAr0EAM7pXCfDSDq2jexu8=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr16332731otf.124.1545303940805; 
 Thu, 20 Dec 2018 03:05:40 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181220102300eucas1p210735c7753688a52a73ccf026884dd11@eucas1p2.samsung.com>
 <20181220102247.4911-1-a.hajda@samsung.com>
 <20181220102247.4911-4-a.hajda@samsung.com>
In-Reply-To: <20181220102247.4911-4-a.hajda@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Dec 2018 12:05:29 +0100
Message-ID: <CAJZ5v0gzwu9Zf+1MjVqomqMuvZpHtpKizETgW0==7HBqDq2w-w@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] driver core: add probe_err_ptr helper
To: Andrzej Hajda <a.hajda@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_030552_832891_4C0FA9A1 
X-CRM114-Status: GOOD (  14.77  )
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
> probe_err is useful in multiple contexts where error is encoded in pointer.
> Adding helper performing conversion to error value should simplify code
> further.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  include/linux/device.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 2d3a1cc6f5da..50632414c363 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1594,6 +1594,8 @@ do {                                                                      \
>  extern __printf(3, 4)
>  int probe_err(const struct device *dev, int err, const char *fmt, ...);
>
> +#define probe_err_ptr(dev, ptr, args...) probe_err(dev, PTR_ERR(ptr), args)
> +
>  /* Create alias, so I can be autoloaded. */
>  #define MODULE_ALIAS_CHARDEV(major,minor) \
>         MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
