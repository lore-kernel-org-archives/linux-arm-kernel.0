Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A8C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AA22082C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QWIXXz+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AA22082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MARE63RNEouCI90w8SSGXj0Hpt9l+t0sARF6qtEFnmU=; b=QWIXXz+v3j1Hhe4ykLwmMVXfM
	9cEd27R8SLCYuZTpiQW3sBfiHY48VbsIRe97LsTHZw5T59t0DPDw/HLcJaeiDN4Zcq3apXkT6GULe
	Ytfbe935ERKgnhNnX7koJdwlpx0iukDarggWAtrfBn8RIRI/kX0e8XfT1TaVAWf/dwXrxvFCUUOb2
	qpno+rtwu/Ps7VY7NvQIVfAXgkyrAm8vgK2Yo5+xcFfoLRhh6JsxQ9vj+DbR0AMAIm3FOJZfpQYOj
	89czMispAiv7m81UtfzxdvMlc4N2Tg7DxtuOxE54zm2/ZjlJSVysvBVuuORnA5oWt+QKFJTxPxzjY
	ULEMRysUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpKGz-0003vX-MZ; Thu, 31 Jan 2019 21:53:25 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpKGt-0003us-Fp
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 21:53:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE6A6A78;
 Thu, 31 Jan 2019 13:53:18 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E44813F59C;
 Thu, 31 Jan 2019 13:53:17 -0800 (PST)
Subject: Re: [PATCH v4 07/12] arm64: add sysfs vulnerability show for meltdown
To: Andre Przywara <andre.przywara@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
 <20190125180711.1970973-8-jeremy.linton@arm.com>
 <20190131175418.24b7811c@donnerap.cambridge.arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <394041d0-a738-84f0-56a7-6803d4180113@arm.com>
Date: Thu, 31 Jan 2019 15:53:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190131175418.24b7811c@donnerap.cambridge.arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_135319_540709_4E66E538 
X-CRM114-Status: GOOD (  22.48  )
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
 marc.zyngier@arm.com, catalin.marinas@arm.com, julien.thierry@arm.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, steven.price@arm.com,
 shankerd@codeaurora.org, ykaukab@suse.de, dave.martin@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 01/31/2019 11:54 AM, Andre Przywara wrote:
> On Fri, 25 Jan 2019 12:07:06 -0600
> Jeremy Linton <jeremy.linton@arm.com> wrote:
> 
> Hi,
> 
>> Display the mitigation status if active, otherwise
>> assume the cpu is safe unless it doesn't have CSV3
>> and isn't in our whitelist.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/cpufeature.c | 33 +++++++++++++++++++++++++++------
>>   1 file changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c
>> b/arch/arm64/kernel/cpufeature.c
>> index a9e18b9cdc1e..624dfe0b5cdd 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -944,6 +944,8 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>> 	return has_cpuid_feature(entry, scope);
>> }
>>   
>> +/* default value is invalid until unmap_kernel_at_el0() runs */
> 
> Shall we somehow enforce this? For instance by making __meltdown_safe
> an enum, initialised to UNKNOWN?

Hehe, well I think people complained about my "UNKNOWN" enum. But, in 
the end this version is trying to make it clear we shouldn't have any 
unknown states remaining.

> Then bail out with a BUG_ON or WARN_ON in the sysfs code?

AFAIK, it shouldn't be possible to actually run the sysfs code before 
this gets initialized. So, the comment is just making it clear/forcing 
the understanding of that.


> 
> I just want to avoid to accidentally report "safe" when we actually
> aren't.
> 
>> +static bool __meltdown_safe = true;
>>   static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>>   static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>> @@ -962,6 +964,16 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>> 		{ /* sentinel */ }
>>   	};
>>   	char const *str = "command line option";
>> +	bool meltdown_safe;
>> +
>> +	meltdown_safe = is_midr_in_range_list(read_cpuid_id(), kpti_safe_list);
>> +
>> +	/* Defer to CPU feature registers */
>> +	if (has_cpuid_feature(entry, scope))
>> +		meltdown_safe = true;
>> +
>> +	if (!meltdown_safe)
>> +		__meltdown_safe = false;
>>   
>>   	/*
>>   	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
>> @@ -984,12 +996,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>> 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>> 		return kaslr_offset() > 0;
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
> 
> w/s issue.
> 
> Cheers,
> Andre.
> 
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
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
