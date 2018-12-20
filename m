Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36503C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:11:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FFC21903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oxS1xg+n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlSGMD2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FFC21903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mBVui50TDkX+Qnlb1aZZMPG9myS1bpUWA7AJKitRh9E=; b=oxS1xg+nr839ls
	R9ETfHyPUrg8zNihY2eTMfXtNHCbH1T2VrwyKSV3sz85dgDEjBl6cmAfEMrOrYHoOzdgevPCcv6No
	dOw7JEqcDYSmPlGNWVPu83DeBNYrddk1H5mBiBgFQw1N0SscQ0AH1dtpyscEgpAfdHUcIy5Hpqh55
	LhIK/KkbFaTX9gWjijzcZpOhKMmLZxIpIatUP9jFxuYf0uZUPD/xTF5ba8BbpN61nFMFlRwhqg/ou
	BD//qbGiaubtAe6ich7mM1q9O48wu00jgA6sJoim7GVUO3mc6jfw/upzYe9YOJ+O/aWsuoivPgrPV
	JAwY1rJf4XC6J75BEdSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga5av-00070d-DD; Thu, 20 Dec 2018 21:11:01 +0000
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga5ag-0006hn-U8
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 21:10:51 +0000
Received: by mail-vs1-xe41.google.com with SMTP id n10so1960534vso.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 13:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cUq9TBBK9t1BgxHFuMyVN3iuBzPgKImOP2CXu8v7xh8=;
 b=QlSGMD2rj7s0+DheMQQSufYJhmCo8Zle1mdgAVDYkipVq9GdMLYYBayBErQLSXE0hW
 +H0GlKGcO9QpP4zNSaApPqF3zcNTQj43G+is0wmxB47MzLVrYxOejTXILZ+on5ecNTHl
 uRwemciysky7AeB34k431kNOLWV7tk3wynLXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cUq9TBBK9t1BgxHFuMyVN3iuBzPgKImOP2CXu8v7xh8=;
 b=r3cyavFjsd+Xel4LH+xd1PZprRcOWx2BzssKxi05NvC1fQL7gZudzSKVrgK3F43J5w
 8NLb6jh3xRFArNt954u8qfL55u4+GIE3s0iteqUe8MTBmQoyURUXERKY+V0i0HyteMI3
 owb/u1/hLbXcq/tQJXKqG22wAJq4q0rrXsE0q+/rGDvj7wm+G6UHQJYTlCdpzs/oYDIR
 GG2P68J8Ut1ZdClSrPf3cUbfWAxWBy+3CEmzVsehAxrF4wHfiDuf94Zg0Dl6jt7Bhb/J
 dCVLdl+gIPv89M1JzFeRwPF9vQQAt9pHfF4rp2FKJ7cZnTrKCTNKC1NfEO8Plwik0ouL
 3Cfw==
X-Gm-Message-State: AA+aEWbEedPz2SyavphoEwMJWVUMvnE7HEyO9FXv56byBVpUXYSLjuV5
 SV6heFVvO+IK5tgB4c5KFzIHX2qJojBud5BBQx+vOQ==
X-Google-Smtp-Source: AFSGD/UcKr+fxrsy9M49vWoFuydwg4E2/rRLDRfl/NqRVf2+hPr3L0AsZWYY7rX7f/wwiG3lJS2dg9psDnSV/eqyykk=
X-Received: by 2002:a67:7685:: with SMTP id r127mr12790733vsc.35.1545340235233; 
 Thu, 20 Dec 2018 13:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-19-ulf.hansson@linaro.org>
 <fa99b1a9-2e4d-e97c-9478-43b4d3ef9819@linaro.org>
In-Reply-To: <fa99b1a9-2e4d-e97c-9478-43b4d3ef9819@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Dec 2018 22:09:58 +0100
Message-ID: <CAPDyKFo5Qf-fODAugZK4CqOL81-r0uUjZVmoD2h+M8_b+-_95A@mail.gmail.com>
Subject: Re: [PATCH v10 18/27] drivers: firmware: psci: Add support for PM
 domains using genpd
To: Daniel Lezcano <daniel.lezcano@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_131047_344282_0C85DA98 
X-CRM114-Status: GOOD (  16.05  )
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

[...]

> > -obj-$(CONFIG_ARM_PSCI_FW)    += psci.o
> > +obj-$(CONFIG_ARM_PSCI_FW)    += psci.o psci_pm_domain.o
>
> Same comment as 17/27.
>
> +obj-$(CONFIG_PSCI_IDLE) += psci_pm_domain.o

Let's discuss that in patch 17 to agree on the way forward.

[...]

> > +static int psci_pd_power_off(struct generic_pm_domain *pd)
> > +{
> > +     struct genpd_power_state *state = &pd->states[pd->state_idx];
> > +     u32 *pd_state;
> > +     u32 composite_pd_state;
> > +
> > +     /* If we have failed to enable OSI mode, then abort power off. */
> > +     if (psci_has_osi_support() && !osi_mode_enabled)
> > +             return -EBUSY;
>
> I'm not sure EBUSY is the best error code to describe this situation.
> May be ENOTSUP ?

I see your point. However, -EBUSY is the correct code for this case as
it tells genpd that the PM domain could not power off, but needs to
stay powered on.

To be clear, genpd treat -EBUSY, in a bit special way.

>
> However, how possible is it to pass in this function if the OSI mode was
> not enabled ?

If we fail to enable OSI mode, we keep having the CPUs attached to
PSCI PM PM domains. Although, as we are then running in platform
coordinated mode, there is no point allowing a cluster idle state.

The option would be to convert to the flattened model in case we fail
to enable OSI mode, but that error path is going to be rather
complicated (we need to detach CPUs, unregister domains and providers,
etc). Instead the assumption is that it simply shouldn't fail when we
decide to try. If it does, it's likely something need to be fixed
anyways.

>
> > +     if (!state->data)
> > +             return 0;
> > +
> > +     /* When OSI mode is enabled, set the corresponding domain state. */
> > +     pd_state = state->data;
> > +     composite_pd_state = *pd_state | psci_get_domain_state();
> > +     psci_set_domain_state(composite_pd_state);
> > +
> > +     return 0;
> > +}
> > +
> > +static int psci_pd_parse_state_nodes(struct genpd_power_state *states,
> > +                             int state_count)
>
> __init ?

Yes, probably. I will check and see if/where it could makes sense.
Thanks for pointing it out!

[...]

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
