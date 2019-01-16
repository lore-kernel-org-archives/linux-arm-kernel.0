Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEAEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:10:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A68620859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hV3Xd5Re";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="awKxZ8q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A68620859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cwcnDIieypBfAh/Jud4ztt5kpeLrwGWEB22I/MUCIUI=; b=hV3Xd5Refw5tDM
	gQbm5T/+/jYwNOLXYiR1SSLOms5y5XJ3H0rltAgigHr9woNzxVbfRkSu/dERKHN8des2YsS5nN4kp
	1tpZV/+BSMMCNqoMN1pV9/sjhYKkxmw0231h11AwcfssRnAoaT3DHOa6m9HM+S4oQd+TC8TgMgQmg
	s8zd/MFG3/fQrSpClTPb5rYVDxYFqZg27uoqh+5Zs6OUOxCYnULS5/RwKl+Mk1uYik2JKwFREmsch
	T77pUc8wJ+QXcALl0HEin1z056/JsbWWKvMh4zJR3y1m5uhRAvtIJBJE8h1zzoae66X6ni28ptzmN
	u3GDI1F1BtGdLjjq3VWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjhDm-0001Ty-IF; Wed, 16 Jan 2019 09:10:50 +0000
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjhDj-0001TU-Is
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 09:10:49 +0000
Received: by mail-vk1-xa42.google.com with SMTP id 185so1256508vkc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 01:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dcwaRMhjXSECOE67I6lMjcuIZ7ofsCe0YGAPYo6ayZA=;
 b=awKxZ8q2/TJHio+OyqxnOP8hyfGoGaOHKxa3+O+AmmYN/2uBwfm3BTSi2ezy/zrwvR
 YIAkUB+FeBai5HWfza7xxk7N9mFcCPTX2cs1x1kmRNetuuI0/4OAjIAtvQ6MZBNhpXED
 LmQQh5YjOuNiUgt1PSJd5ym4yx7RdiTvJT2wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dcwaRMhjXSECOE67I6lMjcuIZ7ofsCe0YGAPYo6ayZA=;
 b=jPgi+7oSxTwzbJ5y4QWDdPn8FS8dxI00KtSuQbm3c7dtQwWiKPZ3mKfyS5FrjT3MOW
 GnUMbJ6wRRlAtWWiUS9G/ec/sCL5Hod3/h2tgQ/32fYh37fqJqvXO/xFwLUEya+tHHVZ
 q0SGlw5zcwsNrBQFk+6/2eSKVxaLjadC+pW5VXRYHCzpHD4EoDTzICpkISiL3M/BeZ2N
 hLOPAZetxciYqPpHr6P2lb2R4sSQXBotLDMf0YZoTSUQwLzHFltXfcDbHeVM/7cFGzFt
 fT+5rlgROzhHRpTwCwEPPbSUis/A4LObo98tpFgAWr1N48g1Shf+EZbG+bM7uc38Est5
 ZEhA==
X-Gm-Message-State: AJcUukconzSlfrCS7W/3O6pLbrzLufroORKyUbZ3U3ggABjadJi46wNA
 iP9poIW5X2GsgYzO50lJmO8HFBYBpq7fuuPofQvi8w==
X-Google-Smtp-Source: ALg8bN52JqwTAvztvEtxU7NN8leFd8TWL64GZBajh7fHo8Jduh6ndApXoKn567U1gIGuU4Bj2Vzot6zaA/I1W72Q1uc=
X-Received: by 2002:a1f:9042:: with SMTP id s63mr3018099vkd.17.1547629844899; 
 Wed, 16 Jan 2019 01:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20190103120612.GC23511@e107155-lin>
In-Reply-To: <20190103120612.GC23511@e107155-lin>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 16 Jan 2019 10:10:08 +0100
Message-ID: <CAPDyKFp-JB85TZOs+oso0iidaAsm1A=UDrg=gv+QZ4VJ9gW=fA@mail.gmail.com>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To: Sudeep Holla <sudeep.holla@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_011047_648941_E13968F7 
X-CRM114-Status: GOOD (  25.74  )
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
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 3 Jan 2019 at 13:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Nov 29, 2018 at 06:46:33PM +0100, Ulf Hansson wrote:
> > Over the years this series have been iterated and discussed at various Linux
> > conferences and LKML. In this new v10, a quite significant amount of changes
> > have been made to address comments from v8 and v9. A summary is available
> > below, although let's start with a brand new clarification of the motivation
> > behind this series.
>
> I would like to raise few points, not blockers as such but need to be
> discussed and resolved before proceeding further.
> 1. CPU Idle Retention states
>         - How will be deal with flattening (which brings back the DT bindings,
>           i.e. do we have all we need) ? Because today there are no users of
>           this binding yet. I know we all agreed and added after LPC2017 but
>           I am not convinced about flattening with only valid states.

Not exactly sure I understand what you are concerned about here. When
it comes to users of the new DT binding, I am converting two new
platforms in this series to use of it.

Note, the flattened model is still a valid option to describe the CPU
idle states after these changes. Especially when there are no last man
standing activities to manage by Linux and no shared resource that
need to prevent cluster idle states, when it's active.

>         - Will domain governor ensure not to enter deeper idles states based
>           on its sub-domain states. E.g.: when CPUs are in retention, so
>           called container/cluster domain can enter retention or below and not
>           power off states.

I have tried to point this out as a known limitation in genpd of the
current series, possibly I have failed to communicate that clearly.
Anyway, I fully agree that this needs to be addressed in a future
step.

Note that, this isn't a specific limitation to how idle states are
selected for CPUs and CPU clusters by genpd, but is rather a
limitation to any hierarchical PM domain topology managed by genpd
that has multiple idle states.

Do note, I already started hacking on this and intend to post patches
on top of this series, as these changes isn't needed for those two
ARM64 platforms I have deployed support for.

>         - Is the case of not calling cpu_pm_{enter,exit} handled now ?

It is still called, so no changes in regards to that as apart of this series.

When it comes to actually manage the "last man activities" as part of
selecting an idle state of the cluster, that is going to be addressed
on top as "optimizations".

In principle we should not need to call cpu_pm_enter|exit() in the
idle path at all, but rather only cpu_cluster_pm_enter|exit() when a
cluster idle state is selected. That should improve latency when
selecting an idle state for a CPU. However, to reach that point
additional changes are needed in various drivers, such as the gic
driver for example.

>
> 2. Now that we have SDM845 which may soon have platform co-ordinated idle
>    support in mainline, I *really* would like to see some power comparison
>    numbers(i.e. PC without cluster idle states). This has been the main theme
>    for most of the discussion on this topic for years and now we are close
>    to have some platform, we need to try.

I have quite recently been talking to Qcom folkz about this as well,
but no commitments are made.

Although I fully agree that some comparison would be great, it still
doesn't matter much, as we anyway need to support PSCI OSI mode in
Linux. Lorenzo have agreed to this as well.

>
> 3. Also, after adding such complexity, we really need a platform with an
>    option to build and upgrade firmware easily. This will help to prevent
>    this being not maintained for long without a platform to test, also
>    avoid adding lots of quirks to deal with broken firmware so that newer
>    platforms deal those issues in the firmware correctly.

I don't see how this series change anything from what we already have
today with the PSCI FW. No matter of OSI or PC mode is used, there are
complexity involved.

Although, of course I agree with you, that we should continue to try
to convince ARM vendors about moving to the public version of ATF and
avoid proprietary FW binaries as much as possible.

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
