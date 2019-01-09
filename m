Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3E3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:24:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF98206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jTr36ZyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF98206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ElfiNHAsPuDZ6K3Y9bx/I5WCehWyLxCzoOOhOrlM2FQ=; b=jTr36ZySWKmjWV
	GYCrG6GUG+bR9AxdypMxw/IVZKnrgyzHfzFjlVFFs3LYTwppFSndrm9EffMlRqmgQJ8uC7lzXNTUz
	ZPW38p8tMZ3z9VLG5W/h+Eo8izMMJ4IpKAiqz+U+J2hyrUbDrrxy9WRdZWGviQokxcqF1bcB529Cm
	0YLnROB19uy1NuH0TS1BPa8fzz8eOO+vQauApHWl2kaOLayBg94Ze7zh5V4UXX5nu1yboCkoRsW5n
	QJk+Zphl/ZmFJjxm2GGHZP+7nQ7ilC9l78yHp7Zgm3XRb/GI6jupZphO+wc2ghUZtP2RqCmGZuO9f
	5U2K7GLUut9fPuN4XU0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEmE-00011M-0K; Wed, 09 Jan 2019 14:24:14 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEmB-00010y-62
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:24:12 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6DE480D;
 Wed,  9 Jan 2019 06:24:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38E613F6CF;
 Wed,  9 Jan 2019 06:24:10 -0800 (PST)
Date: Wed, 9 Jan 2019 14:24:08 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 2/3] arm64: KVM: Allow for direct call of HYP functions
 when using VHE
Message-ID: <20190109142407.GH56789@e119886-lin.cambridge.arm.com>
References: <20190109135435.178664-1-marc.zyngier@arm.com>
 <20190109135435.178664-3-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190109135435.178664-3-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_062411_230736_9BBD1DEC 
X-CRM114-Status: GOOD (  21.77  )
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
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 09, 2019 at 01:54:34PM +0000, Marc Zyngier wrote:
> When running VHE, there is no need to jump via some stub to perform
> a "HYP" function call, as there is a single address space.
> 
> Let's thus change kvm_call_hyp() and co to perform a direct call
> in this case. Although this results in a bit of code expansion,
> it allows the compiler to check for type compatibility, something
> that we are missing so far.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h | 32 +++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index e54cb7c88a4e..df32edbadd69 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -370,8 +370,36 @@ void kvm_arm_halt_guest(struct kvm *kvm);
>  void kvm_arm_resume_guest(struct kvm *kvm);
>  
>  u64 __kvm_call_hyp(void *hypfn, ...);
> -#define kvm_call_hyp(f, ...) __kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__)
> -#define kvm_call_hyp_ret(f, ...) kvm_call_hyp(f, ##__VA_ARGS__)
> +
> +/*
> + * The couple of isb() below are there to guarantee the same behaviour
> + * on VHE as on !VHE, where the eret to EL1 acts as a context
> + * synchronization event.
> + */
> +#define kvm_call_hyp(f, ...)						\
> +	do {								\
> +		if (cpus_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN)) {	\
> +			f(__VA_ARGS__);					\
> +			isb();						\
> +		} else {						\
> +			__kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__); \
> +		}							\
> +	} while(0)
> +
> +#define kvm_call_hyp_ret(f, ...)					\
> +	({								\
> +		u64 ret;						\
> +									\
> +		if (cpus_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN)) {	\
> +			ret = f(__VA_ARGS__);				\

__kvm_get_mdcr_el2 and __kvm_vcpu_run_nvhe don't return u64 type, they
return a smaller type. I guess any issues would be picked up when compiling,
but should the name of the macro be clearer as to the assumptions it makes?
Or perhaps take an argument which is the type of ret?

Andrew Murray

> +			isb();						\
> +		} else {						\
> +			ret = __kvm_call_hyp(kvm_ksym_ref(f),		\
> +					     ##__VA_ARGS__);		\
> +		}							\
> +									\
> +		ret;							\
> +	})
>  
>  void force_vm_exit(const cpumask_t *mask);
>  void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
> -- 
> 2.20.1
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
