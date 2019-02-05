Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C3C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:21:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FD220821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CWaLXzjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FD220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g8eyhDInj4ewlHKcq90i3zWOIRr15htJLcEdKDrwapI=; b=CWaLXzjtqfxMcu
	uSjEkllMkvWyxX48AV64L3EImYo2hhUJ+rDt4yvzcbtu9H0VVqrkwI1FCfEq5Q+MJR0nkjG2Aw+o9
	4Ep0Lcjg4YDxLbMttjoReKZ/WvnVb4UQXe4i14ZoNWW6dUyR0cecuw+95Y0fY7qc7rJcdgKLxGwEy
	YyXY9Wa5aHPAHnQbc0EVB195FsJD3290yQKqcYpJVUtBZ0YL4SyVwDTWKgg4FfN3TBbJa2VMC+fZ4
	ncQYilb3yx8WeoQEm5lACnztQYplqWwpkidJ5GpR6bvmtQhcGqzr/0T3OA0M+n+2eN/NfmGuUlXR1
	Tc9rpFH+AKYmfRBpkhsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqziu-0002AH-G7; Tue, 05 Feb 2019 12:21:08 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqzir-00029v-51
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 12:21:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 876DF80D;
 Tue,  5 Feb 2019 04:21:03 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 689463F675;
 Tue,  5 Feb 2019 04:21:02 -0800 (PST)
Subject: Re: [PATCH v2 1/5] KVM: arm/arm64: rename
 kvm_pmu_{enable/disable}_counter functions
To: Andrew Murray <andrew.murray@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>
References: <1549299218-44714-1-git-send-email-andrew.murray@arm.com>
 <1549299218-44714-2-git-send-email-andrew.murray@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <73b4e485-bc5f-d89f-6b01-fd0bc9a22989@arm.com>
Date: Tue, 5 Feb 2019 12:21:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1549299218-44714-2-git-send-email-andrew.murray@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_042105_206673_96AAD043 
X-CRM114-Status: GOOD (  19.29  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 suzuki.poulose@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 04/02/2019 16:53, Andrew Murray wrote:
> The kvm_pmu_{enable/disable}_counter functions can enabled/disable
> multiple counters at once as they operate on a bitmask. Let's
> make this clearer by renaming the function.
>> Signed-off-by: Andrew Murray <andrew.murray@arm.com>


Reviewed-by: Julien Thierry <julien.thierry@arm.com>

> ---
>  arch/arm64/kvm/sys_regs.c |  4 ++--
>  include/kvm/arm_pmu.h     |  8 ++++----
>  virt/kvm/arm/pmu.c        | 12 ++++++------
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index e3e3722..4a6fbac 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -857,11 +857,11 @@ static bool access_pmcnten(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  		if (r->Op2 & 0x1) {
>  			/* accessing PMCNTENSET_EL0 */
>  			__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) |= val;
> -			kvm_pmu_enable_counter(vcpu, val);
> +			kvm_pmu_enable_counter_mask(vcpu, val);
>  		} else {
>  			/* accessing PMCNTENCLR_EL0 */
>  			__vcpu_sys_reg(vcpu, PMCNTENSET_EL0) &= ~val;
> -			kvm_pmu_disable_counter(vcpu, val);
> +			kvm_pmu_disable_counter_mask(vcpu, val);
>  		}
>  	} else {
>  		p->regval = __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask;
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index f87fe20..b73f31b 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -46,8 +46,8 @@ void kvm_pmu_set_counter_value(struct kvm_vcpu *vcpu, u64 select_idx, u64 val);
>  u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu);
>  void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu);
>  void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu);
> -void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val);
> -void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val);
> +void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val);
> +void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val);
>  void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu);
>  void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu);
>  bool kvm_pmu_should_notify_user(struct kvm_vcpu *vcpu);
> @@ -83,8 +83,8 @@ static inline u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
>  }
>  static inline void kvm_pmu_vcpu_reset(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu) {}
> -static inline void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val) {}
> -static inline void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val) {}
> +static inline void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val) {}
> +static inline void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val) {}
>  static inline void kvm_pmu_flush_hwstate(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_pmu_sync_hwstate(struct kvm_vcpu *vcpu) {}
>  static inline bool kvm_pmu_should_notify_user(struct kvm_vcpu *vcpu)
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> index 1c5b76c..c5a722a 100644
> --- a/virt/kvm/arm/pmu.c
> +++ b/virt/kvm/arm/pmu.c
> @@ -135,13 +135,13 @@ u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
>  }
>  
>  /**
> - * kvm_pmu_enable_counter - enable selected PMU counter
> + * kvm_pmu_enable_counter_mask - enable selected PMU counters
>   * @vcpu: The vcpu pointer
>   * @val: the value guest writes to PMCNTENSET register
>   *
>   * Call perf_event_enable to start counting the perf event
>   */
> -void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val)
> +void kvm_pmu_enable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
>  {
>  	int i;
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> @@ -164,13 +164,13 @@ void kvm_pmu_enable_counter(struct kvm_vcpu *vcpu, u64 val)
>  }
>  
>  /**
> - * kvm_pmu_disable_counter - disable selected PMU counter
> + * kvm_pmu_disable_counter_mask - disable selected PMU counters
>   * @vcpu: The vcpu pointer
>   * @val: the value guest writes to PMCNTENCLR register
>   *
>   * Call perf_event_disable to stop counting the perf event
>   */
> -void kvm_pmu_disable_counter(struct kvm_vcpu *vcpu, u64 val)
> +void kvm_pmu_disable_counter_mask(struct kvm_vcpu *vcpu, u64 val)
>  {
>  	int i;
>  	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> @@ -347,10 +347,10 @@ void kvm_pmu_handle_pmcr(struct kvm_vcpu *vcpu, u64 val)
>  
>  	mask = kvm_pmu_valid_counter_mask(vcpu);
>  	if (val & ARMV8_PMU_PMCR_E) {
> -		kvm_pmu_enable_counter(vcpu,
> +		kvm_pmu_enable_counter_mask(vcpu,
>  		       __vcpu_sys_reg(vcpu, PMCNTENSET_EL0) & mask);
>  	} else {
> -		kvm_pmu_disable_counter(vcpu, mask);
> +		kvm_pmu_disable_counter_mask(vcpu, mask);
>  	}
>  
>  	if (val & ARMV8_PMU_PMCR_C)
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
