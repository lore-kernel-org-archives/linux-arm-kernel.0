Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B62BC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:49:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175C221872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YIjoRW4J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="jrYkiArg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175C221872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Meg/D3NrrOhPtDCMy1Q4LYHNVgnpklAkriOhV87viCI=; b=YIjoRW4Jzmlxih
	3NklXkaL/XkBTqRYp0yum2Yltaz46Ltz2ZjFoQFXifdh8me1PImHqi+oS9f8IZRoTx88YySV+/gc9
	l8p48zTSe9nVypq8gt+wiWDw5du9IEA/kYVsKiZKQ+DL75taz8ucVmT8NbDxxaj9albSZCjDROsw2
	0/DfmlBQVsS2Jzqlavf2gnE1CyIaFhJlbwxGGVcJZVdus+DVh/Mh0XSp1jztCuXg/yBEQqIfic3Dr
	awE05W3ugjuy/CsGahJVQYCdnTVEP3/aXDCRACasPJX3l3M2yv7W4NBuekFse8WrX787ovAR8Baju
	bmC2/W5q3Go/ETtR6JqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb4X-0001QL-S5; Fri, 01 Feb 2019 15:49:41 +0000
Received: from mail-eopbgr1410129.outbound.protection.outlook.com
 ([40.107.141.129] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpazO-0003b9-Kx
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:45:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOqMPoMLH6+8z387T+zQlwHhE3l6koQaCcqOpwOwrA8=;
 b=jrYkiArgQELABaTARknecGkcOqUdLJbKai1JU83mNEn8jsD5Bejvj3qjV11Y+JNbfPGTYwEf40uHcszdRfVBe7OzU/h/AUOUdO4LWriD8QP28IbNEVWWqDjcNkyqIlRrSKagua2+EE9QVVatxu+6QL38MGZID6y6yarJ04upxxw=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBSPR01MB3.jpnprd01.prod.outlook.com (52.134.225.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 15:44:17 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::9cb9:6c95:2d20:7852]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::9cb9:6c95:2d20:7852%2]) with mapi id 15.20.1558.026; Fri, 1 Feb 2019
 15:44:16 +0000
From: Biju Das <biju.das@bp.renesas.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: RE: [PATCH v3] PM-runtime: fix deadlock with ktime
Thread-Topic: [PATCH v3] PM-runtime: fix deadlock with ktime
Thread-Index: AQHUuMDySMSMVQqbW0iMWyMv4OqrSKXIWtMAgAKwb6CAAAjqAIAAAdbw
Date: Fri, 1 Feb 2019 15:44:16 +0000
Message-ID: <OSBPR01MB21031D92553AD16A1F206273B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
 <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
 <OSBPR01MB210387DEC42870D8E5688CE9B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAKfTPtDNMV+HFsqc9A0VcMHOO=MvxWYZt8XkmWepso7SpfeAqA@mail.gmail.com>
In-Reply-To: <CAKfTPtDNMV+HFsqc9A0VcMHOO=MvxWYZt8XkmWepso7SpfeAqA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; OSBSPR01MB3;
 20:uOFvUm1zv/nyw0V3904Jwkx1UFD+1e7Ejyj+0jIK0tVOQ/u56flNHZsNWnhD9KkR57O6/OKUoOf1tL5WhACe4uwglEh3PxO0aMEVcuJJKyovOdkGxJ2Fj+IfzVJ9rWjDxojNveuD4AiA4r7GoxFoDD301xSOUTFJMWRpLE5kp3w=
x-ms-office365-filtering-correlation-id: 936a735b-7312-41ea-40b4-08d6885c1fb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:OSBSPR01MB3; 
x-ms-traffictypediagnostic: OSBSPR01MB3:
x-microsoft-antispam-prvs: <OSBSPR01MB3A53FFF72F67412D7379FB8920@OSBSPR01MB3.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(13464003)(199004)(189003)(51444003)(51914003)(53546011)(76176011)(2906002)(6506007)(97736004)(7736002)(7696005)(6116002)(3846002)(25786009)(74316002)(81156014)(6246003)(81166006)(4326008)(54906003)(102836004)(26005)(8676002)(53936002)(93886005)(316002)(86362001)(186003)(99286004)(305945005)(446003)(11346002)(6436002)(105586002)(14454004)(486006)(33656002)(476003)(8936002)(44832011)(478600001)(68736007)(55016002)(229853002)(71190400001)(71200400001)(6916009)(106356001)(9686003)(7416002)(14444005)(256004)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSBSPR01MB3;
 H:OSBPR01MB2103.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XNjI2jWHs0vuQh/kPh7pwG1xjShdx3DfZuHmRmBgZrP8cqj2DGczOVf8/efPILcwxrTASj7UAYt4Ur+emNssm/0MhqOL8FP78LfQuSI7oOYwkyN6aHXYLL4UdtIh2OEMD4RLYDTspP5zR/TjXdmpVyk5W+lwzpGlroc2dwNUsNKwHlYpKOEDHs7QqBzeSKSowQ3w5MaPDBtczn40e9ARjcPa2PYwHQ4XgpViZZ6VbxQj2Pw7tIGSkJarzuVklxY6rbFDOgyjmTjJvRYR1FXIuBd4xsMfbR40qejFnShAirXvgrbbHosZe391gJIm6YI7PKw4KCgqkliOsxVnOVTE+9rKimbnoLhZV+1k530/hAW8Q2+nO10XvJe/Asn4DcXPsdS9rgUAaoPOhYKUmiRtyy0IDD8unqhXlx3zPXgc2ZM=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936a735b-7312-41ea-40b4-08d6885c1fb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 15:44:16.8257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBSPR01MB3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074423_252269_833247B1 
X-CRM114-Status: GOOD (  34.83  )
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

Hi Vincent,

Thanks for the feedback. Instead of reverting.  I just modified the patch like this and it fixed the issue.

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4eaf166..145a182 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,7 +66,7 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-       u64 now = ktime_to_ns(ktime_get());
+       u64 now = ktime_get_mono_fast_ns();
        u64 delta;

regards,
Biju

> -----Original Message-----
> From: linux-renesas-soc-owner@vger.kernel.org <linux-renesas-soc-
> owner@vger.kernel.org> On Behalf Of Vincent Guittot
> Sent: 01 February 2019 15:29
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>; Linux PM <linux-
> pm@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Linux ARM <linux-arm-
> kernel@lists.infradead.org>; Linux OMAP Mailing List <linux-
> omap@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Ulf
> Hansson <ulf.hansson@linaro.org>; Geert Uytterhoeven <geert@linux-
> m68k.org>; Linux-Renesas <linux-renesas-soc@vger.kernel.org>
> Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
>
> On Fri, 1 Feb 2019 at 16:02, Biju Das <biju.das@bp.renesas.com> wrote:
> >
> > Hi Vincent,
> >
> > I have rebased my kernel to "next-20190201".  Still I am seeing dead lock.
> >
> > Am I missing any patch?
>
> No you don't miss anything.
> I think that it's the opposite.
>
> Modification in time accounting in PM runtime has been queued but it has
> not moved (yet) to ktime_get_mono_fast_ns()
>
> Can you try to revert c669560be6c8 ("PM-runtime: Replace jiffies-based
> accounting with ktime-based accounting") ?
>
> >
> > root@ek874:/# echo e61e0000.timer >
> > /sys/devices/system/clocksource/clocksource0/current_clocksource
> > [  193.869423]
> > [  193.870963] ============================================
> > [  193.876292] WARNING: possible recursive locking detected [
> > 193.881625] 5.0.0-rc4-next-20190201-00007-g731346f #3 Not tainted [
> > 193.887737] --------------------------------------------
> > [  193.893066] migration/0/11 is trying to acquire lock:
> > [  193.898136] (____ptrval____) (tk_core.seq){----}, at:
> > update_pm_runtime_accounting+0x14/0x68
> > [  193.906632]
> > [  193.906632] but task is already holding lock:
> > [  193.912483] (____ptrval____) (tk_core.seq){----}, at:
> > multi_cpu_stop+0x8c/0x140 [  193.919828] [  193.919828] other info
> > that might help us debug this:
> > [  193.926377]  Possible unsafe locking scenario:
> > [  193.926377]
> > [  193.932314]        CPU0
> > [  193.934765]        ----
> > [  193.937216]   lock(tk_core.seq);
> > [  193.940453]   lock(tk_core.seq);
> > [  193.943691]
> > [  193.943691]  *** DEADLOCK ***
> > [  193.943691]
> > [  193.949634]  May be due to missing lock nesting notation [
> > 193.949634] [  193.956446] 3 locks held by migration/0/11:
> > [  193.960642]  #0: (____ptrval____) (timekeeper_lock){-.-.}, at:
> > change_clocksource+0x2c/0x118 [  193.969125]  #1: (____ptrval____)
> > (tk_core.seq){----}, at: multi_cpu_stop+0x8c/0x140 [  193.976903]  #2:
> > (____ptrval____) (&(&dev->power.lock)->rlock){....}, at:
> > __pm_runtime_resume+0x40/0x98 [  193.986339] [  193.986339] stack
> backtrace:
> > [  193.990715] CPU: 0 PID: 11 Comm: migration/0 Not tainted
> > 5.0.0-rc4-next-20190201-00007-g731346f #3 [  193.999707] Hardware
> > name: Silicon Linux RZ/G2E evaluation kit EK874 (CAT874 + CAT875) (DT) [
> 194.008089] Call trace:
> > [  194.010553]  dump_backtrace+0x0/0x178 [  194.014227]
> > show_stack+0x14/0x20 [  194.017562]  dump_stack+0xb0/0xec [
> > 194.020895]  __lock_acquire+0xfb4/0x1c08 [  194.024832]
> > lock_acquire+0xd0/0x268 [  194.028420]  ktime_get+0x5c/0x108 [
> > 194.031747]  update_pm_runtime_accounting+0x14/0x68
> > [  194.036643]  rpm_resume+0x4ec/0x698 [  194.040144]
> > __pm_runtime_resume+0x50/0x98 [  194.044264]
> > sh_tmu_enable.part.1+0x24/0x50 [  194.048462]
> > sh_tmu_clocksource_enable+0x48/0x70
> > [  194.053097]  change_clocksource+0x84/0x118 [  194.057208]
> > multi_cpu_stop+0x8c/0x140 [  194.060970]
> > cpu_stopper_thread+0xac/0x120 [  194.065087]
> > smpboot_thread_fn+0x1ac/0x2c8 [  194.069198]  kthread+0x128/0x130 [
> > 194.072439]  ret_from_fork+0x10/0x18
> >
> >
> > Regards,
> > Biju
> >
> > > -----Original Message-----
> > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > Sent: 30 January 2019 21:53
> > > To: Vincent Guittot <vincent.guittot@linaro.org>
> > > Cc: Linux PM <linux-pm@vger.kernel.org>; Linux Kernel Mailing List
> > > <linux- kernel@vger.kernel.org>; Linux ARM <linux-arm-
> > > kernel@lists.infradead.org>; Linux OMAP Mailing List <linux-
> > > omap@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Ulf
> > > Hansson <ulf.hansson@linaro.org>; Biju Das
> > > <biju.das@bp.renesas.com>; Geert Uytterhoeven
> > > <geert@linux-m68k.org>; Linux-Renesas <linux-
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
> > > > Use ktime_get_mono_fast_ns() instead which is lock safe for such
> > > > case
> > > >
> > > > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > > > monotonic across an update and as a result can goes backward.
> > > > According to
> > > > update_fast_timekeeper() description: "In the worst case, this can
> > > > result is a slightly wrong timestamp (a few nanoseconds)". For PM
> > > > runtime autosuspend, this means only that the suspend decision can
> > > > be slightly sub optimal.
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
> > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne
> End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under
> Registered No. 04586709.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
