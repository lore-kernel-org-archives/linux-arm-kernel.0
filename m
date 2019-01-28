Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455FAC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:56:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C82E2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c6aR0Ou9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C82E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hJns07OzEVk18Zyb27K83uyylWYwmTy0MzzrkGytM4A=; b=c6aR0Ou9rWNXbs
	kgnM02WoXotMloJeFQHWwT4WqSqbqtcDGsG9i3C5+uExCNlqt0J8FPJDOKrKk8sPuZWyuUMKYz1T6
	MB53dVKvFJXgudpoJZ41SYCGTqG8VGAKVs6qXzs69MgNbpxvLoQMEMGoK9QMtVFfGRHeMPjQmUok5
	gDFn0K6St0VuvTRD5NiFYo2JXn7jPWmb+FRScHCssDaE4Ae53t3c/RQCAVsvuB4b1MYKhx3aBFKo8
	opKtvalkShuAu0MyDCKAddfNsBVy1IOhGKMp4xIlIR3xmSRg3DpMw2a/36kSFv9YyTha213SNIO0v
	JKS/RbTJuPZLrb7DhGsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go8Ko-00058P-98; Mon, 28 Jan 2019 14:56:26 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go8Kk-00057o-Te
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 14:56:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B05180D;
 Mon, 28 Jan 2019 06:56:22 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380063F589;
 Mon, 28 Jan 2019 06:56:20 -0800 (PST)
Subject: Re: [kvmtool PATCH v5 6/6] arm/kvm: arm64: Add a vcpu feature for
 pointer authentication
To: Amit Daniel Kachhap <amit.kachhap@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-7-git-send-email-amit.kachhap@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <175e884b-928e-364b-c784-be2edbcf566d@arm.com>
Date: Mon, 28 Jan 2019 14:56:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548658727-14271-7-git-send-email-amit.kachhap@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_065622_961824_2FA81E3C 
X-CRM114-Status: GOOD (  18.99  )
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
 Kristina Martsenko <kristina.martsenko@arm.com>, kvmarm@lists.cs.columbia.edu,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Amit,

On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
> This is a runtime feature and can be enabled by --ptrauth option.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arm/aarch32/include/kvm/kvm-cpu-arch.h    | 2 ++
>  arm/aarch64/include/asm/kvm.h             | 3 +++
>  arm/aarch64/include/kvm/kvm-arch.h        | 1 +
>  arm/aarch64/include/kvm/kvm-config-arch.h | 4 +++-
>  arm/aarch64/include/kvm/kvm-cpu-arch.h    | 2 ++
>  arm/aarch64/kvm-cpu.c                     | 5 +++++
>  arm/include/arm-common/kvm-config-arch.h  | 1 +
>  arm/kvm-cpu.c                             | 7 +++++++
>  include/linux/kvm.h                       | 1 +
>  9 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arm/aarch32/include/kvm/kvm-cpu-arch.h b/arm/aarch32/include/kvm/kvm-cpu-arch.h
> index d28ea67..5779767 100644
> --- a/arm/aarch32/include/kvm/kvm-cpu-arch.h
> +++ b/arm/aarch32/include/kvm/kvm-cpu-arch.h
> @@ -13,4 +13,6 @@
>  #define ARM_CPU_ID		0, 0, 0
>  #define ARM_CPU_ID_MPIDR	5
>  
> +unsigned int kvm__cpu_ptrauth_get_feature(void) {}
> +

You probably want a return statement for this function.

>  #endif /* KVM__KVM_CPU_ARCH_H */
> diff --git a/arm/aarch64/include/asm/kvm.h b/arm/aarch64/include/asm/kvm.h
> index c286035..0fd183d 100644
> --- a/arm/aarch64/include/asm/kvm.h
> +++ b/arm/aarch64/include/asm/kvm.h
> @@ -98,6 +98,9 @@ struct kvm_regs {
>  #define KVM_ARM_VCPU_PSCI_0_2		2 /* CPU uses PSCI v0.2 */
>  #define KVM_ARM_VCPU_PMU_V3		3 /* Support guest PMUv3 */
>  
> +/* CPU uses address authentication and A key */
> +#define KVM_ARM_VCPU_PTRAUTH		4
> +
>  struct kvm_vcpu_init {
>  	__u32 target;
>  	__u32 features[7];
> diff --git a/arm/aarch64/include/kvm/kvm-arch.h b/arm/aarch64/include/kvm/kvm-arch.h
> index 9de623a..bd566cb 100644
> --- a/arm/aarch64/include/kvm/kvm-arch.h
> +++ b/arm/aarch64/include/kvm/kvm-arch.h
> @@ -11,4 +11,5 @@
>  
>  #include "arm-common/kvm-arch.h"
>  
> +
>  #endif /* KVM__KVM_ARCH_H */
> diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
> index 04be43d..2074684 100644
> --- a/arm/aarch64/include/kvm/kvm-config-arch.h
> +++ b/arm/aarch64/include/kvm/kvm-config-arch.h
> @@ -8,7 +8,9 @@
>  			"Create PMUv3 device"),				\
>  	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
>  			"Specify random seed for Kernel Address Space "	\
> -			"Layout Randomization (KASLR)"),
> +			"Layout Randomization (KASLR)"),		\
> +	OPT_BOOLEAN('\0', "ptrauth", &(cfg)->has_ptrauth,		\
> +			"Enable address authentication"),
>  
>  #include "arm-common/kvm-config-arch.h"
>  
> diff --git a/arm/aarch64/include/kvm/kvm-cpu-arch.h b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> index a9d8563..f7b64b7 100644
> --- a/arm/aarch64/include/kvm/kvm-cpu-arch.h
> +++ b/arm/aarch64/include/kvm/kvm-cpu-arch.h
> @@ -17,4 +17,6 @@
>  #define ARM_CPU_CTRL		3, 0, 1, 0
>  #define ARM_CPU_CTRL_SCTLR_EL1	0
>  
> +unsigned int kvm__cpu_ptrauth_get_feature(void);
> +>  #endif /* KVM__KVM_CPU_ARCH_H */
> diff --git a/arm/aarch64/kvm-cpu.c b/arm/aarch64/kvm-cpu.c
> index 1b29374..10da2cb 100644
> --- a/arm/aarch64/kvm-cpu.c
> +++ b/arm/aarch64/kvm-cpu.c
> @@ -123,6 +123,11 @@ void kvm_cpu__reset_vcpu(struct kvm_cpu *vcpu)
>  		return reset_vcpu_aarch64(vcpu);
>  }
>  
> +unsigned int kvm__cpu_ptrauth_get_feature(void)
> +{
> +	return (1UL << KVM_ARM_VCPU_PTRAUTH);
> +}
> +

Couldn't this be a simple:
#define PTRAUTH_FEATURE (1UL << KVM_ARM_VCPU_PTRAUTH)

And just define it to 0 for the aarch32 side?

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
