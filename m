Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9BDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:50:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3702171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WJ//eU5I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhSr+GH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3702171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y9vBiMrzJBxKw8ZqRYRR6m/WEoWpubZ9smlwAJoUe9U=; b=WJ//eU5IZs217u
	+lwCQxQh1tf46kV0V/s/WA+cUJINf/ibTvY71dY+K83dpmYjX37yvUhc1i1AMmxgBVxmWwB9pBvPy
	UUqYfeY5H7R7Y05td2mXT5DydlmwsQNXRGpHEqxHRFxlwmk0PtCK0SbVMSCjHLlj8ynA4KNR6uxwe
	i6/V6JsaUVYTZdlZrpVWw8LPpWppfWr0b6lI1Qu+ZgdyKCNcX2T9Po75QKcVu/jK0Jn7sH+MZ3jtn
	pWDKA7assKVG5xMed/JnyFvY5+wgGYuZ1zSskrXLRUh6UxoRJ/mebR+6IT2ULa/vGHth/iEfdqqyx
	cwnicgdWTki2Z/GzMm+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gee6A-0005lW-2U; Wed, 02 Jan 2019 10:50:06 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gee65-0005Ec-3x
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 10:50:03 +0000
Received: by mail-ua1-x943.google.com with SMTP id c24so9773377uak.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 02:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KCM4zcI+RR1+/bzgV3jD0DJeQEh0SfqnhgYBnwCExKA=;
 b=ZhSr+GH0Y2o+ChXtECqlPg2rP4Nr+1BtEFq/dpOO0PGFbkvpFJbpHxjClnQr5nbQFM
 PFPzTZ5IApGDULCJkXB1lgegjGTDfxTbNbp0//3lK7ZyOHEtpB9u6Vm8AJN5ZT8Y/1u4
 JYH6MlhS1mm1bD+uHa8qepM8MO2u87w64PoWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KCM4zcI+RR1+/bzgV3jD0DJeQEh0SfqnhgYBnwCExKA=;
 b=mufDyQxMlhe6JNjMLmam5Ew/X4LuTxAQcGwv6jcOla36CzFsjKwT2NIfiKEcPUe+i1
 R3/WtdggEkZuOx6ZvwhLY1+GwyjGpjPRkFpPgVTrX2Hs1maMyrTY06g0G/ugK/nEk2Y9
 rwrJWgUTmPK6mX729gPBVonSjEYaUJZ4ZmU7HH/pqw0QK616+m+zp7EUgfRe8g3w2rBP
 8W1kT64m1utWATQVhcfQ7E9GOykHNCq47KAsOGVeptGr9T+OI05ffyNvgqoUUu3NIteq
 Ywk4gBf5RpWr81Xx1ZvGoeV8dPqz/hSSE9nQ/lW6VE7EXh8sQDeK/dRY5ps6kCfNj/uz
 EHFA==
X-Gm-Message-State: AJcUukcQtA6KSy2lkBC9UQWZMA0MUWmBjhR48bPt774M5TfNjGFBbi5D
 xErON8JqRpNhgiJopvG7UPgZOgZ89FdVhKfC9Tg1gg==
X-Google-Smtp-Source: ALg8bN4fbViE9+cPJv1b1sVfzEz7DZgfrnL4vh6GWW6q6S+ieK1Le3oi7CHDapOqDPdlQRmxEdrn1vMvxemh5ZXxTKc=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr14813289uad.119.1546426196756; 
 Wed, 02 Jan 2019 02:49:56 -0800 (PST)
MIME-Version: 1.0
References: <1545930550-9906-1-git-send-email-aisheng.dong@nxp.com>
 <CAPDyKFrP8HOum_4S0-4Bx+sYbTNSyctv3rQDB78zozeNWOuv=A@mail.gmail.com>
 <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42117D773477A408462D19D180B00@AM0PR04MB4211.eurprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Jan 2019 11:49:20 +0100
Message-ID: <CAPDyKFq4eji_FVKrRJ2k=c1iKuVP_3aERspy6vpXQzeFdBYt9w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] PM / Domains: Add multi PM domains support for
 attach_dev
To: Aisheng Dong <aisheng.dong@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_025001_167114_A23EF01A 
X-CRM114-Status: GOOD (  33.29  )
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
Cc: "dongas86@gmail.com" <dongas86@gmail.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 29 Dec 2018 at 07:43, Aisheng Dong <aisheng.dong@nxp.com> wrote:
>
> > From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> > Sent: Friday, December 28, 2018 11:37 PM
> >
> > On Thu, 27 Dec 2018 at 18:14, Aisheng Dong <aisheng.dong@nxp.com>
> > wrote:
> > >
> > > Currently attach_dev() in power domain infrastructure still does not
> > > support multi domains case as the struct device *dev passed down from
> > > genpd_dev_pm_attach_by_id() is a virtual PD device, it does not help
> > > for parsing the real device information from device tree, e.g.
> > > Device/Power IDs, Clocks and it's unware of which real power domain
> > > the device should attach.
> >
> > Thanks for working on this!
> >
> > I would appreciate if the changelog could clarify the problem a bit.
> > Perhaps something along the lines of the below.
> >
>
> Sounds good to me.
> I will add them in commit message.
> Thanks for the suggestion.
>
> > "A genpd provider's ->attach_dev() callback may be invoked with a so called
> > virtual device, which is created by genpd, at the point when a device is being
> > attached to one of its corresponding multiple PM domains.
> >
> > In these cases, the genpd provider fails to look up any resource, by a
> > clk_get() for example, for the virtual device in question. This is because, the
> > virtual device that was created by genpd, does not have the virt_dev->of_node
> > assigned."
> >
> > >
> > > Extend the framework a bit to store the multi PM domains information
> > > in per-device struct generic_pm_domain_data, then power domain driver
> > > could retrieve it for necessary operations during attach_dev().
> > >
> > > Two new APIs genpd_is_mpd_device() and dev_gpd_mpd_data() are also
> > > introduced to ease the driver operation.
> > >
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Kevin Hilman <khilman@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > ---
> > > This patch is a follow-up work of the earlier discussion with Ulf
> > > Hansson about the multi PM domains support for the attach_dev() function
> > [1].
> > > After a bit more thinking, this is a less intrusive implementation
> > > with the mininum impact on the exist function definitions and calling
> > follows.
> > > One known little drawback is that we have to use the device driver
> > > private data (device.drvdata) to pass down the multi domains
> > > information in a earlier time. However, as multi PD devices are
> > > created by domain framework, this seems to be safe to use it in domain
> > > core code as device driver is not likely going to use it.
> > > Anyway, if any better ideas, please let me know.
> > >
> > > With the two new APIs, the using can be simply as:
> > > static int xxx_attach_dev(struct generic_pm_domain *domain,
> > >                           struct device *dev) {
> > >         ...
> > >         if (genpd_is_mpd_device(dev)) {
> > >                 mpd_data = dev_gpd_mpd_data(dev);
> > >                 np = mpd_data->parent->of_node;
> > >                 idx = mpd_data->index;
> > >                 //dts parsing
> > >                 ...
> > >         }
> > >         ...
> >
> > I think we can make this a lot less complicated. Just assign virt_dev->of_node =
> > of_node_get(dev->of_node), somewhere in
> > genpd_dev_pm_attach_by_id() and before calling __genpd_dev_pm_attach().
> >
> > Doing that, would mean the genpd provider's ->attach_dev() callback, don't
> > have to distinguish between virtual and non-virtual devices.
> > Instead they should be able to look up resources in the same way as they did
> > before.
> >
>
> Yes, that seems like a smart way.
> But there's still a remain problem that how about the domain index information
> needed for attach_dev()?
>

What do you mean by domain index?

The ->attach_dev() is given both the device and the genpd in question
as in-parameters. Could you store the domain index as part of your
genpd struct? No?

If you are talking about using the "power-domains" specifier from the
DT node of the device, that should then work, similar to as been done
in:

drivers/soc/ti/ti_sci_pm_domains.c
ti_sci_pd_attach_dev()

You may also provide your own xlate callback for your genpd provider,
like what is done in drivers/soc/tegra/powergate-bpmp. - if that
helps!?

Or am I missing something?

[...]

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
