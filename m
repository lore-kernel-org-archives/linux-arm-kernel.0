Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF858C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:29:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6F120820
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o/SJryMh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="opRDLmzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6F120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kMLsQOajN7kfJG0rVZlewRgsmP0c7OYIgHWO7nGLJCc=; b=o/SJryMhYVLciJ
	fdwnIZNRq/fVhRRh9Cv7pJG9CAIopQVFRea+gKsPCMIh5Opo1e01iSBT3RguaTrxeBhsA+iNkA+iF
	qMg1fYzaYNT3egtL2wHSK+v3uXLXnz6ihu0LvN6IxVV/pN80GrL3MSxi787mBzHO67fX6Ehh3pg0X
	HoloAbpPsmk1b9Q1AjYmuJlZ/p5Lx764zVE50tlEa0ugt76+N0ULmrcCwl5h15qgCwVlEbakj2J/R
	VgFBI+qNs6zk4mJT6WzP7+b9CGhxKUVmnpRTddTk5egRuDjFNvDOwO2WKv8uQJMcPr/8n1bibp5+E
	XApExJcNfLchF6XdpFEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqaYy-0004t8-JE; Mon, 04 Feb 2019 09:29:12 +0000
Received: from mail-eopbgr1400100.outbound.protection.outlook.com
 ([40.107.140.100] helo=JPN01-TY1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqaYt-0004sb-VW
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:29:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUhHBODDneyprqbmiY5Ai4FLlCvpafxk7nowup+YfR0=;
 b=opRDLmzwcd6k8RW1FBcXwfhvhaMa0IOqvwWFKiSwgj0ZV8P4u0MQLpD3BvJRDAdkSviprO1lT3aBr3FUi/mwmZ7fJH3dTGVPPa2qoJJnPQH9+OV/VEUdCe/AX1+2+QKZxhr5MRqcngmMSC5wlNTweuVdvk9BJ8Ei+GK35xzfY8g=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.241.22) by
 OSBPR01MB4294.jpnprd01.prod.outlook.com (20.179.180.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Mon, 4 Feb 2019 09:29:01 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::9cb9:6c95:2d20:7852]) by OSBPR01MB2103.jpnprd01.prod.outlook.com
 ([fe80::9cb9:6c95:2d20:7852%2]) with mapi id 15.20.1558.026; Mon, 4 Feb 2019
 09:29:01 +0000
From: Biju Das <biju.das@bp.renesas.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Subject: RE: [PATCH v3] PM-runtime: fix deadlock with ktime
Thread-Topic: [PATCH v3] PM-runtime: fix deadlock with ktime
Thread-Index: AQHUuMDySMSMVQqbW0iMWyMv4OqrSKXIWtMAgAKwb6CAAAjqAIAAAdbwgAADlICAAAExgIAESjTQ
Date: Mon, 4 Feb 2019 09:29:01 +0000
Message-ID: <OSBPR01MB2103B1872251C12C2D1CE75EB86D0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <CAJZ5v0gunbCHp_9mDTmtwW1i-_GcXPcjTP48NdV2zv-B6UrD4g@mail.gmail.com>
 <1548869162-6223-1-git-send-email-vincent.guittot@linaro.org>
 <CAJZ5v0gnJ5DKvOO9OcJoMrGYpHfeQBt2Ec0pMW6=2q5aMoFpww@mail.gmail.com>
 <OSBPR01MB210387DEC42870D8E5688CE9B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAKfTPtDNMV+HFsqc9A0VcMHOO=MvxWYZt8XkmWepso7SpfeAqA@mail.gmail.com>
 <OSBPR01MB21031D92553AD16A1F206273B8920@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAKfTPtB9Ke167hQCKB7wgRpDarn_uFmL3B4QnzHhHUGmuhnejA@mail.gmail.com>
 <CAKfTPtBXt3-jn9h4Pur2Xvg3+k0UvPaNAecXdLB7VWMzccjEgA@mail.gmail.com>
In-Reply-To: <CAKfTPtBXt3-jn9h4Pur2Xvg3+k0UvPaNAecXdLB7VWMzccjEgA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; OSBPR01MB4294;
 20:vYPwxTuGFA8goclAUYiLGrEJDyOSgyBgn3rvdbK6Fj21b4ZZv5XnlpGBPLbArbjss9R+5fvzqmcg467z5PN8sFDtEiNTch76trUGQUUC6nv3+f7zeNyhYdabGTdOBsDRqjslsttFl5lfMMlOaFSogrJpFJhdJwpFW0skdCIYGvE=
x-ms-office365-filtering-correlation-id: 0ecd3084-89bc-4c9a-e120-08d68a83329e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:OSBPR01MB4294; 
x-ms-traffictypediagnostic: OSBPR01MB4294:
x-microsoft-antispam-prvs: <OSBPR01MB42945D701325E4EC06C6E3D9B86D0@OSBPR01MB4294.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(136003)(366004)(396003)(39850400004)(376002)(346002)(51914003)(51444003)(199004)(189003)(13464003)(97736004)(7416002)(53546011)(6506007)(26005)(76176011)(186003)(7696005)(102836004)(446003)(86362001)(11346002)(99286004)(476003)(316002)(71190400001)(44832011)(25786009)(486006)(229853002)(33656002)(105586002)(54906003)(71200400001)(74316002)(106356001)(7736002)(305945005)(68736007)(53936002)(3846002)(6246003)(256004)(14444005)(9686003)(55016002)(8936002)(14454004)(8676002)(478600001)(6116002)(4326008)(81166006)(2906002)(66066001)(6916009)(93886005)(81156014)(6436002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:OSBPR01MB4294;
 H:OSBPR01MB2103.jpnprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YoGTPobkESVJUQB8jZiynwIND3OLOurdNk6J8/XvOPXegeoMAPBvbpde0dMjbvx5Bjz/s2IIYfVlxk6MnobwkCKYLcJnzXGM61X2LgXHIrzFG+jyxyD8gWF5oRDWRtmOc3CwAIQETLTNWUMTLZW0SlrVW6PUYFGLQtVJpMGCa9IACxSLlF760XViVgKI3TAnpAXsMDParUrrI3flY0PQxefBNEyiKu8lwlnWr1OaMilOA5VlOyXP0XdTxbDf8AVReCW5VFrLkjHCKCtyVQTasfujqYlGH45L240OTkVnX4P3qKfA8/59s7TucCFVZR70npDwjCrSIKcWVIvb9mY+B6Cbdj/z3FdfAxowAkDHgOA35fANM3UeXg7a3qKwowKg9A2juhI0mfwsYtoEy3TgRmCPnCdhlQOg4GksOJ1Z2bc=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecd3084-89bc-4c9a-e120-08d68a83329e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 09:29:01.2407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4294
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_012908_183165_2BF5BA1B 
X-CRM114-Status: GOOD (  32.44  )
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

Thanks for the feedback.

> Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
>
> On Fri, 1 Feb 2019 at 16:48, Vincent Guittot <vincent.guittot@linaro.org>
> wrote:
> >
> > On Fri, 1 Feb 2019 at 16:44, Biju Das <biju.das@bp.renesas.com> wrote:
> > >
> > > Hi Vincent,
> > >
> > > Thanks for the feedback. Instead of reverting.  I just modified the patch
> like this and it fixed the issue.
> > >
> > > diff --git a/drivers/base/power/runtime.c
> > > b/drivers/base/power/runtime.c index 4eaf166..145a182 100644
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -66,7 +66,7 @@ static int rpm_suspend(struct device *dev, int
> rpmflags);
> > >   */
> > >  void update_pm_runtime_accounting(struct device *dev)  {
> > > -       u64 now = ktime_to_ns(ktime_get());
> > > +       u64 now = ktime_get_mono_fast_ns();
> > >         u64 delta;
> >
> > yes.
> > This probably also need to be changed in another place
> > (pm_runtime_enable) to be safe
> > Our email have crossed. I just sent something similar
>
> In fact after more thinking, it's probably better to revert because we are not
> sure to be monotonic with ktime_get_mono_fast_ns() which means that the
> time account can be negative but this not yet taken into account. It's part of a
> clean up patch that was on hold while working on previous problem

I confirm there is no deadlock, after reverting the commit c669560be6c8 ("PM-runtime: Replace
 jiffies-based accounting with ktime-based accounting")

Regards,
Biju

> > >
> > > > -----Original Message-----
> > > > From: linux-renesas-soc-owner@vger.kernel.org <linux-renesas-soc-
> > > > owner@vger.kernel.org> On Behalf Of Vincent Guittot
> > > > Sent: 01 February 2019 15:29
> > > > To: Biju Das <biju.das@bp.renesas.com>
> > > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Linux PM <linux-
> > > > pm@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > > kernel@vger.kernel.org>; Linux ARM <linux-arm-
> > > > kernel@lists.infradead.org>; Linux OMAP Mailing List <linux-
> > > > omap@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Ulf
> > > > Hansson <ulf.hansson@linaro.org>; Geert Uytterhoeven <geert@linux-
> > > > m68k.org>; Linux-Renesas <linux-renesas-soc@vger.kernel.org>
> > > > Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
> > > >
> > > > On Fri, 1 Feb 2019 at 16:02, Biju Das <biju.das@bp.renesas.com> wrote:
> > > > >
> > > > > Hi Vincent,
> > > > >
> > > > > I have rebased my kernel to "next-20190201".  Still I am seeing dead
> lock.
> > > > >
> > > > > Am I missing any patch?
> > > >
> > > > No you don't miss anything.
> > > > I think that it's the opposite.
> > > >
> > > > Modification in time accounting in PM runtime has been queued but
> > > > it has not moved (yet) to ktime_get_mono_fast_ns()
> > > >
> > > > Can you try to revert c669560be6c8 ("PM-runtime: Replace
> > > > jiffies-based accounting with ktime-based accounting") ?
> > > >
> > > > >
> > > > > root@ek874:/# echo e61e0000.timer >
> > > > > /sys/devices/system/clocksource/clocksource0/current_clocksource
> > > > > [  193.869423]
> > > > > [  193.870963]
> ============================================
> > > > > [  193.876292] WARNING: possible recursive locking detected [
> > > > > 193.881625] 5.0.0-rc4-next-20190201-00007-g731346f #3 Not
> > > > > tainted [ 193.887737]
> > > > > --------------------------------------------
> > > > > [  193.893066] migration/0/11 is trying to acquire lock:
> > > > > [  193.898136] (____ptrval____) (tk_core.seq){----}, at:
> > > > > update_pm_runtime_accounting+0x14/0x68
> > > > > [  193.906632]
> > > > > [  193.906632] but task is already holding lock:
> > > > > [  193.912483] (____ptrval____) (tk_core.seq){----}, at:
> > > > > multi_cpu_stop+0x8c/0x140 [  193.919828] [  193.919828] other
> > > > > info that might help us debug this:
> > > > > [  193.926377]  Possible unsafe locking scenario:
> > > > > [  193.926377]
> > > > > [  193.932314]        CPU0
> > > > > [  193.934765]        ----
> > > > > [  193.937216]   lock(tk_core.seq);
> > > > > [  193.940453]   lock(tk_core.seq);
> > > > > [  193.943691]
> > > > > [  193.943691]  *** DEADLOCK *** [  193.943691] [  193.949634]
> > > > > May be due to missing lock nesting notation [ 193.949634] [
> > > > > 193.956446] 3 locks held by migration/0/11:
> > > > > [  193.960642]  #0: (____ptrval____) (timekeeper_lock){-.-.}, at:
> > > > > change_clocksource+0x2c/0x118 [  193.969125]  #1:
> > > > > (____ptrval____) (tk_core.seq){----}, at: multi_cpu_stop+0x8c/0x140
> [  193.976903]  #2:
> > > > > (____ptrval____) (&(&dev->power.lock)->rlock){....}, at:
> > > > > __pm_runtime_resume+0x40/0x98 [  193.986339] [  193.986339]
> > > > > stack
> > > > backtrace:
> > > > > [  193.990715] CPU: 0 PID: 11 Comm: migration/0 Not tainted
> > > > > 5.0.0-rc4-next-20190201-00007-g731346f #3 [  193.999707]
> > > > > Hardware
> > > > > name: Silicon Linux RZ/G2E evaluation kit EK874 (CAT874 +
> > > > > CAT875) (DT) [
> > > > 194.008089] Call trace:
> > > > > [  194.010553]  dump_backtrace+0x0/0x178 [  194.014227]
> > > > > show_stack+0x14/0x20 [  194.017562]  dump_stack+0xb0/0xec [
> > > > > 194.020895]  __lock_acquire+0xfb4/0x1c08 [  194.024832]
> > > > > lock_acquire+0xd0/0x268 [  194.028420]  ktime_get+0x5c/0x108 [
> > > > > 194.031747]  update_pm_runtime_accounting+0x14/0x68
> > > > > [  194.036643]  rpm_resume+0x4ec/0x698 [  194.040144]
> > > > > __pm_runtime_resume+0x50/0x98 [  194.044264]
> > > > > sh_tmu_enable.part.1+0x24/0x50 [  194.048462]
> > > > > sh_tmu_clocksource_enable+0x48/0x70
> > > > > [  194.053097]  change_clocksource+0x84/0x118 [  194.057208]
> > > > > multi_cpu_stop+0x8c/0x140 [  194.060970]
> > > > > cpu_stopper_thread+0xac/0x120 [  194.065087]
> > > > > smpboot_thread_fn+0x1ac/0x2c8 [  194.069198]
> > > > > kthread+0x128/0x130 [ 194.072439]  ret_from_fork+0x10/0x18
> > > > >
> > > > >
> > > > > Regards,
> > > > > Biju
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Rafael J. Wysocki <rafael@kernel.org>
> > > > > > Sent: 30 January 2019 21:53
> > > > > > To: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > Cc: Linux PM <linux-pm@vger.kernel.org>; Linux Kernel Mailing
> > > > > > List
> > > > > > <linux- kernel@vger.kernel.org>; Linux ARM <linux-arm-
> > > > > > kernel@lists.infradead.org>; Linux OMAP Mailing List <linux-
> > > > > > omap@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>;
> > > > > > Ulf Hansson <ulf.hansson@linaro.org>; Biju Das
> > > > > > <biju.das@bp.renesas.com>; Geert Uytterhoeven
> > > > > > <geert@linux-m68k.org>; Linux-Renesas <linux-
> > > > > > renesas-soc@vger.kernel.org>
> > > > > > Subject: Re: [PATCH v3] PM-runtime: fix deadlock with ktime
> > > > > >
> > > > > > On Wed, Jan 30, 2019 at 6:26 PM Vincent Guittot
> > > > > > <vincent.guittot@linaro.org> wrote:
> > > > > > >
> > > > > > > A deadlock has been seen when swicthing clocksources which
> > > > > > > use PM
> > > > > > runtime.
> > > > > > > The call path is:
> > > > > > > change_clocksource
> > > > > > >     ...
> > > > > > >     write_seqcount_begin
> > > > > > >     ...
> > > > > > >     timekeeping_update
> > > > > > >         ...
> > > > > > >         sh_cmt_clocksource_enable
> > > > > > >             ...
> > > > > > >             rpm_resume
> > > > > > >                 pm_runtime_mark_last_busy
> > > > > > >                     ktime_get
> > > > > > >                         do
> > > > > > >                             read_seqcount_begin
> > > > > > >                         while read_seqcount_retry
> > > > > > >     ....
> > > > > > >     write_seqcount_end
> > > > > > >
> > > > > > > Although we should be safe because we haven't yet changed
> > > > > > > the clocksource at that time, we can't because of seqcount
> protection.
> > > > > > >
> > > > > > > Use ktime_get_mono_fast_ns() instead which is lock safe for
> > > > > > > such case
> > > > > > >
> > > > > > > With ktime_get_mono_fast_ns, the timestamp is not guaranteed
> > > > > > > to be monotonic across an update and as a result can goes
> backward.
> > > > > > > According to
> > > > > > > update_fast_timekeeper() description: "In the worst case,
> > > > > > > this can result is a slightly wrong timestamp (a few
> > > > > > > nanoseconds)". For PM runtime autosuspend, this means only
> > > > > > > that the suspend decision can be slightly sub optimal.
> > > > > > >
> > > > > > > Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to
> > > > > > > using
> > > > > > > hrtimers")
> > > > > > > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > > > > > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Hi Rafael,
> > > > > > >
> > > > > > > Sorry, I sent the version with the typo mistake that
> > > > > > > generated the compilation error reported by
> > > > > > > kbuild-test-robot
> > > > > > >
> > > > > > > This version doesn't have the typo.
> > > > > >
> > > > > > OK, I've applied this one, thanks!
> > > > >
> > > > >
> > > > >
> > > > > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road,
> > > > > Bourne
> > > > End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales
> > > > under Registered No. 04586709.
> > >
> > >
> > >
> > > Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne
> End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under
> Registered No. 04586709.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
