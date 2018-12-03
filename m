Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09637C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:26:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9EC20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="stqG8U0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9EC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NnkuNRbObI5gqQUA0MFFd56XqCQpzvC522A/vk9RfgE=; b=stqG8U0OUww9g9
	LBUqPHgB5VEmmmb+EyIbABSn5/zOKxM2ZJjp95b5YjGzGgrUWvVl3CV+GK5f8CLfG+ac4xH1Eq1C7
	E1y99S07SlqeFP4i8Akb/wLBbHrgfIPK8VH22L1gIVsSa3PsSoKjHXOeKDkzMNvQ3Od0OsW3Zs/ln
	tyJ0z7LqwfvD9oSRWZ1Z13Rotz8iqO0zQcS3ZJ2R+9Y9OcxwJ4ExWs2+lUca2kixA/D1mpKSU7FNn
	mJm1W69oQsmoaYf5977JRNS2GeTj3o6xZB/nGxzYDFfFhhCjfWW9F7nZJPFZXV2Cy6SUAGN1z/rdg
	/xDk5tg2w8PMRLqxvkgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gToEl-0002I5-ML; Mon, 03 Dec 2018 13:26:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gToEh-0002H8-Uw
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 13:26:09 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB3D35F799;
 Mon,  3 Dec 2018 13:25:56 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65286605CA;
 Mon,  3 Dec 2018 13:25:55 +0000 (UTC)
Date: Mon, 3 Dec 2018 14:25:52 +0100
From: Andrew Jones <drjones@redhat.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 00/12] arm64: Paravirtualized time support
Message-ID: <20181203132552.5exdbzda6dfud2d2@kamzik.brq.redhat.com>
References: <20181128144527.44710-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128144527.44710-1-steven.price@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 03 Dec 2018 13:25:56 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_052608_032637_DEA8C12F 
X-CRM114-Status: GOOD (  22.75  )
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
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 02:45:15PM +0000, Steven Price wrote:
> This series add support for paravirtualized time for Arm64 guests and
> KVM hosts following the specification in Arm's document DEN 0057A:
> 
> https://developer.arm.com/docs/den0057/a

Hi Steven,

As that specification is still a draft, then I guess this series is an
RFC. I just wanted to point that out, as I believe that tag should be
used in future postings until the spec is approved.

Regarding the spec, my understanding from kvm forum was that there was
still a need to explain why kvmclock, or an extension to kvmclock, is
insufficient.

If there hasn't been anything written up about that yet, would you mind
doing so?

> 
> It implements support for Live Physical Time (LPT) which provides the
> guest with a method to derive a stable counter of time during which the
> guest is executing even when the guest is being migrated between hosts
> with different physical counter frequencies.

Intel has TSC scaling. Is there any reason Arm is proposing a PV
solution instead of adding a similar virt extension?

Thanks,
drew

> 
> It also implements support for stolen time, allowing the guest to
> identify time when it is forcibly not executing.
> 
> Patch 1 provides some documentation
> Patches 2-4, 8 and 11 provide some refactoring of existing code
> Patch 5 implements the new PV_FEATURES discovery mechanism
> Patches 6-7 implement live physical time
> Patches 9-10 implement stolen time
> Patch 12 adds the 'PV_TIME' device for user space to enable the features
> 
> Christoffer Dall (2):
>   KVM: arm/arm64: Factor out hypercall handling from PSCI code
>   KVM: Export mark_page_dirty_in_slot
> 
> Steven Price (10):
>   KVM: arm64: Document PV-time interface
>   arm/arm64: Provide a wrapper for SMCCC 1.1 calls
>   arm/arm64: Make use of the SMCCC 1.1 wrapper
>   KVM: arm64: Implement PV_FEATURES call
>   KVM: arm64: Support Live Physical Time reporting
>   clocksource: arm_arch_timer: Use paravirtualized LPT
>   KVM: arm64: Support stolen time reporting via shared page
>   arm64: Retrieve stolen time as paravirtualized guest
>   KVM: Allow kvm_device_ops to be const
>   KVM: arm64: Provide a PV_TIME device to user space
> 
>  Documentation/virtual/kvm/arm/pvtime.txt | 169 ++++++++++++++
>  arch/arm/kvm/Makefile                    |   2 +-
>  arch/arm/kvm/handle_exit.c               |   2 +-
>  arch/arm/mm/proc-v7-bugs.c               |  46 ++--
>  arch/arm64/include/asm/arch_timer.h      |  32 ++-
>  arch/arm64/include/asm/kvm_host.h        |  16 ++
>  arch/arm64/include/asm/kvm_mmu.h         |   2 +
>  arch/arm64/include/asm/pvclock-abi.h     |  32 +++
>  arch/arm64/include/uapi/asm/kvm.h        |   8 +
>  arch/arm64/kernel/Makefile               |   1 +
>  arch/arm64/kernel/cpu_errata.c           |  47 +---
>  arch/arm64/kernel/cpuinfo.c              |   2 +-
>  arch/arm64/kernel/kvm.c                  | 156 +++++++++++++
>  arch/arm64/kvm/Kconfig                   |   1 +
>  arch/arm64/kvm/Makefile                  |   2 +
>  arch/arm64/kvm/handle_exit.c             |   4 +-
>  drivers/clocksource/arm_arch_timer.c     | 176 ++++++++++++++-
>  include/kvm/arm_arch_timer.h             |   2 +
>  include/kvm/arm_hypercalls.h             |  44 ++++
>  include/kvm/arm_psci.h                   |   2 +-
>  include/kvm/arm_pv.h                     |  28 +++
>  include/linux/arm-smccc.h                |  45 ++++
>  include/linux/cpuhotplug.h               |   1 +
>  include/linux/kvm_host.h                 |   5 +-
>  include/linux/kvm_types.h                |   2 +
>  include/uapi/linux/kvm.h                 |   2 +
>  virt/kvm/arm/arm.c                       |  25 +-
>  virt/kvm/arm/hypercalls.c                | 276 +++++++++++++++++++++++
>  virt/kvm/arm/mmu.c                       |  44 ++++
>  virt/kvm/arm/psci.c                      |  76 +------
>  virt/kvm/arm/pvtime.c                    | 243 ++++++++++++++++++++
>  virt/kvm/kvm_main.c                      |  12 +-
>  32 files changed, 1348 insertions(+), 157 deletions(-)
>  create mode 100644 Documentation/virtual/kvm/arm/pvtime.txt
>  create mode 100644 arch/arm64/include/asm/pvclock-abi.h
>  create mode 100644 arch/arm64/kernel/kvm.c
>  create mode 100644 include/kvm/arm_hypercalls.h
>  create mode 100644 include/kvm/arm_pv.h
>  create mode 100644 virt/kvm/arm/hypercalls.c
>  create mode 100644 virt/kvm/arm/pvtime.c
> 
> -- 
> 2.19.2
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
