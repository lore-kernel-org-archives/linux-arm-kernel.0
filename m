Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50238C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:13:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174E42081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RW48+1Os"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174E42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rjOLV6arlQoOTDr+ta0LJM/1tGFzvqdyYIaYkGdp9/M=; b=RW48+1Os1PdqPL
	DYxbuvecYG62dR/2yk5w43KEX2qMiqwRWkAMU8JC+OiBXpqyTqm3T8q2QKVkrGk6Nha5QRKSu6eka
	uUK/vJK1iUCfENOA5k/b3Q4x2OVejvDUhMOTBKXoP1ujOCCzFIO8bJB7uBi0nKBOFj3ru04y1pEfn
	qW1pc2gl/iGjOR+zr1BdovUx9jiATno9SUhZy+Do5YKzY0hnQacASyZHWtfPWga2t8ncLT6YupyeK
	NpDlq0urB/yQxCPrJxLbLjfYhRTPRXh8uTMZ+sjlNeMmc8qTcogBsYacaBiIEFbfBRorUmd1qCfHu
	8miaXYW62sQ1007aqb/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxAe5-0001Bc-2n; Fri, 22 Feb 2019 13:13:41 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxAe0-0001B3-UV
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 13:13:38 +0000
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id A8BD95B877E964836394;
 Fri, 22 Feb 2019 21:13:28 +0800 (CST)
Received: from DGGEMI521-MBX.china.huawei.com ([169.254.6.186]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0415.000;
 Fri, 22 Feb 2019 21:13:21 +0800
From: chenzhou <chenzhou10@huawei.com>
To: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>
Subject: RE: [PATCH] arm64: kdump: fix warning message about failed to stop
 secondary CPUs
Thread-Topic: [PATCH] arm64: kdump: fix warning message about failed to stop
 secondary CPUs
Thread-Index: AQHUyk6QEEREPscNV02OfYJgsoj99qXrEOGAgAAao4CAAJKA0A==
Date: Fri, 22 Feb 2019 13:13:20 +0000
Message-ID: <A47D9AAE3C8E3E4A815B312B14DE75580B2325CE@DGGEMI521-MBX.china.huawei.com>
References: <20190222014625.107640-1-chenzhou10@huawei.com>
 <20190222100305.GA31945@fuggles.cambridge.arm.com>
 <20190222113824.GA42419@lakrids.cambridge.arm.com>
In-Reply-To: <20190222113824.GA42419@lakrids.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.131.64]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_051337_154868_406CF953 
X-CRM114-Status: GOOD (  21.16  )
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
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "chengjian \(D\)" <cj.chengjian@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: Friday, February 22, 2019 7:38 PM
> To: Will Deacon
> Cc: chenzhou; catalin.marinas@arm.com; chengjian (D);
> linux-arm-kernel@lists.infradead.org; takahiro.akashi@linaro.org
> Subject: Re: [PATCH] arm64: kdump: fix warning message about failed to
> stop secondary CPUs
> 
> On Fri, Feb 22, 2019 at 10:03:05AM +0000, Will Deacon wrote:
> > On Fri, Feb 22, 2019 at 09:46:25AM +0800, Chen Zhou wrote:
> > > The local variable mask indicates non-boot cpus. Just print the num
> > > of failing to stop secondary CPUs using varaible waiting_for_crash_ipi.
> >
> > Why? Also s/varaible/variable/
> 
> I think the point is that the mask is an over-estimate, since it's all
> of the CPUs which were online when we sent the stop IPI, not only the
> ones we failed to stop.
> 
> If we had 255 secondary CPUs, and one failed to offline, we log the IDs
> of all 255 CPUs which we tried to offline.
> 
> > > Also replace two pr_warning with the shorter pr_warn.
> > >
> > > Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> > > ---
> > >  arch/arm64/kernel/smp.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > > index 824de70..a4a952e 100644
> > > --- a/arch/arm64/kernel/smp.c
> > > +++ b/arch/arm64/kernel/smp.c
> > > @@ -989,7 +989,7 @@ void smp_send_stop(void)
> > >  		udelay(1);
> > >
> > >  	if (num_online_cpus() > 1)
> > > -		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
> > > +		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
> > >  			   cpumask_pr_args(cpu_online_mask));
> > >
> > >  	sdei_mask_local_cpu();
> > > @@ -1030,8 +1030,8 @@ void crash_smp_send_stop(void)
> > >  		udelay(1);
> > >
> > >  	if (atomic_read(&waiting_for_crash_ipi) > 0)
> > > -		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
> > > -			   cpumask_pr_args(&mask));
> > > +		pr_warn("SMP: failed to stop secondary CPUs %d\n",
> > > +				atomic_read(&waiting_for_crash_ipi));
> 
> I think this should be:
> 
> 	pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
> 		   cpumask_pr_args(cpu_online_mask));
> 
> ... matching smp_send_stop().
> 
> In either case that includes the current processor, but that's not a new
> bug, and not a big deal.
> 

You are right. The mask and cpu_online_mask in kdump path are both the online CPUs 
before sending IPI stop. But the cpu_online_mask of the smp_send_stop() you mentioned
is the online CPUs after sending the IPI stop, which is the CPUs failed to stop, not equal to
the online CPUs before sending IPI stop.

The root cause is that the ipi_cpu_stop() will set related cpu_online_mask false, but the 
ipi_cpu_crash_stop() won't do this. Therefore, we can't get the correct online CPUs at 
the end of crash_smp_send_stop().

In kdump path, we introduce waiting_for_crash_ipi to record the number of CPUs failed to stop,
and we only have the information about the number of CPUs failed to stop.

Sorry, I don't know if I express clear.

Thanks
Chen Zhou

> Thanks,
> Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
