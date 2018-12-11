Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033ADC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:54:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BC72082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c8LLEG41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BC72082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rVR+HVnnqRZ1vHqEVsWceGujWkotYB9MdoTpd6QBJ9M=; b=c8LLEG418dvLBp
	X6K3khOBWxtKBweQyxyWe0FS32+6G6t8pId0wAPRLdiRFcdeSSwuOVb8g1hdEXPX4NPBo+UY+trMa
	c+R2Omm3HEcR/U31dAajyxLYfnpkkPHCdIqasbbPqrrgAiCibAkeG9iTGlJlemILLeyNRFr6Fpx5g
	fxKce4xUoLXMI2biBblNgwII3yzTN2i9QYaUwKRzEFu2DVNr9bWU7oGNCATfKwpeq4fbsMq24Ij6W
	LaGjvX9N4RpDEmuijYdIlEAX+W9QArEoh+CinwmNLqzOf5qtFHolGI7c3tbSNuaniNRBSBRSGWgO3
	nE8o134A73Sl17Wp7ObA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWiUT-0005m7-AY; Tue, 11 Dec 2018 13:54:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWiUP-0005lM-LA
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 13:54:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0DE41596;
 Tue, 11 Dec 2018 05:54:10 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB74E3F59C;
 Tue, 11 Dec 2018 05:54:08 -0800 (PST)
Subject: Re: [PATCH v2 06/28] kernel: Define gettimeofday vdso common code
To: Thomas Gleixner <tglx@linutronix.de>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
 <20181129170530.37789-7-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <97be4423-fb05-69a5-cd01-245e0ff29479@arm.com>
Date: Tue, 11 Dec 2018 13:54:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811292230430.1657@nanos.tec.linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_055421_706532_1ECFC378 
X-CRM114-Status: GOOD (  23.09  )
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

On 29/11/2018 22:11, Thomas Gleixner wrote:
> Vinzenco,
> 
> On Thu, 29 Nov 2018, Vincenzo Frascino wrote:

[...]

>> +/*
>> + * Returns the clock delta, in nanoseconds left-shifted by the clock
>> + * shift.
>> + */
>> +static __always_inline notrace u64 get_clock_shifted_nsec(u64 cycle_last,
>> +							  u64 mult,
>> +							  u64 mask)
>> +{
>> +	u64 res;
>> +
>> +	/* Read the virtual counter. */
> 
> Virtual counter? No. That's again an ARM thingy. This needs to be done in
> architecture code.
>

I agree, the name choice is unfortunate here. And I should have removed the
comment as well. What this function does is getting the hardware counter, which
seems not ARM specific.

>> +/*
>> + * This hook allows the architecture to validate the arguments
>> + * passed to the library.
>> + */
>> +#ifndef __HAVE_VDSO_ARCH_VALIDATE_ARG
>> +#define __arch_valid_arg(x)	true
>> +#endif
> 
> Why would you need that? There is really no point in adding architecture
> hooks.
>

It is for the bogus. BTW I agree with your comment below. Will remove it in v3.

>> +static notrace int __cvdso_clock_gettime(clockid_t clock,
>> +					 struct __vdso_timespec *ts)
>> +{
>> +	const struct vdso_data *vd = __arch_get_vdso_data();
>> +
>> +	if (!__arch_valid_arg(ts))
> 
> Especially not for a timespec pointer. It's a user space supplied pointer
> and what do you want to validate there? If it's bogus, access will fault,
> end of story.
>>> +		return -EFAULT;
>> +
>> +	switch (clock) {
>> +	case CLOCK_REALTIME:
>> +		if (do_realtime(vd, ts))
>> +			goto fallback;
>> +		break;
>> +	case CLOCK_TAI:
>> +		if (do_tai(vd, ts))
>> +			goto fallback;
>> +		break;
>> +	case CLOCK_MONOTONIC:
>> +		if (do_monotonic(vd, ts))
>> +			goto fallback;
>> +		break;
>> +	case CLOCK_MONOTONIC_RAW:
>> +		if (do_monotonic_raw(vd, ts))
>> +			goto fallback;
>> +		break;
>> +	case CLOCK_BOOTTIME:
>> +		if (do_boottime(vd, ts))
>> +			goto fallback;
>> +		break;
>> +	case CLOCK_REALTIME_COARSE:
>> +		do_realtime_coarse(vd, ts);
>> +		break;
>> +	case CLOCK_MONOTONIC_COARSE:
>> +		do_monotonic_coarse(vd, ts);
>> +		break;
> 
> See the x86 implementation. It avoids the switch case. The reason why you
> want to avoid it is that the compiler will turn that thing above into a
> call table, using an indirect branch and then requiring retpoline.
>

Thanks for providing the rationale here. Going forward I will generalize that
implementation and make sure it works on all the architectures.

[...]

>> +static notrace int __cvdso_clock_getres(clockid_t clock_id,
>> +					struct __vdso_timespec *res)
>> +{
>> +	u64 ns;
>> +
>> +	if (!__arch_valid_arg(res))
>> +		return -EFAULT;
>> +
>> +	if (clock_id == CLOCK_REALTIME ||
>> +	    clock_id == CLOCK_TAI ||
>> +	    clock_id == CLOCK_BOOTTIME ||
>> +	    clock_id == CLOCK_MONOTONIC ||
>> +	    clock_id == CLOCK_MONOTONIC_RAW)
>> +		ns = MONOTONIC_RES_NSEC;
> 
> This is wrong. You cannot unconditionally set that. See what the syscall
> based version does. You always need to verify that the syscall version and
> the vdso version return the same information and not something randomly
> different.
>

Agreed, I will fix it in v3.

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
