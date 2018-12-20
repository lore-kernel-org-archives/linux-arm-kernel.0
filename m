Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1096DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:50:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4128217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RktclLzC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c93U3Jyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4128217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ItRWkDHfVqnm01JAARQKdOcqeStt/8TyHyBB1ZGl2fs=; b=RktclLzCn486e/
	X1FwB261QEbfMAz7Ux04Znmy65ljkXDvcPQRdEfqeV6ervHhyQer4plAslRLwusNZbUXMcnhsc3bp
	gcGrhWLmlnTAmsA3rjALlnoL3HjLK6G2FlaSBFslBkiRWxXtuscOtS0X8SQmr2omzf9miXIhhhnzK
	+6/iyzh0MW8buPDfcYQF2qSrzen4t6oJ6u/l6NFl1+2euM3KRmRd1laMKiiVR9tsz7AGhtKR6dcOr
	RamK3viYTnDRRU7gCRlBoyfd2ZdPJu2SBp/AHVubrhhe5bIGH6PlQ5GAMLJA08jlE4v+4R89+G9Zq
	IsoW0AC4cCrtXj46ZQPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga0aQ-00064r-L8; Thu, 20 Dec 2018 15:50:10 +0000
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga0aH-0004vE-58
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 15:50:07 +0000
Received: by mail-vs1-xe44.google.com with SMTP id y27so1375392vsi.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qn72qtavczvyDQK9+bypOLwn0vE7TYTvQ62AhlWVQvc=;
 b=c93U3JyxU7xHglhNXDNeXprXo6AnSMsYOYtv0bAJBQYaG/VFNHKiSoh3sjn5+4EIok
 BsWcGL3OAaiRmdepRf3pLtbpU/MyRxY+e9CW10GFIT3euZGvyafmJ2CwrGITnes/vCii
 hHBBU11S/aM8xzbF6ZSfauHf0vFO6wijkdxpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qn72qtavczvyDQK9+bypOLwn0vE7TYTvQ62AhlWVQvc=;
 b=rqd5NGin16d8zyyZLbA0treQCVTrrcDZhTPWYFvXSC1QJwpUXjdRbR4xx2HOn443b+
 YwSP9ezghQP36oLjN9+YSs4CfEfP15qv5xjBNxEOv/xm2gSXDh8PCmwg10pH1rxZdAsQ
 BweiXTmP9q4nPkBeDyurEZGETVZMCbHyd3XkCwMmyQ/9AfSOGEnQi47ZY2Z6RfuWvZ8F
 0YBIavZDurU4M5vYcYwHOubRZCFZCzP6Cm3MxPxxOiQ+rwpq9JQGKbDJzlXj1n0rf8aO
 KhXLz1IBdYPyvioq+WmvnAfSzJvnxRKIhM2ztrP6Ql/6xR/UgAPkkieUJ1cYG4qqwivW
 YpMg==
X-Gm-Message-State: AA+aEWabNsBNo2WH+58057F6aVg8z+lilHA1Aokg/HaZMRY621+XjBlv
 uestva4oc+fm6ORqHZO8aMnLMdmn9xJ6zho0AvzrcA==
X-Google-Smtp-Source: AFSGD/X0T/PUFBNw2axl+qwYI9yKy7q7VEdIgg/mW+jwrGKXNHWex9SJwM4cT5gy19+WAPLksaxH3/8dcTlPwFuGwik=
X-Received: by 2002:a67:7685:: with SMTP id r127mr12276554vsc.35.1545320986457; 
 Thu, 20 Dec 2018 07:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org>
 <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
In-Reply-To: <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Dec 2018 16:49:09 +0100
Message-ID: <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com>
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM
 domains
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_075001_196062_DFEE526F 
X-CRM114-Status: GOOD (  29.22  )
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

On Thu, 20 Dec 2018 at 15:19, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > Following changes are about to implement support for PM domains to PSCI.
> > Those changes are mainly going to be implemented in a new separate file,
> > hence a couple of the internal PSCI functions needs to be shared to be
> > accessible. So, let's do that via adding new PSCI header file.
> >
> > Moreover, the changes deploying support for PM domains, needs to be able to
> > switch the PSCI FW into the OS initiated mode. For that reason, let's add a
> > new function that deals with this and share it via the new PSCI header
> > file.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - New patch. Re-places the earlier patch: "drivers: firmware: psci:
> >         Share a few internal PSCI functions".
> >
> > ---
> >  drivers/firmware/psci/psci.c | 28 +++++++++++++++++++++-------
> >  drivers/firmware/psci/psci.h | 14 ++++++++++++++
> >  2 files changed, 35 insertions(+), 7 deletions(-)
> >  create mode 100644 drivers/firmware/psci/psci.h
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index 8dbcdecc2ae4..623591b541a4 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -34,6 +34,8 @@
> >  #include <asm/smp_plat.h>
> >  #include <asm/suspend.h>
> >
> > +#include "psci.h"
> > +
> >  /*
> >   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
> >   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> > @@ -90,23 +92,35 @@ static u32 psci_function_id[PSCI_FN_MAX];
> >  static DEFINE_PER_CPU(u32, domain_state);
> >  static u32 psci_cpu_suspend_feature;
> >
> > -static inline u32 psci_get_domain_state(void)
> > +u32 psci_get_domain_state(void)
> >  {
> >       return __this_cpu_read(domain_state);
> >  }
> >
> > -static inline void psci_set_domain_state(u32 state)
> > +void psci_set_domain_state(u32 state)
> >  {
> >       __this_cpu_write(domain_state, state);
> >  }
> >
> > +bool psci_set_osi_mode(void)
> > +{
> > +     int ret;
> > +
> > +     ret = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
> > +                     PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
> > +     if (ret)
> > +             pr_warn("failed to enable OSI mode: %d\n", ret);
> > +
> > +     return !ret;
> > +}
>
> Please keep the convention with the error code (0 => success)
>
> In the next patch it can be called:
>
> if (psci_has_osi_support())
>         osi_mode_enabled = psci_set_osi_mode() ? false : true;
>

Sure!

> > +
> >  static inline bool psci_has_ext_power_state(void)
> >  {
> >       return psci_cpu_suspend_feature &
> >                               PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
> >  }
> >
> > -static inline bool psci_has_osi_support(void)
> > +bool psci_has_osi_support(void)
> >  {
> >       return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
> >  }
> > @@ -285,10 +299,7 @@ static int __init psci_features(u32 psci_func_id)
> >                             psci_func_id, 0, 0);
> >  }
> >
> > -#ifdef CONFIG_CPU_IDLE
> > -static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> > -
> > -static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> > +int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> >  {
> >       int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
> >
> > @@ -305,6 +316,9 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_CPU_IDLE
>
> It would be nicer if you can remove the CONFIG_CPU_IDLE by replacing it
> with a specific one (eg. CONFIG_PSCI_IDLE) and make it depend on
> CONFIG_CPU_IDLE, so the config options stay contained in their
> respective subsystems directory.

I am all for simplifying the Kconfig options in here, as indeed it's
rather messy. However, I would rather avoid folding in additional
cleanup changes to this series, is already extensive enough.

Would you be okay if we deal with that on top?

[...]

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
