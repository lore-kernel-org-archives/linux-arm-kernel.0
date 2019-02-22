Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF2DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:11:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A22F20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XUo6gcqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A22F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WLYy/IalF0yRHe6r6h7a6MWN92Uzq4G8VAvKNqVrj30=; b=XUo6gcqFbVyTVU
	o69/fVNo/VkE2zNHwXBTG/7qLvmghM/HlvL17YSEjGrBrXegC2bP4he5FsaZrosIKyB8RWEUTh4Ot
	TQt/jXYXo6PH0KGVcQIGDhrj+949HMv4Cziwj1p3qj1vsimk6pBH3X9OXtqK++JOwtWmH/flJU3+D
	qkKFPivjbXvaVKUhfkQb6XjgFjBRVN2/2koYzDLDQrp4d5I53o+Q2uaAgPVUN5kWaSg3gUz1V6HRr
	ym1oyngjeOf8cAi6Ehi4nZt1KHGBm7TyQNH8W+OJ/niT7H1qdx1UFep7LfM/zbZMXClFmz2WtZU6Q
	jtBYoF3B0c6zh9Wh3IUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx6rE-00076J-NS; Fri, 22 Feb 2019 09:11:00 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx6rB-00075y-2j
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:10:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 768C280D;
 Fri, 22 Feb 2019 01:10:56 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D01683F703;
 Fri, 22 Feb 2019 01:10:53 -0800 (PST)
Subject: Re: [PATCH v5 24/26] KVM: arm64: Add a capabillity to advertise SVE
 support
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-25-git-send-email-Dave.Martin@arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <e1e048ff-dbe0-34fe-3318-d9c9ecbccf0e@arm.com>
Date: Fri, 22 Feb 2019 09:10:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-25-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_011057_762004_9961C1FC 
X-CRM114-Status: GOOD (  20.63  )
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
> To provide a uniform way to check for KVM SVE support amongst other
> features, this patch adds a suitable capability KVM_CAP_ARM_SVE,
> and reports it as present when SVE is available.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/kvm/reset.c   | 8 ++++++++
>  include/uapi/linux/kvm.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index e67cd2e..f636b34 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -35,6 +35,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_coproc.h>
>  #include <asm/kvm_mmu.h>
> +#include <asm/virt.h>
>  
>  /* Maximum phys_shift supported for any VM on this host */
>  static u32 kvm_ipa_limit;
> @@ -93,6 +94,9 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_ARM_VM_IPA_SIZE:
>  		r = kvm_ipa_limit;
>  		break;
> +	case KVM_CAP_ARM_SVE:
> +		r = system_supports_sve();
> +		break;
>  	default:
>  		r = 0;
>  	}
> @@ -105,6 +109,10 @@ static int kvm_reset_sve(struct kvm_vcpu *vcpu)
>  	if (!system_supports_sve())
>  		return -EINVAL;
>  
> +	/* Verify that KVM startup enforced this when SVE was detected: */
> +	if (WARN_ON(!has_vhe()))
> +		return -EINVAL;

I'm wondering, wouldn't it make more sense to check for this when
userland tries to set KVM_ARM_VCPU_SVE?

Otherwise:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Cheers,

-- 
Julien Thierry

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
