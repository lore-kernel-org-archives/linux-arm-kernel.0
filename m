Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2334DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:48:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B7E217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L4UQ+TMN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JecUyX7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B7E217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ic2THcETsSvi+OH+7EUTF5rJGH8lgTiHC+XOcNHkl60=; b=L4UQ+TMN5O8bbI
	h0h2TunhoP/lAegnvDkQXOG3nH5k/8tfs8vxlSvN+9ZXSpdatGUgS9VDtBHtyF6e3kk6acF/bVpK9
	rUHhgEmSbo/SlK9SLV8hCbdWBfxoZigTTGvmTPbZwVdUUuP0iQ98P+LMRQra/Vr7IYcybHlYY5qLI
	T/Yz5VuKSkG7MZ7MF19PmWekWXpjt3vKZ+B9K9tl9vriTVoutIw2y+i3PY4+0HjXVqR32Dwu67dPA
	mwD74aVWOeoVLhjMCtlDdlh9vNxCDaGV+JFNtvmsDx/avVDF7NcaAlZzSK4ge7/rs9PaXohIcwhXO
	yCNDvfQ98D1PSPLN0Qtg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZaLD-0002xQ-PF; Wed, 19 Dec 2018 11:48:43 +0000
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZaLA-0002wo-GB
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 11:48:42 +0000
Received: by mail-ua1-x942.google.com with SMTP id d2so6875596ual.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 03:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I7SDTVKItAO5FJGbZNOH6yIuLijvFxA7I0ahvnghE+w=;
 b=JecUyX7C/oU0T3HlZiJMGON9FAvg1DhrdnqecXiFE09+x0yoErjRuuuL76SzecvR62
 TbptUyzzvMB42kDRGWOukzihmEwxSWddkYWT5F6c3wANC1rYiYcXJVVZd2cxQppYXFS6
 9TGCu0nkGqdGw4X6A928dE/1zsG6vr3On3K8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I7SDTVKItAO5FJGbZNOH6yIuLijvFxA7I0ahvnghE+w=;
 b=XfMJfsxXrV6sHCM20O8+v3E756Gt7PfLh4O7BnDkaUJ/gn9ljRrI05RQ74aMnOLLen
 fx0g0gHOfQzu8slDiqAeuxev65ATcdSSO74pwEchJp7GDIVMvzAQep8R8lCICrhQhRS2
 Ar2gMn2PfhsGwD5+Zv0enxvUQci61BcI67/GXT+NanZDaBIjH+pqmXPULmd5SRCotYGf
 +xElVfKEH9sGpEDnrmF+c6wHnzlc+y5eLq0/0YEpd0lO18qzZ6JPTog5ze5j2XQE2Ov/
 y03Ix58jg3GRXep9hghpIUYqVKiXxlzb9YWAG/76d1fsAAfvOjKHgxEPOSQcJ7X7yO3W
 owPQ==
X-Gm-Message-State: AA+aEWbWaBx8efuJ5up072H7COJTFFnW/60KcyjF2k/8utu0H2F1YqGj
 IuFp1GZ5tOVSU30onaPHUe7Ntv5fMlZpZq7eh6SR1A==
X-Google-Smtp-Source: AFSGD/W5qQKUFuz8lfieLd7UcGi+i5QGT3GjMHpGMoLMSCtGNgd30SqVi0LduTzFKo0oRHlKEqithnHEjDpiqLrnzRM=
X-Received: by 2002:ab0:2b0b:: with SMTP id e11mr3362455uar.77.1545220108824; 
 Wed, 19 Dec 2018 03:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-25-ulf.hansson@linaro.org>
 <20181219111744.GA23393@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181219111744.GA23393@e107981-ln.cambridge.arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Dec 2018 12:47:53 +0100
Message-ID: <CAPDyKFoFn=3VzYLriROYEgCT=gbrsjbx8Fc1dktTJ1BdCBxniw@mail.gmail.com>
Subject: Re: [PATCH v10 24/27] drivers: firmware: psci: Support CPU hotplug
 for the hierarchical model
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_034840_534424_896659FF 
X-CRM114-Status: GOOD (  30.25  )
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
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 19 Dec 2018 at 12:17, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Nov 29, 2018 at 06:46:57PM +0100, Ulf Hansson wrote:
> > When the hierarchical CPU topology is used and when a CPU has been put
> > offline (hotplug), that same CPU prevents its PM domain and thus also
> > potential master PM domains, from being powered off. This is because genpd
> > observes the CPU's struct device to remain being active from a runtime PM
> > point of view.
> >
> > To deal with this, let's decrease the runtime PM usage count by calling
> > pm_runtime_put_sync_suspend() of the CPU's struct device when putting it
> > offline. Consequentially, we must then increase the runtime PM usage for
> > the CPU, while putting it online again.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Make it work when the hierarchical CPU topology is used, which may be
> >         used both for OSI and PC mode.
> >       - Rework the code to prevent "BUG: sleeping function called from
> >         invalid context".
> > ---
> >  drivers/firmware/psci/psci.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index b03bccce0a5d..f62c4963eb62 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -15,6 +15,7 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/arm-smccc.h>
> > +#include <linux/cpu.h>
> >  #include <linux/cpuidle.h>
> >  #include <linux/errno.h>
> >  #include <linux/linkage.h>
> > @@ -199,9 +200,20 @@ static int psci_cpu_suspend(u32 state, unsigned long entry_point)
> >
> >  static int psci_cpu_off(u32 state)
> >  {
> > +     struct device *dev;
> >       int err;
> >       u32 fn;
> >
> > +     /*
> > +      * When the hierarchical CPU topology is used, decrease the runtime PM
> > +      * usage count for the current CPU, as to allow other parts in the
> > +      * topology to enter low power states.
> > +      */
> > +     if (psci_dt_topology) {
> > +             dev = get_cpu_device(smp_processor_id());
> > +             pm_runtime_put_sync_suspend(dev);
> > +     }
> > +
> >       fn = psci_function_id[PSCI_FN_CPU_OFF];
> >       err = invoke_psci_fn(fn, state, 0, 0);
> >       return psci_to_linux_errno(err);
> > @@ -209,6 +221,7 @@ static int psci_cpu_off(u32 state)
> >
> >  static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
> >  {
> > +     struct device *dev;
> >       int err;
> >       u32 fn;
> >
> > @@ -216,6 +229,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
> >       err = invoke_psci_fn(fn, cpuid, entry_point, 0);
> >       /* Clear the domain state to start fresh. */
> >       psci_set_domain_state(0);
> > +
> > +     /* Increase runtime PM usage count if the hierarchical CPU toplogy. */
> > +     if (!err && psci_dt_topology) {
> > +             dev = get_cpu_device(cpuid);
>
> I do not like adding this code in the cpu_{on/off} method themselves, I will
> have a look at the patchset as whole to see how we can restructure it.

Any suggestions are welcome, of course. This was the best and most
simple option I could come up with.

Another option, could be to simply to remove the runtime PM deployment
from psci_cpu_off|on() altogether and just live with that limitation
for now. That works for me as well.

>
> More to the point, using cpuid as a logical cpu id is wrong, it is a
> physical id that you should convert to a logical id through
> get_logical_index().

Oh, didn't know that, thanks for pointing that out!

>
> Lorenzo
>
> > +             pm_runtime_get_sync(dev);
> > +     }
> > +
> >       return psci_to_linux_errno(err);
> >  }
> >
> > --
> > 2.17.1
> >

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
