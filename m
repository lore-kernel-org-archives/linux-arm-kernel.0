Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDBFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908992054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NmxUvygy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908992054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wq3TrUEh/TLSXJlNBurwlFAl9rKSuv2KL0WzPdRjdSE=; b=NmxUvygyQhR2w+
	GFt0ctKE4viI1bbLTin9oJTAyild9nS5UNLyuNgP05nAQIvzDaIRHzMXEwTD+tT4Edl1z4vRR93fX
	KCR4ltzQOCVto2V+hPnUd9FhPBVe65auCgaZAOaxOnB/46VoKrV9AAJRj44ZNhowZe0sop5yDt186
	1BD9x0IjBGJXvSj0xWmYnPHDuNYh9bZ2oK1lApuJWMW/d04z8Nii/OXTLk0MomuhtVvL55Fqa5u8G
	dnYlVBdrdt+UTFLJHAR2sQQlRMQUHUTUJxhM3Tnsu3A8mzMmDjLT3WP/CFvjWkCo2pe9b7LqHFGkH
	sbBSpCToSfL86gMAHbKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk4gy-00014G-K6; Thu, 17 Jan 2019 10:14:32 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4gu-00013h-Qr; Thu, 17 Jan 2019 10:14:30 +0000
Received: by mail-ot1-f65.google.com with SMTP id s5so10608635oth.7;
 Thu, 17 Jan 2019 02:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s9h0YwkfxQwlaGw8Qv9w2vEklaH/txDnyG6QeSQpnQk=;
 b=RW/1ctJSvpOcJg8o/O+Kxf9tsV8IItvVEv8qha5IveUzNyRmysISmRMsPAzZgmAGj8
 JdMDsNKjFW4CdysSGkeK1J66nZjwfJTJ81pDw6y+t8z5JmQkDLwxO/wAlbh0nRjiPJ+n
 CgGZlB/t3Yv+qsbNayBvtDMraKz5ILFz3pOTgjT47L8PV95pUZA58cqPmnLTPR5ZvAWX
 +L+r8mb8yGgbmLBPq7mBTcdnDquHT04KUElB1vlk9BZ9sZt6rTL8gWKCz13yPpIZlJ1Y
 m0SvUdAeYevqjjPaZqiXtg/E9aCHmYGDVzTqJ/tzFAtJxCZ4Okdwqz5e833BzPGZHpnm
 wHKA==
X-Gm-Message-State: AJcUukd6oEtkcDbyWwig+wfbIaqqLhVvt2oE7nqYzGTLhW+wC6pVnhkQ
 FMW4+7aet5JqNdjay5hO4apwzB2rcSwPLkufENmd7c0p
X-Google-Smtp-Source: ALg8bN6lre7Lb9QdYWyLzF1L1/2W7CyEcSJNBj/GljFrwE2iANjN3EkC7hylf5X4+4O7fjrdTo6ld2ApR48874Ysme8=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr8554395otg.139.1547720067764; 
 Thu, 17 Jan 2019 02:14:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7>
 <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jan 2019 11:14:16 +0100
Message-ID: <CAJZ5v0jMOnV-maVfxbD-8HWOV30qzLfYUYN+xMNBhhgJWB2aFw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
To: Viresh Kumar <viresh.kumar@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_021428_865922_B1D044E2 
X-CRM114-Status: GOOD (  21.97  )
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

On Thu, Jan 17, 2019 at 11:08 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 17, 2019 at 6:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 14-01-19, 22:04, Amit Kucheria wrote:
> > > Add a flag to be used by cpufreq drivers to tell cpufreq core to
> > > auto-register themselves as a thermal cooling device.
> > >
> > > There series converts over all the drivers except arm_big_little.c.
> > > Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> > > others.
> > >
> > > Things needing fixing:
> > >  - Look at how to detect that we're not in IKS mode in arm_big_little's
> > >    .ready callback.
> >
> > is_bL_switching_enabled() lets you know if IKS is enabled or not.
> > Set/clear flag conditionally before the cpufreq-driver is registered,
> > based on the output of is_bL_switching_enabled().
> >
> > >  - The other pending issue is to fix allmodconfig that leaves us with
> > >    CPU_FREQ=y and THERMAL=m (CPU_THERMAL=y). That leads to undefined
> > >    references for functions defined in cpu_cooling.c
> >
> > Okay, that's a terrible thing and the solution looks to be rather
> > difficult.
> >
> > For others who may not be aware of the issue here, currently the
> > cpufreq drivers use helpers of cpu_cooling.c (CONFIG_CPU_THERMAL),
> > which uses helpers of the thermal core (CONFIG_THERMAL).
> > CONFIG_THERMAL is defined as tristate and CONFIG_CPU_THERMAL as bool
> > in Kconfigs.
>
> And CONFIG_CPU_THERMAL is defined under "if THERMAL".
>
> > The cpufreq drivers using the cpu_cooling.c file have this in their
> > Kconfig entry:
> >
> > # if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
> > #       depends on !CPU_THERMAL || THERMAL
> >
> >
> > This series now places the cpufreq core in place of the cpufreq driver
> > and it messes up everything. It is not just about allmodconfig, but
> > any configuration which makes the compilation fail.
> >
> > What are the solutions we have now ?
> >
> > 1. Have following for CONFIG_CPU_FREQ
> >        depends on !CPU_THERMAL || THERMAL
>
> Sorry, but this makes my teeth hurt.
>
> >    The platforms which don't need CPU_THERMAL (like x86) should not
> >    enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.
> >
> >    @amit: If this gets accepted, please update the Kconfig entries for
> >    all those drivers to not have above lines anymore.
> >
> > - Change CONFIG_THERMAL to bool instead of tristate ?
> >
> > - Anything else ?
>
> The design in the thermal subsystem seems to be upside-down.
> Non-modular code should never be made depend on anything only defined
> in a module.
>
> Would an explicit "select THERMAL" under CPU_THERMAL cause THERMAL to be 'y'?

Alternatively, "depends on THERMAL=y" under CPU_THERMAL should work
too, shouldn't it?  "!CPU_THERMAL || THERMAL" would be always true
then, AFAICS.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
