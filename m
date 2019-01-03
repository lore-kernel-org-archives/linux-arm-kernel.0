Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C491FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:25:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952F52073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PDqQVlRJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OJ5GPDpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952F52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:References:From:
	In-Reply-To:To:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kh6lwze04KFy6RpFlUVbXn+cfe3YG5WPND5dmp7D4e8=; b=PDqQVlRJSmEi1O
	UcyWDIllaCFYGAe3y+d/lSUR5gy76WCqm2Qc2mDoX5Cspk1MQeU0Nvf8otHjRtnW+cA45M9q10BhC
	+cuPH0ooyWFXTKIOi1Bbhqhqs8qxkDH2LQzp3C2VUJLkAZT4jhxZuKVYxflzbQA1+YB+kEbe51d8A
	6wl4qvDIdoyHoqFMRdIWyeBRGshXuy9mxh2iVXPnagcLP9qfExehu/oYEr73sVCT59pnkeU40iF2B
	SKCnQvYNMzDXtNJgKUyeC8Mc5ahEIqZNLPow0SJ+KzCssIqXmHT3j2oZ3xx9kN/21ErrGi2nRy4vc
	9lIr7RhU+l11y7KZ+A9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf6kH-00048w-Ns; Thu, 03 Jan 2019 17:25:25 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf6kE-000488-4S
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 17:25:23 +0000
Received: by mail-pg1-x543.google.com with SMTP id m1so16271135pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 03 Jan 2019 09:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:subject:cc:to:in-reply-to
 :from:user-agent:references:message-id:date;
 bh=/3f/8UT7w199nKPlhdUgU5QbN336qKDqa4dp0VAFn3o=;
 b=OJ5GPDpwIT5BUlrsmJcISqgZwLCriISgVDu9pY/mzNmYddwyBAZ87M7N/YfZV3IDKk
 4me6+5u77HMyi9RneH3J8W1HfTfx7hvGlyyeMp2gTP42ixyJtiAHhNeJqyqU+Qh/Mas8
 RuTe5IEVEkutHgWJKU1aqYYS1M/glQzmF1A7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding:subject
 :cc:to:in-reply-to:from:user-agent:references:message-id:date;
 bh=/3f/8UT7w199nKPlhdUgU5QbN336qKDqa4dp0VAFn3o=;
 b=nRLPWMWT+ogNHv3fGbtJ7KfG0kLdfCbaarPlq4dmFuPtui4LrrMisDIbK4welQsN1x
 yrbsCtjkoNS/pgMKyXYId6lFnzqgwtm7hh0/oPwmhWbCu/8DAFn5Hnyqh2L/dCHJG86t
 vUgCArWYDAZMtuUfAAtiywCs9ashi8Fi6qpEh6/myLfTthudMfkq1+4DusK0uuahSqOl
 IrEnpafHdLNLBsSnE36zkFW5M/MIKxx9IbTcNp2Ieuiv2KGFn4ocrVzm9j+JqS3J3Yel
 sa94QggXtcrvUKO3WfhVQ97YPX0IqyCTaRHR0y7mD6pKAF6wnIVcobSeTCR/3A0LfunX
 H2RQ==
X-Gm-Message-State: AA+aEWZnpZ3xCdG0XLM1FlspLpJ0CREKxDpFw4K9dpZFbT+4v2SoQG/3
 H6Y7OyfT5yoEBYg287As1dpmWrf08K1Nmw==
X-Google-Smtp-Source: AFSGD/UzT6muXz6Bru5yQRk20DRxN1niAZ9rGNBJ+HZdRIZhgPvmxrkm1qYWbbr+wkxnAGQgn4fjNg==
X-Received: by 2002:a62:16d6:: with SMTP id 205mr48856414pfw.256.1546536321419; 
 Thu, 03 Jan 2019 09:25:21 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id 78sm104626790pft.184.2019.01.03.09.25.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Jan 2019 09:25:20 -0800 (PST)
MIME-Version: 1.0
Subject: Re: [PATCH v3] driver core: platform: Add an error message to
 platform_get_irq*()
To: "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <CAJZ5v0hwhuerPoizdYjqNkdymxubOweZ3JhPiXRUcrNtByz_=Q@mail.gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
 <20190102185106.56913-1-swboyd@chromium.org>
 <CAJZ5v0iL_Fq0RUbLjMj9WBitDw2amNV_ybirkiPbuYb0zroGAg@mail.gmail.com>
 <154653191998.15366.14229484132412159772@swboyd.mtv.corp.google.com>
 <CAJZ5v0hwhuerPoizdYjqNkdymxubOweZ3JhPiXRUcrNtByz_=Q@mail.gmail.com>
Message-ID: <154653631992.15366.980047163353936345@swboyd.mtv.corp.google.com>
Date: Thu, 03 Jan 2019 09:25:19 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_092522_202587_B8FE79D0 
X-CRM114-Status: GOOD (  12.91  )
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

Quoting Rafael J. Wysocki (2019-01-03 09:22:56)
> On Thu, Jan 3, 2019 at 5:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > I don't see much benefit to seeing -ENXIO or -EINVAL printed here, so I
> > left out the error code.
> 
> OK, so the value of the message is to tell the user that some driver
> asked for an invalid IRQ, right?

Yes.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
