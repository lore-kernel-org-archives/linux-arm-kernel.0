Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA37C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:19:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD8620C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XuGlvxCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD8620C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KvXTE0h3/PiCbJ5H14n8CrMk1IpODVVtks8U5fmlV8Q=; b=XuGlvxCdUF7rBp
	ji+lTS61gqLGrP8RorJEEfQ2tRAeDgwnb1GjqHFA63oLHIuP+W89fLVX4+whK8mWHLcJh3F2VH9I+
	L4rcu+5iS3+w1hPMXtlfqPqnLz0pYnF8RHSGYziGH4/z3E1/ckHoDTpxSjhfEogSREangcRoy1c1S
	7AIsrvvMIlXyZFPtHQq1O0zn7uzO5+UJjx6Gy8UBdM0Jnx+1IwCPf9ujjoWoC588FdYd0udB/6elO
	oN35CKfmzUul7fFiGEEpYoevi6lECbDHXaO1JlLNc3rqD3uu9wZEn/+HSGUdCVnJtEZtEPT4ohw5Y
	NsAbRShzyRZf2iBvO1Eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz1v7-0004sU-Ky; Wed, 27 Feb 2019 16:18:57 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz1uz-0004rt-UB
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 16:18:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB7AC1596;
 Wed, 27 Feb 2019 08:18:47 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E4F93F738;
 Wed, 27 Feb 2019 08:18:45 -0800 (PST)
Subject: Re: [PATCH v5 22/23] x86: Add support for generic vDSO
To: Thomas Gleixner <tglx@linutronix.de>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-23-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1902231138130.1666@nanos.tec.linutronix.de>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <82104913-fcce-8012-1815-05ea78081ff4@arm.com>
Date: Wed, 27 Feb 2019 16:18:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902231138130.1666@nanos.tec.linutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_081849_979998_70552872 
X-CRM114-Status: GOOD (  17.22  )
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

On 23/02/2019 10:45, Thomas Gleixner wrote:
> On Fri, 22 Feb 2019, Vincenzo Frascino wrote:
>>  void update_vsyscall_tz(void)
>>  {
>> -	vsyscall_gtod_data.tz_minuteswest = sys_tz.tz_minuteswest;
>> -	vsyscall_gtod_data.tz_dsttime = sys_tz.tz_dsttime;
>> +	vdso_data.tz_minuteswest = sys_tz.tz_minuteswest;
>> +	vdso_data.tz_dsttime = sys_tz.tz_dsttime;
>>  }
>>  
>>  void update_vsyscall(struct timekeeper *tk)
>>  {
>>  	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
>> -	struct vsyscall_gtod_data *vdata = &vsyscall_gtod_data;
>> -	struct vgtod_ts *base;
>> +	struct vdso_data *vdata = &vdso_data;
>> +	struct vdso_timestamp *vdso_ts;
>>  	u64 nsec;
>>  
>>  	/* Mark the new vclock used. */
>>  	BUILD_BUG_ON(VCLOCK_MAX >= 32);
>>  	WRITE_ONCE(vclocks_used, READ_ONCE(vclocks_used) | (1 << vclock_mode));
>>  
>> -	gtod_write_begin(vdata);
>> +	vdso_write_begin(vdata);
> 
> This begs the question why this update code is still architecture
> specific. The vdso data is now generic, so the whole update can be generic
> as well. The only x86 specific thing is this perhaps:
> 
>   	int vclock_mode = tk->tkr_mono.clock->archdata.vclock_mode;
> 
> 	vdata->clock_mode	= vclock_mode;
> 
> But either than can be made generic and mandatory or easily resolved with a
> trivial arch_update_vsyscall() inline.
>

I agree, I will make it generic in the next patch series.

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
