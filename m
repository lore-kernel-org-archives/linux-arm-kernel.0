Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FF7C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:23:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811D92082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t0ORDsqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811D92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ojy585wJNcfn1fq/pS9i+wmS5ZMZe95ZMszE4ZBh/Y=; b=t0ORDsqYfM5+8O
	+k2dHsM2/vqhWSeQeEnYfHaleUN24cnvZGN7vv+fLQFHxPJVLzGXsms34RV6zm9hxF6v8s3woAmlA
	4uiIZSloOUG4oNNWJk35VDTpl2+hfd7kDzMcXxLfS78VyaXANlADwGt9QWzpbmX9XOs8lx4AuuCPN
	1RJz/wza35RU5f1P42cPmGE00ZBN5WnBV43e3gIaBI7IcztWWqHGGTkkOXK7bbX8B9V1Q17KK2zep
	/2lWx6ZIoknJ0hJgm6A5WOh/OI0QXBxAkxti1h+g/Z/tOnhe7Cyosqw6CtYpUP7ztufcPkLHGQm1V
	r/CH0hQHvJTS7yWG1bKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWhzz-0006ld-WA; Tue, 11 Dec 2018 13:22:56 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWhzw-0006l1-Hm
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:22:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2370EBD;
 Tue, 11 Dec 2018 05:22:41 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F04003F59C;
 Tue, 11 Dec 2018 05:22:39 -0800 (PST)
Subject: Re: [PATCH v2 01/28] kernel: Standardize vdso_datapage
To: Thomas Gleixner <tglx@linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-2-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292333300.1657@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b9ac0054-4246-35fc-918e-47f67b11a44f@arm.com>
Date: Tue, 11 Dec 2018 13:22:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811292333300.1657@nanos.tec.linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_052252_599428_29D4CB70 
X-CRM114-Status: GOOD (  22.40  )
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

Hi Thomas,

thank you for reviewing my patches.

On 29/11/2018 22:39, Thomas Gleixner wrote:
> On Thu, 29 Nov 2018, Vincenzo Frascino wrote:
>> +/*
>> + * Copyright (C) 2012 ARM Limited
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> 
> Please use SPDX identifier for the license and get rid of the boiler plate.
> 

Agreed, I will fix it in the next iteration.

>> +#include <linux/types.h>
>> +
>> +struct vdso_data {
>> +	__u64 cs_cycle_last;	/* Timebase at clocksource init */
> 
> Why do you want to use the __u* variants? This is not a header exposed to
> user space. It's part of the kernel.
> 

This patch contains the same datatypes of the file from which is copied. Said
that, I agree with you and I will fix this in v3.

>> +	__u64 raw_time_sec;	/* Raw time */
>> +	__u64 raw_time_nsec;
>> +	__u64 xtime_clock_sec;	/* Kernel time */
>> +	__u64 xtime_clock_nsec;
>> +	__u64 xtime_coarse_sec;	/* Coarse time */
>> +	__u64 xtime_coarse_nsec;
>> +	__u64 wtm_clock_sec;	/* Wall to monotonic time */
>> +	__u64 wtm_clock_nsec;
>> +	__u32 tb_seq_count;	/* Timebase sequence counter */
>> +	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
>> +	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
>> +	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
>> +	__u32 tz_minuteswest;	/* Whacky timezone stuff */
>> +	__u32 tz_dsttime;
>> +	__u32 use_syscall;
> 
> This struct is also suboptimal cache line and access pattern wise. Aside of
> that please look at the x86 variant of this struct. It's optimized and
> handles all the clock variants without adding randomly named struct
> members.
> 

I had a look at the x86 implementation and I agree with you and Arnd that it is
better than what I am proposing here. Therefore, in my v3, I will follow that
model for the vdso unification. Thanks to both for pointing that out and for
providing the rationale behind it.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
