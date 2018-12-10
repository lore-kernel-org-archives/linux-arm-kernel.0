Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB630C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:40:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857822082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fHQfcTD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857822082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CHo2gyrvdTpsFEc1bn2gD+opffzH8JCdeGmaGpcvahg=; b=fHQfcTD+hN/BGv
	ey1UrPzsgL3pE7j4hmuIwN9AqXM95L84UDNkUxDtG2sb0HfpHqz5XHNWeLyV+WrAecl/9INvXnlcR
	W1CAE6wQkh7jpjTZ8/A9gXngwTsbrG2b3E7nUmsh5O8ugtPegAh6zCkVqCX/u/XVyJw2B5cB0Y6f+
	T0ed2W+94Ymq2/QxQcnUgW7bOFgHvEDp/G/2aFmhrrz8JSuoFYhuRmp1hewhnJGGaij4qiPvV4ZOE
	RHSov9hF2CyTV2T0JWWg6TC7EFZOvfYrTOT03OaIIGNDhs4Pg87I/1rvfRdDhbwJbIWEJdXtoBvTs
	duSIm4g9bwKl4SulbP5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWIyo-0003h4-Lc; Mon, 10 Dec 2018 10:40:02 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWIyk-0003g7-WD
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:40:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E659A1596;
 Mon, 10 Dec 2018 02:39:47 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C3153F6A8;
 Mon, 10 Dec 2018 02:39:46 -0800 (PST)
Date: Mon, 10 Dec 2018 10:39:44 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 05/12] KVM: arm64: Implement PV_FEATURES call
Message-ID: <20181210103943.g5txylpjvfxdolpi@lakrids.cambridge.arm.com>
References: <20181128144527.44710-1-steven.price@arm.com>
 <20181128144527.44710-6-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128144527.44710-6-steven.price@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_023959_078656_30445570 
X-CRM114-Status: GOOD (  21.90  )
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
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 02:45:20PM +0000, Steven Price wrote:
> This provides a mechanism for querying which paravirtualized features
> are available in this hypervisor.
> 
> Also add the header file which defines the ABI for the paravirtualized
> clock features we're about to add.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/include/asm/pvclock-abi.h | 32 ++++++++++++++++++++++++++++
>  include/kvm/arm_pv.h                 | 28 ++++++++++++++++++++++++
>  include/linux/arm-smccc.h            |  1 +
>  virt/kvm/arm/hypercalls.c            |  9 ++++++++
>  4 files changed, 70 insertions(+)
>  create mode 100644 arch/arm64/include/asm/pvclock-abi.h
>  create mode 100644 include/kvm/arm_pv.h
> 
> diff --git a/arch/arm64/include/asm/pvclock-abi.h b/arch/arm64/include/asm/pvclock-abi.h
> new file mode 100644
> index 000000000000..64ce041c8922
> --- /dev/null
> +++ b/arch/arm64/include/asm/pvclock-abi.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2018 Arm Ltd. */
> +
> +#ifndef __ASM_PVCLOCK_ABI_H
> +#define __ASM_PVCLOCK_ABI_H
> +
> +#include <kvm/arm_pv.h>
> +
> +struct pvclock_vm_time_info {
> +	__le32 revision;
> +	__le32 attributes;
> +	__le64 sequence_number;
> +	__le64 scale_mult;
> +	__le32 shift;
> +	__le32 reserved;
> +	__le64 native_freq;
> +	__le64 pv_freq;
> +	__le64 div_by_pv_freq_mult;
> +} __packed;
> +
> +struct pvclock_vcpu_stolen_time_info {
> +	__le32 revision;
> +	__le32 attributes;
> +	__le64 stolen_time;
> +	/* Structure must be 64 byte aligned, pad to that size */
> +	u8 padding[48];
> +} __packed;
> +
> +#define PV_VM_TIME_NOT_SUPPORTED	-1
> +#define PV_VM_TIME_INVALID_PARAMETERS	-2

Could you please add a comment describing that these are defined in ARM
DEN0057A?

> +
> +#endif
> diff --git a/include/kvm/arm_pv.h b/include/kvm/arm_pv.h
> new file mode 100644
> index 000000000000..19d2dafff31a
> --- /dev/null
> +++ b/include/kvm/arm_pv.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * Copyright (C) 2018 Arm Ltd.
> + */
> +
> +#ifndef __KVM_ARM_PV_H
> +#define __KVM_ARM_PV_H
> +
> +#include <linux/arm-smccc.h>
> +
> +#define ARM_SMCCC_HV_PV_FEATURES					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> +			   ARM_SMCCC_SMC_64,			\
> +			   ARM_SMCCC_OWNER_HYP_STANDARD,	\
> +			   0x20)
> +
> +#define ARM_SMCCC_HV_PV_TIME_LPT					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> +			   ARM_SMCCC_SMC_64,			\
> +			   ARM_SMCCC_OWNER_HYP_STANDARD,	\
> +			   0x21)
> +
> +#define ARM_SMCCC_HV_PV_TIME_ST					\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
> +			   ARM_SMCCC_SMC_64,			\
> +			   ARM_SMCCC_OWNER_HYP_STANDARD,	\
> +			   0x22)
> +
> +#endif /* __KVM_ARM_PV_H */

Do these need to live in a separate header, away from the struct
definitions?

I'd be happy for these to live in <linux/arm-smccc.h>, given they're
standard calls.

As before, a comment referring to ARM DEN0057A would be nice.


> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index b047009e7a0a..4e0866cc48c0 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -54,6 +54,7 @@
>  #define ARM_SMCCC_OWNER_SIP		2
>  #define ARM_SMCCC_OWNER_OEM		3
>  #define ARM_SMCCC_OWNER_STANDARD	4
> +#define ARM_SMCCC_OWNER_HYP_STANDARD	5

Minor nit, but could we make that STANDARD_HYP?

>  #define ARM_SMCCC_OWNER_TRUSTED_APP	48
>  #define ARM_SMCCC_OWNER_TRUSTED_APP_END	49
>  #define ARM_SMCCC_OWNER_TRUSTED_OS	50
> diff --git a/virt/kvm/arm/hypercalls.c b/virt/kvm/arm/hypercalls.c
> index 153aa7642100..ba13b798f0f8 100644
> --- a/virt/kvm/arm/hypercalls.c
> +++ b/virt/kvm/arm/hypercalls.c
> @@ -5,6 +5,7 @@
>  #include <linux/kvm_host.h>
>  
>  #include <asm/kvm_emulate.h>
> +#include <asm/pvclock-abi.h>
>  
>  #include <kvm/arm_hypercalls.h>
>  #include <kvm/arm_psci.h>
> @@ -40,6 +41,14 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>  				break;
>  			}
>  			break;
> +		case ARM_SMCCC_HV_PV_FEATURES:
> +			val = SMCCC_RET_SUCCESS;
> +			break;
> +		}
> +		break;
> +	case ARM_SMCCC_HV_PV_FEATURES:
> +		feature = smccc_get_arg1(vcpu);
> +		switch (feature) {
>  		}

IIUC, at this point in time, this happens to always return
SMCCC_RET_NOT_SUPPORTED.

If you leave this part out of the patch, and add it as required, this
patch is purely adding definitions, which would be a bit nicer for
review.

Thanks,
Mark.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
