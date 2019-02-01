Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF3EC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E2F2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZiA4eRVk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyT0WPZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E2F2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+3VVD131woiaxwmc7ZwJ4mQCmKL/FSmqbfneIKqPv1c=; b=ZiA4eRVk0X/pl5
	dnmH2svCHivNm2XWQbEncX8ON2jp0y+BMjKHdIc9eP9cPBnDgvGkiZFEV3pddMnwumo+iJytH4BUs
	EErTS70WidulMsI3wrmiCvOhmDIZm19s6bT7SkOYhiW5071VcLTWmzXmB6XkCu7qJr/OABHv8cs5G
	+U9tS27Qrc9mCPVAgpSyKS00NsiYqb5CwCsnykSswqYdJozgn9935Pb++0LUUJY5uVUDt3lnZ5jCL
	g1dc+UtlBHrvWd2LZTGMhZJnDuMVTiy6orDo5SLSTFzA7AZozLO2iDpUp8kU8Yr1JCF8xeCBrEWwB
	8OF5diILtBOjQOMuHS/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb5N-0003PA-Ch; Fri, 01 Feb 2019 15:50:33 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpb0l-00065T-C4
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:46:31 +0000
Received: by mail-wm1-x341.google.com with SMTP id m1so6588391wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=nmKI7S7geKqD0oD5uE7F9WOUkGs9hutqw9feJA1Xf/8=;
 b=QyT0WPZP2kpW6A+LnwV1/7aGFdQXYZcE3w2jUHcT6S4TZCf39dEn+iap/9OAyeBsyY
 V2s3nXK7XZV4qWO3hA83fqnwKSSvqFzfHgYwuGp9oMtQRJ0rVEZCfDdet5QZK/KAW0EN
 oNPKiMbYLBl8J2I/tjYyBtZ0RL54zXVkkWXtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=nmKI7S7geKqD0oD5uE7F9WOUkGs9hutqw9feJA1Xf/8=;
 b=lxrFDM8qL1vzP86baUiWK+40lzpsc2cVtjQhtCjnupL8OZjVHQmRJi/rlh7rWtWi51
 CvmCaU6LtfJcz+kZHGCWGMtsdV6GPlw+gghlbwsamKQF89do9knWdPVZyJeGCO/OnMXf
 6oGxfAdnh86e1JBPlVda4wxhQlDEVrMfvVX9QYI/kU/7rMmr1u5XZZbvzcX+KG0Xi1T5
 T3Zl3ws0oVRlkS3sL5EnAcNwIvViBuTMevmNANjyL8dFEZV+h41TNOJYakPZbW+JQCcr
 YFvtgZ9ZbLLxGKrGHQkI/9sEh83+YTamiXiR9u7P88NlMRbM3Yq7BJZhH7NqGxvtMDN0
 EzTg==
X-Gm-Message-State: AHQUAuaAZcAGApMm8Y+XsGkFaMz82oFEWhxcguYBLftkx6wcm4pjPyR9
 ij4cRXO94+BAGb7f/DFpBe5Wmw==
X-Google-Smtp-Source: AHgI3IZarAaq62J0n0ZfIoDtAlPOP1lNA2i0d8VSH06kLsEmWDzqTgY/+kwG581xnv2H+ao9l3i0rQ==
X-Received: by 2002:a1c:2408:: with SMTP id k8mr2905350wmk.110.1549035945097; 
 Fri, 01 Feb 2019 07:45:45 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:4055:ba1:78bb:b422])
 by smtp.gmail.com with ESMTPSA id y138sm3911384wmc.16.2019.02.01.07.45.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:45:44 -0800 (PST)
Date: Fri, 1 Feb 2019 16:45:42 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
Message-ID: <20190201154542.GA6174@linaro.org>
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
 <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
 <OSBPR01MB210387DEC42870D8E5688CE9B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAKfTPtDNMV+HFsqc9A0VcMHOO=MvxWYZt8XkmWepso7SpfeAqA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKfTPtDNMV+HFsqc9A0VcMHOO=MvxWYZt8XkmWepso7SpfeAqA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074547_680983_B22158D2 
X-CRM114-Status: GOOD (  35.86  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Le Friday 01 Feb 2019 =E0 16:28:54 (+0100), Vincent Guittot a =E9crit :
> On Fri, 1 Feb 2019 at 16:02, Biju Das <biju.das@bp.renesas.com> wrote:
> >
> > Hi Vincent,
> >
> > I have rebased my kernel to "next-20190201".  Still I am seeing dead lo=
ck.
> >
> > Am I missing any patch?
> =

> No you don't miss anything.
> I think that it's the opposite.
> =

> Modification in time accounting in PM runtime has been queued but it
> has not moved (yet) to ktime_get_mono_fast_ns()
> =

> Can you try to revert c669560be6c8 ("PM-runtime: Replace jiffies-based
> accounting with ktime-based accounting") ?

Or instead you can apply :

---
 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4eaf166..1c40e2a 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,7 +66,7 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	u64 now =3D ktime_to_ns(ktime_get());
+	u64 now =3D ktime_get_mono_fast_ns();
 	u64 delta;
 =

 	delta =3D now - dev->power.accounting_timestamp;
@@ -1315,7 +1315,7 @@ void pm_runtime_enable(struct device *dev)
 =

 		/* About to enable runtime pm, set accounting_timestamp to now */
 		if (!dev->power.disable_depth)
-			dev->power.accounting_timestamp =3D ktime_to_ns(ktime_get());
+			dev->power.accounting_timestamp =3D ktime_get_mono_fast_ns();
 	} else {
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
 	}
-- =

2.7.4


>
> =

> >
> > root@ek874:/# echo e61e0000.timer > /sys/devices/system/clocksource/clo=
cksource0/current_clocksource
> > [  193.869423]
> > [  193.870963] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > [  193.876292] WARNING: possible recursive locking detected
> > [  193.881625] 5.0.0-rc4-next-20190201-00007-g731346f #3 Not tainted
> > [  193.887737] --------------------------------------------
> > [  193.893066] migration/0/11 is trying to acquire lock:
> > [  193.898136] (____ptrval____) (tk_core.seq){----}, at: update_pm_runt=
ime_accounting+0x14/0x68
> > [  193.906632]
> > [  193.906632] but task is already holding lock:
> > [  193.912483] (____ptrval____) (tk_core.seq){----}, at: multi_cpu_stop=
+0x8c/0x140
> > [  193.919828]
> > [  193.919828] other info that might help us debug this:
> > [  193.926377]  Possible unsafe locking scenario:
> > [  193.926377]
> > [  193.932314]        CPU0
> > [  193.934765]        ----
> > [  193.937216]   lock(tk_core.seq);
> > [  193.940453]   lock(tk_core.seq);
> > [  193.943691]
> > [  193.943691]  *** DEADLOCK ***
> > [  193.943691]
> > [  193.949634]  May be due to missing lock nesting notation
> > [  193.949634]
> > [  193.956446] 3 locks held by migration/0/11:
> > [  193.960642]  #0: (____ptrval____) (timekeeper_lock){-.-.}, at: chang=
e_clocksource+0x2c/0x118
> > [  193.969125]  #1: (____ptrval____) (tk_core.seq){----}, at: multi_cpu=
_stop+0x8c/0x140
> > [  193.976903]  #2: (____ptrval____) (&(&dev->power.lock)->rlock){....}=
, at: __pm_runtime_resume+0x40/0x98
> > [  193.986339]
> > [  193.986339] stack backtrace:
> > [  193.990715] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.0.0-rc4-n=
ext-20190201-00007-g731346f #3
> > [  193.999707] Hardware name: Silicon Linux RZ/G2E evaluation kit EK874=
 (CAT874 + CAT875) (DT)
> > [  194.008089] Call trace:
> > [  194.010553]  dump_backtrace+0x0/0x178
> > [  194.014227]  show_stack+0x14/0x20
> > [  194.017562]  dump_stack+0xb0/0xec
> > [  194.020895]  __lock_acquire+0xfb4/0x1c08
> > [  194.024832]  lock_acquire+0xd0/0x268
> > [  194.028420]  ktime_get+0x5c/0x108
> > [  194.031747]  update_pm_runtime_accounting+0x14/0x68
> > [  194.036643]  rpm_resume+0x4ec/0x698
> > [  194.040144]  __pm_runtime_resume+0x50/0x98
> > [  194.044264]  sh_tmu_enable.part.1+0x24/0x50
> > [  194.048462]  sh_tmu_clocksource_enable+0x48/0x70
> > [  194.053097]  change_clocksource+0x84/0x118
> > [  194.057208]  multi_cpu_stop+0x8c/0x140
> > [  194.060970]  cpu_stopper_thread+0xac/0x120
> > [  194.065087]  smpboot_thread_fn+0x1ac/0x2c8
> > [  194.069198]  kthread+0x128/0x130
> > [  194.072439]  ret_from_fork+0x10/0x18
> >
> >
> > Regards,
> > Biju
> >
> > > -----Original Message-----
> > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > Sent: 30 January 2019 21:53
> > > To: Vincent Guittot <vincent.guittot@linaro.org>
> > > Cc: Linux PM <linux-pm@vger.kernel.org>; Linux Kernel Mailing List <l=
inux-
> > > kernel@vger.kernel.org>; Linux ARM <linux-arm-
> > > kernel@lists.infradead.org>; Linux OMAP Mailing List <linux-
> > > omap@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Ulf
> > > Hansson <ulf.hansson@linaro.org>; Biju Das <biju.das@bp.renesas.com>;
> > > Geert Uytterhoeven <geert@linux-m68k.org>; Linux-Renesas <linux-
> > > renesas-soc@vger.kernel.org>
> > > Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
> > >
> > > On Wed, Jan 30, 2019 at 6:26 PM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > A deadlock has been seen when swicthing clocksources which use PM
> > > runtime.
> > > > The call path is:
> > > > change_clocksource
> > > >     ...
> > > >     write_seqcount_begin
> > > >     ...
> > > >     timekeeping_update
> > > >         ...
> > > >         sh_cmt_clocksource_enable
> > > >             ...
> > > >             rpm_resume
> > > >                 pm_runtime_mark_last_busy
> > > >                     ktime_get
> > > >                         do
> > > >                             read_seqcount_begin
> > > >                         while read_seqcount_retry
> > > >     ....
> > > >     write_seqcount_end
> > > >
> > > > Although we should be safe because we haven't yet changed the
> > > > clocksource at that time, we can't because of seqcount protection.
> > > >
> > > > Use ktime_get_mono_fast_ns() instead which is lock safe for such ca=
se
> > > >
> > > > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > > > monotonic across an update and as a result can goes backward.
> > > > According to
> > > > update_fast_timekeeper() description: "In the worst case, this can
> > > > result is a slightly wrong timestamp (a few nanoseconds)". For PM
> > > > runtime autosuspend, this means only that the suspend decision can =
be
> > > > slightly sub optimal.
> > > >
> > > > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using
> > > > hrtimers")
> > > > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > ---
> > > >
> > > > Hi Rafael,
> > > >
> > > > Sorry, I sent the version with the typo mistake that generated the
> > > > compilation error reported by kbuild-test-robot
> > > >
> > > > This version doesn't have the typo.
> > >
> > > OK, I've applied this one, thanks!
> >
> >
> >
> > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne En=
d, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Regist=
ered No. 04586709.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
