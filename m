Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54136C32789
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234422148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gPFoS8ZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234422148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8/ZzYweevwyRIRGuGTj6ZvO6vyU/ft7kVZKBHuOQkto=; b=gPFoS8ZV4gVkmr
	BVE/JpjsfKpAW/Wt3qddbP2RhMamwCytcCLUb76FQaw9q/sgtA8NlTJQVpCb0IkzCPo6L20PRAieX
	6dYAsjf3TbEmeuU/3Uz2euHquBeWNFQJYNpPPMYHhL4crfmROwPVJs4NnpaeC8euS+KJk/Vv8Ys4r
	xZKKGtMYjaZVou00klhb2S7S66jg1jstXHNQyQDSCUcAqh8EaP52MFReE9mX3el78jn7uyDj4oa9h
	R6gxaB/T9AoGaI3QW7dicsrGVsEGTOqYeTsNHNsMA0b5Gv67FXo4r1RdrCi9Nx4OU8MAOL0B/+v3v
	wJw3OwUckvNeMGOttZnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPsD-0007yH-So; Thu, 29 Nov 2018 17:13:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPs0-0007vV-Va
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:12:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24EFEA78;
 Thu, 29 Nov 2018 09:12:46 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3408F3F59C;
 Thu, 29 Nov 2018 09:12:44 -0800 (PST)
Date: Thu, 29 Nov 2018 17:12:32 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v6 03/24] arm64: cpufeature: Add cpufeature for IRQ
 priority masking
Message-ID: <20181129171231.ho5a3hx3ig3skm2x@lakrids.cambridge.arm.com>
References: <1542023835-21446-1-git-send-email-julien.thierry@arm.com>
 <1542023835-21446-4-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1542023835-21446-4-git-send-email-julien.thierry@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_091257_109889_1CC4F7C7 
X-CRM114-Status: GOOD (  20.08  )
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
Cc: daniel.thompson@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com,
 joel@joelfernandes.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 12, 2018 at 11:56:54AM +0000, Julien Thierry wrote:
> Add a cpufeature indicating whether a cpu supports masking interrupts
> by priority.
> 
> The feature will be properly enabled in a later patch.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/cpucaps.h    |  3 ++-
>  arch/arm64/include/asm/cpufeature.h |  6 ++++++
>  arch/arm64/kernel/cpufeature.c      | 23 +++++++++++++++++++++++
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 6e2d254..f367e5c 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -54,7 +54,8 @@
>  #define ARM64_HAS_CRC32				33
>  #define ARM64_SSBS				34
>  #define ARM64_WORKAROUND_1188873		35
> +#define ARM64_HAS_IRQ_PRIO_MASKING		36
>  
> -#define ARM64_NCAPS				36
> +#define ARM64_NCAPS				37
>  
>  #endif /* __ASM_CPUCAPS_H */
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 7e2ec64..a6e063f 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -514,6 +514,12 @@ static inline bool system_supports_cnp(void)
>  		cpus_have_const_cap(ARM64_HAS_CNP);
>  }
>  
> +static inline bool system_supports_irq_prio_masking(void)
> +{
> +	return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) &&
> +	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
> +}

This should probably be s/supports/uses/.

With that:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> +
>  #define ARM64_SSBD_UNKNOWN		-1
>  #define ARM64_SSBD_FORCE_DISABLE	0
>  #define ARM64_SSBD_KERNEL		1
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 03a9d96..1b5b553 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1145,6 +1145,14 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
>  }
>  #endif /* CONFIG_ARM64_RAS_EXTN */
>  
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
> +static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
> +				   int scope)
> +{
> +	return false;
> +}
> +#endif
> +
>  static const struct arm64_cpu_capabilities arm64_features[] = {
>  	{
>  		.desc = "GIC system register CPU interface",
> @@ -1368,6 +1376,21 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
>  		.cpu_enable = cpu_enable_cnp,
>  	},
>  #endif
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
> +	{
> +		/*
> +		 * Depends on having GICv3
> +		 */
> +		.desc = "IRQ priority masking",
> +		.capability = ARM64_HAS_IRQ_PRIO_MASKING,
> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
> +		.matches = can_use_gic_priorities,
> +		.sys_reg = SYS_ID_AA64PFR0_EL1,
> +		.field_pos = ID_AA64PFR0_GIC_SHIFT,
> +		.sign = FTR_UNSIGNED,
> +		.min_field_value = 1,
> +	},
> +#endif
>  	{},
>  };
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
