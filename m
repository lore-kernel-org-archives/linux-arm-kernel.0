Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11F2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:27:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C5720868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PQwETa1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C5720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=61tzNud5gfEyrcAxe7DViksmhRnin1sVh0KK8PFP7ME=; b=PQwETa1bY4H52g
	ZlIEj/BMu9NI/CwP3HT2p1ueQM6PBsGF5FyLOzZhdWd8SA4Y+1/4Uw5SdTYbZHI9dU/U2V1bZsOSM
	mAExJZVdQ76ZzrnjQZ3aQM18OrsrM+GLZzZkO9AvBHSWViXU4/3uB0I1yh9YvzRHEv2XYHOmDzM0f
	pLp4JuSVwnR+8GuaTGLk8fGNCPqoOB5worluIqbz0YhOLSwPsmXOXyeGe9PS0u6f4LTa8bI1MyCix
	Uq1R/fu8+WpLjXZt4gkQZ5C73yEuhc63gX/b/LAJNreV8Nd9scHBM8cDp8r4Jx1cYWgF9oFLDUHng
	EAYtP8+uoznuhX711rPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQcE-0007Hd-Gx; Tue, 15 Jan 2019 15:26:58 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQcB-0007HF-6J
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 15:26:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8F3480D;
 Tue, 15 Jan 2019 07:26:53 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C58E63F5BD;
 Tue, 15 Jan 2019 07:26:51 -0800 (PST)
Subject: Re: [PATCH v4 01/24] kernel: Standardize vdso_datapage
To: Thomas Gleixner <tglx@linutronix.de>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
 <20190115135539.24762-2-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1901151554260.1561@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <7b0c86a9-b22b-ec89-436e-c8a6a69146b6@arm.com>
Date: Tue, 15 Jan 2019 15:26:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901151554260.1561@nanos.tec.linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_072655_238695_8A9CDF50 
X-CRM114-Status: GOOD (  17.35  )
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

On 15/01/2019 14:57, Thomas Gleixner wrote:
> On Tue, 15 Jan 2019, Vincenzo Frascino wrote:
> 
>> +/*
>> + * There is one vdso_timestamp object in vvar for each vDSO-accelerated
>> + * clock_id. For high-resolution clocks, this encodes the time
>> + * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
>> + * the actual time.
>> + *
>> + * To be noticed that nsec is left-shifted by vdso_data.shift.
> 
> This is only true for highres clocks. For coarse the nsec value is not
> shifted.
>

Agreed, missed part of the comment here. I will fix it in v5.

>> + */
>> +struct vdso_timestamp {
>> +	u64 sec;
>> +	u64 nsec;
>> +};
>> +
>> +/*
>> + * vdso_data will be accessed by 32 and 64 bit code at the same time
>> + * so we should be careful before modifying this structure.
>> + */
>> +struct vdso_data {
>> +	u32 seq;		/* Timebase sequence counter */
>> +
>> +	s32 clock_mode;
>> +	u64 cycle_last;		/* Timebase at clocksource init */
>> +	u64 mask;		/* Clocksource mask (mono = raw) */
> 
> mono = raw? This is broken. The VDSO cannot define time different from the
> regular syscall interfaces.
> 

On v2 of this series I had the masks for mono and raw separate, but based on
your comment (the core timekeeper has them duplicated purely for access pattern
optimization and simplicity). I unified them. Could you please provide more
details on what should be done in this case?

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
