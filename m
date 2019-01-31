Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E81C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:48:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D5520869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b1saKiWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D5520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZCuZ3x13KpXCqeYtACYIFHdjBnEO4VzWMkPsA/+GTaY=; b=b1saKiWjVsrXWn+th0ONTuXky
	xSIlVIIDYyDABQvw0WicjKyDQ0cz3WotGnmPwagskCEPWtaK8Xyg7YO4eM8RbnOl+8z3pF14hxxRm
	fE+p9ae0jLPNK5vHv20OBa1M9EnElZUw9xUHA0pXhLTroTeFSobqgInUXJUdzPUCsdool3OWbThQX
	UEe7/ykTuyslYE7XPaeRhxBVlB0n1f1fI22s6ShpIpO88DWBt4p9tX/2Jer6NlgLctTcly1lAAkff
	zPSIHQSyalj8FBcAiQF8AukA/Adz/2uvP0ZRKbiw2fd9sHhVyUwrlZ3xcSIJmLRYAtvxEqxOjOUT9
	k1rk89OWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpKBy-0002KI-BS; Thu, 31 Jan 2019 21:48:14 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpKBs-0002JZ-UN
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 21:48:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD27BA78;
 Thu, 31 Jan 2019 13:48:05 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7D213F59C;
 Thu, 31 Jan 2019 13:48:04 -0800 (PST)
Subject: Re: [PATCH v4 07/12] arm64: add sysfs vulnerability show for meltdown
To: Julien Thierry <julien.thierry@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-8-jeremy.linton@arm.com>
 <915f945c-eeb7-9cdf-2d95-d7da7552f229@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <d1d7fd58-f7c6-c5e3-e5f3-618303d161d6@arm.com>
Date: Thu, 31 Jan 2019 15:48:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <915f945c-eeb7-9cdf-2d95-d7da7552f229@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_134808_983457_B60CB97A 
X-CRM114-Status: GOOD (  20.54  )
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
Cc: stefan.wahren@i2se.com, mlangsdo@redhat.com, suzuki.poulose@arm.com,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, steven.price@arm.com, ykaukab@suse.de,
 dave.martin@arm.com, shankerd@codeaurora.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 01/31/2019 03:28 AM, Julien Thierry wrote:
> Hi Jeremy,
> 
> On 25/01/2019 18:07, Jeremy Linton wrote:
>> Display the mitigation status if active, otherwise
>> assume the cpu is safe unless it doesn't have CSV3
>> and isn't in our whitelist.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/cpufeature.c | 33 +++++++++++++++++++++++++++------
>>   1 file changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index a9e18b9cdc1e..624dfe0b5cdd 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -944,6 +944,8 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>>   	return has_cpuid_feature(entry, scope);
>>   }
>>   
>> +/* default value is invalid until unmap_kernel_at_el0() runs */
>> +static bool __meltdown_safe = true;
>>   static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>>   
>>   static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>> @@ -962,6 +964,16 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>>   		{ /* sentinel */ }
>>   	};
>>   	char const *str = "command line option";
>> +	bool meltdown_safe;
>> +
>> +	meltdown_safe = is_midr_in_range_list(read_cpuid_id(), kpti_safe_list);
>> +
>> +	/* Defer to CPU feature registers */
>> +	if (has_cpuid_feature(entry, scope))
>> +		meltdown_safe = true;
> 
> Do we need to check the cpuid registers if the CPU is in the known safe
> list?

I don't believe so. In the previous patch where this was broken out 
these checks were just or'ed together. In this path it just seemed a 
little cleaner than adding the additional check/or'ing the results 
here/whatever as we only want to set it safe (never the other way 
around). AKA, i'm running out of horizontal space, and I want to keep 
the 'defer to registers' comment.


> 
> Otherwise:
> 
> Reviewed-by: Julien Thierry <julien.thierry@arm.com>
> 
>> +
>> +	if (!meltdown_safe)
>> +		__meltdown_safe = false;
>>   
>>   	/*
>>   	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
>> @@ -984,12 +996,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>>   	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>>   		return kaslr_offset() > 0;
>>   
>> -	/* Don't force KPTI for CPUs that are not vulnerable */
>> -	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
>> -		return false;
>> -
>> -	/* Defer to CPU feature registers */
>> -	return !has_cpuid_feature(entry, scope);
>> +	return !meltdown_safe;
>>   }
>>   
>>   static void
>> @@ -2055,3 +2062,17 @@ static int __init enable_mrs_emulation(void)
>>   }
>>   
>>   core_initcall(enable_mrs_emulation);
>> +
>> +#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
>> +ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	if (arm64_kernel_unmapped_at_el0())
>> +		return sprintf(buf, "Mitigation: KPTI\n");
>> +
>> +	if (__meltdown_safe)
>> +		return sprintf(buf, "Not affected\n");
>> +
>> +	return sprintf(buf, "Vulnerable\n");
>> +}
>> +#endif
>>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
