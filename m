Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C2FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:47:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D845C20C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uBoYGVfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D845C20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Tc1upTYNQ32YknfeMoLLbHCP5m5cV8dtlLPfgMhee6k=; b=uBoYGVfgQJOWK5
	Sq8PWUnmaaMr0dQNI4957pzj5Hlo6L4hFge3ei/qGFW/9L18ag2pRNckogUOZFJ3gnJos2T2h5J7k
	l7VlUaGpAIo2+HNlN5yNpa3m1aaKXkfGVJ+2DHgzBxsR1FIsCjCuhJUvbC5tFMwCSEBJIh5J0mBvF
	muB7mu1fbKGnfuLvwBxFNqnFUoGPOlvWCvwXo8YLN2p/t3czd4W6IxVAciKtTRjVVURu46K7kRxNj
	Uhji2OCaIB85zuEbmaVtrPrWGZU3P7FSx2HQIL35nnvMBvgPCv/YxDi2OIAgA08mNJV48nOz9nbOz
	pN71KauGrZwDYmL6Ieew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyzYj-00056Y-Dj; Wed, 27 Feb 2019 13:47:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyzYg-000568-7I
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 13:47:40 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA96B374;
 Wed, 27 Feb 2019 05:47:35 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B7323F5C1;
 Wed, 27 Feb 2019 05:47:33 -0800 (PST)
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
To: Thomas Gleixner <tglx@linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231751510.1666@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9c1da773-7fae-69ad-484b-224f3e76ea09@arm.com>
Date: Wed, 27 Feb 2019 13:47:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902231751510.1666@nanos.tec.linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_054738_276204_46E8C3B4 
X-CRM114-Status: GOOD (  19.20  )
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
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Thomas,

On 23/02/2019 17:31, Thomas Gleixner wrote:
> On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
>> +static notrace int do_hres(const struct vdso_data *vd,
>> +			   clockid_t clk,
>> +			   struct __vdso_timespec *ts)
>> +{
>> +	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
>> +	u64 cycles, last, sec, ns;
>> +	u32 seq, cs_index = CLOCKSOURCE_MONO;
>> +
>> +	if (clk == CLOCK_MONOTONIC_RAW)
>> +		cs_index = CLOCKSOURCE_RAW;
> 
> Uuurgh. So you create an array with 16 members and then use two. This code
> is really optimized and now you add not only the pointless array, you also
> need the extra index plus another conditional. Not to talk about the cache
> impact which makes things even worse. In the x86 implementation we have:
> 
>        u32 		seq;			 +  0
>        int		mode;			 +  4
>        u64		mask;			 +  8
>        u32		mult;			 + 16
>        u32		shift;			 + 20
>        struct vgtod_ts	basetimer[VGTOD_BASES];  + 24
> 
> Each basetime array member occupies 16 bytes. So
> 
> 	CLOCK_REALTIME		+ 24
> 	CLOCK_MONOTONIC		+ 40
> 	..
> 		cacheline boundary		
> 	..
> 	CLOCK_REALTIME_COARSE	+ 104
> 	CLOCK_MONOTONIC_COARSE	+ 120   <- cacheline boundary
> 	CLOCK_BOOTTIME		+ 136
> 	CLOCK_REALTIME_ALARM	+ 152
> 	CLOCK_BOOTTIME_ALARM	+ 168
>        
> So the most used clocks REALTIME/MONO are in the first cacheline.
> 
> So with your scheme the thing becomes
> 
>        u32 		seq;			 +   0
>        int		mode;			 +   4
>        struct cs	cs[16]			 +   8
>        struct vgtod_ts	basetimer[VGTOD_BASES];  + 264
> 
> and 
> 
> 	CLOCK_REALTIME		+ 264
> 	CLOCK_MONOTONIC		+ 280
>

The clocksource array has two elements (CLOCKSOURCE_RAW, CLOCKSOURCE_MONO) and
the situation with my scheme should be the following:
	u32		seq:			+    0
	s32		clock_mode;		+    4
	u64		cycle_last;		+    8
	struct vdso_cs	cs[2];			+    16
	struct vdso_ts	basetime[VDSO_BASES];	+    48

which I agree makes still things a bit worse.

Assuming L1_CACHE_SHIFT == 6:

	CLOCK_REALTIME			+    48
	...
	cache boundary
	...
	CLOCK_MONOTONIC			+    64
	CLOCK_PROCESS_CPUTIME_ID	+    80
	CLOCK_THREAD_CPUTIME_ID		+    96
	CLOCK_MONOTONIC_RAW		+    112
	...
	cache boundary
	...
	CLOCK_REALTIME_COARSE		+    128
	CLOCK_MONOTONIC_COARSE		+    144
	CLOCK_BOOTTIME			+    160
	CLOCK_REALTIME_ALARM 		+    172
	CLOCK_BOOTTIME_ALARM		+    188
	...

> IOW, the most important clocks touch TWO cachelines now which are not even
> adjacent. No, they are 256 bytes apart, which really sucks for prefetching.
> 
> We're surely not going to sacrify the performance which we carefully tuned
> in that code just to support MONO_RAW. The solution I showed you in the
> other reply does not have these problems at all.
> 
> It's easy enough to benchmark these implementations and without trying I'm
> pretty sure that you can see the performance drop nicely. Please do so next
> time and provide the numbers in the changelogs.
> 

I did run some benchmarks this morning to quantify the performance impact and
seems that using vdsotest[1] the difference in between a stock linux kernel
5.0.0-rc7 and one that has unified vDSO, running on my x86 machine (Xeon Gold
5120T), is below 1%. Please find the results below, I will add them as well to
the next changelog.

[1] https://github.com/nathanlynch/vdsotest

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo

8<-----------------

Unified vDSO:
=============

clock-gettime-monotonic: syscall: 351 nsec/call
clock-gettime-monotonic:    libc: 37 nsec/call
clock-gettime-monotonic:    vdso: 31 nsec/call
clock-getres-monotonic: syscall: 271 nsec/call
clock-getres-monotonic:    libc: 269 nsec/call
clock-getres-monotonic:    vdso: 9 nsec/call
clock-gettime-monotonic-coarse: syscall: 280 nsec/call
clock-gettime-monotonic-coarse:    libc: 22 nsec/call
clock-gettime-monotonic-coarse:    vdso: 11 nsec/call
clock-getres-monotonic-coarse: syscall: 274 nsec/call
clock-getres-monotonic-coarse:    libc: 276 nsec/call
clock-getres-monotonic-coarse:    vdso: 10 nsec/call
clock-gettime-monotonic-raw: syscall: 337 nsec/call
clock-gettime-monotonic-raw:    libc: 38 nsec/call
clock-gettime-monotonic-raw:    vdso: 32 nsec/call
clock-getres-monotonic-raw: syscall: 284 nsec/call
clock-getres-monotonic-raw:    libc: 271 nsec/call
clock-getres-monotonic-raw:    vdso: 9 nsec/call
clock-gettime-tai: syscall: 332 nsec/call
clock-gettime-tai:    libc: 37 nsec/call
clock-gettime-tai:    vdso: 31 nsec/call
clock-getres-tai: syscall: 273 nsec/call
clock-getres-tai:    libc: 281 nsec/call
clock-getres-tai:    vdso: 10 nsec/call
clock-gettime-boottime: syscall: 338 nsec/call
clock-gettime-boottime:    libc: 37 nsec/call
clock-gettime-boottime:    vdso: 32 nsec/call
clock-getres-boottime: syscall: 283 nsec/call
clock-getres-boottime:    libc: 278 nsec/call
clock-getres-boottime:    vdso: 9 nsec/call
clock-gettime-realtime: syscall: 338 nsec/call
clock-gettime-realtime:    libc: 39 nsec/call
clock-gettime-realtime:    vdso: 32 nsec/call
clock-getres-realtime: syscall: 281 nsec/call
clock-getres-realtime:    libc: 277 nsec/call
clock-getres-realtime:    vdso: 10 nsec/call
clock-gettime-realtime-coarse: syscall: 286 nsec/call
clock-gettime-realtime-coarse:    libc: 21 nsec/call
clock-gettime-realtime-coarse:    vdso: 12 nsec/call
clock-getres-realtime-coarse: syscall: 285 nsec/call
clock-getres-realtime-coarse:    libc: 283 nsec/call
clock-getres-realtime-coarse:    vdso: 11 nsec/call
getcpu: syscall: 234 nsec/call
getcpu:    libc: 31 nsec/call
getcpu:    vdso: 20 nsec/call
gettimeofday: syscall: 293 nsec/call
gettimeofday:    libc: 32 nsec/call
gettimeofday:    vdso: 31 nsec/call

Stock Kernel:
=============

clock-gettime-monotonic: syscall: 349 nsec/call
clock-gettime-monotonic:    libc: 37 nsec/call
clock-gettime-monotonic:    vdso: 28 nsec/call
clock-getres-monotonic: syscall: 296 nsec/call
clock-getres-monotonic:    libc: 295 nsec/call
clock-getres-monotonic:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-monotonic-coarse: syscall: 296 nsec/call
clock-gettime-monotonic-coarse:    libc: 21 nsec/call
clock-gettime-monotonic-coarse:    vdso: 11 nsec/call
clock-getres-monotonic-coarse: syscall: 287 nsec/call
clock-getres-monotonic-coarse:    libc: 288 nsec/call
clock-getres-monotonic-coarse:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-monotonic-raw: syscall: 353 nsec/call
clock-gettime-monotonic-raw:    libc: 360 nsec/call
clock-gettime-monotonic-raw:    vdso: 352 nsec/call
clock-getres-monotonic-raw: syscall: 282 nsec/call
clock-getres-monotonic-raw:    libc: 286 nsec/call
clock-getres-monotonic-raw:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-tai: syscall: 351 nsec/call
clock-gettime-tai:    libc: 364 nsec/call
clock-gettime-tai:    vdso: 365 nsec/call
clock-getres-tai: syscall: 287 nsec/call
clock-getres-tai:    libc: 287 nsec/call
clock-getres-tai:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-boottime: syscall: 347 nsec/call
clock-gettime-boottime:    libc: 364 nsec/call
clock-gettime-boottime:    vdso: 355 nsec/call
clock-getres-boottime: syscall: 287 nsec/call
clock-getres-boottime:    libc: 287 nsec/call
clock-getres-boottime:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-realtime: syscall: 346 nsec/call
clock-gettime-realtime:    libc: 36 nsec/call
clock-gettime-realtime:    vdso: 29 nsec/call
clock-getres-realtime: syscall: 285 nsec/call
clock-getres-realtime:    libc: 287 nsec/call
clock-getres-realtime:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-realtime-coarse: syscall: 296 nsec/call
clock-gettime-realtime-coarse:    libc: 20 nsec/call
clock-gettime-realtime-coarse:    vdso: 11 nsec/call
clock-getres-realtime-coarse: syscall: 301 nsec/call
clock-getres-realtime-coarse:    libc: 297 nsec/call
clock-getres-realtime-coarse:    vdso: not tested
Note: vDSO version of clock_getres not found
getcpu: syscall: 255 nsec/call
getcpu:    libc: 32 nsec/call
getcpu:    vdso: 21 nsec/call
gettimeofday: syscall: 339 nsec/call
gettimeofday:    libc: 31 nsec/call
gettimeofday:    vdso: 30 nsec/call


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
