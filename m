Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22736C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:52:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E461320851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bN6YOglD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E461320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DW0LSf9nfzq79X18Z6bGtYJV/G6yfXCpVNDrOoVrUyI=; b=bN6YOglDNR09I1
	s4ui7GGt0I9zXls6cmEIes402Zu/I+bIUa6ZKI/yUnXBNJXnI+J0zZnKIKN5XUfqTerateE7rVcjE
	V/EkVg/vKfc45t7B+3LDP/z1QDzhMWsVyIjzuhtBZCtyK7T+z/wR0FPY6YqmrKAOJ1wU7Eheb5EG5
	lyh2qkdS0Q8a909DB6uwMbCcYM927+VwqzlsBnrk7PFhySOe8CKoFICwf2G5A85b6iTqRHpiXY8wo
	jEVq1RLoXNNfgzsNUzzhZE6L0g+q4oC8YA7z9KIW2o/yzYKWMjg+x/ufqt1Z62DjCYq6oo/t2Aq/H
	on1ZKy5bIW+k1jWSqZpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyf26-0004H6-FE; Tue, 26 Feb 2019 15:52:38 +0000
Received: from mail-ua1-f68.google.com ([209.85.222.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyf22-00046X-QX
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 15:52:36 +0000
Received: by mail-ua1-f68.google.com with SMTP id f88so12289368uaf.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 07:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M8aHP+EP1+52AUOAcM6Ccarn204LCwasLQidz0XbIIg=;
 b=QQlwB1OrAJV8Vdg1xkZG2wmSVqz84/5HM40b5gIZQUB2CfF0nnpsnLcwh2IgE/lmy+
 SJwAfwIAWiF3xEUUomBDPx/jAsR2fcyXme1kV0ZQq1otmi/FPfDM9QOntr3JRNRKfkhm
 QJ8mCeBu1MHys6XQlYYZFJJrNCP0ZFccgjxh3NalB2gyQyXtldB/2lioAgcNtgNR0oW4
 uNtRazqm1SrrA96SZAyxrqBMTlBo2YyrUEMFhcX5jUL3EgAxd79hOcd+kuSOwSmVXbgb
 8SB5XbHQysFKVcdf2nrYxJUw6jDat1vJ9NAhqQkFAD01XwFL5OFd1Al73haZWWsnRZ2z
 Jh+Q==
X-Gm-Message-State: AHQUAuZUdefsrlVmp0UIeZUiwS5amItgK4Ip76o1TJl+kir1fBN/Tuv7
 VZMqFQz9lgI4vyAGaf84HLLvpb8lbVYos9BGMQw=
X-Google-Smtp-Source: AHgI3IYweKXEg8moKC8vW2WsnevUwoJJtog24yh89eOUqLndHtydlGllIyAX2VmCVtGoAU2il9JtBgZg/fQcRdMnSlw=
X-Received: by 2002:ab0:6950:: with SMTP id c16mr6795550uas.0.1551196353200;
 Tue, 26 Feb 2019 07:52:33 -0800 (PST)
MIME-Version: 1.0
References: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
 <1477347668-41901-9-git-send-email-lina.iyer@linaro.org>
In-Reply-To: <1477347668-41901-9-git-send-email-lina.iyer@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Feb 2019 16:52:20 +0100
Message-ID: <CAMuHMdVDtP=Y=FWfy56d+azW4bJ=3ihmmwdVkzEX-K3W6Wc9zA@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] PM / Domains: Support IRQ safe PM domains
To: Lina Iyer <lina.iyer@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_075234_873338_A8A375CB 
X-CRM114-Status: GOOD (  26.14  )
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Juri Lelli <Juri.Lelli@arm.com>,
 Linux PM list <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
 Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>, Brendan Jackman <brendan.jackman@arm.com>,
 linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Lina,

Yes, this is a reply to an old patch.
But it seems there are no upstream users of GENPD_FLAG_IRQ_SAFE yet...

On Tue, Oct 25, 2016 at 12:21 AM Lina Iyer <lina.iyer@linaro.org> wrote:
> Generic Power Domains currently support turning on/off only in process
> context. This prevents the usage of PM domains for domains that could be
> powered on/off in a context where IRQs are disabled. Many such domains
> exist today and do not get powered off, when the IRQ safe devices in
> that domain are powered off, because of this limitation.
>
> However, not all domains can operate in IRQ safe contexts. Genpd
> therefore, has to support both cases where the domain may or may not
> operate in IRQ safe contexts. Configuring genpd to use an appropriate
> lock for that domain, would allow domains that have IRQ safe devices to
> runtime suspend and resume, in atomic context.
>
> To achieve domain specific locking, set the domain's ->flag to
> GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that genpd
> should use a spinlock instead of a mutex for locking the domain. Locking
> is abstracted through genpd_lock() and genpd_unlock() functions that use
> the flag to determine the appropriate lock to be used for that domain.
>
> Domains that have lower latency to suspend and resume and can operate
> with IRQs disabled may now be able to save power, when the component
> devices and sub-domains are idle at runtime.
>
> The restriction this imposes on the domain hierarchy is that non-IRQ
> safe domains may not have IRQ-safe subdomains, but IRQ safe domains may
> have IRQ safe and non-IRQ safe subdomains and devices.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 111 ++++++++++++++++++++++++++++++++++++++++----
>  include/linux/pm_domain.h   |  10 +++-
>  2 files changed, 110 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 1ad42f2..07ed835 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -74,11 +74,70 @@ static const struct genpd_lock_ops genpd_mtx_ops = {
>         .unlock = genpd_unlock_mtx,
>  };
>
> +static void genpd_lock_spin(struct generic_pm_domain *genpd)
> +       __acquires(&genpd->slock)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&genpd->slock, flags);
> +       genpd->lock_flags = flags;
> +}
> +
> +static void genpd_lock_nested_spin(struct generic_pm_domain *genpd,
> +                                       int depth)
> +       __acquires(&genpd->slock)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave_nested(&genpd->slock, flags, depth);
> +       genpd->lock_flags = flags;

I don't think this is correct: during the second or any subsequent call,
the old genpd->lock_flags will be overwritten by the new one.
As interrupts are already disabled when doing a second call, the new
flags will reflect this, and calling genpd_unlock_spin() below will
never re-enable interrupts again.

Note that changing the above to

    if (!depth)
            genpd->lock_flags = flags;

won't help, as that means the first call to genpd_unlock_spin() will
re-enable interrupts, which is too early.

Using a single genpd->lock_flags can work only in case interrupts were
already disabled before the first call.  But perhaps that's guaranteed?

Apart from that, given depth is used as a lockdep subclass, and the
following comment in include/linux/lockdep.h:

    /*
     * For trivial one-depth nesting of a lock-class, the following
     * global define can be used. (Subsystems with multiple levels
     * of nesting should define their own lock-nesting subclasses.)
     */
    #define SINGLE_DEPTH_NESTING                 1

I'm wondering if depth > 1 actually works as expected.

Am I missing something?

Thanks!

> +}
> +
> +static int genpd_lock_interruptible_spin(struct generic_pm_domain *genpd)
> +       __acquires(&genpd->slock)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&genpd->slock, flags);
> +       genpd->lock_flags = flags;
> +       return 0;
> +}
> +
> +static void genpd_unlock_spin(struct generic_pm_domain *genpd)
> +       __releases(&genpd->slock)
> +{
> +       spin_unlock_irqrestore(&genpd->slock, genpd->lock_flags);
> +}

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
