Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD256C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:17:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853D520855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ByfWcFQ+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ukgrokuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853D520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EaHbmr5/ugerFTrAuHXtIUBuvNpS+3czNHaJ5ovyiFM=; b=ByfWcFQ+6adHOe
	WIr92EMdy0y2OOCRQmrts4hAlkcxBGAH7MosxyCPDKmjBFLnDyoQ4Eck7d04n+0Bis7jv9/NYJAUN
	aSxEFJ0BJBV3phTqJ+nyd7NrWOuNO5HbgTpXgYWWJ5LcTYtqe7O2+FQ2OTPhU/bmXLTM5t3CedrmV
	Nn5loXtq6IRBc0TfN9gKnAVkXiNeMn8hKDzw50wTHWGNuaoIeZvfAx+UmaPAazbpPJbDexv604A0p
	W3FH4yOkc2qrImmoRXqc8Fm/fb3KYG8rGIU8ujtxgQMw76lPL3/uibCrm+VKSxD+oQ6XwbCJsVjP2
	wwwJTB29UqdBOFAc7i+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkF2C-0005Im-R0; Thu, 17 Jan 2019 21:17:08 +0000
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkF29-0005I0-JE
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 21:17:07 +0000
Received: by mail-yb1-xb41.google.com with SMTP id q145so3557527ybq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 17 Jan 2019 13:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L8+pWFbjCXuZb0yF6AHOy187X+FZaQYqjUOMZpie9bQ=;
 b=UkgrokuhmHu5BHG9ibxHHWYsSKQA3yFgbi4+RJoVYS4roItRbCA+YtWxsQ3IbIDK5e
 pDvM+E6OCfoYyABAXjNnhy/jgIkT29DAdAIg/ZFVFfydlbfpF0A8+udmJ3KQVH/OGaTO
 vvtCH0aH7OLaI74+5J3X087dmFrWAnpfUMDkCkXU0CExTZrM6srsrUS7NrpjCJrAe7G/
 XunrDnB5IDTQCVFGiK+3QED+lKX1ms3JGwriAmXv3Wm4VeFIaktUpi9h5AlESJQ2dTc5
 Zday/2myvmMO5cZu6rGcDT/6oVsiTJVGQvOafg0pBDZXEYuYh4AFKFunlkL1tnb+oZ8h
 SNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L8+pWFbjCXuZb0yF6AHOy187X+FZaQYqjUOMZpie9bQ=;
 b=WphEWm3PwjyX5FySbX0rg3zdrfHtRLryolIatIZFeM3E9dR4Bio3CjNKAS6Za6i7qj
 182i4f69YPKUejnUcOdOgQBwSn1Z+cxFHE4AhDdBIkaGu+V/zn8CpcasZoXu0OrQ1WRD
 wMRMM64MNYuB+9SQg0XoWmRZvUQ1zv7bk4iLdlt/J7fi2MQQyr4gRVzHiaqScmaChlLx
 h+EC0dvYYjMlVh5xj+bBEa2dULiupX2IHGpY9mjSb7BaENM0fW1so69J58SD7b+7qJbO
 IEbNE9l4UCn6mk6fT93VBJEvHsJL/PbHs7DDdQhQQKDY4r45nZqlA8Z8URdSb9JRwdkS
 W+Ug==
X-Gm-Message-State: AJcUukclDcbCJNPDbPLlG3AiLowkv4uDA3qs3a+n6J2Fd1t8pKRtov8r
 SXVuSRePFET5lPEx4A6AITXz2wG2e5STe/pUN82vdQ==
X-Google-Smtp-Source: ALg8bN5L/+ZMMprFQ2JLwBhESmh/RacXyg5Z5w5UMTcZ6sNZUnbODdvqnV98JCzG9xUJjtbbSo2TxGh09Tfuc+xYG/M=
X-Received: by 2002:a25:7ec5:: with SMTP id z188mr3790812ybc.282.1547759822737; 
 Thu, 17 Jan 2019 13:17:02 -0800 (PST)
MIME-Version: 1.0
References: <20190117151942.6092-1-saiprakash.ranjan@codeaurora.org>
 <154775022743.169631.1716489383315213219@swboyd.mtv.corp.google.com>
 <CABXOdTfE+_q8DrRfPE1V+3pU7x5rLoOy7k5LYMrwd+xojsBWvw@mail.gmail.com>
 <20190117211410.GA30749@anatevka>
In-Reply-To: <20190117211410.GA30749@anatevka>
From: Guenter Roeck <groeck@google.com>
Date: Thu, 17 Jan 2019 13:16:51 -0800
Message-ID: <CABXOdTefAMjNypoa9uB2nMgAwi_e1pRMRxiDbXGfGT8_v7Ho-Q@mail.gmail.com>
Subject: Re: [PATCHv2] watchdog: qcom: Add suspend/resume support
To: Jerry.Hoemann@hpe.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_131705_660583_39779CFE 
X-CRM114-Status: GOOD (  23.13  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Rajendra Nayak <rnayak@codeaurora.org>, linux-watchdog@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>, Stephen Boyd <swboyd@chromium.org>,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 1:14 PM Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
>
> On Thu, Jan 17, 2019 at 11:09:31AM -0800, Guenter Roeck wrote:
> > On Thu, Jan 17, 2019 at 10:37 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Sai Prakash Ranjan (2019-01-17 07:19:42)
> > > > diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> > > > index 780971318810..5dfd604477a4 100644
> > > > --- a/drivers/watchdog/qcom-wdt.c
> > > > +++ b/drivers/watchdog/qcom-wdt.c
> > > > @@ -245,6 +245,28 @@ static int qcom_wdt_remove(struct platform_device *pdev)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> > > > +{
> > > > +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> > > > +
> > > > +       if (watchdog_active(&wdt->wdd))
> > > > +               qcom_wdt_stop(&wdt->wdd);
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int __maybe_unused qcom_wdt_resume(struct device *dev)
> > > > +{
> > > > +       struct qcom_wdt *wdt = dev_get_drvdata(dev);
> > > > +
> > > > +       if (watchdog_active(&wdt->wdd))
> > > > +               qcom_wdt_start(&wdt->wdd);
> > > > +
> > > > +       return 0;
> > > > +}
> > >
> > > This looks fairly generic. For example, the Mediatek driver also stops
> > > and starts (but also pings after starting). Grepping for 'active' in
> > > drivers/watchdog/ finds more examples. Could there be some functions in
> > > watchdog core that do the common things like watchdog_stop() and
> > > watchdog_start() and watchdog_start_and_ping()? Or maybe a bit can be
> > > set during registration so that the 'struct class watchdog_class' can
> > > get PM ops to stop and start on suspend/resume of the watchdog character
> > > device?
> > >
> > > Nothing is wrong with the patch, I'm just bemoaning the amount of code
> > > duplication here.
> > >
> >
> > Patch(es) to add the functionality to the watchdog core are welcome;
> > it should be possible to move the functionality into the core (maybe
> > to be enabled with a new watchdog API call). Doing it using the class
> > device sounds like an excellent idea. This should be straightforward
> > to implement, though the question of "should we ping on resume or not"
> > might be an endless source for bike shedding fun.
> >
> > Guenter
>
> It could be controlled by a currently unused bit in the
> watchdog_info.options.  Then people can agree to disagree.
>
I thought about that, but that would result in inconsistent behavior
across drivers. Of course we could be all fancy and make it runtime
configurable via ioctl.

Guenter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
