Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ABEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:48:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28D0222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bgMINM2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28D0222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DunVDTJcYNWF8JINWCEWvopC4iMyigeJmSMXOcBzHQE=; b=bgMINM2zaYTNykz1kCXa+0Cgh
	HqG0WBFMyM1ixliOPdnT/Miz5O/KZD3yiOKV+9e2G1ILWyV4fqUzXfWD0CQvwHWm7xzMkkFP9TX1O
	dKno/4MSDqdbqnGPTHF2jO1/12VbkVQWp/W2DpHQTjxbZ2xtdXHP3UOMoGns5Gr1HrYHofhfIx27O
	6J9dJfU+egaSd/yG44OmGAat+PVRs2msjIbw1ewaBZ3tZ03m6g90DHvv9V6zULQ15TxnsrQ+suo53
	TnMT6eIjgCMZTR6ityOsBKT8fMrh4qZKKnRkk0VsthlZ5Js4G4QmDwlkUNAMQsefE7tONmbS9rzC6
	S0zL8ht7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guEYo-0006uJ-4n; Thu, 14 Feb 2019 10:48:06 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guEYl-0006u0-EH
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:48:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB62DEBD;
 Thu, 14 Feb 2019 02:48:02 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 207BC3F575;
 Thu, 14 Feb 2019 02:47:59 -0800 (PST)
Subject: Re: [PATCH v5 4/5] arm64/kvm: add a userspace option to enable
 pointer authentication
To: James Morse <james.morse@arm.com>
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-5-git-send-email-amit.kachhap@arm.com>
 <1e3f2a9a-e3f7-bb06-495a-24f77a73cae0@arm.com>
From: Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <b462c85b-8312-f1f3-e0b1-d9dcc0f616b4@arm.com>
Date: Thu, 14 Feb 2019 16:17:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1e3f2a9a-e3f7-bb06-495a-24f77a73cae0@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_024803_495430_F58CA5C0 
X-CRM114-Status: GOOD (  26.53  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Kristina Martsenko <kristina.martsenko@arm.com>,
 Dave Martin <Dave.Martin@arm.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


Hi,
On 1/31/19 9:57 PM, James Morse wrote:
> Hi Amit,
> 
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
> 
>> diff --git a/Documentation/arm64/pointer-authentication.txt
> b/Documentation/arm64/pointer-authentication.txt
>> index a25cd21..0529a7d 100644
>> --- a/Documentation/arm64/pointer-authentication.txt
>> +++ b/Documentation/arm64/pointer-authentication.txt
>> @@ -82,7 +82,8 @@ pointers).
>>   Virtualization
>>   --------------
>>
>> -Pointer authentication is not currently supported in KVM guests. KVM
>> -will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
>> -the feature will result in an UNDEFINED exception being injected into
>> -the guest.
>> +Pointer authentication is enabled in KVM guest when virtual machine is
>> +created by passing a flag (KVM_ARM_VCPU_PTRAUTH)
> 
> Isn't that a VCPU flag? Shouldn't this be when each VCPU is created?
Yes it is a VCPU flag.
> 
> 
>> requesting this feature
>> +to be enabled. Without this flag, pointer authentication is not enabled
>> +in KVM guests and attempted use of the feature will result in an UNDEFINED
>> +exception being injected into the guest.
> 
> ... what happens if KVM's user-space enables ptrauth on some vcpus, but not on
> others?
Yes seems to be issue. Let me check more on this if there are other ways 
of passing the userspace parameter such as in CREATE_VM type ioctl.
> 
> You removed the id-register suppression in the previous patch, but it doesn't
> get hooked up to kvm_arm_vcpu_ptrauth_allowed() here. (you could add
> kvm_arm_vcpu_ptrauth_allowed() earlier, and default it to true to make it easier).
> 
> Doesn't this mean that if the CPU supports pointer auth, but user-space doesn't
> specify this flag, the guest gets mysterious undef's whenever it tries to use
> the advertised feature?
Agree, ID registers should be masked  when userspace disables it.
> 
> (whether we support big/little virtual-machines is probably a separate issue,
> but the id registers need to be consistent with our trap-and-undef behaviour)
> 
> 
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index c798d0c..4a6ec40 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -453,14 +453,15 @@ static inline bool kvm_arch_requires_vhe(void)
>>   
>>   void kvm_arm_vcpu_ptrauth_enable(struct kvm_vcpu *vcpu);
>>   void kvm_arm_vcpu_ptrauth_disable(struct kvm_vcpu *vcpu);
>> +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu);
>>   
>>   static inline void kvm_arm_vcpu_ptrauth_reset(struct kvm_vcpu *vcpu)
>>   {
>>   	/* Disable ptrauth and use it in a lazy context via traps */
>> -	if (has_vhe() && kvm_supports_ptrauth())
>> +	if (has_vhe() && kvm_supports_ptrauth()
>> +			&& kvm_arm_vcpu_ptrauth_allowed(vcpu))
>>   		kvm_arm_vcpu_ptrauth_disable(vcpu);
>>   }
>> -
>>   void kvm_arm_vcpu_ptrauth_trap(struct kvm_vcpu *vcpu);
>>   
> 
>> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
>> index 5b980e7..c0e5dcd 100644
>> --- a/arch/arm64/kvm/handle_exit.c
>> +++ b/arch/arm64/kvm/handle_exit.c
>> @@ -179,7 +179,8 @@ static int handle_sve(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>    */
>>   void kvm_arm_vcpu_ptrauth_trap(struct kvm_vcpu *vcpu)
>>   {
>> -	if (has_vhe() && kvm_supports_ptrauth())
>> +	if (has_vhe() && kvm_supports_ptrauth()
>> +			&& kvm_arm_vcpu_ptrauth_allowed(vcpu))
> 
> Duplication. If has_vhe() moved into kvm_supports_ptrauth(), and
> kvm_supports_ptrauth() was called from kvm_arm_vcpu_ptrauth_allowed() it would
> be clearer that use of this feature was becoming user-controlled policy.
> 
> (We don't need to list the dependencies at every call site)
ok.
> 
> 
>> diff --git a/arch/arm64/kvm/hyp/ptrauth-sr.c b/arch/arm64/kvm/hyp/ptrauth-sr.c
>> index 0576c01..369624f 100644
>> --- a/arch/arm64/kvm/hyp/ptrauth-sr.c
>> +++ b/arch/arm64/kvm/hyp/ptrauth-sr.c
>> @@ -42,3 +42,16 @@ void __no_ptrauth __hyp_text __ptrauth_switch_to_host(struct kvm_vcpu *vcpu,
>>   	ptrauth_keys_store((struct ptrauth_keys *) &guest_ctxt->sys_regs[APIAKEYLO_EL1]);
>>   	ptrauth_keys_switch((struct ptrauth_keys *) &host_ctxt->sys_regs[APIAKEYLO_EL1]);
>>   }
>> +
>> +/**
>> + * kvm_arm_vcpu_ptrauth_allowed - checks if ptrauth feature is present in vcpu
> 
> ('enabled by KVM's user-space' may be clearer. 'Present in vcpu' could be down
> to a cpufeature thing)
ok.
> 
> 
>> + *
>> + * @vcpu: The VCPU pointer
>> + *
>> + * This function will be used to enable/disable ptrauth in guest as configured
> 
> ... but it just tests the bit ...
> 
>> + * by the KVM userspace API.
>> + */
>> +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
>> +{
>> +	return test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features);
>> +}
> 
> 
> Thanks,
> 
> James
> 
//Amit

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
