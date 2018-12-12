Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F72C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:31:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19EA2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MQsotdN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19EA2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BZVSu/P3yu6fwMcQv/Iqliw3BQRsWEZxpYF9uCFQ7Zc=; b=MQsotdN5r3Wmne5Gdbzj6UW9+
	iNE8D+bEXzpnXysB4+RxoIOUxvsExJB78um2ZZWrtc051WbW1pYHL+jl86oQ9/Vf5d653FUfQyYzY
	DpNqitFTvLTXlK+/c/10kjuZhJnUYTvg2zTkntNiLircMi/WQ/XVF40KK4Yz6XuV410eYQ2sk9ebj
	VM8Jkw7fWfobJAKp0Q8/GTga5TXqHBzCsDdBugP6muGgDpC90Y2ddzLiYorgH7Oq8bnWMyeDSQnTT
	8q0JDLNRlnQOZtcJNiTAUUa0FtyyjqU8kJKgnIEluWG7MHdTu3pbumaw9HYT6l2iJaqkTvJS+THcD
	C9920261Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXTtY-0004BK-RI; Thu, 13 Dec 2018 16:31:28 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXTtQ-00048O-M9
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:31:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAF3480D;
 Thu, 13 Dec 2018 08:31:09 -0800 (PST)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23C733F614;
 Thu, 13 Dec 2018 08:31:09 -0800 (PST)
Subject: Re: [PATCH 2/6] arm64: add sysfs vulnerability show for meltdown
To: Julien Thierry <julien.thierry@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-3-jeremy.linton@arm.com>
 <d1ad00a8-1b87-f234-aa41-c1f342cb28dc@arm.com>
 <af4f1e1e-673d-28e0-909d-f1e85b4d5b45@arm.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <3dfed0e1-9819-ccfd-1024-b6f64f5fbffe@arm.com>
Date: Wed, 12 Dec 2018 08:49:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <af4f1e1e-673d-28e0-909d-f1e85b4d5b45@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_083121_376122_785430DD 
X-CRM114-Status: GOOD (  22.07  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Julien,

Thanks for taking a look at this!

On 12/13/2018 04:46 AM, Julien Thierry wrote:
> 
> 
> On 13/12/2018 09:23, Julien Thierry wrote:
>> Hi Jeremy,
>>
>> On 06/12/2018 23:44, Jeremy Linton wrote:
>>> Add a simple state machine which will track whether
>>> all the online cores in a machine are vulnerable.
>>>
>>> Once that is done we have a fairly authoritative view
>>> of the machine vulnerability, which allows us to make a
>>> judgment about machine safety if it hasn't been mitigated.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   arch/arm64/kernel/cpufeature.c | 31 ++++++++++++++++++++++++++-----
>>>   1 file changed, 26 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 242898395f68..bea9adfef7fa 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -905,6 +905,8 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>>>   	return has_cpuid_feature(entry, scope);
>>>   }
>>>   
>>> +static enum { A64_MELT_UNSET, A64_MELT_SAFE, A64_MELT_UNKN } __meltdown_safe = A64_MELT_UNSET;
>>> +
>>
>> I'm wondering, do we really need that tri state?
>>
>> Can't we consider that we are safe an move to unsafe/unkown if any cpu
>> during bring up is not in the safe list?
>>
>> The only user of this is cpu_show_meltdown, but I don't imagine it'll
>> get called before unmap_kernel_at_el0() is called for the boot CPU which
>> should initialise that state.
>>
>> Or is there another reason for having that UNSET state?
>>
> 
> Ok, I think I get the point of the UNSET as #ifndef
> CONFIG_UNMAP_KERNEL_AT_EL0 we don't set the state. But does that mean we
> always fall in the "Unknown" case when we don't build kpti in? Is that
> desirable?
> 
> If so, I'd suggest replacing the tri-state with the following change:
> 
> 
>>> +
>>> +#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
>>> +ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
>>> +		char *buf)
>>> +{
>>> +	if (arm64_kernel_unmapped_at_el0())
>>> +		return sprintf(buf, "Mitigation: KPTI\n");
>>> +
> 
> 	if (!IS_ENABLED(UNMAP_KERNEL_AT_EL0) || !meltdown_safe)
> 		sprintf(buf, "Unknown\n");
> 	else
> 		sprintf(buf, "Not affected\n");

If I'm understanding what your suggesting:

Isn't this only checking the current core, rather than the whole 
machine? IIRC that was the fundamental complaint with the original set.





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
