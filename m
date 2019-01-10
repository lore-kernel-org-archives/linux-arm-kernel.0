Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0819C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:11:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3BF20660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sXMSPul5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3BF20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eckc506AfAFt/OwVkqLbxXneat9izFuy1QuU80smrx0=; b=sXMSPul5f/fQt8Yrs2+iVK/09
	b5Zgq3YcmwBhMGrbQh6DYsIoJHkVe5r0rml1KU1f1bqtRCwulJ/FFGcrv97Z9xIgzKAeb5zHEHLp1
	pKeDZCg9nhkT5WrpWlHAnMBXN7Z49CgHjXgVSJpL8quPc/2nmaeCeL6KcI5yPkI65R8ytZVLArcE+
	xZpc8ElLJUkr3suXfp7P2+m4D3f3oumC/1cl4L1yUaqjoPCE7lxoZvPhUSUerlBV6Bjb8tigrvcTw
	CfICUJAouYyrVFFWtnx5IiJKORda3eMHAKGOBg3o5ZaXjHRfB1m6V28yfzMR7Ad9yRmKLtsUL7Ac8
	n0Fp1VAxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghb2u-0006q5-Bs; Thu, 10 Jan 2019 14:10:56 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghb2r-0006pk-1Z
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 14:10:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FF531596;
 Thu, 10 Jan 2019 06:10:52 -0800 (PST)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED9233F5AF;
 Thu, 10 Jan 2019 06:10:50 -0800 (PST)
Subject: Re: [PATCH v3 4/7] arm64: add sysfs vulnerability show for meltdown
To: Julien Thierry <julien.thierry@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-5-jeremy.linton@arm.com>
 <8c8b564a-1d65-bc18-73fb-58b349a47800@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <7e843245-56c0-d7c1-38ba-27ff231a500a@arm.com>
Date: Thu, 10 Jan 2019 08:10:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8c8b564a-1d65-bc18-73fb-58b349a47800@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_061053_094837_2187D2F3 
X-CRM114-Status: GOOD (  22.19  )
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

Hi Julien,

On 01/10/2019 03:23 AM, Julien Thierry wrote:
> Hi Jeremy,
> 
> On 09/01/2019 23:55, Jeremy Linton wrote:
>> Display the mitigation status if active, otherwise
>> assume the cpu is safe unless it doesn't have CSV3
>> and isn't in our whitelist.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/cpufeature.c | 32 +++++++++++++++++++++++++++-----
>>   1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index ab784d7a0083..ef7bbc49ef78 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -944,8 +944,12 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>>   	return has_cpuid_feature(entry, scope);
>>   }
>>   
>> +/* default value is invalid until unmap_kernel_at_el0() runs */
>> +static bool __meltdown_safe = true;
>> +
>>   #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>   static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>> +extern uint arm64_requested_vuln_attrs;
>>   
>>   static bool is_cpu_meltdown_safe(void)
>>   {
>> @@ -972,6 +976,14 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>>   {
>>   	char const *str = "command line option";
>>   
>> +	bool meltdown_safe = is_cpu_meltdown_safe() ||
>> +		has_cpuid_feature(entry, scope);
>> +
>> +	if (!meltdown_safe)
>> +		__meltdown_safe = false;
>> +
>> +	arm64_requested_vuln_attrs |= VULN_MELTDOWN;
>> +
>>   	/*
>>   	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
>>   	 * ThunderX leads to apparent I-cache corruption of kernel text, which
>> @@ -993,11 +1005,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>>   	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
>>   		return true;
>>   
>> -	if (is_cpu_meltdown_safe())
>> -		return false;
>> -
>> -	/* Defer to CPU feature registers */
>> -	return !has_cpuid_feature(entry, scope);
>> +	return !meltdown_safe;
>>   }
>>   
>>   static void
>> @@ -2065,3 +2073,17 @@ static int __init enable_mrs_emulation(void)
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
> 
> An issue I see is that we don't even bother to check it that CPUs are
> meltdown safe if CONFIG_UNMAP_KERNEL_AT_EL0 is not defined but here
> we'll advertise that the system is meltdown safe.

That check isn't necessary anymore because the sysfs attribute is only 
populated if unmap_kernel_at_el0() runs (assuming I haven't messed 
something up). That was Dave/Will's suggestions in the last thread about 
how to handle this case.



> 
> I think that checking whether we know that CPUs are meltdown safe should
> be separated from whether mitigation is applied.
> 
> Someone who knows thinks their CPUs are in the white list might want to
> compile out code that does the kpti, but it would be good to give them a
> proper diagnostic whether they were wrong or not.
> 
> Cheers,
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
