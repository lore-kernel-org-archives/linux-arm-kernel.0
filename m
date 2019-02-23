Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F4BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:51:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E0B206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K0dNrRuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E0B206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/pBVcvn2YhFNhwsA7CZDYW6roLZph/xVOVs9jO7SDM4=; b=K0dNrRuLNWdDlR
	iLKO+eF2lGpLKCyAkgNmYs6WKIb8uhAkcvAJlXCPo+bouMyp0WyNHKtzrHA5Fm1BDG28npgBBrelj
	2KBZl9OfGa20jFfmEA3Sgbi3oRuB7bRKlujWfkknFORTtNWvfJtvhvAr7cxaAc+r0hQZLTwazAclJ
	mdbyXJgrzxjwnbNytjSV4rvipk0Vp9c67kE+Km1bzaWlREKX/XoH2whTM+X6Yiup3US7/5YT5sFFW
	F91oZ2Rtux5p9z8xu5r7zC6Ycc6PHyeCs+EEJyEfkRx138O+eTFWV/hZBZjdWzotxw+FCbv3M2UJ0
	/1Q5RuRWHY77nmxTyimQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxaWF-0008Cw-VG; Sat, 23 Feb 2019 16:51:19 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxaWB-0008CE-RV
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 16:51:17 +0000
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gxaW4-0002qp-51; Sat, 23 Feb 2019 17:51:08 +0100
Date: Sat, 23 Feb 2019 17:51:07 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 01/23] kernel: Standardize vdso_datapage
In-Reply-To: <20190222122430.21180-2-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1902231727060.1666@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-2-vincenzo.frascino@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_085116_036130_9C553D00 
X-CRM114-Status: GOOD (  21.47  )
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

On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
> +/*
> + * There is one vdso_clocksource object in vvar for each vDSO clocksource
> + * (mono, raw). This struct is designed to keep vdso_data "cache-line friendly"
> + * and optimal in terms of access pattern.
> + *
> + * Note that mask and shift are the same for mono and raw.
> + */
> +struct vdso_clocksource {
> +	u64 mask;		/* Clocksource mask */
> +	u32 mult;		/* Clocksource multiplier */
> +	u32 shift;		/* Clocksource shift */

Can you please get rid of the tail comments and use proper kerneldoc
format?

> +/*
> + * vdso_data will be accessed by 32 and 64 bit code at the same time
> + * so we should be careful before modifying this structure.
> + */
> +struct vdso_data {
> +	u32 seq;		/* Timebase sequence counter */
> +
> +	s32 clock_mode;
> +	u64 cycle_last;		/* Timebase at clocksource init */
> +
> +	struct vdso_clocksource cs[CLOCKSOURCE_BASES];

Why would you need different clocksource parameters? That really bloats the
data structure and makes the cache access pattern worse. Also the vdso
update needs to copy the same data over and over for no value.

The only clock ID which needs a different mult/shift would be
MONOTONIC_RAW, but if we expose that through the VDSO then we really can be
smarter than this. See incomplete and uncompilable patch below for
reference. You get the idea.

> +	struct vdso_timestamp basetime[VDSO_BASES];
> +
> +	s32 tz_minuteswest;	/* Timezone definitions */
> +	s32 tz_dsttime;

Also please keep the tabular alignment of the members

	u32		foo;
	struct bar	bar;

that's way better to read than

	u32 foo;
	struct bar bar;

Thanks

	tglx

8<-----------------

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -139,9 +139,10 @@ notrace static inline u64 vgetcyc(int mo
 	return U64_MAX;
 }
 
-notrace static int do_hres(clockid_t clk, struct timespec *ts)
+notrace static int do_hres(clockid_t clk, struct timespec *ts,
+			   struct vsyscall_gtod_data *vdata)
 {
-	struct vgtod_ts *base = &gtod->basetime[clk];
+	struct vgtod_ts *base = &vdata->basetime[clk];
 	u64 cycles, last, sec, ns;
 	unsigned int seq;
 
@@ -168,9 +169,10 @@ notrace static int do_hres(clockid_t clk
 	return 0;
 }
 
-notrace static void do_coarse(clockid_t clk, struct timespec *ts)
+notrace static void do_coarse(clockid_t clk, struct timespec *ts,
+			      struct vsyscall_gtod_data *vdata)
 {
-	struct vgtod_ts *base = &gtod->basetime[clk];
+	struct vgtod_ts *base = &vdata->basetime[clk];
 	unsigned int seq;
 
 	do {
@@ -194,10 +196,12 @@ notrace int __vdso_clock_gettime(clockid
 	 */
 	msk = 1U << clock;
 	if (likely(msk & VGTOD_HRES)) {
-		return do_hres(clock, ts);
+		return do_hres(clock, ts, &gtod[0]);
 	} else if (msk & VGTOD_COARSE) {
-		do_coarse(clock, ts);
+		do_coarse(clock, ts, &gtod[0]);
 		return 0;
+	} else if (msk & VGTOD_RAW) {
+		return do_hres(clock, ts, &gtod[1]);
 	}
 	return vdso_fallback_gettime(clock, ts);
 }
@@ -210,7 +214,7 @@ notrace int __vdso_gettimeofday(struct t
 	if (likely(tv != NULL)) {
 		struct timespec *ts = (struct timespec *) tv;
 
-		do_hres(CLOCK_REALTIME, ts);
+		do_hres(CLOCK_REALTIME, ts, &gtod[0]);
 		tv->tv_usec /= 1000;
 	}
 	if (unlikely(tz != NULL)) {
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -30,6 +30,7 @@ struct vgtod_ts {
 #define VGTOD_BASES	(CLOCK_TAI + 1)
 #define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
 #define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
+#define VGTOD_RAW	BIT(CLOCK_MOTONONIC_RAW)
 
 /*
  * vsyscall_gtod_data will be accessed by 32 and 64 bit code at the same time
@@ -49,7 +50,8 @@ struct vsyscall_gtod_data {
 	int		tz_minuteswest;
 	int		tz_dsttime;
 };
-extern struct vsyscall_gtod_data vsyscall_gtod_data;
+
+extern struct vsyscall_gtod_data vsyscall_gtod_data[2];
 
 extern int vclocks_used;
 static inline bool vclock_was_used(int vclock)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
