Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BB7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:31:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B07206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nuplmfAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B07206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ynco3TC3flszPBPoJhzc5Wlsjse33jtr4CTs9Xg4p88=; b=nuplmfAWmUGp9Z
	xKVVs+NsI9555JcxpYDA+FcpobF8usiDULMV+sNeIlHB+l+EmjC8vsCbpob0Cl9AzDJSvhSahbxgw
	JJ8D4N8x6fx8zOsRPwkM8gRkxswP9SC3HwyuGsVbq0jXAM84w2MRNF0TZGTxAEXJELMbtcSY0Yfz2
	7PygXFXNFL1/wXL5mI77szuqsM+hMyoqfiqwoDqNuDm+gWj/So3vsLir62APJaQ2vKOBmH3qBaoEG
	5M+4/ZP+dTILfbP4ZdTon2U5zHobga20z3cAWz5rkrYq6wSM7f3olf7LBi85yuXZuiy7LIz0cdkqt
	kMt0g6cVkeFoWJ7+Xrvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxb9J-0003W2-1c; Sat, 23 Feb 2019 17:31:41 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxb9F-0003Vf-Fy
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 17:31:39 +0000
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gxb9B-0003FB-Eq; Sat, 23 Feb 2019 18:31:33 +0100
Date: Sat, 23 Feb 2019 18:31:32 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
In-Reply-To: <20190222122430.21180-3-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1902231751510.1666@nanos.tec.linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_093137_671867_5AE39567 
X-CRM114-Status: GOOD (  13.30  )
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
> +static notrace int do_hres(const struct vdso_data *vd,
> +			   clockid_t clk,
> +			   struct __vdso_timespec *ts)
> +{
> +	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
> +	u64 cycles, last, sec, ns;
> +	u32 seq, cs_index = CLOCKSOURCE_MONO;
> +
> +	if (clk == CLOCK_MONOTONIC_RAW)
> +		cs_index = CLOCKSOURCE_RAW;

Uuurgh. So you create an array with 16 members and then use two. This code
is really optimized and now you add not only the pointless array, you also
need the extra index plus another conditional. Not to talk about the cache
impact which makes things even worse. In the x86 implementation we have:

       u32 		seq;			 +  0
       int		mode;			 +  4
       u64		mask;			 +  8
       u32		mult;			 + 16
       u32		shift;			 + 20
       struct vgtod_ts	basetimer[VGTOD_BASES];  + 24

Each basetime array member occupies 16 bytes. So

	CLOCK_REALTIME		+ 24
	CLOCK_MONOTONIC		+ 40
	..
		cacheline boundary		
	..
	CLOCK_REALTIME_COARSE	+ 104
	CLOCK_MONOTONIC_COARSE	+ 120   <- cacheline boundary
	CLOCK_BOOTTIME		+ 136
	CLOCK_REALTIME_ALARM	+ 152
	CLOCK_BOOTTIME_ALARM	+ 168
       
So the most used clocks REALTIME/MONO are in the first cacheline.

So with your scheme the thing becomes

       u32 		seq;			 +   0
       int		mode;			 +   4
       struct cs	cs[16]			 +   8
       struct vgtod_ts	basetimer[VGTOD_BASES];  + 264

and 

	CLOCK_REALTIME		+ 264
	CLOCK_MONOTONIC		+ 280

IOW, the most important clocks touch TWO cachelines now which are not even
adjacent. No, they are 256 bytes apart, which really sucks for prefetching.

We're surely not going to sacrify the performance which we carefully tuned
in that code just to support MONO_RAW. The solution I showed you in the
other reply does not have these problems at all.

It's easy enough to benchmark these implementations and without trying I'm
pretty sure that you can see the performance drop nicely. Please do so next
time and provide the numbers in the changelogs.

Thanks,

	tglx

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
