Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D67C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:03:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90AB2218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kym3s95z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="bglA+m2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AB2218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t4lkO9VrDQyfcrvZCXdSQT8HyNNHVi4+nZjr0EnlwYQ=; b=kym3s95zMiWxM7
	Jce09yDWS7FjC0IpykuyIJ4Mj3VOOsGxKLi1wGYJxrWzgfHhOVo65CuyxRZW6fNOukKnSLLMIkDa5
	RXebgyutdBZVhv/HrsIyJCHB5Cf1hQyx0wW/F1JJH90CFK5JuXVvOdrv1F8NEzELw86rqOoput8P5
	5wtIOoe5RHTyHTApDNw/fSuuMgERlWNfPfkZZUL1btOfsvG9YphRHH2AbilJX7VvFq2g7KEkviTH1
	LLIP4t0qFgMdo2s4JYkNyKQ9SXNtA0FlMMh7f/8uhrEuwmJhwI2k4HL9PyGkSCjMUEqNN6Jz7nwzp
	huci/Y9d01OYNjepV3QQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpaLP-0000Qf-EX; Fri, 01 Feb 2019 15:03:03 +0000
Received: from mail-eopbgr1410134.outbound.protection.outlook.com
 ([40.107.141.134] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpaLH-0000Ps-L8
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:03:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVkEVZgzMCi6v7s17iyhH2kuQ9ix5EccPaX8cuLmf3g=;
 b=bglA+m2ebpcn7YPMr2madjBA9/uN4g/zxMhtm/fX0hQapG2kwRnHJric//hRH/YZif/jAakpHudd1HVRfap1IsnDrLkrDIjq1xOqEo9G1WdfxfH7lN620KHts6NroOmLOJt99crsl7VYfksAD1Uydk5+EfdUtd6u/km5d6JheUY=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB3432.jpnprd01.prod.outlook.com (20.178.96.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 15:02:49 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::9cb9:6c95:2d20:7852]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::9cb9:6c95:2d20:7852%2]) with mapi id 15.20.1558.026; Fri, 1 Feb 2019
 15:02:49 +0000
From: Biju Das <biju.das@bp.renesas.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Vincent Guittot
 <vincent.guittot@linaro.org>
Subject: RE: [PATCH v3] PM-runtime: fix deadlock with ktime
Thread-Topic: [PATCH v3] PM-runtime: fix deadlock with ktime
Thread-Index: AQHUuMDySMSMVQqbW0iMWyMv4OqrSKXIWtMAgAKwb6A=
Date: Fri, 1 Feb 2019 15:02:49 +0000
Message-ID: <OSBPR01MB210387DEC42870D8E5688CE9B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
 <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
In-Reply-To: <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; OSBPR01MB3432;
 20:Aip9NjyVoU7OCxqPVXV4F3fQ1XbsG0tJyeIHAtQuGo6eVVIv5hRVCrNCowgV4U73V+ilhAWN8QrGRcR9P2TebT6XT7LZzbrJiOulk0PyKMB0VoeudWWmuwH/n4/lYBtrDic54k5r09ILPoqAg+vuZpjWMNvjypy3NFIx7gMMzNA=
x-ms-office365-filtering-correlation-id: cd513be2-c8ee-47e5-ff08-08d688565530
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:OSBPR01MB3432; 
x-ms-traffictypediagnostic: OSBPR01MB3432:
x-microsoft-antispam-prvs: <OSBPR01MB34329074942CF9282E18D584B8920@OSBPR01MB3432.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(13464003)(9686003)(110136005)(476003)(3846002)(54906003)(4326008)(305945005)(7736002)(316002)(44832011)(86362001)(25786009)(6116002)(6246003)(446003)(55016002)(11346002)(478600001)(8676002)(66066001)(53936002)(33656002)(81156014)(14454004)(81166006)(8936002)(2906002)(68736007)(26005)(229853002)(186003)(99286004)(102836004)(71200400001)(74316002)(71190400001)(97736004)(486006)(76176011)(7696005)(256004)(14444005)(6506007)(53546011)(6436002)(105586002)(106356001)(7416002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSBPR01MB3432;
 H:OSBPR01MB2103.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qhjp/YfuiNia9F3oF1D9WqFyU1HZZGQAatIyygT7HkpvR4P9Xm5xrS9Ddrf6LFNgqxISzBfxs3CTblq1g1L+UZUTDv1Kg58ohi0JbG27jYxzYqaqc6a9KviCe4ytfxY8UuAQMSOfJJjbgTpT4saPuQ5iYdbEJ+8BGRrQPlUkF1MtWOl98dbe8JtyLF1vijfIpsDK47VbHK447cDOA8WJJIYMMIMRdzLxzVeI2byYl1aUutbBZcu133eIyn6MYI4RtYOZAKy8Bh6ejTSN9nrPMpotODY8sV1EWfN8RHEE76r0LM9Os4jMV5kJPTAdVSEeVZCkewUSrps8L1lkUJovYX3xTiYO6iYZU10JxfrX5XAGrZf7AZsTK6Dg+nXBd1o7gzzAhEPfNtKgiSCUcf1h4Hj0dQhlovPRwYKvvz4xi2E=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd513be2-c8ee-47e5-ff08-08d688565530
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 15:02:49.5311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3432
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_070255_741038_8D47EF6B 
X-CRM114-Status: GOOD (  26.59  )
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

Hi Vincent,

I have rebased my kernel to "next-20190201".  Still I am seeing dead lock.

Am I missing any patch?

root@ek874:/# echo e61e0000.timer > /sys/devices/system/clocksource/clocksource0/current_clocksource
[  193.869423]
[  193.870963] ============================================
[  193.876292] WARNING: possible recursive locking detected
[  193.881625] 5.0.0-rc4-next-20190201-00007-g731346f #3 Not tainted
[  193.887737] --------------------------------------------
[  193.893066] migration/0/11 is trying to acquire lock:
[  193.898136] (____ptrval____) (tk_core.seq){----}, at: update_pm_runtime_accounting+0x14/0x68
[  193.906632]
[  193.906632] but task is already holding lock:
[  193.912483] (____ptrval____) (tk_core.seq){----}, at: multi_cpu_stop+0x8c/0x140
[  193.919828]
[  193.919828] other info that might help us debug this:
[  193.926377]  Possible unsafe locking scenario:
[  193.926377]
[  193.932314]        CPU0
[  193.934765]        ----
[  193.937216]   lock(tk_core.seq);
[  193.940453]   lock(tk_core.seq);
[  193.943691]
[  193.943691]  *** DEADLOCK ***
[  193.943691]
[  193.949634]  May be due to missing lock nesting notation
[  193.949634]
[  193.956446] 3 locks held by migration/0/11:
[  193.960642]  #0: (____ptrval____) (timekeeper_lock){-.-.}, at: change_clocksource+0x2c/0x118
[  193.969125]  #1: (____ptrval____) (tk_core.seq){----}, at: multi_cpu_stop+0x8c/0x140
[  193.976903]  #2: (____ptrval____) (&(&dev->power.lock)->rlock){....}, at: __pm_runtime_resume+0x40/0x98
[  193.986339]
[  193.986339] stack backtrace:
[  193.990715] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.0.0-rc4-next-20190201-00007-g731346f #3
[  193.999707] Hardware name: Silicon Linux RZ/G2E evaluation kit EK874 (CAT874 + CAT875) (DT)
[  194.008089] Call trace:
[  194.010553]  dump_backtrace+0x0/0x178
[  194.014227]  show_stack+0x14/0x20
[  194.017562]  dump_stack+0xb0/0xec
[  194.020895]  __lock_acquire+0xfb4/0x1c08
[  194.024832]  lock_acquire+0xd0/0x268
[  194.028420]  ktime_get+0x5c/0x108
[  194.031747]  update_pm_runtime_accounting+0x14/0x68
[  194.036643]  rpm_resume+0x4ec/0x698
[  194.040144]  __pm_runtime_resume+0x50/0x98
[  194.044264]  sh_tmu_enable.part.1+0x24/0x50
[  194.048462]  sh_tmu_clocksource_enable+0x48/0x70
[  194.053097]  change_clocksource+0x84/0x118
[  194.057208]  multi_cpu_stop+0x8c/0x140
[  194.060970]  cpu_stopper_thread+0xac/0x120
[  194.065087]  smpboot_thread_fn+0x1ac/0x2c8
[  194.069198]  kthread+0x128/0x130
[  194.072439]  ret_from_fork+0x10/0x18


Regards,
Biju

> -----Original Message-----
> From: Rafael J. Wysocki <rafael@kernel.org>
> Sent: 30 January 2019 21:53
> To: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Linux PM <linux-pm@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Linux ARM <linux-arm-
> kernel@lists.infradead.org>; Linux OMAP Mailing List <linux-
> omap@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Ulf
> Hansson <ulf.hansson@linaro.org>; Biju Das <biju.das@bp.renesas.com>;
> Geert Uytterhoeven <geert@linux-m68k.org>; Linux-Renesas <linux-
> renesas-soc@vger.kernel.org>
> Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
>
> On Wed, Jan 30, 2019 at 6:26 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > A deadlock has been seen when swicthing clocksources which use PM
> runtime.
> > The call path is:
> > change_clocksource
> >     ...
> >     write_seqcount_begin
> >     ...
> >     timekeeping_update
> >         ...
> >         sh_cmt_clocksource_enable
> >             ...
> >             rpm_resume
> >                 pm_runtime_mark_last_busy
> >                     ktime_get
> >                         do
> >                             read_seqcount_begin
> >                         while read_seqcount_retry
> >     ....
> >     write_seqcount_end
> >
> > Although we should be safe because we haven't yet changed the
> > clocksource at that time, we can't because of seqcount protection.
> >
> > Use ktime_get_mono_fast_ns() instead which is lock safe for such case
> >
> > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > monotonic across an update and as a result can goes backward.
> > According to
> > update_fast_timekeeper() description: "In the worst case, this can
> > result is a slightly wrong timestamp (a few nanoseconds)". For PM
> > runtime autosuspend, this means only that the suspend decision can be
> > slightly sub optimal.
> >
> > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using
> > hrtimers")
> > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > Hi Rafael,
> >
> > Sorry, I sent the version with the typo mistake that generated the
> > compilation error reported by kbuild-test-robot
> >
> > This version doesn't have the typo.
>
> OK, I've applied this one, thanks!



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
