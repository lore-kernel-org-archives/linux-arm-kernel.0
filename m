Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6DBC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:24:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98C02073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kWQsTWT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98C02073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sD+r9y9TYPIvv+mL9bETy8RIaLNj5ObqI2Y3iPNrlcA=; b=kWQsTWT5t+dj8f
	J2CkO8ZTLzHYn7YCddTU/OstdetCaXeZH4Dk+i/o7imwvQRbVSOhvQaICLNQjWPigPRbdoqSaZkQ9
	4OWf3UEJZXIYASXY1XmzLToaTOruTLlC84dl44cPfQeqKVXO7onVxL25VP2yPlqP7AiK5jSTaxHjM
	TTQbmXIP4ltn/U+5YYKsp3qyrunV/D8iMzKNVM3o+0GPOtFXmYO4b9EJAkDmNrzWtddQYDM6S/t5m
	rUL7a62NlMBPBhgXRZVCyAyZTa44y0o5PHFf2H246vdomSrK9U0VAudGz+fWwiNUoLh9RvobPfwbP
	osqCsRevt2FyBSPorxDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr0iZ-0005nI-UY; Tue, 05 Feb 2019 13:24:51 +0000
Received: from mail-vs1-f66.google.com ([209.85.217.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr0iW-0005my-CT
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 13:24:49 +0000
Received: by mail-vs1-f66.google.com with SMTP id b74so2094026vsd.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 05:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mH2jC//BX4csPlxzLWPxIbl/VLPdX2MNzc/nlQzQz8Q=;
 b=M5nfh9DHgf3yhYoKHrZAv5kud0hdFAXYitYONLqNEzgcIGdxh4jTwBmdEKSLKvAs9G
 0UwM78rRrRyrLO9+Z3iUiMk9/D7oqzAbRKJ/bcSeMy1fC7s4xBN/BCm7ajNh29++vSup
 /u+SSqIff07TrZ8EHljPa413fRtDjbhEvDD16n/kRFSrD9G+pqydVkQWtw29hg0wsv5u
 pktItQtTuDmlx/iRXNfh5iuwO7OYfzWpNQ1DmuJibfbPYMb0dLHfDQ+jHVoFqjJSARrT
 K9sQk48FaKYIpGJe0O3dgTbbMUK1LPMxgcgguOCfoNvrvkp6eLTo99Q2rvVbCbmzfv9F
 NNUA==
X-Gm-Message-State: AHQUAuY3Vtzt2BJInsqFBCUKdzYQUf/NDGlpJQCWgpFpW7784owwG4uz
 I/PZmTb7XNZ/P+X5z+RxZ1OklBuCUM9EUJ+yxIk=
X-Google-Smtp-Source: AHgI3IZGiOTTw8sZiDzZNxEUVJfcek13r1NV7ffeSdfvgl9Jp03HBQFnX+NKK7wxVbto9ZhTYk3nwT3JsD0+hzp5ILU=
X-Received: by 2002:a67:d119:: with SMTP id u25mr1891966vsi.63.1549373086077; 
 Tue, 05 Feb 2019 05:24:46 -0800 (PST)
MIME-Version: 1.0
References: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFpyg7oGoDZA+=SG7R3yL874Geeqs5LWrsAf50csxsE05A@mail.gmail.com>
In-Reply-To: <CAPDyKFpyg7oGoDZA+=SG7R3yL874Geeqs5LWrsAf50csxsE05A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Feb 2019 14:24:33 +0100
Message-ID: <CAMuHMdWdbRpA_M4V1kigab6U8rSDgGYXtidiSU4MVdj5xarK8g@mail.gmail.com>
Subject: Re: [PATCH v2 ] PM-runtime: fix deadlock with ktime
To: Ulf Hansson <ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_052448_428122_7624A71E 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Biju Das <biju.das@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Ulf,

On Wed, Jan 30, 2019 at 1:15 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Wed, 30 Jan 2019 at 12:16, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
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
>
> Hmm, isn't this already a problem in genpd then?
>
> In genpd's ->runtime_resume() callback (genpd_runtime_resume()) we
> call ktime_get() to measure the latency of running the callback.
>
> Or, perhaps irq_safe_dev_in_no_sleep_domain() returns true for the
> genpd + device in question, which means the ktime thingy is skipped.
>
> Geert?

Correct. After adding

    dev_info(dev, "%s: pm_runtime_is_irq_safe = %d,
genpd_is_irq_safe(%s) = %d => %s\n", __func__,
pm_runtime_is_irq_safe(dev), genpd->name, genpd_is_irq_safe(genpd),
ret ? "true" : "false");

I see on R-Car M2-W:

    sh_cmt ffca0000.timer: irq_safe_dev_in_no_sleep_domain:
pm_runtime_is_irq_safe = 1, genpd_is_irq_safe(always-on) = 0 => true

For all other devices, the result is false.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
