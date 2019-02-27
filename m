Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16556C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:01:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86CE218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QTPIuUQD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFIzSfN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86CE218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dOCSwoZSlZj0pAeFZVpsUVV5aiIth7u7n76Hi7ZGiHs=; b=QTPIuUQDTxjMK3
	0BdVnfiwjt6pbH0dsc0G+Ih2OjUCTX+rrlUrAm83z+rz5XsaxHTJdGrKyemEYCr83XXd2p21/K7du
	7uwxB1M1pc03GDKG44wDNN1WKryvRCXipE2LZAGbMbQq7tVOVRAYlftUt6gzMLbeEY5GHjZQ9YZDY
	kVb6iIT1uGvZDxt/vNDOCzcqCQ1HU/PAlkIuGWbeR3m8sfx5rSITi0S2geB6Ujg/KSjlGMAU3rK83
	4+orOGlSnptsc/QvprybAgz4s/E+1iUrhwoN+tbkKcMmHhUm+0RZi1tP4YlBZ9/3Zkb9UFvyRMrJz
	6hly5+YMhVioYEMfHkzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gymey-0000x0-Uo; Wed, 27 Feb 2019 00:01:16 +0000
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gymeu-0000wX-Fx
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 00:01:14 +0000
Received: by mail-ua1-x942.google.com with SMTP id c5so13672193uaq.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 16:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tg+2XcH32wEHA5nyAjtq91plGODU29mwHB2Ur6ovBSc=;
 b=qFIzSfN+Wr2+wigymye4+ET2M6J5vNgQFsd4AzlmTISWgvbtXbGluPFZnpvRCqrp0E
 6jvz+/WfLutzg0ZvNAlf7BBrEgiIFic47Qt1SGZ1PQDcFcNy5DwQn1OFd+MeX1S3HnQ7
 WiaFaLSEZE0JHnki8mSizY74dORsopaV4/2r+u16DnSTn3v7FjK7/Mry3b4uXdtqeRY3
 H5I8IDu289cug3+6y0aEP1FijINmYWJZPrzPLiF4yYSKWZUq0N2hdpvN9C+gyelA9+uA
 8Gyk1Gi4qwd/8nwX0mMXQJKlhWS5KKunGDUagbBb9e2pr8vUQXYE0fpW5h4mwTWtDbM7
 7nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tg+2XcH32wEHA5nyAjtq91plGODU29mwHB2Ur6ovBSc=;
 b=h+OpeR/YMT0BOh6byveObxmmdKR3vXzZ0NnMTEZxXtX7AsYBV0VSY3HWusTPYB6bDV
 avC8zubOd5UmNjpA2OG5nedyxYMOT3x80gAQcaLjHPnevc3DVmxdx2kdfunBGJlMUVlG
 wpooNm1XHpjJrQLb6Tl7gZzoCU+RQPrgJ4db4VU8c9nRmAA5w1DYPxMEH0uH5DpoiaAr
 BDot0/Phfb/fVMbIAbArYBQkOAR1EIb3juLEho+fvMD0xBvGKKrFRMH8Utcu60oSRnzK
 Hnb54JYPygL4yLvdCJJcAuC7Lh89K/SQoWz4JY+/r25GpPOOB3V3LjHm7ZH96Agy5owx
 d8/w==
X-Gm-Message-State: AHQUAuZ6l6ncVDyzge/pDTyzPuENILbq5CWIG2bDntTvdxu6h+owdBU5
 hoi7z7w9Mpu2CbwpoDwSyTsJ2QcVDvmuUb9hH4wCAg==
X-Google-Smtp-Source: AHgI3IYXqeQaGpfh2cEnyPTpm3PwkVsKLV/W3e6ePPoJRmtxDZxuZth5f+L5c7k8JSrYfew1DPNHL0y0lrRBLr+Oh7A=
X-Received: by 2002:a67:8055:: with SMTP id b82mr256830vsd.200.1551225671305; 
 Tue, 26 Feb 2019 16:01:11 -0800 (PST)
MIME-Version: 1.0
References: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
 <1477347668-41901-9-git-send-email-lina.iyer@linaro.org>
 <CAMuHMdVDtP=Y=FWfy56d+azW4bJ=3ihmmwdVkzEX-K3W6Wc9zA@mail.gmail.com>
In-Reply-To: <CAMuHMdVDtP=Y=FWfy56d+azW4bJ=3ihmmwdVkzEX-K3W6Wc9zA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 27 Feb 2019 01:00:35 +0100
Message-ID: <CAPDyKFq1xma+vi_T0qyPo0FNUEUOSiog2WGhEkgZLN4j-0z6aQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] PM / Domains: Support IRQ safe PM domains
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_160112_538662_CA66DA63 
X-CRM114-Status: GOOD (  33.00  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Juri Lelli <Juri.Lelli@arm.com>, Linux PM list <linux-pm@vger.kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>,
 Brendan Jackman <brendan.jackman@arm.com>, Lina Iyer <lina.iyer@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Andy Gross <andy.gross@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 26 Feb 2019 at 16:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Lina,
>
> Yes, this is a reply to an old patch.
> But it seems there are no upstream users of GENPD_FLAG_IRQ_SAFE yet...

Correct. But I are working on adding the first ones, as you probably know.

>
> On Tue, Oct 25, 2016 at 12:21 AM Lina Iyer <lina.iyer@linaro.org> wrote:
> > Generic Power Domains currently support turning on/off only in process
> > context. This prevents the usage of PM domains for domains that could be
> > powered on/off in a context where IRQs are disabled. Many such domains
> > exist today and do not get powered off, when the IRQ safe devices in
> > that domain are powered off, because of this limitation.
> >
> > However, not all domains can operate in IRQ safe contexts. Genpd
> > therefore, has to support both cases where the domain may or may not
> > operate in IRQ safe contexts. Configuring genpd to use an appropriate
> > lock for that domain, would allow domains that have IRQ safe devices to
> > runtime suspend and resume, in atomic context.
> >
> > To achieve domain specific locking, set the domain's ->flag to
> > GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that genpd
> > should use a spinlock instead of a mutex for locking the domain. Locking
> > is abstracted through genpd_lock() and genpd_unlock() functions that use
> > the flag to determine the appropriate lock to be used for that domain.
> >
> > Domains that have lower latency to suspend and resume and can operate
> > with IRQs disabled may now be able to save power, when the component
> > devices and sub-domains are idle at runtime.
> >
> > The restriction this imposes on the domain hierarchy is that non-IRQ
> > safe domains may not have IRQ-safe subdomains, but IRQ safe domains may
> > have IRQ safe and non-IRQ safe subdomains and devices.
> >
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/domain.c | 111 ++++++++++++++++++++++++++++++++++++++++----
> >  include/linux/pm_domain.h   |  10 +++-
> >  2 files changed, 110 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 1ad42f2..07ed835 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -74,11 +74,70 @@ static const struct genpd_lock_ops genpd_mtx_ops = {
> >         .unlock = genpd_unlock_mtx,
> >  };
> >
> > +static void genpd_lock_spin(struct generic_pm_domain *genpd)
> > +       __acquires(&genpd->slock)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&genpd->slock, flags);
> > +       genpd->lock_flags = flags;
> > +}
> > +
> > +static void genpd_lock_nested_spin(struct generic_pm_domain *genpd,
> > +                                       int depth)
> > +       __acquires(&genpd->slock)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave_nested(&genpd->slock, flags, depth);
> > +       genpd->lock_flags = flags;
>
> I don't think this is correct: during the second or any subsequent call,
> the old genpd->lock_flags will be overwritten by the new one.
> As interrupts are already disabled when doing a second call, the new
> flags will reflect this, and calling genpd_unlock_spin() below will
> never re-enable interrupts again.

That seems like a correct observation, at least as far as I can tell.
Thanks for looking into this!

>
> Note that changing the above to
>
>     if (!depth)
>             genpd->lock_flags = flags;
>
> won't help, as that means the first call to genpd_unlock_spin() will
> re-enable interrupts, which is too early.
>
> Using a single genpd->lock_flags can work only in case interrupts were
> already disabled before the first call.  But perhaps that's guaranteed?

So far, the only user case I have been playing with, is for CPUs. In
that case, this code in executed in the cpuidle path and thus IRQs are
disabled, so yes then it works.

>
> Apart from that, given depth is used as a lockdep subclass, and the
> following comment in include/linux/lockdep.h:
>
>     /*
>      * For trivial one-depth nesting of a lock-class, the following
>      * global define can be used. (Subsystems with multiple levels
>      * of nesting should define their own lock-nesting subclasses.)
>      */
>     #define SINGLE_DEPTH_NESTING                 1
>
> I'm wondering if depth > 1 actually works as expected.
>
> Am I missing something?

I don't think so, we need to fix this problem, in one way or the other.

Clearly this code hasn't been executed enough, probably only by me and
Lina and for CPUs. Ideally, we should try to make it work for the
generic case, as I think there are more potential users of it.

[...]

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
