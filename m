Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C705AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:18:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942B8218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KNWbTQ1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942B8218A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Cf+yYxBkF9uHFkXnEgBbr88V+zlwEBmfzQA2VAVm0s=; b=KNWbTQ1YXAZA12
	J9shXDPuJKtifXuf87HNMRIe1aVquo9CpqvDZeUaAjFQJOHn1I4E9aoqXm7Npaar9MUCY81nqmhkg
	++Qdta7WlALLT9L77bHuSzjHmztSsWKGMiRBE1cl7x6zcJAtZcDo2Ga7OxQkbIllGvMPynHR0cXy7
	SCblWRD5MNuj2go8EZXvmzByx6wT8LQz/no/DObCbTzQTkm7YX1K3wrvQv3+fiLweKVE2t3McgxG1
	d94Jfsai8yYeNH+b14f1kNLibcVWR3o+iPe02BifoW/Nh2K5XZdNtOZ6Pb8le3hhl77CRvWuVuXTd
	eQRVGnEqDT0lc/huptCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyl39-0005mh-C6; Tue, 26 Feb 2019 22:18:07 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyl35-0005lx-V1
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 22:18:05 +0000
Received: by mail-oi1-f196.google.com with SMTP id e7so11759300oia.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 14:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HDa/ptpbA7FOQQPBvC4Dp/ILmzgJ+DifAfs5Neb6F6E=;
 b=muFRJHOXhcgN9N36+yIdHGpql+JinqHBo/R5pbVQw6vKb3/wrTV362oAhMJmcx5ALZ
 jVkKi4WYM8LcFq4uW5yIf26wgULZttHqQgKwPkvg2INmv5GXWrLLkVE3Mk2NYwjRYMae
 GQna77fwhFdakkKEFZzbOEH9QS8xdwvHfN65eJRCvaAec5qbg44p+//dpPBzHT/tR0XP
 LjXa6p0EzL/wQtaU7S68ZvQdLYD1Ih3zw2RD6LV9Se9MaihHvEsXje1K+MEPWt+Ouevl
 ZmOdDoio8pff3/8/1v4ffrJFPNgD6eCocslgOvPid/8gLvUgYBVaF6J2zXH3UBgV1VvR
 k1zQ==
X-Gm-Message-State: AHQUAuYInUgZcHu9y5TLstKIziuF6WiDk6q6N0HQwB/iOwbWHXlB62LI
 xccup4ZdewlkB5qQhdYIvnygofc2vIb0s3lupuc=
X-Google-Smtp-Source: AHgI3IZz657IyniTaNC/i3jZGnKN4wLb8EEzLCFTcKbZbncwkAb+Ox9U1LH5y3d3Xkjzv6349PjrMjgbDBiMwtXrav8=
X-Received: by 2002:aca:88b:: with SMTP id 133mr3884939oii.95.1551219482652;
 Tue, 26 Feb 2019 14:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <20190226145415.19411-8-ulf.hansson@linaro.org>
 <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=ddMEwvr8rt=PxxPpxoAHary7cYLYgTBbcuBuiGbTZA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Feb 2019 23:17:51 +0100
Message-ID: <CAJZ5v0icO1VUm7bFLA+3=zLF2BpbP5QC=evS9b0LAbWAC+SqhQ@mail.gmail.com>
Subject: Re: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before
 selecting an idle state
To: Ulf Hansson <ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_141803_999030_DC95DA2E 
X-CRM114-Status: GOOD (  16.34  )
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
 Frederic Weisbecker <fweisbec@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 26, 2019 at 11:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 26, 2019 at 3:54 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > A common piece of data used by cpuidle governors, is the information about
> > when the next timer/tick is going to fire. Rather than having each governor
> > calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
> > the code by calling these functions before invoking the ->select() callback
> > of the governor - and store the output data in the struct cpuidle_device.
>
> That misses the point IMO.
>
> You don't need to store two values in struct cpuidle_device, but just
> one, and not before running ->select(), but before invoking the
> driver's ->enter() callback.
>
> At that point, the decision on whether or not to stop the scheduler
> tick has been made already and it should be sufficient to store the
> return value of tick_nohz_get_next_hrtimer() introduced by patch
> [3/8],

Or the difference between in and ts->idle_entrytime for that matter,
whichever is more useful.

> because that value represents the next timer regardless of what
> has been decided with respect to the tick.
>
> And you won't need the tick_nohz_get_next_timer() any more then.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
