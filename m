Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D417C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:46:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7A220880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l7ChzQ4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7A220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DoorG5bxBpbiGk/m3DmhUomTEFRuHaMBw5CsWehfsFk=; b=l7ChzQ4nGl8tkc
	9o7eDJwVZEzeF8aOgAua/dE4eR3Qa1v/m2J4hvcqfd/i/1nsXvzJnb78mg4KO2kk0ZwybxhSRz9Gd
	f/IAy5bIylkkGMx0B1m8X2Afw+sirYDkE+Ch3lCXFP35MsNblGbHSwRWKC4+mdl3ualxvnq0JysV0
	s/VobhgeUW5E7j/MYRY9L2u/vo7nodVrWXuQUPelMvg4x2Q4qrqob0g6IJ0S/y4Xoh4xSEHsu2EzA
	JrCfyycHHKXoUuQ4774jvIZx/gqVI/ylh4e+Udlrsphiu1Xyks2Txz36tcsvOgyIx/sdTeqLhBIFJ
	RSgPcN5YgBnqva5hmXrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXOW2-0002S1-Vp; Thu, 13 Dec 2018 10:46:51 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXOVv-00027O-RK
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 10:46:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A208A78;
 Thu, 13 Dec 2018 02:46:33 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BCB83F6A8;
 Thu, 13 Dec 2018 02:46:31 -0800 (PST)
Subject: Re: [PATCH 2/6] arm64: add sysfs vulnerability show for meltdown
From: Julien Thierry <julien.thierry@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>, linux-arm-kernel@lists.infradead.org
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-3-jeremy.linton@arm.com>
 <d1ad00a8-1b87-f234-aa41-c1f342cb28dc@arm.com>
Message-ID: <af4f1e1e-673d-28e0-909d-f1e85b4d5b45@arm.com>
Date: Thu, 13 Dec 2018 10:46:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d1ad00a8-1b87-f234-aa41-c1f342cb28dc@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_024644_846697_81A7DD6D 
X-CRM114-Status: GOOD (  20.70  )
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
Cc: mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 13/12/2018 09:23, Julien Thierry wrote:
> Hi Jeremy,
> 
> On 06/12/2018 23:44, Jeremy Linton wrote:
>> Add a simple state machine which will track whether
>> all the online cores in a machine are vulnerable.
>>
>> Once that is done we have a fairly authoritative view
>> of the machine vulnerability, which allows us to make a
>> judgment about machine safety if it hasn't been mitigated.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>  arch/arm64/kernel/cpufeature.c | 31 ++++++++++++++++++++++++++-----
>>  1 file changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 242898395f68..bea9adfef7fa 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -905,6 +905,8 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>>  	return has_cpuid_feature(entry, scope);
>>  }
>>  
>> +static enum { A64_MELT_UNSET, A64_MELT_SAFE, A64_MELT_UNKN } __meltdown_safe = A64_MELT_UNSET;
>> +
> 
> I'm wondering, do we really need that tri state?
> 
> Can't we consider that we are safe an move to unsafe/unkown if any cpu
> during bring up is not in the safe list?
> 
> The only user of this is cpu_show_meltdown, but I don't imagine it'll
> get called before unmap_kernel_at_el0() is called for the boot CPU which
> should initialise that state.
> 
> Or is there another reason for having that UNSET state?
> 

Ok, I think I get the point of the UNSET as #ifndef
CONFIG_UNMAP_KERNEL_AT_EL0 we don't set the state. But does that mean we
always fall in the "Unknown" case when we don't build kpti in? Is that
desirable?

If so, I'd suggest replacing the tri-state with the following change:


>> +
>> +#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
>> +ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
>> +		char *buf)
>> +{
>> +	if (arm64_kernel_unmapped_at_el0())
>> +		return sprintf(buf, "Mitigation: KPTI\n");
>> +

	if (!IS_ENABLED(UNMAP_KERNEL_AT_EL0) || !meltdown_safe)
		sprintf(buf, "Unknown\n");
	else
		sprintf(buf, "Not affected\n");


Thanks,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
