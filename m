Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E352C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:40:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED68520821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z/tJCkOq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERl4PjnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED68520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NCXhdjfPUwMQI/cYVIuStWvP2vHZCnLqi7J1ek5TjCw=; b=Z/tJCkOqMHd5W+
	njhbBO5VArD7Ur4ff2uAQsvgsXzU/+DgAKZk6V0BEa+a4RvOuFfzdipMBt7R4IGPAWS0ACxPmvPJu
	OLMb7YqaPGLi80dhJ1TMJUdeGJGuT5gFMsYok/wqmob8vkC+J/Zrtzlkp/94beIKGgbZmnb7+6hFp
	D44VQmxYIJnnJsgOCvWy9LsBbk4hhZBtgj/psEqAVqyuxhAeo/7bzCC6jL3mysn13siUxzPgS+Z8g
	WIneAiO3itYM45PNeJQj5aZC5JROOFCiELGr+Mhyzz2m5ri5+i0D33h6ZiV7lsL0yhh55bdyThNy1
	t+6G2m4TEkn4IauXkvCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqwHC-0000F9-65; Tue, 05 Feb 2019 08:40:18 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqwH8-0000EP-PH
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 08:40:16 +0000
Received: by mail-it1-x142.google.com with SMTP id c9so6272635itj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B2bmbisHuVIYawJyBYYO7RFGK5f9BbXCucFYT52KAD4=;
 b=ERl4PjnQ47C0fFglkXDzEEbSo1xup4bX5rtbQgHooqis0KvfeNsLs+5xIkQ+2Dds3G
 2NF8WogtZwqwXhmh1KNqtR5Txsdrb6un8RzdVhaGB1CBWNtg1nwurPJFqQXUEpcYeebd
 ur3CMUYrg18NWjm3DOGemSzdQjh4mk+GcHimk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B2bmbisHuVIYawJyBYYO7RFGK5f9BbXCucFYT52KAD4=;
 b=F2Z0wHdwOequGckbK//ETsMymipFMpwzmgVLXJeREeqDTPFlufZfCVZMJF5FtsqCLL
 j8f+F/lEwYYorJNzSt/l5wJ0jP79C9ohb4RBvqfKQ0Vk8t7RDQ3Ui3F8KNWwnWL+y2nD
 /shusPK/JC1WNaT5gnO+BE6kETompBAycEH6PXxvSFKf+YoNQH3B0nBxbStAbcMDGQAv
 6twycozEKWW5sJlAHchfzgZ3x9H5Div1MkicG6ZUlSH2KVvPb8zBf+OxB4E+neKp+Hhz
 cu59n+eQ83r/mI17VFYuNSs/69ocBnfiSqpl6wdZI1k2RWsgSwoS4ICqP9NZ32gjcxlm
 tDqw==
X-Gm-Message-State: AHQUAuadP/5TyBWXcR50iYzQwrblH+teLyySg6hD52dk8Y5cOHHIo2eA
 yUlv0pRUh8p8aW2L15R58MtR99ikZkHRUdIW8MBe/g==
X-Google-Smtp-Source: AHgI3IbDR4EuPco6YNzypa0ZNqIf6S6yQEpVBszClWdskiIgbOWxkN6nloIFRJVCT+xCxeKp403dW6850iM/qOxm958=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr1897387ioh.294.1549356010339; 
 Tue, 05 Feb 2019 00:40:10 -0800 (PST)
MIME-Version: 1.0
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
 <1549297553-17647-2-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFrzs5PvrK_23HARKYkytPr3LF4S7j5rJ6LJANKmm7BMrA@mail.gmail.com>
In-Reply-To: <CAPDyKFrzs5PvrK_23HARKYkytPr3LF4S7j5rJ6LJANKmm7BMrA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 5 Feb 2019 09:39:59 +0100
Message-ID: <CAKfTPtCqj62fYHYDth0evMqBYxY9JgqVBngDe57D4XqBKw35UA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM-runtime: move runtime accounting on
 ktime_get_mono_fast_ns()
To: Ulf Hansson <ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_004014_846643_8AC50395 
X-CRM114-Status: GOOD (  19.01  )
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
Cc: Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thara Gopinath <thara.gopinath@linaro.org>, Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 5 Feb 2019 at 09:10, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 4 Feb 2019 at 17:25, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > Similarly to what happened whith autosuspend, a deadlock has been raised
> > with runtime accounting in the sequence:
> >
> > change_clocksource
> >     ...
> >     write_seqcount_begin
> >     ...
> >     timekeeping_update
> >         ...
> >         sh_cmt_clocksource_enable
> >             ...
> >             rpm_resume
> >                 update_pm_runtime_accounting
> >                     ktime_get
> >                         do
> >                             read_seqcount_begin
> >                         while read_seqcount_retry
> >     ....
> >     write_seqcount_end
> >
> > Move runtime accounting on ktime_get_mono_fast_ns()
> > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > monotonic across an update of timekeeping and as a result time can goes
> > backward. Add a test to skip accounting for such situation which should
> > stay exceptional.
> >
> > Fixes: a08c2a5a3194 ("PM-runtime: Replace jiffies-based accounting with ktime-based accounting")
> > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks

>
> Kind regards
> Uffe
>
>
> > ---
> >  drivers/base/power/runtime.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 1caa394..50740da 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -66,13 +66,22 @@ static int rpm_suspend(struct device *dev, int rpmflags);
> >   */
> >  void update_pm_runtime_accounting(struct device *dev)
> >  {
> > -       u64 now = ktime_to_ns(ktime_get());
> > +       u64 now = ktime_get_mono_fast_ns();
> > +       u64 last = dev->power.accounting_timestamp;
> >         u64 delta;
> >
> > -       delta = now - dev->power.accounting_timestamp;
> > -
> >         dev->power.accounting_timestamp = now;
> >
> > +       /*
> > +        * Because ktime_get_mono_fast_ns() is not monotonic during
> > +        * timekeeping update, we must ensure that now is after the last saved
> > +        * timesptamp
> > +        */
> > +       if (now < last)
> > +               return;
> > +
> > +       delta = now - last;
> > +
> >         if (dev->power.disable_depth > 0)
> >                 return;
> >
> > @@ -1312,7 +1321,7 @@ void pm_runtime_enable(struct device *dev)
> >
> >                 /* About to enable runtime pm, set accounting_timestamp to now */
> >                 if (!dev->power.disable_depth)
> > -                       dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
> > +                       dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
> >         } else {
> >                 dev_warn(dev, "Unbalanced %s!\n", __func__);
> >         }
> > --
> > 2.7.4
> >

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
