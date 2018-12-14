Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17455C41606
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:12:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4207920879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FVlOP8R7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4207920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uORp6sAAmgjOHO5PN7mbFaQWsvpYaGbeILnCSRMWMdA=; b=FVlOP8R7/kD7UI
	enChXaM2NTbquMLTs8TEtTVgix7AQ4+8xpg5w8ShuBWIVBLSil3nvNaXsFs2uUY23gyHiEU3xWS5g
	739PV61SLahEqJkpuMcrpH+XFO/qcloWNm5Kxdcta2ftEVYAhH99Rttw3WDqFkzDft4mUqh/Bo2m1
	ACYuxGxDTjTtnhcmpNziEYJY8m+BPYYTk3hnHmQD72Br9z4Q9uAYvohv6It8yCs9BOMou0AFDTK9X
	cym9L0joHmHGioyS43Lhi57uOpuf+T+RfOnrrcm90wz3o7Iy+6ei61Si6RK3bzNEue4fuKdTcVwDU
	ihAGLDcdsM8Lcu4YkvTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXnwt-0007yL-W4; Fri, 14 Dec 2018 13:56:15 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXnwq-0007xC-EL
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 13:56:13 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B233780D;
 Fri, 14 Dec 2018 05:55:59 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAD653F575;
 Fri, 14 Dec 2018 05:55:57 -0800 (PST)
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To: Dongjiu Geng <gengdongjiu@huawei.com>
References: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com>
From: James Morse <james.morse@arm.com>
Message-ID: <f252e4ca-cdc2-bc42-32a6-5dae7dee51ee@arm.com>
Date: Fri, 14 Dec 2018 13:55:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1544782537-13377-1-git-send-email-gengdongjiu@huawei.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_055612_494391_B2CAAFF4 
X-CRM114-Status: GOOD (  19.84  )
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
Cc: peter.maydell@linaro.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com,
 rkrcmar@redhat.com, will.deacon@arm.com, christoffer.dall@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Dongjiu Geng,

On 14/12/2018 10:15, Dongjiu Geng wrote:
> When user space do memory recovery, it will check whether KVM and
> guest support the error recovery, only when both of them support,
> user space will do the error recovery. This patch exports this
> capability of KVM to user space.

I can understand user-space only wanting to do the work if host and guest
support the feature. But 'error recovery' isn't a KVM feature, its a Linux
kernel feature.

KVM will send it's user-space a SIGBUS with MCEERR code whenever its trying to
map a page at stage2 that the kernel-mm code refuses this because its poisoned.
(e.g. check_user_page_hwpoison(), get_user_pages() returns -EHWPOISON)

This is exactly the same as happens to a normal user-space process.

I think you really want to know if the host kernel was built with
CONFIG_MEMORY_FAILURE. The not-at-all-portable way to tell this from user-space
is the presence of /proc/sys/vm/memory_failure_* files.
(It looks like the prctl():PR_MCE_KILL/PR_MCE_KILL_GET options silently update
an ignored policy if the kernel isn't built with CONFIG_MEMORY_FAILURE, so they
aren't helpful)


> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index cd209f7..241e2e2 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4895,3 +4895,12 @@ Architectures: x86
>  This capability indicates that KVM supports paravirtualized Hyper-V IPI send
>  hypercalls:
>  HvCallSendSyntheticClusterIpi, HvCallSendSyntheticClusterIpiEx.
> +
> +8.21 KVM_CAP_ARM_MEMORY_ERROR_RECOVERY
> +
> +Architectures: arm, arm64
> +
> +This capability indicates that guest memory error can be detected by the KVM which
> +supports the error recovery.

KVM doesn't detect these errors.
The hardware detects them and notifies the OS via one of a number of mechanisms.
This gets plumbed into memory_failure(), which sets a flag that the mm code uses
to prevent the page being used again.

KVM is only involved when it tries to map a page at stage2 and the mm code
rejects it with -EHWPOISON. This is the same as the architectures
do_page_fault() checking for (fault & VM_FAULT_HWPOISON) out of
handle_mm_fault(). We don't have a KVM cap for this, nor do we need one.


> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index b72a3dd..90d1d9a 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -82,6 +82,7 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  		r = kvm_arm_support_pmu_v3();
>  		break;
>  	case KVM_CAP_ARM_INJECT_SERROR_ESR:
> +	case KVM_CAP_ARM_MEMORY_ERROR_RECOVERY:
>  		r = cpus_have_const_cap(ARM64_HAS_RAS_EXTN);
>  		break;

The CPU RAS Extensions are not at all relevant here. It is perfectly possible to
support memory-failure without them, AMD-Seattle and APM-X-Gene do this. These
systems would report not-supported here, but the kernel does support this stuff.
Just because the CPU supports this, doesn't mean the kernel was built with
CONFIG_MEMORY_FAILURE. The CPU reports may be ignored, or upgraded to SIGKILL.



Thanks,

James

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
