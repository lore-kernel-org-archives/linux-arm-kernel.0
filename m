Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63191C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:36:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FAA217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ynn1yR+e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMvn4HuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FAA217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v5oKdcnL6x5En4Q0mOeNnN6WJfUkNnlNeuI5he2tGfw=; b=Ynn1yR+eGEZ/ID
	qei9ARJYEoMFkOmx8SWpAIEhh8IVMi1m9YjggKb5iD+yeg0VJLWkLpdRp97cEBv26+R0tNGI8Aq6M
	EAClqZqxeg0qwnWAyZJ8BcJFY7eemIGfRqgAPsBTZ4UJQFh02JkvU+JdGYiNG088JwPBtWQKp1o7s
	Ms/ETiMATQJrYHkyfetv7JyFfw/U63BlTHxhapzstSNDJ3r7doNnQ0oWNRFefNnU6fZdkY5H2PwwL
	qIszI+Jv52pZuMgogQl+mc4aDZVcB6mBHf5CLY3+3Ws4oIdkuE6qtTgpqZ4Jnmgnq253yIw3jrF/X
	JMX8+77aQmIsk577SOqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtXIT-00077B-U0; Tue, 12 Feb 2019 12:36:21 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtXIO-00076m-HQ
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 12:36:19 +0000
Received: by mail-wr1-x444.google.com with SMTP id r2so2471599wrv.10
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 04:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X8YnGwepQr5rSwMO4z3gWCd1Sf310+rOc6Pdk4CAJzM=;
 b=YMvn4HuAIMVs7QJ4d1ezdgcWfjzrfy612x1Gyvm5NRvK7IxdGXY1Ful+AgoGb6F/KO
 jSrUVG974HPX2hIogaetr4yXCo7L/P450hlvE5KXQY66dvHC38yZicQB+Z+NvPdgFIL/
 aaQv7pkOe+MlRV3tXW2m8gaxGzX9BEU3RP8+nYgAmr9pLB2pub5GbKfS//AILsKRxZR4
 zo4cDLAldSHBeCAf1ewwYMsKEcQnUALmctqaZJL2xf3y7rvxqIPD2BFVkkA1X99RY8K3
 FG7+TAWwr2eOPFEngZxveidwHM7/St9Cu7ria4jo0kRDql++xGx7P1fXrH8+32FuIFS5
 5X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=X8YnGwepQr5rSwMO4z3gWCd1Sf310+rOc6Pdk4CAJzM=;
 b=Vl78IdxP1HLXxIFCfHGNcubcFWtd4wBZtiHkFsEBWLzQEq0G29h+nG+F388ICtg5Vc
 U/Zu4uW/PTxnwPS5zLh6vZ5F0n9ZAZOSmcwgNSlsk3quffKL0zVNtyWrT8/qnQBeskLB
 4gm+J8fzOs4LAlbDJe+MZ3fkMVqv1g4bf92B26sNB7/8m09PhcE+EbIUfdKTFhHQmeC/
 mu8a6lia2ejQo79fadaKX0vb8cYlORoG7qsWK6/JGszgX7gOQE4nS0kQSbZibmwjWTc3
 8BdBL6rMwIR/5oVXLwx2olK/oCEYUoetHHADx0MoLPFCf4V7z9dNZNAG6NlwJZsk8ngd
 2JZg==
X-Gm-Message-State: AHQUAub2Y9+XhdZ4Tma49veNoOOaT3M9V/whDztZMF5xzY3EkxKX/UxL
 DkgGEKHHNXeBYVWDIs7D1DI=
X-Google-Smtp-Source: AHgI3IbqWtT/hZFpc4eTFJQr3IUrW33vpcEVRt7r98pb1q7IbakDHhhhEBMvyHkaRhtJVK7zy+7j+Q==
X-Received: by 2002:adf:e647:: with SMTP id b7mr2749512wrn.260.1549974973822; 
 Tue, 12 Feb 2019 04:36:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5c98:e2e4:edd5:bef0?
 ([2001:b07:6468:f312:5c98:e2e4:edd5:bef0])
 by smtp.googlemail.com with ESMTPSA id u184sm7786221wmg.45.2019.02.12.04.36.12
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 04:36:12 -0800 (PST)
Subject: Re: [PATCH v2 00/27] KVM: x86/mmu: Remove fast invalidate mechanism
To: Sean Christopherson <sean.j.christopherson@intel.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 James Hogan <jhogan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>
References: <20190205205443.1059-1-sean.j.christopherson@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <dc703147-dd43-18ee-a4ec-5635187e8a5e@redhat.com>
Date: Tue, 12 Feb 2019 13:36:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205205443.1059-1-sean.j.christopherson@intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_043616_581466_46101BCF 
X-CRM114-Status: GOOD (  31.58  )
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
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Xiao Guangrong <guangrong.xiao@gmail.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 05/02/19 21:54, Sean Christopherson wrote:
> ...and clean up the MMIO spte generation code.
> 
> === Non-x86 Folks ===
> Patch 01/27 (which you should also be cc'd on) changes the prototype for
> a function that is defined by all architectures but only actually used
> by x86.  Feel free to skip the rest of this cover letter.
> 
> === x86 Folks ===
> Though not explicitly stated, for all intents and purposes the fast
> invalidate mechanism was added to speed up the scenario where removing
> a memslot, e.g. when accessing PCI ROM, caused KVM to flush all shadow
> entries[1].
> 
> The other use cases of "flush everything" are VM teardown and handling
> MMIO generation overflow, neither of which is a performance critial
> path (see "Other Uses" below).
> 
> For the memslot case, zapping all shadow entries is overkill, i.e. KVM
> only needs to zap the entries associated with the memslot, but KVM has
> historically used a big hammer because if all you have is a hammer,
> everything looks like a nail.
> 
> Rather than zap all pages when removing a memslot, zap only the shadow
> entries associated with said memslot.  I see a performance improvement
> of ~5% when zapping only the pages for the deleted memslot when using a
> slightly modified version of the original benchmark[2][3][4] (I don't
> have easy access to a system with hundreds of gigs of memory).
> 
> $ cat shell.sh
>         #!/bin/sh
> 
>         echo 3 > /proc/sys/vm/drop_caches
>         ./mmtest -c 8 -m 2000 -e ./rom.sh
> 
> I.e. running 8 threads and 2gb of memory per thread, time in milliseconds:
> 
> Before: 89.117
> After:  84.768
> 
> 
> With the memslot use case gone, maintaining the fast invalidate path
> adds a moderate amount of complexity but provides little to no value.
> Furhtermore, its existence may give the impression that it's "ok" to zap
> all shadow pages.  Remove the fast invalidate mechanism to simplify the
> code and to discourage future code from zapping all pages as using such
> a big hammer should be a last resort.
> 
> Unfortunately, simply reverting the fast invalidate code re-introduces
> shortcomings in the previous code, notably that KVM may hold a spinlock
> and not schedule for an extended period of time.  Releasing the lock to
> voluntarily reschedule is perfectly doable, and for the VM teardown case
> of "zap everything" it can be added with no additional changes since KVM
> doesn't need to provide any ordering guarantees about sptes in that case.
> 
> For the MMIO case, KVM needs to prevent vCPUs from consuming stale sptes
> created with an old generation number.  This should be a non-issue as
> KVM is supposed to prevent consuming stale MMIO sptes regardless of the
> zapping mechanism employed, releasing mmu_lock while zapping simply
> makes it much more likely to hit any bug leading to stale spte usage.
> As luck would have it, there are a number of corner cases in the MMIO
> spte invalidation flow that could theoretically result in reusing stale
> sptes.  So before reworking memslot zapping and reverting to the slow
> invalidate mechanism, fix a number of bugs related to MMIO generations
> and opportunistically clean up the memslots/MMIO generation code.
> 
> 
> === History ===
> Flushing of shadow pages when removing a memslot was originally added
> by commit 34d4cb8fca1f ("KVM: MMU: nuke shadowed pgtable pages and ptes
> on memslot destruction"), and obviously emphasized functionality over
> performance.  Commit 2df72e9bc4c5 ("KVM: split kvm_arch_flush_shadow")
> added a path to allow flushing only the removed slot's shadow pages,
> but x86 just redirected to the "zap all" flow.
> 
> Eventually, it became evident that zapping everything is slow, and so
> x86 developed a more efficient hammer in the form of the fast invalidate
> mechanism.
> 
> === Other Uses ===
> When a VM is being destroyed, either there are no active vcpus, i.e.
> there's no lock contention, or the VM has ungracefully terminated, in
> which case we want to reclaim its pages as quickly as possible, i.e.
> not release the MMU lock if there are still CPUs executing in the VM.
> 
> The MMIO generation scenario is almost literally a one-in-a-million
> occurrence, i.e. is not a performance sensitive scenario.
> 
> It's worth noting that prior to the "fast invalidate" series being
> applied, there was actually another use case of kvm_mmu_zap_all() in
> emulator_fix_hypercall() whose existence may have contributed to
> improving the performance of "zap all" instead of avoiding it altogether.
> But that usage was removed by the series itself in commit 758ccc89b83c
> ("KVM: x86: drop calling kvm_mmu_zap_all in emulator_fix_hypercall").
> 
> [1] https://lkml.kernel.org/r/1369960590-14138-1-git-send-email-xiaoguangrong@linux.vnet.ibm.com
> [2] https://lkml.kernel.org/r/1368706673-8530-1-git-send-email-xiaoguangrong@linux.vnet.ibm.com
> [3] http://lkml.iu.edu/hypermail/linux/kernel/1305.2/00277.html
> [4] http://lkml.iu.edu/hypermail/linux/kernel/1305.2/00277/mmtest.tar.bz2
> 
> v1: https://patchwork.kernel.org/cover/10756579/
> v2:
>   - Fix a zap vs flush priority bug in kvm_mmu_remote_flush_or_zap() [me]
>   - Voluntarily reschedule and/or drop mmu_lock as needed when zapping
>     all sptes or all MMIO sptes [Paolo]
>   - Add patches to clean up the memslots/MMIO generation code and fix
>     a variety of theoretically corner case bugs
> 
> 
> Sean Christopherson (27):
>   KVM: Call kvm_arch_memslots_updated() before updating memslots
>   KVM: x86/mmu: Detect MMIO generation wrap in any address space
>   KVM: x86/mmu: Do not cache MMIO accesses while memslots are in flux
>   KVM: Explicitly define the "memslot update in-progress" bit
>   KVM: x86: Use a u64 when passing the MMIO gen around
>   KVM: x86: Refactor the MMIO SPTE generation handling
>   KVM: Remove the hack to trigger memslot generation wraparound
>   KVM: Move the memslot update in-progress flag to bit 63
>   KVM: x86/mmu: Move slot_level_*() helper functions up a few lines
>   KVM: x86/mmu: Split remote_flush+zap case out of
>     kvm_mmu_flush_or_zap()
>   KVM: x86/mmu: Zap only the relevant pages when removing a memslot
>   Revert "KVM: MMU: document fast invalidate all pages"
>   Revert "KVM: MMU: drop kvm_mmu_zap_mmio_sptes"
>   KVM: x86/mmu: Voluntarily reschedule as needed when zapping MMIO sptes
>   KVM: x86/mmu: Remove is_obsolete() call
>   Revert "KVM: MMU: reclaim the zapped-obsolete page first"
>   Revert "KVM: MMU: collapse TLB flushes when zap all pages"
>   Revert "KVM: MMU: zap pages in batch"
>   Revert "KVM: MMU: add tracepoint for kvm_mmu_invalidate_all_pages"
>   Revert "KVM: MMU: show mmu_valid_gen in shadow page related
>     tracepoints"
>   Revert "KVM: x86: use the fast way to invalidate all pages"
>   KVM: x86/mmu: skip over invalid root pages when zapping all sptes
>   KVM: x86/mmu: Voluntarily reschedule as needed when zapping all sptes
>   Revert "KVM: MMU: fast invalidate all pages"
>   KVM: x86/mmu: Differentiate between nr zapped and list unstable
>   KVM: x86/mmu: WARN if zapping a MMIO spte results in zapping children
>   KVM: x86/mmu: Consolidate kvm_mmu_zap_all() and
>     kvm_mmu_zap_mmio_sptes()
> 
>  Documentation/virtual/kvm/mmu.txt   |  41 +--
>  arch/mips/include/asm/kvm_host.h    |   2 +-
>  arch/powerpc/include/asm/kvm_host.h |   2 +-
>  arch/s390/include/asm/kvm_host.h    |   2 +-
>  arch/x86/include/asm/kvm_host.h     |   9 +-
>  arch/x86/kvm/mmu.c                  | 442 +++++++++++++---------------
>  arch/x86/kvm/mmu.h                  |   1 -
>  arch/x86/kvm/mmutrace.h             |  42 +--
>  arch/x86/kvm/x86.c                  |   7 +-
>  arch/x86/kvm/x86.h                  |   7 +-
>  include/linux/kvm_host.h            |  23 +-
>  virt/kvm/arm/mmu.c                  |   2 +-
>  virt/kvm/kvm_main.c                 |  39 ++-
>  13 files changed, 286 insertions(+), 333 deletions(-)
> 

Queued, thanks.

Paolo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
