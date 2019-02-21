Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC24C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:28:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF6A20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oluuqCFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF6A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ju2kWulI8iwk6P4zZxYRChDcwR1E+Styn9ezULkuPbk=; b=oluuqCFq6j/+i4
	Xm3Z0o0SxLCwuRa6R1qP5R9Hb5AbsiRUMz0gO4BVoNFap3P7jshShHt0VBGqp8kRA4w+UM7MFgS3v
	ef7JRI6BgYHAgFLnOLKP6E4ZmVGlOmdmswUOwkM07QJvuxSbwphP3QQnMFTTcZSmxNoCQXX5zL6Re
	ag/zQMASIBM75SwHp9fhk1FeOwvyaK0tb4fZhERl8GCeNDyDSw4yOQGo0AiRevi6pQAUYi1vmJdf/
	LOFeQSdOTXvgV1bBW7Vo9sc+ZK2mbWzrbFSEQUoE+CM6FGakRtRA/fknxi8GHLpN8CJJJQVFWguXV
	pp4tYbICU3B0mpOwTp0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwrCw-0004n0-Rg; Thu, 21 Feb 2019 16:28:22 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwrCs-0004k6-If
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 16:28:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CB3DA78;
 Thu, 21 Feb 2019 08:28:18 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 250C23F690;
 Thu, 21 Feb 2019 08:28:12 -0800 (PST)
Subject: Re: [PATCH v5 19/26] KVM: arm64: Enumerate SVE register indices for
 KVM_GET_REG_LIST
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-20-git-send-email-Dave.Martin@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <2b50c4cd-d729-4109-9e90-66a2a7b94cf9@arm.com>
Date: Thu, 21 Feb 2019 16:28:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-20-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_082818_768382_A89F072B 
X-CRM114-Status: GOOD (  23.92  )
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
Cc: Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 18/02/2019 19:52, Dave Martin wrote:
> This patch includes the SVE register IDs in the list returned by
> KVM_GET_REG_LIST, as appropriate.
> 
> On a non-SVE-enabled vcpu, no new IDs are added.
> 
> On an SVE-enabled vcpu, IDs for the FPSIMD V-registers are removed
> from the list, since userspace is required to access the Z-
> registers instead to access their context.  For the variably-sized
> SVE registers, the appropriate set of slice IDs are enumerated,
> depending on the maximum vector length for the vcpu.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Julien Thierry <julien.thiery@arm.com>

> 
> ---
> 
> Changes since v4:
> 
>  * Drop KVM_SVE_SLICES(), which is no longer used due to the dropping of
>    register multi-slice support from the series.
> 
>  * Drop register multi-slice support.
> ---
>  arch/arm64/kvm/guest.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 8cfa889..4a2ad60 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -366,6 +366,14 @@ static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
>  			continue;
>  		}
>  
> +		/*
> +		 * The KVM_REG_ARM64_SVE regs must be used instead of
> +		 * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
> +		 * SVE-enabled vcpus:
> +		 */
> +		if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(i))
> +			continue;
> +
>  		if (uind) {
>  			if (put_user(reg, *uind))
>  				return -EFAULT;
> @@ -436,6 +444,44 @@ static int get_timer_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	return copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)) ? -EFAULT : 0;
>  }
>  
> +static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
> +{
> +	/* Only the first slice ever exists, for now */
> +	const unsigned int slices = 1;
> +
> +	if (!vcpu_has_sve(vcpu))
> +		return 0;
> +
> +	return slices * (SVE_NUM_PREGS + SVE_NUM_ZREGS + 1 /* FFR */);
> +}
> +
> +static int copy_sve_reg_indices(const struct kvm_vcpu *vcpu, u64 __user **uind)
> +{
> +	/* Only the first slice ever exists, for now */
> +	const unsigned int slices = 1;
> +	unsigned int i, n;
> +
> +	if (!vcpu_has_sve(vcpu))
> +		return 0;
> +
> +	for (i = 0; i < slices; i++) {
> +		for (n = 0; n < SVE_NUM_ZREGS; n++) {
> +			if (put_user(KVM_REG_ARM64_SVE_ZREG(n, i), (*uind)++))
> +				return -EFAULT;
> +		}
> +
> +		for (n = 0; n < SVE_NUM_PREGS; n++) {
> +			if (put_user(KVM_REG_ARM64_SVE_PREG(n, i), (*uind)++))
> +				return -EFAULT;
> +		}
> +
> +		if (put_user(KVM_REG_ARM64_SVE_FFR(i), (*uind)++))
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * kvm_arm_num_regs - how many registers do we present via KVM_GET_ONE_REG
>   *
> @@ -446,6 +492,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
>  	unsigned long res = 0;
>  
>  	res += num_core_regs(vcpu);
> +	res += num_sve_regs(vcpu);
>  	res += kvm_arm_num_sys_reg_descs(vcpu);
>  	res += kvm_arm_get_fw_num_regs(vcpu);
>  	res += NUM_TIMER_REGS;
> @@ -466,6 +513,10 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = copy_sve_reg_indices(vcpu, &uindices);
> +	if (ret)
> +		return ret;
> +
>  	ret = kvm_arm_copy_fw_reg_indices(vcpu, uindices);
>  	if (ret)
>  		return ret;
> 

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
