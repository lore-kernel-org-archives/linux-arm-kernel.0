Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E7DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:13:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B672146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P1JDKHmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B672146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PRuTRLGtIFGspOphCOumL0gdejjf1Ev5RLOqe0GWRVM=; b=P1JDKHmjZfYnqG
	87a5NorM/FMIwRbSodBkPevM6oAMZB/WkufaJK4/Fz1YtZnaD+T671XrA3kq88yLhTbZmmNJC62xo
	0oEppxkvnSpb+OsFGcwd0D0GY69Ogcd85Ss+RaQwLK+4NZriL8j+j1O4R8L5ol/5kJo94iXSxrwJy
	sympvE1x+SDTuwW4USqUdRna9rBLgzDDmRDy98FPGIPQNBQ5mO4OOP+kzFIUuDUOk3Dfach2reZch
	5VWnACz6+6IL3gwBSIYcJWUgq7eARV5L+7C8ybHcX9tBXQ5cGLDvGHtCnvT4Xs2rT77nUAjdMv6FC
	GnW3nGCLeTL8jzYNnpgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwPoA-0006h3-J3; Wed, 20 Feb 2019 11:12:58 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwPo7-0006fO-5n
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 11:12:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79A9CA78;
 Wed, 20 Feb 2019 03:12:53 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDC1A3F575;
 Wed, 20 Feb 2019 03:12:51 -0800 (PST)
Subject: Re: [PATCH v5 06/26] arm64/sve: Check SVE virtualisability
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-7-git-send-email-Dave.Martin@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <64764e35-c243-e642-a868-5b9e221813c7@arm.com>
Date: Wed, 20 Feb 2019 11:12:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-7-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_031255_229740_881EAA9D 
X-CRM114-Status: GOOD (  27.56  )
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

Hi Dave,

On 18/02/2019 19:52, Dave Martin wrote:
> Due to the way the effective SVE vector length is controlled and
> trapped at different exception levels, certain mismatches in the
> sets of vector lengths supported by different physical CPUs in the
> system may prevent straightforward virtualisation of SVE at parity
> with the host.
> 
> This patch analyses the extent to which SVE can be virtualised
> safely without interfering with migration of vcpus between physical
> CPUs, and rejects late secondary CPUs that would erode the
> situation further.
> 
> It is left up to KVM to decide what to do with this information.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/fpsimd.h |  1 +
>  arch/arm64/kernel/cpufeature.c  |  2 +-
>  arch/arm64/kernel/fpsimd.c      | 86 ++++++++++++++++++++++++++++++++++-------
>  3 files changed, 73 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
> index dd1ad39..964adc9 100644
> --- a/arch/arm64/include/asm/fpsimd.h
> +++ b/arch/arm64/include/asm/fpsimd.h
> @@ -87,6 +87,7 @@ extern void sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
>  extern u64 read_zcr_features(void);
>  
>  extern int __ro_after_init sve_max_vl;
> +extern int __ro_after_init sve_max_virtualisable_vl;
>  
>  #ifdef CONFIG_ARM64_SVE
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f6d84e2..5eaacb4 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1825,7 +1825,7 @@ static void verify_sve_features(void)
>  	unsigned int len = zcr & ZCR_ELx_LEN_MASK;
>  
>  	if (len < safe_len || sve_verify_vq_map()) {
> -		pr_crit("CPU%d: SVE: required vector length(s) missing\n",
> +		pr_crit("CPU%d: SVE: vector length support mismatch\n",
>  			smp_processor_id());
>  		cpu_die_early();
>  	}
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 62c37f0..64729e2 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include <linux/bitmap.h>
> +#include <linux/bitops.h>
>  #include <linux/bottom_half.h>
>  #include <linux/bug.h>
>  #include <linux/cache.h>
> @@ -48,6 +49,7 @@
>  #include <asm/sigcontext.h>
>  #include <asm/sysreg.h>
>  #include <asm/traps.h>
> +#include <asm/virt.h>
>  
>  #define FPEXC_IOF	(1 << 0)
>  #define FPEXC_DZF	(1 << 1)
> @@ -130,14 +132,18 @@ static int sve_default_vl = -1;
>  
>  /* Maximum supported vector length across all CPUs (initially poisoned) */
>  int __ro_after_init sve_max_vl = SVE_VL_MIN;
> +int __ro_after_init sve_max_virtualisable_vl = SVE_VL_MIN;
>  /* Set of available vector lengths, as vq_to_bit(vq): */
>  static __ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
> +/* Set of vector lengths present on at least one cpu: */
> +static __ro_after_init DECLARE_BITMAP(sve_vq_partial_map, SVE_VQ_MAX);
>  static void __percpu *efi_sve_state;
>  
>  #else /* ! CONFIG_ARM64_SVE */
>  
>  /* Dummy declaration for code that will be optimised out: */
>  extern __ro_after_init DECLARE_BITMAP(sve_vq_map, SVE_VQ_MAX);
> +extern __ro_after_init DECLARE_BITMAP(sve_vq_partial_map, SVE_VQ_MAX);
>  extern void __percpu *efi_sve_state;
>  
>  #endif /* ! CONFIG_ARM64_SVE */
> @@ -623,12 +629,6 @@ int sve_get_current_vl(void)
>  	return sve_prctl_status(0);
>  }
>  
> -/*
> - * Bitmap for temporary storage of the per-CPU set of supported vector lengths
> - * during secondary boot.
> - */
> -static DECLARE_BITMAP(sve_secondary_vq_map, SVE_VQ_MAX);
> -
>  static void sve_probe_vqs(DECLARE_BITMAP(map, SVE_VQ_MAX))
>  {
>  	unsigned int vq, vl;
> @@ -650,6 +650,7 @@ static void sve_probe_vqs(DECLARE_BITMAP(map, SVE_VQ_MAX))
>  void __init sve_init_vq_map(void)
>  {
>  	sve_probe_vqs(sve_vq_map);
> +	bitmap_copy(sve_vq_partial_map, sve_vq_map, SVE_VQ_MAX);
>  }
>  
>  /*
> @@ -658,25 +659,58 @@ void __init sve_init_vq_map(void)
>   */
>  void sve_update_vq_map(void)
>  {
> -	sve_probe_vqs(sve_secondary_vq_map);
> -	bitmap_and(sve_vq_map, sve_vq_map, sve_secondary_vq_map, SVE_VQ_MAX);
> +	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
> +
> +	sve_probe_vqs(tmp_map);
> +	bitmap_and(sve_vq_map, sve_vq_map, tmp_map, SVE_VQ_MAX);
> +	bitmap_or(sve_vq_partial_map, sve_vq_partial_map, tmp_map, SVE_VQ_MAX);
>  }
>  
>  /* Check whether the current CPU supports all VQs in the committed set */
>  int sve_verify_vq_map(void)
>  {
> -	int ret = 0;
> +	DECLARE_BITMAP(tmp_map, SVE_VQ_MAX);
> +	unsigned long b;
>  
> -	sve_probe_vqs(sve_secondary_vq_map);
> -	bitmap_andnot(sve_secondary_vq_map, sve_vq_map, sve_secondary_vq_map,
> -		      SVE_VQ_MAX);
> -	if (!bitmap_empty(sve_secondary_vq_map, SVE_VQ_MAX)) {
> +	sve_probe_vqs(tmp_map);
> +
> +	bitmap_complement(tmp_map, tmp_map, SVE_VQ_MAX);
> +	if (bitmap_intersects(tmp_map, sve_vq_map, SVE_VQ_MAX)) {
>  		pr_warn("SVE: cpu%d: Required vector length(s) missing\n",
>  			smp_processor_id());
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}
>  
> -	return ret;
> +	if (!IS_ENABLED(CONFIG_KVM) || !is_hyp_mode_available())
> +		return 0;
> +
> +	/*
> +	 * For KVM, it is necessary to ensure that this CPU doesn't
> +	 * support any vector length that guests may have probed as
> +	 * unsupported.
> +	 */
> +
> +	/* Recover the set of supported VQs: */
> +	bitmap_complement(tmp_map, tmp_map, SVE_VQ_MAX);
> +	/* Find VQs supported that are not globally supported: */
> +	bitmap_andnot(tmp_map, tmp_map, sve_vq_map, SVE_VQ_MAX);
> +
> +	/* Find the lowest such VQ, if any: */
> +	b = find_last_bit(tmp_map, SVE_VQ_MAX);
> +	if (b >= SVE_VQ_MAX)
> +		return 0; /* no mismatches */
> +
> +	/*
> +	 * Mismatches above sve_max_virtualisable_vl are fine, since
> +	 * no guest is allowed to configure ZCR_EL2.LEN to exceed this:
> +	 */
> +	if (sve_vl_from_vq(bit_to_vq(b)) <= sve_max_virtualisable_vl) {
> +		pr_warn("SVE: cpu%d: Unsupported vector length(s) present\n",

Nit: might be good to specify that the vector length is unsupported for
virtualisation.

Also, since KVM is the one deciding what to do with the information,
should we have a warning here? But I can understand that knowing which
CPUs are introducing unsupported vector length, maybe using pr_devel()
instead of pr_warn()


In any case, the logic looks good to me:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
