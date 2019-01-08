Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73890C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:52:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427B5206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fX9PHGu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427B5206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T5Q0neldaPredrwDziadoh2+jy3SEcVWGMcx72aTRGM=; b=fX9PHGu590+mArJnz5pzEbn1c
	TeyNZvJvNzto1X4IsXYbbBn7f0CGh48yXfhG+4NYZp3TBBRzmIXBOo9f2OBLptonAGZi5QEVgOsdb
	ii+7Vgc8EkvAfLQeWk+LJ34qMRu+v99X6DZdBO/FmoEpzyNG/PguPH6rv/Ioy/iOQGr7UAO3MPt4w
	Cgwx10Twz1Rt9bIiOnn9UyrZtPkBgv/Vi5xUOsm9NSQUyN7MbhfgOaoCXfkrMATiKyza5QJ/c+29N
	4bIjgIPjridaUpX5hpbH6KS2oS6Hjn0A4rFv1+b4rxzKb39TGXf6l/9MYntX5lC+37nMUjKhgB/wy
	1nHkSqHCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggsjX-0005r8-3x; Tue, 08 Jan 2019 14:51:59 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggsjS-0005qH-JU
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 14:51:56 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 863C680D;
 Tue,  8 Jan 2019 06:51:52 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B50543F5AF;
 Tue,  8 Jan 2019 06:51:50 -0800 (PST)
Subject: Re: [PATCH v8 15/26] arm64: alternative: Apply alternatives early in
 boot process
To: Julien Thierry <julien.thierry@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-16-git-send-email-julien.thierry@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <cec17e88-d199-abb4-4919-deff7182a26f@arm.com>
Date: Tue, 8 Jan 2019 14:51:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1546956464-48825-16-git-send-email-julien.thierry@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_065154_655391_BA6F2D04 
X-CRM114-Status: GOOD (  26.73  )
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
Cc: mark.rutland@arm.com, daniel.thompson@linaro.org, marc.zyngier@arm.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Julien,

On 08/01/2019 14:07, Julien Thierry wrote:
> From: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Currently alternatives are applied very late in the boot process (and
> a long time after we enable scheduling). Some alternative sequences,
> such as those that alter the way CPU context is stored, must be applied
> much earlier in the boot sequence.
> 
> Introduce apply_boot_alternatives() to allow some alternatives to be
> applied immediately after we detect the CPU features of the boot CPU.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> [julien.thierry@arm.com: rename to fit new cpufeature framework better,
> 			 apply BOOT_SCOPE feature early in boot]
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arch/arm64/include/asm/alternative.h |  1 +
>   arch/arm64/include/asm/cpufeature.h  |  4 ++++
>   arch/arm64/kernel/alternative.c      | 43 +++++++++++++++++++++++++++++++-----
>   arch/arm64/kernel/cpufeature.c       |  6 +++++
>   arch/arm64/kernel/smp.c              |  7 ++++++
>   5 files changed, 56 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> index 9806a23..b9f8d78 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -25,6 +25,7 @@ struct alt_instr {
>   typedef void (*alternative_cb_t)(struct alt_instr *alt,
>   				 __le32 *origptr, __le32 *updptr, int nr_inst);
>   
> +void __init apply_boot_alternatives(void);
>   void __init apply_alternatives_all(void);
>   bool alternative_is_applied(u16 cpufeature);
>   
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 89c3f31..e505e1f 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -391,6 +391,10 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
>   extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
>   extern struct static_key_false arm64_const_caps_ready;
>   
> +/* ARM64 CAPS + alternative_cb */
> +#define ARM64_NPATCHABLE (ARM64_NCAPS + 1)
> +extern DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
> +
>   #define for_each_available_cap(cap)		\
>   	for_each_set_bit(cap, cpu_hwcaps, ARM64_NCAPS)
>   
> diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
> index c947d22..a9b4677 100644
> --- a/arch/arm64/kernel/alternative.c
> +++ b/arch/arm64/kernel/alternative.c
> @@ -155,7 +155,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
>   	} while (cur += d_size, cur < end);
>   }
>   
> -static void __apply_alternatives(void *alt_region, bool is_module)
> +static void __apply_alternatives(void *alt_region,  bool is_module,
> +				 unsigned long *feature_mask)
>   {
>   	struct alt_instr *alt;
>   	struct alt_region *region = alt_region;
> @@ -165,6 +166,9 @@ static void __apply_alternatives(void *alt_region, bool is_module)
>   	for (alt = region->begin; alt < region->end; alt++) {
>   		int nr_inst;
>   
> +		if (!test_bit(alt->cpufeature, feature_mask))
> +			continue;
> +
>   		/* Use ARM64_CB_PATCH as an unconditional patch */
>   		if (alt->cpufeature < ARM64_CB_PATCH &&
>   		    !cpus_have_cap(alt->cpufeature))
> @@ -203,8 +207,11 @@ static void __apply_alternatives(void *alt_region, bool is_module)
>   		__flush_icache_all();
>   		isb();
>   
> -		/* We applied all that was available */
> -		bitmap_copy(applied_alternatives, cpu_hwcaps, ARM64_NCAPS);
> +		/* Ignore ARM64_CB bit from feature mask */
> +		bitmap_or(applied_alternatives, applied_alternatives,
> +			  feature_mask, ARM64_NCAPS);
> +		bitmap_and(applied_alternatives, applied_alternatives,
> +			   cpu_hwcaps, ARM64_NCAPS);
>   	}
>   }
>   
> @@ -225,8 +232,13 @@ static int __apply_alternatives_multi_stop(void *unused)
>   			cpu_relax();
>   		isb();
>   	} else {
> +		DECLARE_BITMAP(remaining_capabilities, ARM64_NPATCHABLE);
> +
> +		bitmap_complement(remaining_capabilities, boot_capabilities,
> +				  ARM64_NPATCHABLE);
> +
>   		BUG_ON(all_alternatives_applied);
> -		__apply_alternatives(&region, false);
> +		__apply_alternatives(&region, false, remaining_capabilities);
>   		/* Barriers provided by the cache flushing */
>   		WRITE_ONCE(all_alternatives_applied, 1);
>   	}
> @@ -240,6 +252,24 @@ void __init apply_alternatives_all(void)
>   	stop_machine(__apply_alternatives_multi_stop, NULL, cpu_online_mask);
>   }
>   
> +/*
> + * This is called very early in the boot process (directly after we run
> + * a feature detect on the boot CPU). No need to worry about other CPUs
> + * here.
> + */
> +void __init apply_boot_alternatives(void)
> +{
> +	struct alt_region region = {
> +		.begin	= (struct alt_instr *)__alt_instructions,
> +		.end	= (struct alt_instr *)__alt_instructions_end,
> +	};
> +
> +	/* If called on non-boot cpu things could go wrong */
> +	WARN_ON(smp_processor_id() != 0);
> +
> +	__apply_alternatives(&region, false, &boot_capabilities[0]);
> +}
> +
>   #ifdef CONFIG_MODULES
>   void apply_alternatives_module(void *start, size_t length)
>   {
> @@ -247,7 +277,10 @@ void apply_alternatives_module(void *start, size_t length)
>   		.begin	= start,
>   		.end	= start + length,
>   	};
> +	DECLARE_BITMAP(all_capabilities, ARM64_NPATCHABLE);
> +
> +	bitmap_fill(all_capabilities, ARM64_NPATCHABLE);
>   
> -	__apply_alternatives(&region, true);
> +	__apply_alternatives(&region, true, &all_capabilities[0]);
>   }
>   #endif
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 84fa5be..71c8d4f 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -54,6 +54,9 @@
>   EXPORT_SYMBOL(cpu_hwcaps);
>   static struct arm64_cpu_capabilities const __ro_after_init *cpu_hwcaps_ptrs[ARM64_NCAPS];
>   
> +/* Need also bit for ARM64_CB_PATCH */
> +DECLARE_BITMAP(boot_capabilities, ARM64_NPATCHABLE);
> +
>   /*
>    * Flag to indicate if we have computed the system wide
>    * capabilities based on the boot time active CPUs. This
> @@ -1672,6 +1675,9 @@ static void update_cpu_capabilities(u16 scope_mask)
>   		if (caps->desc)
>   			pr_info("detected: %s\n", caps->desc);
>   		cpus_set_cap(caps->capability);
> +
> +		if (caps->type & SCOPE_BOOT_CPU)

You may want to do :
		if (scope_mask & SCOPE_BOOT_CPU)

for a tighter check to ensure this doesn't update the boot_capabilities
after we have applied the boot_scope alternatives and miss applying the
alternatives for those, should someone add a multi-scope (i.e SCOPE_BOOT_CPU and
something else) capability (even by mistake).

With that:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
