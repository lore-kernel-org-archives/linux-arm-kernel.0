Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D843C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA4E2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UKKWRM6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA4E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YYgdAzMYyHm9Peqv3jwL36+rZlHrqHl/+aGf9YHFLTc=; b=UKKWRM6pBBD6Ae
	PP7m8bza7Jr2kGlNzGKJpfIdJsqzqi+XaYtsUVf/hp0dRvFKbIxcn5xNNubGQwfooNuBFjKHtIC1S
	t0y64+UcADpZaC8zlSC2d4M8jdpaWRPTqF9mss6XC1U5dyq9gm6+xsnxFJ7ztjYykzCfF1d1yjoKl
	oB1WcoKJ0wPIOUIn4sfYKFozqpNpoPWKKd3pyKk5a1aY8lwkGVwi4gBJk0k8z3R7K61AIRbymWIsZ
	TFQeV3V47YM+/5f3WhGwyshHolEI8fRpL6CiIt9UXdpPy9lLdU1hrrmek3wDheML1ZmcLzo6Uhzw0
	6zq0CBJJN/lEoHdwq69A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk4bV-0007F6-HT; Thu, 17 Jan 2019 10:08:53 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4bT-0007Ej-2n; Thu, 17 Jan 2019 10:08:52 +0000
Received: by mail-ot1-f68.google.com with SMTP id w25so10559903otm.13;
 Thu, 17 Jan 2019 02:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=438LmxlRqmX1Z8nfxUBP4cpRWlXxVI4hUs/MnRI3eXE=;
 b=S1aTqO5gwLUbWN1g9L+BBwYZ/pd41i5Ltdabdu7Z2ASfGw4jB+xchAwsoT3t9hc0DU
 GtN4fwg4tHvrPbye9Dl+jJFYtvqJzNmRaMFgXsE++s466gJL3D4zesz+FmWbJCbNzRtI
 4RWABT9hfE+Hbk7y5OeNygNaIDLZgEtqHGfAcp8gXhk/OI9CgEtz1MXqIh++8nT7kgzZ
 WDTqNmJgW1tT00YZqAXlob8M0B4iFrye1VbMYsMACrGMG5f67mRuf0U3iqMPO7Q9wGwj
 cAO6W1mVzVwK5m3apm05MvVJhaRgnJ//BFH1zlRhSr2hU0CVq/rEMaVVt5lJkW3sxsT+
 d7/g==
X-Gm-Message-State: AJcUukfhs+jzw/HZ6GtaJ6PdnmKXO5ZyxqkxFtLYnKViz6iGwfZtjzVd
 70vXZ8ms5fmP0lWiVN+Fxqdn7P2yy1kN/PrQ3wE=
X-Google-Smtp-Source: ALg8bN59jsC+Qkq1M45eC1FC/FMXbtSfl7Cppi3k8YlECf2lKBzLaHoQWqkGl45qIOSiKVTyxolgk0uclTOJxzMxzE4=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr7890302otq.119.1547719729999; 
 Thu, 17 Jan 2019 02:08:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7>
In-Reply-To: <20190117054916.dqduckt7larn32av@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jan 2019 11:08:38 +0100
Message-ID: <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
To: Viresh Kumar <viresh.kumar@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_020851_120381_A5B4EB9A 
X-CRM114-Status: GOOD (  19.66  )
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
Cc: "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eduardo Valentin <edubezval@gmail.com>, Matthias Kaehlcke <mka@chromium.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Stephen Boyd <swboyd@chromium.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 17, 2019 at 6:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-01-19, 22:04, Amit Kucheria wrote:
> > Add a flag to be used by cpufreq drivers to tell cpufreq core to
> > auto-register themselves as a thermal cooling device.
> >
> > There series converts over all the drivers except arm_big_little.c.
> > Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> > others.
> >
> > Things needing fixing:
> >  - Look at how to detect that we're not in IKS mode in arm_big_little's
> >    .ready callback.
>
> is_bL_switching_enabled() lets you know if IKS is enabled or not.
> Set/clear flag conditionally before the cpufreq-driver is registered,
> based on the output of is_bL_switching_enabled().
>
> >  - The other pending issue is to fix allmodconfig that leaves us with
> >    CPU_FREQ=y and THERMAL=m (CPU_THERMAL=y). That leads to undefined
> >    references for functions defined in cpu_cooling.c
>
> Okay, that's a terrible thing and the solution looks to be rather
> difficult.
>
> For others who may not be aware of the issue here, currently the
> cpufreq drivers use helpers of cpu_cooling.c (CONFIG_CPU_THERMAL),
> which uses helpers of the thermal core (CONFIG_THERMAL).
> CONFIG_THERMAL is defined as tristate and CONFIG_CPU_THERMAL as bool
> in Kconfigs.

And CONFIG_CPU_THERMAL is defined under "if THERMAL".

> The cpufreq drivers using the cpu_cooling.c file have this in their
> Kconfig entry:
>
> # if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
> #       depends on !CPU_THERMAL || THERMAL
>
>
> This series now places the cpufreq core in place of the cpufreq driver
> and it messes up everything. It is not just about allmodconfig, but
> any configuration which makes the compilation fail.
>
> What are the solutions we have now ?
>
> 1. Have following for CONFIG_CPU_FREQ
>        depends on !CPU_THERMAL || THERMAL

Sorry, but this makes my teeth hurt.

>    The platforms which don't need CPU_THERMAL (like x86) should not
>    enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.
>
>    @amit: If this gets accepted, please update the Kconfig entries for
>    all those drivers to not have above lines anymore.
>
> - Change CONFIG_THERMAL to bool instead of tristate ?
>
> - Anything else ?

The design in the thermal subsystem seems to be upside-down.
Non-modular code should never be made depend on anything only defined
in a module.

Would an explicit "select THERMAL" under CPU_THERMAL cause THERMAL to be 'y'?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
