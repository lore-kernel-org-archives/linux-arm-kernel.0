Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A616C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:39:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD5E217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lOnrIFRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD5E217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+OnPmuXfepcah/7IJ+v1GvLIcAcZUXi8nc1+GN6g2mI=; b=lOnrIFRnH12O2h
	zacO2a+5+y2Sfkt/lQQXXGxRzn7d1v+5JSRLGf+zd/WN6VxXWnRR5Cr9WX2ug8duM+GdOeQtl3Ogh
	vm8l40uDXOslQlzx+/9e+qSs2WYREHLTMlqaf7SNwX1qIj8cwiX1g1jha5HX8dhoZUul4gKyDz6l9
	5SibMfx/xGJEPZbdvRA/3wJnDNAG0kNWtqqfZRrvxvcZ6KX1Q+r35jrWXDjLbb0Md71oeLeL+nDkE
	xVbl9M1MAO9lAB3DdV1TsDIfOb73QbU9u0o8nHrl8Vhui/nt+n4CbIzqeAwo742+Op+/HpFNzWRJL
	kg4m2cdf73pOm0G8MezQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf6xa-0008Di-Vm; Thu, 03 Jan 2019 17:39:10 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf6xX-0008C5-LL
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 17:39:09 +0000
Received: by mail-oi1-f195.google.com with SMTP id x202so28276630oif.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 09:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6DZzW66VVPYYwKb351IgdGl4LhNRguOE3nUFacZsWeU=;
 b=V0ZpsQlLhE86ZL/dzoZcUBF34kZxvtBmrlkdwxiVFW01GkQRDJguelrS/p+SY7pJ64
 K4b1U90SoajDLCxY9UpJq49CB9QdC7R2OiYb6D6JY7UNKh0SejKktcy7HHvYFV2+5ghM
 7Gm4yxBcZtq9Dv2FFfvLkuLYvDrYOSy5Zd7Fnr8wjobndYo0Mtc4H0j3nmUs0Qw00GM0
 Z83TRJRRFw4YBuLgCb+VGJFOFzbI89ARABN4SIX5wv9beUuyaYpAxfpLkxrb4vXX2rZ4
 +BcYA2nZzc9GMdC6g4Y66ucU4w6L9mCantbWuFAENjSsS7S1Sa6pDDJuPHf+Jbdlos0j
 +gCg==
X-Gm-Message-State: AA+aEWaBm5haDFIFMa/g9sX/bx8/y17pFaeiyAVDP5jc+dMg2WrbcdiH
 kCsejUZKg0VHLIC66qlZIuAJDnctGEupyUoyDd0=
X-Google-Smtp-Source: AFSGD/UD4eLUSYW8g1hpqewFWE2ZnhqNgvnUEyJetkcbPYNbBLNt6H2GhhBH0q6UiJABrf+9L6Et7H9vdjIZNiUTTgU=
X-Received: by 2002:aca:195:: with SMTP id 143mr30684057oib.322.1546537146567; 
 Thu, 03 Jan 2019 09:39:06 -0800 (PST)
MIME-Version: 1.0
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20190102185106.56913-1-swboyd@chromium.org>
 <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com>
 <154653191998.15366.14229484132412159772@swboyd.mtv.corp.google.com>
 <CAJZ5v0hwhuerPoizdYjqNkdymxubOweZ3JhPiXRUcrNtByz_=Q@mail.gmail.com>
 <154653631992.15366.980047163353936345@swboyd.mtv.corp.google.com>
In-Reply-To: <154653631992.15366.980047163353936345@swboyd.mtv.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jan 2019 18:38:55 +0100
Message-ID: <CAJZ5v0jj13UgkM+7ad8-17W_4cdOJw61FMyvshBAcybzaiea5A@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: platform: Add an error message to
 platform_get_irq*()
To: Stephen Boyd <swboyd@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_093907_701866_6E359127 
X-CRM114-Status: GOOD (  13.25  )
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
Cc: Rob Herring <robh@kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, javierm@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 3, 2019 at 6:25 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Rafael J. Wysocki (2019-01-03 09:22:56)
> > On Thu, Jan 3, 2019 at 5:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > I don't see much benefit to seeing -ENXIO or -EINVAL printed here, so I
> > > left out the error code.
> >
> > OK, so the value of the message is to tell the user that some driver
> > asked for an invalid IRQ, right?
>
> Yes.

OK

This can help to reduce code duplication a bit, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the v3.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
