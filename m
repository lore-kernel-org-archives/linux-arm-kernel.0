Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C00C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:16:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610C720892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p1YY9RKh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCX96gWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610C720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gQvAAk7lN1B9zSLvMQJOSFHROQsOtkma5dzU/C25Swk=; b=p1YY9RKhgctyzP
	ylhb4d9QXpMUTIeRD6YmHHjMcD7Wd8qDNZWR+vsEiraA+qIA4eBiQT24BtWsMlamAvRmHyzgQSxj2
	iOpAdJNMCzFpPIOGmfLNVBj5Afv6Nk/tufmqo3UFHOvcqaz+KCwmBi3UYZj80tfv7QkzAS495aH9u
	yTZA6B6Zs5wFX+5p2YnL3A+jrG5B4WGB14NNd5JvWVvm0q86lMwg+UAybwX5O3J8r81mJF67WQf+A
	VZdmc82vMjyY+8woUB2Wrc4UpEMOhCTDvWY3Ri9IEWcEc6Wv4MujbW6xRNyaa6a9Ebbs1K05lo95j
	HajZ640r9ULbSC7FOaaA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUplY-0004J1-Cw; Thu, 06 Dec 2018 09:16:16 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUplS-0004Cc-VC
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:16:14 +0000
Received: by mail-vs1-xe41.google.com with SMTP id z3so13852406vsf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oplyraUjlzT1MdYD0jbSQna4BlEOoZ+ROrl7JO6ZcX4=;
 b=QCX96gWOCi1IvweM1uDEYuimkCOcRF7+ITWdMJ1/cX/tm7go7g7PjiOOT2DThXg68X
 oUJoeiHaC9AjOqB99Lc717nDsBjT9MAWCi/KsdCqStANCdXYNgUzqlm9kjXrE9vUwWg0
 dnBjBvLFgr43VIcrmgXIskRRE41DcczVCmHhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oplyraUjlzT1MdYD0jbSQna4BlEOoZ+ROrl7JO6ZcX4=;
 b=AyVaAzGPqZStFoRCQJmll8l1+h/v28dBpxo2cXkC2Ubou4tww+JQR7KGWA9CeS5gPX
 mEwlHk6WmNJL3HmqGgiwntpXDq/X9JYoytMRA597kCHtO8iJWDhaiAyFQPVrHthEIkTB
 46FJrX3UpWitBm2aLWJAsu77QRCJhqFQFUUWvD9fgt3Nx/A9iDXvj6sxl414FhYcz143
 AAFEOTEZ2rAPFr6V+aX+1eHrqOCC9YGLuhO/zFYaB/hc5tfiD80AGXYMNlwY2DP7U76u
 oGORNUqUJpwSD4mLcwaE0wewBlblCeYle4CgImwVY0/Gb7Y8OprJPg2l6KJkdrcpz5jb
 id5Q==
X-Gm-Message-State: AA+aEWbfrWI6upYZIHAYa08ap9Aq8hDhATKLe5LQFoKcYXyiMMUHqoCB
 582thBqXFizp0uiflgB94xr5zpaStrGDC1+zw3QvOw==
X-Google-Smtp-Source: AFSGD/UsZHvpC5TvTgT03vNBBhf3FX4VZq9uUDDdv07eTOp+J7Lffk6T8QhJKmOgHmIFPIqHa1bqWbsUwoPyi827vs0=
X-Received: by 2002:a67:b245:: with SMTP id s5mr12360073vsh.200.1544087759184; 
 Thu, 06 Dec 2018 01:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-22-ulf.hansson@linaro.org>
 <20181204184553.GO18262@codeaurora.org>
In-Reply-To: <20181204184553.GO18262@codeaurora.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 6 Dec 2018 10:15:23 +0100
Message-ID: <CAPDyKFqv+1R-hbSmgfrn8jtBXEB3S1-=bg+ArBkR4m-cxd2oQQ@mail.gmail.com>
Subject: Re: [PATCH v10 21/27] drivers: firmware: psci: Add a helper to attach
 a CPU to its PM domain
To: Lina Iyer <ilina@codeaurora.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_011611_004696_6F27742C 
X-CRM114-Status: GOOD (  17.98  )
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
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 4 Dec 2018 at 19:45, Lina Iyer <ilina@codeaurora.org> wrote:
>
> On Thu, Nov 29 2018 at 10:50 -0700, Ulf Hansson wrote:
> >Introduce a new PSCI DT helper function, psci_dt_attach_cpu(), which takes
> >a CPU number as an in-parameter and attaches the CPU's struct device to its
> >corresponding PM domain. Additionally, the helper prepares the CPU to be
> >power managed via runtime PM, which is the last step needed to enable the
> >interaction with the PM domain through the runtime PM callbacks.
> >
> >Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >---
> >
> >Changes in v10:
> >       - New patch: Replaces "PM / Domains: Add helper functions to
> >         attach/detach CPUs to/from genpd".
> >
> >---
> > drivers/firmware/psci/psci.h           |  1 +
> > drivers/firmware/psci/psci_pm_domain.c | 19 +++++++++++++++++++
> > 2 files changed, 20 insertions(+)
> >
> >diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
> >index 05af462cc96e..fbc9980dee69 100644
> >--- a/drivers/firmware/psci/psci.h
> >+++ b/drivers/firmware/psci/psci.h
> >@@ -15,6 +15,7 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state);
> > int psci_dt_init_pm_domains(struct device_node *np);
> > int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
> >                       struct device_node *cpu_node, u32 *psci_states);
> >+int psci_dt_attach_cpu(int cpu);
> > #else
> > static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
> > #endif
> >diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
> >index 6c9d6a644c7f..b0fa7da8a0ce 100644
> >--- a/drivers/firmware/psci/psci_pm_domain.c
> >+++ b/drivers/firmware/psci/psci_pm_domain.c
> >@@ -12,8 +12,10 @@
> > #include <linux/device.h>
> > #include <linux/kernel.h>
> > #include <linux/pm_domain.h>
> >+#include <linux/pm_runtime.h>
> > #include <linux/slab.h>
> > #include <linux/string.h>
> >+#include <linux/cpu.h>
> > #include <linux/cpuidle.h>
> > #include <linux/cpu_pm.h>
> >
> >@@ -367,4 +369,21 @@ int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
> >
> >       return 0;
> > }
> >+
> >+int psci_dt_attach_cpu(int cpu)
> >+{
> >+      struct device *dev = get_cpu_device(cpu);
> >+      int ret;
> >+
> >+      ret = dev_pm_domain_attach(dev, true);
> >+      if (ret)
> >+              return ret;
> >+
> >+      pm_runtime_irq_safe(dev);
> >+      pm_runtime_get_noresume(dev);
> >+      pm_runtime_set_active(dev);
> You would want to set this only if the CPU is online. Otherwise we will
> not power down the domain, if the CPU was never brought online.

Nice catch!

The platforms I tested this series on brings all their CPUs online
during boot, hence I haven't observed the problem.

I will post a new version soon to address the problem. Again, thanks
for your review!

[...]

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
