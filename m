Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FBCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:03:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F3121871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LgIMziYI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ESTlneAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F3121871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y1VlwG4wqE1+8PMxPSEzw6dVh5EHjWJArLtF5BCkv5w=; b=LgIMziYIKwagzZ
	Rp0MxBOKKCH5OGFFIxdP5R0fCItLkB/Ao8GyrGjGcDgZHDOahxshr+RhBCaykOAPAFft92cRTA5ze
	pp8wWZ3dNmWwqr0iwaaGvMrb60kEM5tzj6gDeF700k7Ry9e2NKhlwJ8e2se95UsAqwn/vW3KA4qO1
	Wsw4cftX8xOudnV0Hwa0GNEp4jSm7kTcIu0804xfW3+fhgaGrmwm/ysORvKheOFdb5mtixSJCibwG
	pkzcX+8Zq44i1+14iDvylz72NZ83I4mtJWXWZX1zy3smymOijohsYQ+Vy3cgNaccqvXnITyuGk1d3
	h7Zfdl9M0O1Bf50oRFOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYgr-0004dE-4e; Wed, 19 Dec 2018 10:02:57 +0000
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYgn-0004c2-9k
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:02:55 +0000
Received: by mail-ua1-x943.google.com with SMTP id n7so6776308uao.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 02:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NQx7dLUJGiSAdVx/e9rnK06sQwchI0BSenA1bBEwXWM=;
 b=ESTlneAdRAvwkG+zZ26ezJt7iDxfFGWlUc3J7WkSnuGT/Si2x2H3LHwRoD5AupI9xI
 r2RVktvCRDT9LEsXK7hSdzePAY9E7Q0cQSJknQDSmE/2FcIIUxWJQ6vZMXWqCrlM6+QY
 JvdtcM36xJtSnNKcalSFnzRJR6qo4xstBZQ5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NQx7dLUJGiSAdVx/e9rnK06sQwchI0BSenA1bBEwXWM=;
 b=t4uB6T1aW3dzpJevC72aCFk+YNgthMhF/nB0lkc9754uSyvKgpnzmew4+0Y9m/ZLlT
 HodI3w4XuyUHY8Me4o6n4xXJNUV0aP+LtJ9TKrrCFO7gdO3SZGVvOqZn8iwIzSIgrCsl
 jEIdIMg4F8ma97c3Xu9UckLHbETBboIxC5bNmBonu57hYNhz1mR+azC2tAfVBgNgPOEl
 ngVA1bS+ypszYlhpUBwDWeRL4n1EynczC6G2VbUP5AgbxYKYJ2lXZ4cPyOZpEb5LMFK0
 ABNtqmGiyXslrQIFyW6noOLE8NVg/3zYr1LcxiRtQdsq0WBHwPiHFM4aj24g1mTVf2IN
 wFUQ==
X-Gm-Message-State: AA+aEWZL/umtAtj5/Zto9SoO32m946WxeWE6GKCJNH877Tw571y4HZon
 4nRSA90e7K6qmoglbT03V1R4Tg3US+j/Oz5UB2oAoA==
X-Google-Smtp-Source: AFSGD/VwoVhy63mcAPAyB7tvXdB338299OtPsVMetYCfWdZ7miCMyRZSMVVAxuuDM4tC725I/ZurmECoM7YO5mF3Gt0=
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr10084799uan.107.1545213761724; 
 Wed, 19 Dec 2018 02:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-3-ulf.hansson@linaro.org>
 <45ff9a4b-6130-7800-28cc-a2f5f736f44b@linaro.org>
In-Reply-To: <45ff9a4b-6130-7800-28cc-a2f5f736f44b@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Dec 2018 11:02:05 +0100
Message-ID: <CAPDyKFpPa1u1ouoa2zFzMe2McqEpxu7Vex2zd1nYoQUQtY2s-A@mail.gmail.com>
Subject: Re: [PATCH v10 02/27] PM / Domains: Add support for CPU devices to
 genpd
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_020253_337164_D7D8E5B7 
X-CRM114-Status: GOOD (  26.32  )
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
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 19 Dec 2018 at 10:53, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > To enable a device belonging to a CPU to be attached to a PM domain managed
> > by genpd, let's do a few changes to it, as to make it convenient to manage
> > the specifics around CPUs.
> >
> > To be able to quickly find out what CPUs that are attached to a genpd,
> > which typically becomes useful from a genpd governor as following changes
> > is about to show, let's add a cpumask to the struct generic_pm_domain. At
> > the point when a CPU device gets attached to a genpd, let's update its
> > cpumask. Moreover, let's also propagate changes to the cpumask upwards in
> > the topology to the master PM domains. In this way, the cpumask for a genpd
> > hierarchically reflects all CPUs attached to the topology below it.
> >
> > Finally, let's make this an opt-in feature, to avoid having to manage CPUs
> > and the cpumask for a genpd that doesn't need it. For that reason, let's
> > add a new genpd configuration bit, GENPD_FLAG_CPU_DOMAIN.
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Don't allocate the cpumask when not used.
> >       - Simplify the code that updates the cpumask.
> >       - Document the GENPD_FLAG_CPU_DOMAIN.
> >
> > ---
> >  drivers/base/power/domain.c | 66 ++++++++++++++++++++++++++++++++++++-
> >  include/linux/pm_domain.h   | 13 ++++++++
> >  2 files changed, 78 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index e27b91d36a2a..c3ff8e395308 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/suspend.h>
> >  #include <linux/export.h>
> > +#include <linux/cpu.h>
> >
> >  #include "power.h"
> >
> > @@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> >  #define genpd_is_irq_safe(genpd)     (genpd->flags & GENPD_FLAG_IRQ_SAFE)
> >  #define genpd_is_always_on(genpd)    (genpd->flags & GENPD_FLAG_ALWAYS_ON)
> >  #define genpd_is_active_wakeup(genpd)        (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> > +#define genpd_is_cpu_domain(genpd)   (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> >
> >  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
> >               const struct generic_pm_domain *genpd)
> > @@ -1377,6 +1379,56 @@ static void genpd_free_dev_data(struct device *dev,
> >       dev_pm_put_subsys_data(dev);
> >  }
> >
> > +static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
> > +                                int cpu, bool set, unsigned int depth)
> > +{
> > +     struct gpd_link *link;
> > +
> > +     if (!genpd_is_cpu_domain(genpd))
> > +             return;
>
> With this test, we won't continue updating the cpumask for the other
> masters. Is it done on purpose ?

Correct, and yes it's on purpose.

We are not even allocating the cpumask for the genpd in question,
unless it has the GENPD_FLAG_CPU_DOMAIN set.

[...]

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
