Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E94C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:29:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F90218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BitaViYY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gClI8gB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F90218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fuZDzibx1u2kolR8p3BSqUSClH+HFccKoWZ91HPlQiA=; b=BitaViYYtt0jWH
	WRO5RBxyAS1nn/pBKTiuEn5Q6FPukhmvb03IwJmuhPedNSi1ZrSzXqbnVPRzWmf4H+XueFpF7I+8c
	4Zh1QtWNpZWB7Q/XkcUDIRZK1pd4gff6h2QkTSU388z6/RASnFb2mJfR35xYU6DICf7jAcEcNZ8Lc
	4qKngEpAK8nTmuH575/66fMUZU+37r1731AgG5qMnhOae3mmLRuOIPNjKhM1q1jqcNLoz/7HiDnP3
	523HNAmnEzFs5bH3Hze9vQtNO8z0f/7oAyfhaK+6739Q1DVE6nc1X5kKYfFWnGSoxDNmU/u3Pe2gl
	am9tDwmufnwxZpoCWP7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpakg-0002Uz-WF; Fri, 01 Feb 2019 15:29:11 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpakd-0002UW-HZ
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:29:09 +0000
Received: by mail-io1-xd44.google.com with SMTP id m19so6000365ioh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uYKc9GV/4uCJsaJYgvdgE+UUlXO7kvvSTACKVVKdeEU=;
 b=gClI8gB5sXKGUTrc4Umfpr9L3RkHZb7r/U34ZyDlWsq9cBUeK3gw/O+Zod6ppjd8/O
 QgPqMHJ/wXVYQQpJctIrTdIdMdak5H1CjwXJvTg6wMGTvGkzPkbMCrVkd5489Qb9D52B
 f2ANrunklqX7yRGg/smX1a/P3MclaQBp1y+z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uYKc9GV/4uCJsaJYgvdgE+UUlXO7kvvSTACKVVKdeEU=;
 b=BhyziP+vQ0jblq32UOx1asmDXEO/mr5kMZnuTPSgoZO42Qd98zmzLlW5ZnroaqaUv7
 +gdi0qvA5sE8FJSjl63PJMLkAbU5lCsKPFQ4i7ho2ZGFlL59b26u9kqsMc7gV1u1f1rN
 JDwmitPfPgbrTopFPDflZ1ihQzOFMBbrNrnsaMx+egy0q8dwxhVLUXxChdyNLVMBcckU
 ZM/mjBxc9MdGqDfe3L7/e8pxLbEFNYaTHPlND0OY8YfsIHtI6oujh0pCDj5Y3UeYlRYM
 /HyHn4SslnxFxyRwrNb8lUhAoUjxm+nhEvBHC59tOzJjOn+J/Vs+Kux5Tt/e9MRmZJ0i
 ZgFg==
X-Gm-Message-State: AHQUAubI2GNIdXCiNSkvPxnkumUu7JD2N/YixRcPMsBQZFoha8TOrxpb
 qsVMoVqtr2dpAn65sOtrapMLGb8sPjvSqYOVFLoW+w==
X-Google-Smtp-Source: AHgI3IZYLv9yZWEvhp1o6Pj4fxsF+K3xGXgAWckOMz6MVhkiR0dg7Tm6iQPvfGv6HDWKUxS90rDkP1n4smkpzzBuiBg=
X-Received: by 2002:a6b:c8c9:: with SMTP id
 y192mr22069631iof.183.1549034945923; 
 Fri, 01 Feb 2019 07:29:05 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
 <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
 <OSBPR01MB210387DEC42870D8E5688CE9B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB210387DEC42870D8E5688CE9B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 1 Feb 2019 16:28:54 +0100
Message-ID: <CAKfTPtDNMV+HFsqc9A0VcMHOO=MvxWYZt8XkmWepso7SpfeAqA@mail.gmail.com>
Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
To: Biju Das <biju.das@bp.renesas.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_072907_579335_5ACE40EE 
X-CRM114-Status: GOOD (  26.31  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 1 Feb 2019 at 16:02, Biju Das <biju.das@bp.renesas.com> wrote:
>
> Hi Vincent,
>
> I have rebased my kernel to "next-20190201".  Still I am seeing dead lock.
>
> Am I missing any patch?

No you don't miss anything.
I think that it's the opposite.

Modification in time accounting in PM runtime has been queued but it
has not moved (yet) to ktime_get_mono_fast_ns()

Can you try to revert c669560be6c8 ("PM-runtime: Replace jiffies-based
accounting with ktime-based accounting") ?

>
> root@ek874:/# echo e61e0000.timer > /sys/devices/system/clocksource/clocksource0/current_clocksource
> [  193.869423]
> [  193.870963] ============================================
> [  193.876292] WARNING: possible recursive locking detected
> [  193.881625] 5.0.0-rc4-next-20190201-00007-g731346f #3 Not tainted
> [  193.887737] --------------------------------------------
> [  193.893066] migration/0/11 is trying to acquire lock:
> [  193.898136] (____ptrval____) (tk_core.seq){----}, at: update_pm_runtime_accounting+0x14/0x68
> [  193.906632]
> [  193.906632] but task is already holding lock:
> [  193.912483] (____ptrval____) (tk_core.seq){----}, at: multi_cpu_stop+0x8c/0x140
> [  193.919828]
> [  193.919828] other info that might help us debug this:
> [  193.926377]  Possible unsafe locking scenario:
> [  193.926377]
> [  193.932314]        CPU0
> [  193.934765]        ----
> [  193.937216]   lock(tk_core.seq);
> [  193.940453]   lock(tk_core.seq);
> [  193.943691]
> [  193.943691]  *** DEADLOCK ***
> [  193.943691]
> [  193.949634]  May be due to missing lock nesting notation
> [  193.949634]
> [  193.956446] 3 locks held by migration/0/11:
> [  193.960642]  #0: (____ptrval____) (timekeeper_lock){-.-.}, at: change_clocksource+0x2c/0x118
> [  193.969125]  #1: (____ptrval____) (tk_core.seq){----}, at: multi_cpu_stop+0x8c/0x140
> [  193.976903]  #2: (____ptrval____) (&(&dev->power.lock)->rlock){....}, at: __pm_runtime_resume+0x40/0x98
> [  193.986339]
> [  193.986339] stack backtrace:
> [  193.990715] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.0.0-rc4-next-20190201-00007-g731346f #3
> [  193.999707] Hardware name: Silicon Linux RZ/G2E evaluation kit EK874 (CAT874 + CAT875) (DT)
> [  194.008089] Call trace:
> [  194.010553]  dump_backtrace+0x0/0x178
> [  194.014227]  show_stack+0x14/0x20
> [  194.017562]  dump_stack+0xb0/0xec
> [  194.020895]  __lock_acquire+0xfb4/0x1c08
> [  194.024832]  lock_acquire+0xd0/0x268
> [  194.028420]  ktime_get+0x5c/0x108
> [  194.031747]  update_pm_runtime_accounting+0x14/0x68
> [  194.036643]  rpm_resume+0x4ec/0x698
> [  194.040144]  __pm_runtime_resume+0x50/0x98
> [  194.044264]  sh_tmu_enable.part.1+0x24/0x50
> [  194.048462]  sh_tmu_clocksource_enable+0x48/0x70
> [  194.053097]  change_clocksource+0x84/0x118
> [  194.057208]  multi_cpu_stop+0x8c/0x140
> [  194.060970]  cpu_stopper_thread+0xac/0x120
> [  194.065087]  smpboot_thread_fn+0x1ac/0x2c8
> [  194.069198]  kthread+0x128/0x130
> [  194.072439]  ret_from_fork+0x10/0x18
>
>
> Regards,
> Biju
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: 30 January 2019 21:53
> > To: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Linux PM <linux-pm@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Linux ARM <linux-arm-
> > kernel@lists.infradead.org>; Linux OMAP Mailing List <linux-
> > omap@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Ulf
> > Hansson <ulf.hansson@linaro.org>; Biju Das <biju.das@bp.renesas.com>;
> > Geert Uytterhoeven <geert@linux-m68k.org>; Linux-Renesas <linux-
> > renesas-soc@vger.kernel.org>
> > Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
> >
> > On Wed, Jan 30, 2019 at 6:26 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > A deadlock has been seen when swicthing clocksources which use PM
> > runtime.
> > > The call path is:
> > > change_clocksource
> > >     ...
> > >     write_seqcount_begin
> > >     ...
> > >     timekeeping_update
> > >         ...
> > >         sh_cmt_clocksource_enable
> > >             ...
> > >             rpm_resume
> > >                 pm_runtime_mark_last_busy
> > >                     ktime_get
> > >                         do
> > >                             read_seqcount_begin
> > >                         while read_seqcount_retry
> > >     ....
> > >     write_seqcount_end
> > >
> > > Although we should be safe because we haven't yet changed the
> > > clocksource at that time, we can't because of seqcount protection.
> > >
> > > Use ktime_get_mono_fast_ns() instead which is lock safe for such case
> > >
> > > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > > monotonic across an update and as a result can goes backward.
> > > According to
> > > update_fast_timekeeper() description: "In the worst case, this can
> > > result is a slightly wrong timestamp (a few nanoseconds)". For PM
> > > runtime autosuspend, this means only that the suspend decision can be
> > > slightly sub optimal.
> > >
> > > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using
> > > hrtimers")
> > > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >
> > > Hi Rafael,
> > >
> > > Sorry, I sent the version with the typo mistake that generated the
> > > compilation error reported by kbuild-test-robot
> > >
> > > This version doesn't have the typo.
> >
> > OK, I've applied this one, thanks!
>
>
>
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
