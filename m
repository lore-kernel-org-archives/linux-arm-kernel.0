Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B1CC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:39:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D402145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gG9NGw7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D402145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HA7dgh/+ILqxGf7SCI2m5VaoXi9w15FhplbEB0hrbag=; b=gG9NGw7CiCGGWa
	oM5eboVAQWlxBMWDhvco8Y4H3iFi+M4JWBkyDy2TTUJhf10GjJdw6i3t/mhQJHaRUj+Euw2roukOX
	g5uoEUgn5xZL+rHRsS5+cPIN9O8S8TpoUW+b82i6t6Nqt0/CuX9C5uzGFDV0xQ4qFgao9JKuM8tX7
	Wljcx18xhbd/EltUb5zp+3yQMNquyoL7VYr08vsXkbXlHUotd+45LkFozBiFTBTwN4FHjgcsmtklw
	IuC9mFm9nXAHtq78+g1XK97waVziDAPA6u/FiVZk5DYMrZ809/RhVeRpKGCE3oKLSDdKwiIpXoNHX
	w8/f+4zzbJWVT4y5nuRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSUxr-0004K0-52; Thu, 29 Nov 2018 22:39:19 +0000
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSUxn-0004JR-Nc
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 22:39:17 +0000
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gSUxZ-0001qA-4J; Thu, 29 Nov 2018 23:39:01 +0100
Date: Thu, 29 Nov 2018 23:39:00 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v2 01/28] kernel: Standardize vdso_datapage
In-Reply-To: <20181129170530.37789-2-vincenzo.frascino@arm.com>
Message-ID: <alpine.DEB.2.21.1811292333300.1657@nanos.tec.linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-2-vincenzo.frascino@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_143915_908529_D811E956 
X-CRM114-Status: GOOD (  17.02  )
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
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
> +/*
> + * Copyright (C) 2012 ARM Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.

Please use SPDX identifier for the license and get rid of the boiler plate.

> +#include <linux/types.h>
> +
> +struct vdso_data {
> +	__u64 cs_cycle_last;	/* Timebase at clocksource init */

Why do you want to use the __u* variants? This is not a header exposed to
user space. It's part of the kernel.

> +	__u64 raw_time_sec;	/* Raw time */
> +	__u64 raw_time_nsec;
> +	__u64 xtime_clock_sec;	/* Kernel time */
> +	__u64 xtime_clock_nsec;
> +	__u64 xtime_coarse_sec;	/* Coarse time */
> +	__u64 xtime_coarse_nsec;
> +	__u64 wtm_clock_sec;	/* Wall to monotonic time */
> +	__u64 wtm_clock_nsec;
> +	__u32 tb_seq_count;	/* Timebase sequence counter */
> +	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
> +	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
> +	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
> +	__u32 tz_minuteswest;	/* Whacky timezone stuff */
> +	__u32 tz_dsttime;
> +	__u32 use_syscall;

This struct is also suboptimal cache line and access pattern wise. Aside of
that please look at the x86 variant of this struct. It's optimized and
handles all the clock variants without adding randomly named struct
members.

Thanks,

	tglx

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
