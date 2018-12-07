Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC11C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA40B20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ic+5gvMa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZvRECnL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA40B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a7msSs/TkqFoWUFx4KH+692ugjHdqIm49JbEWyZKZ6Y=; b=Ic+5gvMamz84h9
	OYhDsY0cBQMHhBSKu1gxuUYzpPsXgHBi7mExt9nbV02g8uZAzMj1NtxPhgLBP3hi2xdW8JntkeDmw
	a+wNiQJ0VKv+MZLKsndgMPVqrJvFefQmwM1uPglz+SUviBUJCpGyQaGoWL9NbmMZJ5OhjXn7b0go5
	BCiPo/AW+ngQO2ddLNS5iu9WxB67ZgivLOQwgSbw/n+nl/zzQnD8uHyCRQurbl8fAaH1vrwIAc5xZ
	RErXBphavaCyumjyN0xlsAz7rUt5UyN+lNX+f9J/aLt2fbAbYvRWE0JN3I58rcE3Rbqb7mGpXFsqb
	9Yyp2T4wqzJHnV4E+PfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKt1-0004Ab-NB; Fri, 07 Dec 2018 18:30:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKsz-00043c-ER
 for linux-arm-kernel@bombadil.infradead.org; Fri, 07 Dec 2018 18:30:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0PbFfQmPCEsipSPKsP3fi6MlajA1uyTsaL0/MrjorgM=; b=ZvRECnL/AsnRZUJcPh+rckRdF
 uIi08rh6pLc5klWrPAoAUvTlKrhHu0iD3bq9+Edx+kWeE5BBHi7sG6E5nIG77jCp77hx+w6LY42SJ
 TyaE3TWw2L2gRH356RvC3DXGl3XYc/8MG0OPTk3A7Xy2rIPwCvwyFGffnuGF0Az5zWfj8CFL2FQOZ
 hfI+KVuKG5snuZfMbFRw9to5e1nUt+ZCeljTZR65XP8lowfHCMS8K13IiVP7Vq8BGPJ+BoHra73mA
 YYTPq89C9C10zBbztaBsPky8LKV/pXQ7C1i/mssFNnHZMdpkU64kYLVpGlIGiriIZdsKjVtcOsh+m
 TTCIemnoA==;
Received: from foss.arm.com ([217.140.101.70])
 by casper.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKJM-00043y-FN
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:53:14 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40FC715AD;
 Fri,  7 Dec 2018 09:53:01 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 10E133F5AF;
 Fri,  7 Dec 2018 09:53:01 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 8AFE51AE0BA4; Fri,  7 Dec 2018 17:53:22 +0000 (GMT)
Date: Fri, 7 Dec 2018 17:53:22 +0000
From: Will Deacon <will.deacon@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
Message-ID: <20181207175321.GA11430@edgewater-inn.cambridge.arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_175312_789189_3F958A55 
X-CRM114-Status: GOOD (  21.25  )
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Thomas,

You got me at this bit:

On Thu, Nov 29, 2018 at 11:11:52PM +0100, Thomas Gleixner wrote:
> On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
> > +static __always_inline notrace int __do_realtime_or_tai(
> > +		const struct vdso_data *vd,
> > +		struct __vdso_timespec *ts,
> > +		bool is_tai)
> > +{
> > +	u32 seq, cs_mono_mult, cs_shift;
> > +	u64 ns, sec;
> > +	u64 cycle_last, cs_mono_mask;
> > +
> > +	if (vd->use_syscall)
> > +		return -1;
> > +repeat:
> > +	seq = vdso_read_begin(vd);
> > +	cycle_last = vd->cs_cycle_last;
> > +	cs_mono_mult = vd->cs_mono_mult;
> > +	cs_shift = vd->cs_shift;
> > +	cs_mono_mask = vd->cs_mono_mask;
> > +
> > +	if (is_tai)
> > +		sec = vd->tai_sec;
> > +	else
> > +		sec = vd->xtime_clock_sec;
> > +	ns = vd->xtime_clock_nsec;
> > +
> > +	if (unlikely(vdso_read_retry(vd, seq)))
> > +		goto repeat;
> > +
> > +	ns += get_clock_shifted_nsec(cycle_last, cs_mono_mult, cs_mono_mask);
> 
> This is broken. You cannot read the counter outside the seq count protected
> region. Please tell the ARM64 folks that their VDSO asm maze is broken.

We'll fix the maze, but could you explain a bit about the brokenness,
please? The write side in update_vsyscall() is only touching the data page,
so I think we've got those fields covered correctly with the seqlock. We'd
only have to worry about protecting the counter if it could be written
somehow.

Is your concern to do with migrating between systems, where the new system
has a counter with a different offset? If so, what does the program flow
look like when migrating in? I guess somehow we ensure that update_vsyscall()
is invoked before userspace can resume.

Anyway, moving the counter read into the protected region is a little fiddly
because the memory barriers we have in there won't give us the ordering we
need. We'll instead need to do something nasty, like create a dependency
from the counter read to the read of the seqlock:

Maybe the untested crufty hack below, although this will be a nightmare to
implement in C.

Will

--->8

diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index c39872a7b03c..2d1dfecae76b 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -73,6 +73,8 @@ x_tmp		.req	x8
 	movn	x_tmp, #0xff00, lsl #48
 	and	\res, x_tmp, \res
 	mul	\res, \res, \mult
+	and	x_tmp, x_tmp, xzr
+	add	vdso_data, vdso_data, x_tmp
 	.endm
 
 	/*
@@ -147,12 +149,12 @@ ENTRY(__kernel_gettimeofday)
 	/* w11 = cs_mono_mult, w12 = cs_shift */
 	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
 	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=1b
 
 	get_nsec_per_sec res=x9
 	lsl	x9, x9, x12
 
 	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
+	seqcnt_check fail=1b
 	get_ts_realtime res_sec=x10, res_nsec=x11, \
 		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
 
@@ -211,13 +213,13 @@ realtime:
 	/* w11 = cs_mono_mult, w12 = cs_shift */
 	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
 	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
-	seqcnt_check fail=realtime
 
 	/* All computations are done with left-shifted nsecs. */
 	get_nsec_per_sec res=x9
 	lsl	x9, x9, x12
 
 	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
+	seqcnt_check fail=realtime
 	get_ts_realtime res_sec=x10, res_nsec=x11, \
 		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
 	clock_gettime_return, shift=1
@@ -231,7 +233,6 @@ monotonic:
 	ldp	w11, w12, [vdso_data, #VDSO_CS_MONO_MULT]
 	ldp	x13, x14, [vdso_data, #VDSO_XTIME_CLK_SEC]
 	ldp	x3, x4, [vdso_data, #VDSO_WTM_CLK_SEC]
-	seqcnt_check fail=monotonic
 
 	/* All computations are done with left-shifted nsecs. */
 	lsl	x4, x4, x12
@@ -239,6 +240,7 @@ monotonic:
 	lsl	x9, x9, x12
 
 	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
+	seqcnt_check fail=monotonic
 	get_ts_realtime res_sec=x10, res_nsec=x11, \
 		clock_nsec=x15, xtime_sec=x13, xtime_nsec=x14, nsec_to_sec=x9
 
@@ -253,13 +255,13 @@ monotonic_raw:
 	/* w11 = cs_raw_mult, w12 = cs_shift */
 	ldp	w12, w11, [vdso_data, #VDSO_CS_SHIFT]
 	ldp	x13, x14, [vdso_data, #VDSO_RAW_TIME_SEC]
-	seqcnt_check fail=monotonic_raw
 
 	/* All computations are done with left-shifted nsecs. */
 	get_nsec_per_sec res=x9
 	lsl	x9, x9, x12
 
 	get_clock_shifted_nsec res=x15, cycle_last=x10, mult=x11
+	seqcnt_check fail=monotonic_raw
 	get_ts_clock_raw res_sec=x10, res_nsec=x11, \
 		clock_nsec=x15, nsec_to_sec=x9
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
