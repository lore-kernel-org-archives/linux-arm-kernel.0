Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C4C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:18:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE522218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 18:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pzr4C0qL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PFt7daVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE522218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jbJT77yQpYmF96FqAmGz9rpoFDfFCKbYcxXmPFLruKs=; b=pzr4C0qL4hp3N5
	dvY0rcMmd6jy5laLUY9MKZJpRXV/r6XtFLaK979cLre5MhWlHVW34ZlroiAqSgWWDQr0JCcbZgK39
	j/wBoPvDTleXoWfL/7AYRcsFkpXgCnxXMdw5c2VxxYAgAyWXazq8/8UzBtbTEQYr066A0wX4HmO8B
	VLJb5w//0uPLBAOVm5eVndE7iTPllmTKB46gxWb7eAMmPkD5bbf+LcWugdfvjPOGJukDE9yyXiA8M
	vOfDWut2heHokkpEyvvUClN9RkvyZVjcCK4wuFrv/snAyaFbv/ewxPxBEjHU9PHLQDMA2TfauvTUP
	GCGbhA/ItvSLtKFgll5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gel5g-0002Oq-Su; Wed, 02 Jan 2019 18:18:04 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gel5d-0002OC-V0
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 18:18:03 +0000
Received: by mail-pg1-x543.google.com with SMTP id g189so14898362pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
 :from:user-agent:references:message-id:date;
 bh=4BX045HuqzZQyLnghk5iaBiLMxe1Qq6U3uS4PB9/uLg=;
 b=PFt7daVNho4cL+SGAaJnt6xRclJEymy7RG1WUL+d3dyiTbMU0otgop2rC4MQffKGrA
 XG7N3vNiUXJ62b6+G+UUR6BxKSnXYO7A+l3Wv942x7lDb2iWUOD8TrzG9BxMHObIH4Ya
 k0qgzHq0RFyCveyIdYrgQigxU18J5xcJ6A7TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:subject
 :cc:to:in-reply-to:from:user-agent:references:message-id:date;
 bh=4BX045HuqzZQyLnghk5iaBiLMxe1Qq6U3uS4PB9/uLg=;
 b=Z2BlJHAlbd4Iwtsty1vG+hGTua4qPoXGl32ZZPEw04ihlgFjY/B6arcZuOgLsMOO2t
 q/COrmbRFTbyTTfl/d6JPwUjr5rp427dvvt2U9sakzouDUriVd2ycL1vD2QGOqpAAOgT
 CvW5jhLY0MeUB7rzInTUGHMDn0ZDSzYpKB9xvzK6xB2owRf6quD6UL4VL8Dt+D42jVya
 K/PXwwa7W7EaQR6955otv3kt0boo2O4XiCh2geTQOGVv1SiPWDXP+P4kXRzVfLzJTk/6
 KePfYAA3CEpHgLn3WAYaAD7OdeMxFQtbJ3+2FA6KuUX9UlkTlLmsQS93ja3lyWPWiVzQ
 ezQA==
X-Gm-Message-State: AA+aEWZJ8JJJvXUAM+TwzUNFMk6IJtTgwcaTKbh5ZAXMV5MbO4xSa0PR
 G3kda76Xij1qRILru/HtSZ8IXQ==
X-Google-Smtp-Source: AFSGD/UPHpLjW+AXVFjEjAm75gjeEgjowwb3HS9AAeGheP1dpquQ//uCgTP9undsY4Tnx9xebWkFng==
X-Received: by 2002:a62:6799:: with SMTP id t25mr45307411pfj.139.1546453080499; 
 Wed, 02 Jan 2019 10:18:00 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id n73sm86997017pfj.148.2019.01.02.10.17.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Jan 2019 10:17:59 -0800 (PST)
MIME-Version: 1.0
Subject: Re: [PATCH v2] driver core: platform: Add an error message to
 platform_get_irq*()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
In-Reply-To: <CAHp75Ve9YSPy14hwKOsjChZ6JhRYokLqm-RNs6xgu-RG-5QctA@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20181228215620.120672-1-swboyd@chromium.org>
 <CAHp75Ve9YSPy14hwKOsjChZ6JhRYokLqm-RNs6xgu-RG-5QctA@mail.gmail.com>
Message-ID: <154645307874.15366.9874268705850757907@swboyd.mtv.corp.google.com>
Date: Wed, 02 Jan 2019 10:17:58 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_101802_021515_24E440E7 
X-CRM114-Status: GOOD (  16.06  )
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
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Mark Brown <broonie@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Andy Shevchenko (2018-12-30 02:42:39)
> On Fri, Dec 28, 2018 at 11:56 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > A grep of the kernel shows that many drivers print an error message if
> > they fail to get the irq they're looking for. Furthermore, those drivers
> > all decide to print the device name, or not, and the irq they were
> > requesting, or not, etc. Let's consolidate all these error messages into
> > the API itself, allowing us to get rid of the error messages in each
> > driver.
> 
> > +static int __platform_get_irq(struct platform_device *dev, unsigned int num, bool warn)
> >  {
> 
> > +error:
> > +       if (warn)
> > +               dev_err(&dev->dev, "IRQ index %u not found\n", num);
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * platform_get_irq - get an IRQ for a device
> > + * @dev: platform device
> > + * @num: IRQ number index
> > + */
> > +int platform_get_irq(struct platform_device *dev, unsigned int num)
> > +{
> > +       return __platform_get_irq(dev, num, true);
> 
> Hmm... Why not just  do
> int  ret = __plaform_get_irq();
> if (ret)
>  dev_err();
> return ret;
> 
> instead of big refactoring of platform_get_irq()?

Sure. Thanks for the suggestion. But we need to check for ret < 0 I
suppose so that we don't print an error message for all the irq numbers.
I'll send the updated patch as a v3.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
