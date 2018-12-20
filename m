Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FA4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:35:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5042A21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EyUqj+0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5042A21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AyELJ5RKY6uH850I723x73I8ID923o0WezRCx3HtwEY=; b=EyUqj+0bFvqLg8
	rm8Pn9NEL2X0kPixqvuR2oDSxm8j+y9pM3Pw+EJMNwa2j+KvGBZAO/FwhxUAMney26lMZtSyrR1On
	Uq4OjHSoLZ65EEawDfDLOTT1m19mFchZg1x1VUrLm7kLsrLtVFRpT+hxNDG9GyCzIdnIpDl/qIH5F
	QmFwqk/qoJJ233abjhbVU8vg3hQ3s2UvcXB6Djr90IEG774thEVAsyHS7kzl87mvlP1JQn+9IPCJL
	agSKsvCGdlidhpfoEOVP2l4KnAksV8uKeqM8dbNIcSrPvacqPJGVgd+TSbFAlC1MyEGSUgD91AWu5
	eah+c7XW1xEmloLZtJ4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZvgG-0006fm-Ld; Thu, 20 Dec 2018 10:35:52 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZvgD-0006eW-8S
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 10:35:50 +0000
Received: by mail-ot1-f68.google.com with SMTP id s5so1127646oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 02:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eLCDsw0Ehg/InjXwwxdbQFCOnNOo69hsIb55rOLFQHM=;
 b=PJCBqsgkCx6A2lESfd3hUFpw67+01T4G3UBUh9SS3xsG7+2q6bIHpbOAXK4czeh0La
 zVgVFyaZbfrGFQgjpsL16/MyhT8kuSiTd7QpOTiTag0F/x+z3+a4c3Fh78pz3bky/iC3
 ZMiDKAzM+iblWFqgWz7lwk2B7GHBNBEDqe/VFwEckyBcpdjnxfNStUZc2Kmhtp93rWfU
 e8f4zd7b87QDRIUUb6CqIQu2SKgbf+PeMSB4GhBKENqjPByNMQ9nDFnH9C8WZwgbe5Q6
 R5ESL7KKTfnMatnLWQEXg34FprrKUOWG+/MfbbNZmmxeyuqDu3Z0SWdQDhiqFK5RmWzk
 ieaQ==
X-Gm-Message-State: AA+aEWaHE5MiNjTVVsPdbmIOQ1jf85Vek/MUhiktiIazUrq8edo65GWa
 tN87asX1LVmxSCabVjdCCZj+p/ah7bZxIfUYfHE=
X-Google-Smtp-Source: AFSGD/WTF7cj30vtsipQOAdHMfLuUdcEidVbwt1UCFNuvVwEqDxfWOkCiGXFL7A/0DPW0p3vnhDmFHEQfQh0FN2nQhc=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr18120855otg.139.1545302137597; 
 Thu, 20 Dec 2018 02:35:37 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181220102259eucas1p2f748c68e01cd4e09a266da879722e218@eucas1p2.samsung.com>
 <20181220102247.4911-1-a.hajda@samsung.com>
 <20181220102247.4911-2-a.hajda@samsung.com>
In-Reply-To: <20181220102247.4911-2-a.hajda@samsung.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Dec 2018 11:35:26 +0100
Message-ID: <CAJZ5v0in=0FVaoUeL=s8CS+pGVpVo460sTXg4MX_P17pss7JbA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] driver core: add probe_err log helper
To: Andrzej Hajda <a.hajda@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_023549_303958_E03DDFAA 
X-CRM114-Status: GOOD (  22.12  )
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
> During probe every time driver gets resource it should usually check for error
> printk some message if it is not -EPROBE_DEFER and return the error. This
> pattern is simple but requires adding few lines after any resource acquisition
> code, as a result it is often omited or implemented only partially.
> probe_err helps to replace such code sequences with simple call, so code:
>         if (err != -EPROBE_DEFER)
>                 dev_err(dev, ...);
>         return err;
> becomes:
>         return probe_err(dev, err, ...);
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I'm not entirely convinced that the dev_err() log level is adequate
for this purpose, but anyway it looks like this may reduce code
duplication quite a bit, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v3:
>   - added 'extern __printf(3, 4)' decorators to probe_err,
>   - changed error logging format - newline at the end,
>   - added empty lines in probe_err around dev_err,
>   - added R-b by Mark and Andy.
> v2:
>   - added error value to log message,
>   - fixed code style,
>   - added EXPORT_SYMBOL_GPL,
>   - Added R-B by Javier (I hope the changes did not invalidate it).
> ---
>  drivers/base/core.c    | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/device.h |  3 +++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 0073b09bb99f..7f644f3c41d3 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3099,6 +3099,45 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>
>  #endif
>
> +/**
> + * probe_err - probe error check and log helper
> + * @dev: the pointer to the struct device
> + * @err: error value to test
> + * @fmt: printf-style format string
> + * @...: arguments as specified in the format string
> + *
> + * This helper implements common pattern present in probe functions for error
> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
> + * It replaces code sequence:
> + *     if (err != -EPROBE_DEFER)
> + *             dev_err(dev, ...);
> + *     return err;
> + * with
> + *     return probe_err(dev, err, ...);
> + *
> + * Returns @err.
> + *
> + */
> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> +{
> +       struct va_format vaf;
> +       va_list args;
> +
> +       if (err == -EPROBE_DEFER)
> +               return err;
> +
> +       va_start(args, fmt);
> +       vaf.fmt = fmt;
> +       vaf.va = &args;
> +
> +       dev_err(dev, "error %d: %pV", err, &vaf);
> +
> +       va_end(args);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(probe_err);
> +
>  static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>  {
>         return fwnode && !IS_ERR(fwnode->secondary);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 6cb4640b6160..2d3a1cc6f5da 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1591,6 +1591,9 @@ do {                                                                      \
>         WARN_ONCE(condition, "%s %s: " format, \
>                         dev_driver_string(dev), dev_name(dev), ## arg)
>
> +extern __printf(3, 4)
> +int probe_err(const struct device *dev, int err, const char *fmt, ...);
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
