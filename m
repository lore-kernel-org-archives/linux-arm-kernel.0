Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F1FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:55:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7E220872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l8MW4HHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7E220872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DOK7RPF3tSLFffa6VZkdbcw6KHzunH9kO7AlnMVKnnk=; b=l8MW4HHzUa1Pw0
	+fHXPx6BNjTszwUt1LeIDFdUvgv+RgLNGk3SZBcAOiyXYzcyFr1xFrrezDJX2mXasT8J53gvm07Hf
	2D8Huk4lSTZC1nS74UCNy0U/2x/iCllV3xgBOBJHTaUTDdXjdIq3p1KyM87W9bRUBjMieeauJ3mzp
	7LhUMvQqPBO+CvUeobiDDu5drQhw5N7aczkNxG3whDb7q9P9yq88pPR41dUAwNGZKhJurk1MU3MzP
	MADiF1khkvIx5FBRWNd/prImLIDmaxGruyhsWkVjNoIeqrGl7rbi+34E34fyxMJW34THn5YOKJhfF
	IZyo42F1Flt6O9mGTWcA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghuT4-0003WD-RL; Fri, 11 Jan 2019 10:55:14 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghuT1-0003Ut-7F
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 10:55:12 +0000
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id ac8736e6ecfb3cd6; Fri, 11 Jan 2019 11:55:08 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 02/27] PM / Domains: Add support for CPU devices to
 genpd
Date: Fri, 11 Jan 2019 11:54:20 +0100
Message-ID: <1993885.1ZciKZtFgT@aspire.rjw.lan>
In-Reply-To: <CAPDyKFpPa1u1ouoa2zFzMe2McqEpxu7Vex2zd1nYoQUQtY2s-A@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <45ff9a4b-6130-7800-28cc-a2f5f736f44b@linaro.org>
 <CAPDyKFpPa1u1ouoa2zFzMe2McqEpxu7Vex2zd1nYoQUQtY2s-A@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_025511_425304_EBA6A453 
X-CRM114-Status: GOOD (  26.07  )
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
 Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wednesday, December 19, 2018 11:02:05 AM CET Ulf Hansson wrote:
> On Wed, 19 Dec 2018 at 10:53, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> > On 29/11/2018 18:46, Ulf Hansson wrote:
> > > To enable a device belonging to a CPU to be attached to a PM domain managed
> > > by genpd, let's do a few changes to it, as to make it convenient to manage
> > > the specifics around CPUs.
> > >
> > > To be able to quickly find out what CPUs that are attached to a genpd,
> > > which typically becomes useful from a genpd governor as following changes
> > > is about to show, let's add a cpumask to the struct generic_pm_domain. At
> > > the point when a CPU device gets attached to a genpd, let's update its
> > > cpumask. Moreover, let's also propagate changes to the cpumask upwards in
> > > the topology to the master PM domains. In this way, the cpumask for a genpd
> > > hierarchically reflects all CPUs attached to the topology below it.
> > >
> > > Finally, let's make this an opt-in feature, to avoid having to manage CPUs
> > > and the cpumask for a genpd that doesn't need it. For that reason, let's
> > > add a new genpd configuration bit, GENPD_FLAG_CPU_DOMAIN.
> > >
> > > Cc: Lina Iyer <ilina@codeaurora.org>
> > > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v10:
> > >       - Don't allocate the cpumask when not used.
> > >       - Simplify the code that updates the cpumask.
> > >       - Document the GENPD_FLAG_CPU_DOMAIN.
> > >
> > > ---
> > >  drivers/base/power/domain.c | 66 ++++++++++++++++++++++++++++++++++++-
> > >  include/linux/pm_domain.h   | 13 ++++++++
> > >  2 files changed, 78 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index e27b91d36a2a..c3ff8e395308 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/sched.h>
> > >  #include <linux/suspend.h>
> > >  #include <linux/export.h>
> > > +#include <linux/cpu.h>
> > >
> > >  #include "power.h"
> > >
> > > @@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> > >  #define genpd_is_irq_safe(genpd)     (genpd->flags & GENPD_FLAG_IRQ_SAFE)
> > >  #define genpd_is_always_on(genpd)    (genpd->flags & GENPD_FLAG_ALWAYS_ON)
> > >  #define genpd_is_active_wakeup(genpd)        (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> > > +#define genpd_is_cpu_domain(genpd)   (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> > >
> > >  static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
> > >               const struct generic_pm_domain *genpd)
> > > @@ -1377,6 +1379,56 @@ static void genpd_free_dev_data(struct device *dev,
> > >       dev_pm_put_subsys_data(dev);
> > >  }
> > >
> > > +static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
> > > +                                int cpu, bool set, unsigned int depth)
> > > +{
> > > +     struct gpd_link *link;
> > > +
> > > +     if (!genpd_is_cpu_domain(genpd))
> > > +             return;
> >
> > With this test, we won't continue updating the cpumask for the other
> > masters. Is it done on purpose ?
> 
> Correct, and yes it's on purpose.
> 
> We are not even allocating the cpumask for the genpd in question,
> unless it has the GENPD_FLAG_CPU_DOMAIN set.

So this patch is generally fine by me.  You can add my ACK to it when
submitting it again, unless it is changed, so I know I've seen it
already.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
