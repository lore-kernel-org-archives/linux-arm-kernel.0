Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCEAC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:14:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CBC218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g628Dugi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FT5AXaAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CBC218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=57OuRIbij5TsL8zHjGkqaZ2E2SWIaX9iHWld6Eanx8o=; b=g628DugidlAU2O
	WDdVXVPwmNP/Mv6eGA8QjIB0D5dTTtqEp6nvEYLfi4omzeERo9WaYKr9+iJGtDWHI2LVqmzfi8PZQ
	ogzn1gkv7TeF2B566aa1BRr8cnWGRmxyu6bV4RawdVGAGg+i8qaB2WsP+/1ZO1ta9oP4Q117b9Iiq
	w55nwvC9Hi7lVBH2IHaiBEvk6dzxQuWKRHSvcwxtJnQJSV0UxEZ5qp5C6ae1eaurD21QoNqXxCggH
	RP6FUuo9m8mRGXktDg9PG5+Q9DTMWZLHASiYplSNxH7OTkG05gWxTL7LchLQcnvLmTonvyrOIAZQu
	xrRavhZyR9dwOylrHQrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golwv-0001uL-OB; Wed, 30 Jan 2019 09:14:25 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golws-0001tu-Qz
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 09:14:24 +0000
Received: by mail-io1-xd42.google.com with SMTP id k7so18768555iob.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7inwf88cJRcfDvtFYb4nhiHFyYrUFeMVx/Nfb8s/mDk=;
 b=FT5AXaAXfXtRDfMZj0oO+Efr7rG8gsAAdpmcHzCf8CKbR+a1cz5eh2VZotCPFPZjLk
 680Pyz+0OYHptrJ51KyjiwaYJ78QcwQetD9aN27OUiTK1HYITlS8nyLOKCayB8MH/khk
 L2aMTpUvqib4EcXqoNOiK9WP/MqTiLcLdfSLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7inwf88cJRcfDvtFYb4nhiHFyYrUFeMVx/Nfb8s/mDk=;
 b=EETXwj0P7+hGt8n7wKA313gO8K/x1fO3BNr7TwUicvBQMhOFs+UCXc0NF4fPXYd9Nu
 AyBSuwu1h5NmofW6GXgIKs+tfr4TQc80gWb2zMJEbv4/VNwCe9ojFo0ubwhNVHLQoszA
 uQxXKpgKcdxKciu7OxGX7PpEXd5D8wuk2/97s8MM093vWYrQtDtHAbHkQEH40zli6I78
 mHeYyWSvVtrhFT+IfcdyJ6hnsMrWcSKCTi9+SF4phc7Lrgegu4oriSDn4uKdAJZltJWM
 iY4v8JT31jDJ+FpWbIeb9yVUOdweOo5PyZWGNM8waMGqwhjiYNT2EUZbYbVVN2JLPrkX
 yn8g==
X-Gm-Message-State: AHQUAuZa8Xhc8D7SX4nksaoBusICzcWV4zwbxH84MWeT9l3V3VLHX4rV
 9qzo3CzkT4OUvYMvT20ZdZeHMKWMyoMr0GJ6MOtgIw==
X-Google-Smtp-Source: AHgI3IapTk6Cx+uKKxCvydUS5H0/P4+4cDs6ruKPWKS7IWgP3w5ITA1qsYh6ugiAg8mMMKjKnJhewyU+QSpiMRSqeDo=
X-Received: by 2002:a6b:c8c9:: with SMTP id
 y192mr16194143iof.183.1548839661820; 
 Wed, 30 Jan 2019 01:14:21 -0800 (PST)
MIME-Version: 1.0
References: <1548836194-15264-1-git-send-email-vincent.guittot@linaro.org>
 <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWYV-tDD2osdvs4yhD-mu2n8-JSC7rV8Zt5vW4kr8hdWQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 30 Jan 2019 10:14:10 +0100
Message-ID: <CAKfTPtBiWunvVHv=tpq7CPqAX+54d_dyPt6BME_m1_Wz+qPaTA@mail.gmail.com>
Subject: Re: [PATCH] PM-runtime: fix deadlock with ktime
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_011422_877264_FE1684EF 
X-CRM114-Status: GOOD (  21.63  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:TI ETHERNET SWITCH DRIVER \(CPSW\)" <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Geert,

On Wed, 30 Jan 2019 at 09:21, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Vincent,
>
> On Wed, Jan 30, 2019 at 9:16 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > The call path is:
> > change_clocksource
> >     ...
> >     write_seqcount_begin
> >     ...
> >     timekeeping_update
> >         ...
> >         sh_cmt_clocksource_enable
> >             ...
> >             rpm_resume
> >                 pm_runtime_mark_last_busy
> >                     ktime_get
> >                         do
> >                             read_seqcount_begin
> >                         while read_seqcount_retry
> >     ....
> >     write_seqcount_end
> >
> > Although we should be safe because we haven't yet changed the clocksource
> > at that time, we can't because of seqcount protection.
> >
> > Use ktime_get_mono_fast_ns instead which is lock safe for such case
> >
> > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
> > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Thanks for your patch!
>
> /**
>  * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
>  *
>  * This timestamp is not guaranteed to be monotonic across an update.
>  * The timestamp is calculated by:
>  *
>  *      now = base_mono + clock_delta * slope
>  *
>  * So if the update lowers the slope, readers who are forced to the
>  * not yet updated second array are still using the old steeper slope.
>  *
>  * tmono
>  * ^
>  * |    o  n
>  * |   o n
>  * |  u
>  * | o
>  * |o
>  * |12345678---> reader order
>  *
>  * o = old slope
>  * u = update
>  * n = new slope
>  *
>  * So reader 6 will observe time going backwards versus reader 5.
>  *
>  * While other CPUs are likely to be able observe that, the only way
>  * for a CPU local observation is when an NMI hits in the middle of
>  * the update. Timestamps taken from that NMI context might be ahead
>  * of the following timestamps. Callers need to be aware of that and
>  * deal with it.
>  */
>
> As this function is not guaranteed to be monotonic, have you checked how
> the Runtime PM code behaves if time goes backwards? Does it just make
> a suboptimal decision or does it crash?

As a worst case this will generate a suboptimal decision around the update

Regards,
Vincent

>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
