Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550ABC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:40:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C0420844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cV2+ccEG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0W/wiQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C0420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I5v5v0p6HICtPCO2arhzKG6pkj+9QzRwNELlbalJ9ps=; b=cV2+ccEGSg0RPZ
	yOBfhGXfwxZG6zfIGSwHoapFdo0J5LUuHaR/uh26LXeVOPocS4PmyHEotyNDNPA5GIukjssv5Er38
	SCgFXTCitJdaJqLZtERng5aG0AjPWtrBkVmFDPKEHYQi75+FQTwqyBZ3mtsGgSJFqQTj42lfkMHK3
	1JEnCl4xLV1zBBTZkEU0d/SED0Zf6EAFu91csCVTlKI/fw2J0dwfxYC0Su11Y0QZYdVN2K+QFI55h
	444kZ7d6ErMuNT4xdfK6Ojqwa9plxHedtg4fdDToJhocQWDriI0lLDOHgMvY2ifVSGFzZdKR4A2OZ
	FgUyweCBjr/qOuEFQOwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr0xw-0004if-PG; Tue, 05 Feb 2019 13:40:44 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr0xt-0004iG-GE
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 13:40:42 +0000
Received: by mail-vs1-xe42.google.com with SMTP id z3so2140845vsf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 05:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hGz+KaIHU6kdZjr70CxUzqvL/Y3JaHXrvpE3EZ2OZfE=;
 b=z0W/wiQn7JYbpAZ1ol9zt74MyT0lCGqciOPnKnapYHSRPgPTaEviiqgcQ9K1b2wh8i
 yPZ6PBrJDufXLkOGem2jmlKPtpWVxIzf1uDzjPvacUf1hdtQttxrmYJbCd3PsU+jgzsP
 /v9+mWIvCCW0dXF8zXGP8fBTWUpy9lhOLqvMYHJTByxbSYRFYyiVoWBXFhgJQJwWHozm
 56qIIc3lJvN0RS56QJuXMFYFYKv7MK7k940KjaYavrVhrCM2YZdtnm8hB+YXfcFQ+8FI
 pKoDyJ61mVVH5zD06oYLTuwtyADsD5UHJ2Z4GHNeoL1Os741Fq1WTl1wJOeBqx7P7ZvU
 PHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hGz+KaIHU6kdZjr70CxUzqvL/Y3JaHXrvpE3EZ2OZfE=;
 b=MJRgJQhzwNhyJtosOjc4xr0j6jVLYcs9K0LEMIqVoOGLzqPStbGpUut9UbL5hzmuN1
 j9CHb3F54zFFnaFFdRphx/OFbtKU8l+nQeC+ZAKJ+kCM5zYpdeo1GfQU/h+nyZ71ETrl
 cRR3Gn03wAlXlhDbyXvSxKXiOKnkr+sBccbptxLLoM4B9v68m6NmwKKwEtNgTkEB3LWQ
 HdfmNl86pqb8p4PgFT1Srue8EAiumIKTbzPMUlL9O1gXoDMOW8QQPJvUDkKIfkRXFUap
 0U3KJ/NIRJLBnahR1tU8VKTRxtVRYncxYRPcaubZxNu73ujbvfbiZlkFFkLDOQ8jvMQn
 +NvQ==
X-Gm-Message-State: AHQUAubj6D8qT0XuxvV5OBJm4Z6EoONQykEC0lCidwbaMRlIv6BNKvJM
 CfeOBfao74uAcAxSJ7hfKtESQw+yghfDtV0PY6LMhg==
X-Google-Smtp-Source: AHgI3IYVw/nkWXn4pDQ6QdiimktaGEI7Lc7rL5L+LWqatJUnmPRDh65+YENGhUU2l+fUF4WoXLWXU9Tun+zS5f6jloY=
X-Received: by 2002:a67:b245:: with SMTP id s5mr2002390vsh.200.1549374040188; 
 Tue, 05 Feb 2019 05:40:40 -0800 (PST)
MIME-Version: 1.0
References: <1548846984-2044-1-git-send-email-vincent.guittot@linaro.org>
 <CAPDyKFpyg7oGoDZA+=SG7R3yL874Geeqs5LWrsAf50csxsE05A@mail.gmail.com>
 <CAMuHMdWdbRpA_M4V1kigab6U8rSDgGYXtidiSU4MVdj5xarK8g@mail.gmail.com>
In-Reply-To: <CAMuHMdWdbRpA_M4V1kigab6U8rSDgGYXtidiSU4MVdj5xarK8g@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Feb 2019 14:40:04 +0100
Message-ID: <CAPDyKFqSofB2TfQXqhngQhaSKRZr-k-z2CXpQ2oWvnCn3JeFHQ@mail.gmail.com>
Subject: Re: [PATCH v2 ] PM-runtime: fix deadlock with ktime
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_054041_564823_DE358517 
X-CRM114-Status: GOOD (  14.84  )
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

On Tue, 5 Feb 2019 at 14:24, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Wed, Jan 30, 2019 at 1:15 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Wed, 30 Jan 2019 at 12:16, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > A deadlock has been seen when swicthing clocksources which use PM runtime.
> > > The call path is:
> > > change_clocksource
> > >     ...
> > >     write_seqcount_begin
> > >     ...
> > >     timekeeping_update
> > >         ...
> > >         sh_cmt_clocksource_enable
> > >             ...
> > >             rpm_resume
> >
> > Hmm, isn't this already a problem in genpd then?
> >
> > In genpd's ->runtime_resume() callback (genpd_runtime_resume()) we
> > call ktime_get() to measure the latency of running the callback.
> >
> > Or, perhaps irq_safe_dev_in_no_sleep_domain() returns true for the
> > genpd + device in question, which means the ktime thingy is skipped.
> >
> > Geert?
>
> Correct. After adding
>
>     dev_info(dev, "%s: pm_runtime_is_irq_safe = %d,
> genpd_is_irq_safe(%s) = %d => %s\n", __func__,
> pm_runtime_is_irq_safe(dev), genpd->name, genpd_is_irq_safe(genpd),
> ret ? "true" : "false");
>
> I see on R-Car M2-W:
>
>     sh_cmt ffca0000.timer: irq_safe_dev_in_no_sleep_domain:
> pm_runtime_is_irq_safe = 1, genpd_is_irq_safe(always-on) = 0 => true
>
> For all other devices, the result is false.

Thanks for confirming! I guess we have been lucky so far.

Anyway, if runtime PM core converts to use ktime_get_mono_fast_ns(),
we should probably consider to convert genpd to this as well. Don't
you think?

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
