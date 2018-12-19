Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFA4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:10:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31C221871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gGImH35U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQ3h4xZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31C221871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HQj5p7H/Per7gfpPD0ZMWK3Q0+aZ24EJvKt+hsli7zU=; b=gGImH35UwlaCIS
	hSQWsOj2JNHSJEGC6+rv0cYdYDWeczMxiwEolzGyoTL0k3+9izzrxRNGA2NKPbIWmhEId+2vSxeAp
	CqIQEKjL56vkQE7GIDXjuRnxRuw+tgpmliGVctmPyHzDNbk9Wylpc6LRSagRdrJIayc4CvlPTFIa1
	Fvgs/w/2ZVnYWCcUpvriyrHQQXxOgYGSx4Qm9oCjbN+QyPlJ5rjDUhYNymKz5mYKKGXZJo6SsT2j/
	8xEQnnj9S/LSXCgpXl9BT3gQ8EGMT1cLpQW4QXw33mDYQ/6iVnXrv80R02ncEUeKUtRrYUyndyZcp
	xlgRe6/4BjBiolVrh+aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYo0-00081o-Ot; Wed, 19 Dec 2018 10:10:20 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYnx-00074T-6x
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:10:19 +0000
Received: by mail-vs1-xe43.google.com with SMTP id x28so4257914vsh.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 02:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5/K3ksz2cOuGH+8ZePuFENnYOvHlfiSjHSQXc/PYJ2c=;
 b=RQ3h4xZ8xf011F6uO04XuKcLaR0eSLQf56kPf2PwCFf8encr5t4yZcsP2//ZUyeqZb
 0XXXQmjZFkshO8WK7FK5I42B2gPtvDAJeSIXTVi/NmmtJ6ZrNE1Z7zS/bkzbmnlLRXbj
 HWW1rGq17p4uQiOt++oJtRbnnmPV1J0IvFiv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5/K3ksz2cOuGH+8ZePuFENnYOvHlfiSjHSQXc/PYJ2c=;
 b=ODlG9Ib+Dw+zOp/Nwh4HZ64jISjPKDUTpP5/se/aFJRVvJMcL/6O95JPPG9FiQsQvz
 HqZo09HCnZ2n7dKVRu5vrCBUHlguiJZ2nabFRMDFyFcUkD8yYVF4kuJ9WAa1B7LIsiaI
 LGdQgb3sk9F9Gdkzbb6sTuSvaow/jYvuqSPQ8sa+cnPq85T6Vbh3m7HkAtcCGzeOsTg7
 IYuH66yFXdfn74BeOSw3P56mqX3pz9e7nWe4UIMxHlhzTtFeZsGkMbzE6hqClHiG2l+W
 fXElBmwyto5RKENDMNdkW3O80pKYx0IbMpX5mLJQoRI9ZtyRf2CYaKnbWexCzPBr4Kne
 jJkg==
X-Gm-Message-State: AA+aEWbOiuorjUCgVH29mhihN4PIfKSmWS7y8X2Kl5uBfh0xKBz5ogts
 aStgVLyXhkqD2smupbDIFHy4ln7nt8KkQjJf3OETMA==
X-Google-Smtp-Source: AFSGD/WwtGYT9ruDBSvX6LKMVI14aD24tA/A1hBTdZNZP1nRDiYXyKMWV01DtQ4Mro4VlMQdNoA1Zx3cqygYixgWxrk=
X-Received: by 2002:a67:e002:: with SMTP id c2mr10059987vsl.34.1545214203976; 
 Wed, 19 Dec 2018 02:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-5-ulf.hansson@linaro.org>
 <5529fc0a-af96-b10a-ca4a-f1417598f4ee@linaro.org>
In-Reply-To: <5529fc0a-af96-b10a-ca4a-f1417598f4ee@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Dec 2018 11:09:28 +0100
Message-ID: <CAPDyKFr4KmCMciLANLCEsTKj2Mz-B89BybSvX4Y8g=L5vim=fw@mail.gmail.com>
Subject: Re: [PATCH v10 04/27] PM / Domains: Add genpd governor for CPUs
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_021017_260750_F205A6DA 
X-CRM114-Status: GOOD (  32.37  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Frederic Weisbecker <fweisbec@gmail.com>,
 Tony Lindgren <tony@atomide.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 19 Dec 2018 at 10:54, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > As it's now perfectly possible that a PM domain managed by genpd contains
> > devices belonging to CPUs, we should start to take into account the
> > residency values for the idle states during the state selection process.
> > The residency value specifies the minimum duration of time, the CPU or a
> > group of CPUs, needs to spend in an idle state to not waste energy entering
> > it.
> >
> > To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
> > may be used for a PM domain that have CPU devices attached or if the CPUs
> > are attached through subdomains.
> >
> > The new governor computes the minimum expected idle duration time for the
> > online CPUs being attached to the PM domain and its subdomains. Then in the
> > state selection process, trying the deepest state first, it verifies that
> > the idle duration time satisfies the state's residency value.
> >
> > It should be noted that, when computing the minimum expected idle duration
> > time, we use the information from tick_nohz_get_next_wakeup(), to find the
> > next wakeup for the related CPUs. Future wise, this may deserve to be
> > improved, as there are more reasons to why a CPU may be woken up from idle.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Fold in patch that extended the new genpd CPU governor to cope with
> >         QoS constraints, as to avoid confusion.
> >       - Simplified the code according to suggestions from Rafael.
> >
> > ---
> >  drivers/base/power/domain_governor.c | 61 +++++++++++++++++++++++++++-
> >  include/linux/pm_domain.h            |  3 ++
> >  2 files changed, 63 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> > index 99896fbf18e4..61a7c3c03c98 100644
> > --- a/drivers/base/power/domain_governor.c
> > +++ b/drivers/base/power/domain_governor.c
> > @@ -10,6 +10,9 @@
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_qos.h>
> >  #include <linux/hrtimer.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/ktime.h>
> > +#include <linux/tick.h>
> >
> >  static int dev_update_qos_constraint(struct device *dev, void *data)
> >  {
> > @@ -211,8 +214,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
> >       struct generic_pm_domain *genpd = pd_to_genpd(pd);
> >       struct gpd_link *link;
> >
> > -     if (!genpd->max_off_time_changed)
> > +     if (!genpd->max_off_time_changed) {
> > +             genpd->state_idx = genpd->cached_power_down_state_idx;
> >               return genpd->cached_power_down_ok;
> > +     }
> >
> >       /*
> >        * We have to invalidate the cached results for the masters, so
> > @@ -237,6 +242,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
> >               genpd->state_idx--;
> >       }
> >
> > +     genpd->cached_power_down_state_idx = genpd->state_idx;
> >       return genpd->cached_power_down_ok;
> >  }
> >
> > @@ -245,6 +251,54 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
> >       return false;
> >  }
> >
> > +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
> > +{
> > +     struct generic_pm_domain *genpd = pd_to_genpd(pd);
> > +     ktime_t domain_wakeup, cpu_wakeup;
> > +     s64 idle_duration_ns;
> > +     int cpu, i;
> > +
> > +     /* Validate dev PM QoS constraints. */
> > +     if (!default_power_down_ok(pd))
> > +             return false;
> > +
> > +     if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
> > +             return true;
>
> Is it possible to have this function called without the
> GENPD_FLAG_CPU_DOMAIN flag set in the genpd?

Theoretically yes, however in practice, probably not.

Do note, if the GENPD_FLAG_CPU_DOMAIN isn't set, then we haven't
allocated the cpumask for the genpd, so then we shouldn't use it.

>
> > +     /*
> > +      * Find the next wakeup for any of the online CPUs within the PM domain
> > +      * and its subdomains. Note, we only need the genpd->cpus, as it already
> > +      * contains a mask of all CPUs from subdomains.
> > +      */
> > +     domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
> > +     for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> > +             cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
> > +             if (ktime_before(cpu_wakeup, domain_wakeup))
> > +                     domain_wakeup = cpu_wakeup;
> > +     }
> > +

[...]

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
