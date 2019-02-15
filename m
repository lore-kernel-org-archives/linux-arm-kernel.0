Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A37FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:49:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E592A2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="swkdaaeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E592A2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a5eAsBrVXncKFbrdq1dQ3qwWSMrp1G+uZZb4v1ETezo=; b=swkdaaeFGqYBzcbBAUQ0yC7mQ
	yNHzsgLUBCOI3qDhELmCUtNXvb2LzaKSS+UR4xUdo3+5cpgux28oqzDQxKT6RKRH/ujRhwalreHrj
	8OgBuMDxtjM2iZ8WUP0puG7LXtSsOhEkmrmKL8kSBsCPdkwetgLdS2sBSB+voW6kNlvpYcbUo0Gmc
	CZOtBmXsN7xdHzzdaf193jhUOf+AFvbnD9mVI1wpIcOL8BESgPdQ1GspkHi0LMJwzF6L8X0Fkyo49
	BxYbSlfCtZfCHM+idzvPda2VYeRlAV0ZyOUBdSfFOYF/qEHEMnDvpt9xKn/raKMp5cpMJGdKwg5rQ
	r3nkf1+2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVRc-0003rb-Q9; Fri, 15 Feb 2019 04:49:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVRZ-0003r8-Rd
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 04:49:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA741A78;
 Thu, 14 Feb 2019 20:49:43 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9513D3F589;
 Thu, 14 Feb 2019 20:49:40 -0800 (PST)
Subject: Re: [PATCH v5 4/5] arm64/kvm: add a userspace option to enable
 pointer authentication
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-5-git-send-email-amit.kachhap@arm.com>
 <a9b22dcf-2238-344f-0b7b-b4a9de7c562c@arm.com>
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <6f341bd4-299b-8cc5-2509-f3598a78e4c6@arm.com>
Date: Fri, 15 Feb 2019 10:19:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a9b22dcf-2238-344f-0b7b-b4a9de7c562c@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_204945_896898_073A6775 
X-CRM114-Status: GOOD (  18.14  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2/13/19 11:05 PM, Kristina Martsenko wrote:
> On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
>> This feature will allow the KVM guest to allow the handling of
>> pointer authentication instructions or to treat them as undefined
>> if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
>> supply this parameter instead of creating a new API.
>>
>> A new register is not created to pass this parameter via
>> SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
>> supplied is enough to enable this feature.
> 
> [...]
> 
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index b200c14..b6950df 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -346,6 +346,10 @@ static inline int kvm_arm_have_ssbd(void)
>>   static inline void kvm_vcpu_load_sysregs(struct kvm_vcpu *vcpu) {}
>>   static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
>>   static inline void kvm_arm_vcpu_ptrauth_reset(struct kvm_vcpu *vcpu) {}
>> +static inline bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
> 
> It seems like this is only ever called from arm64 code, so do we need an
> arch/arm/ definition?
Yes not required. Nice catch.
> 
>> +/**
>> + * kvm_arm_vcpu_ptrauth_allowed - checks if ptrauth feature is present in vcpu
>> + *
>> + * @vcpu: The VCPU pointer
>> + *
>> + * This function will be used to enable/disable ptrauth in guest as configured
>> + * by the KVM userspace API.
>> + */
>> +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
>> +{
>> +	return test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features);
>> +}
> 
> I'm not sure, but should there also be something like
> 
> if (test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features) &&
>      !kvm_supports_ptrauth())
> 	return -EINVAL;
> 
> in kvm_reset_vcpu?
Yes makes sense. I missed it and with Dave martin patch this may be done 
cleanly.

Thanks,
Amit D

> 
> Thanks,
> Kristina
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
