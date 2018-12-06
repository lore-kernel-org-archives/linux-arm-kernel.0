Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6A2C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:21:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD8F20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eHBodRlI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQHaEzE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD8F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=KGXyIsEDGeprbx6T70pG/DLUOPWY5dgwUsxNg76s0WY=; b=eHB
	odRlI/iiCF9Wbqz3az+0dQXwRvrliTEzaXHdqaG4Q+PA35not3ploTcbb7WbGnVvvLqSwD8ExQOcx
	otGf1qwLBkKcbvnoxTLiwERYfq/z0RNX8N13vewBdhBuW+KLBmTv+LvuJ7J2nqW6/DhoOs9OtBV7U
	IhnVp7B53IsWQaVb+6jYXUBnSvhjjQ0qm76FcRZOePA3Qd3aqlHi8vBpWK2RhINd6vxaxIUtjk/eU
	/8BwM3jsUxKu1bbjD62yS6jL0uWybqs2We8vpmT9cr/7IKwqJLFLe0kK9psU9Wg4lRzjdY2Y3q8SN
	PUBwybsNH4WhWInCzxjE8Scpe3N/ukw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtb6-0002Rp-0J; Thu, 06 Dec 2018 13:21:44 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtaz-0002Q5-JC
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:21:41 +0000
Received: by mail-pl1-x642.google.com with SMTP id a14so155200plm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=niHnVH2bfGHteoJGPZcpd1954RrmGez0+UHvE3wDR1U=;
 b=bQHaEzE7xVWcXYhMkBMmCPeQvYaCLlbO7XkXrNDXT+KZXuOEhoh+ZCcRuya+zAgYOJ
 pCTaP8hKNu40klUJfUHcWqvhvUrI2sM/uv2QXtewqqCyEcz/wB84yaxa6gv7ZnT0eNmh
 2UrDAmuTjKTKB+PwoBX5yw5b4AUUZsP6AZRj9GrYuQSXycGEgzMMyatjpNmaaU9z7kId
 sNqGbwChDvzxrmlUhwGeu3nksj0tct6wC8LTiis/Y0uiLo9rTDg+G9HbGjPocV7HKMyk
 W+p+fYYtTloNNkqFW7pfFFKmibftFLW+O2HAvkqN3aM9q4/EyQLCsmX4bHFBYv0ABvaA
 XWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=niHnVH2bfGHteoJGPZcpd1954RrmGez0+UHvE3wDR1U=;
 b=AG5A6oifkDKJ00iaRXBJKrMXO+4ET2ytgny2TiqJju2a4Qdq++C66efXlwMUe2aaxl
 q01Wl73yScJJ/E32N9mqAfWwBHvPD4XRsjzT8DQbZ1nAsS1Qae0kk/I8AT76BbIc1/B4
 78rvTG2DrEs+9uvLWD/WxI7/HtNA9yWua7j/HVHmsOpgW4tHp4qmyh4EhMiqH5ZHSWGZ
 Z5ZhC56CFgNfVI5SGIP+GiJ/KgPHHtfcQ7fhEN/ukrK0U8WFP/oJOYXAP9841zQydR9g
 1NY9GieTWjtFXftbiTvvVyDTiYnJu6x6EU+I087fryQf7nWisMxcbyk/+mc80RMqTFeR
 5Qwg==
X-Gm-Message-State: AA+aEWbEuboPD+8afJ8XHxqKARaaw63vsrB8zj1MKJdKh+lRidn7CypW
 PH4lBhGuoSleaDl4Xd+g94Y=
X-Google-Smtp-Source: AFSGD/WT/IwJmq80cl7+03kkOJcqb7s/m9QX6aQZnkjlikrIr0RV7MthFe3JQPbwLBa67Q2CT+Zlbg==
X-Received: by 2002:a17:902:bf44:: with SMTP id
 u4mr28448247pls.5.1544102486538; 
 Thu, 06 Dec 2018 05:21:26 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.21.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 05:21:25 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [Resend PATCH V5 0/10] x86/KVM/Hyper-v: Add HV ept tlb range flush
 hypercall support in KVM
Date: Thu,  6 Dec 2018 21:21:03 +0800
Message-Id: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_052137_630253_2D64BFE0 
X-CRM114-Status: UNSURE (   9.10  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-mips@linux-mips.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
 benh@kernel.crashing.org, will.deacon@arm.com, christoffer.dall@arm.com,
 paulus@ozlabs.org, hpa@zytor.com, kys@microsoft.com,
 kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com, mpe@ellerman.id.au,
 x86@kernel.org, linux@armlinux.org.uk, michael.h.kelley@microsoft.com,
 mingo@redhat.com, catalin.marinas@arm.com, jhogan@kernel.org,
 Lan Tianyu <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
 haiyangz@microsoft.com, kvm-ppc@vger.kernel.org, bp@alien8.de,
 pbonzini@redhat.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, paul.burton@mips.com,
 devel@linuxdriverproject.org, vkuznets@redhat.com,
 linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

For nested memory virtualization, Hyper-v doesn't set write-protect
L1 hypervisor EPT page directory and page table node to track changes 
while it relies on guest to tell it changes via HvFlushGuestAddressLlist
hypercall. HvFlushGuestAddressLlist hypercall provides a way to flush
EPT page table with ranges which are specified by L1 hypervisor.

If L1 hypervisor uses INVEPT or HvFlushGuestAddressSpace hypercall to
flush EPT tlb, Hyper-V will invalidate associated EPT shadow page table
and sync L1's EPT table when next EPT page fault is triggered.
HvFlushGuestAddressLlist hypercall helps to avoid such redundant EPT
page fault and synchronization of shadow page table.

This patchset is based on the Patch "KVM/VMX: Check ept_pointer before
flushing ept tlb"(https://marc.info/?l=kvm&m=154408169705686&w=2).

Change since v4:
       1) Split flush address and flush list patches. This patchset only contains
       flush address patches. Will post flush list patches later.
       2) Expose function hyperv_fill_flush_guest_mapping_list()
       out of hyperv file
       3) Adjust parameter of hyperv_flush_guest_mapping_range()
       4) Reorder patchset and move Hyper-V and VMX changes ahead.

Change since v3:
        1) Remove code of updating "tlbs_dirty" in kvm_flush_remote_tlbs_with_range()
        2) Remove directly tlb flush in the kvm_handle_hva_range()
        3) Move tlb flush in kvm_set_pte_rmapp() to kvm_mmu_notifier_change_pte()
        4) Combine Vitaly's "don't pass EPT configuration info to
vmx_hv_remote_flush_tlb()" fix

Change since v2:
       1) Fix comment in the kvm_flush_remote_tlbs_with_range()
       2) Move HV_MAX_FLUSH_PAGES and HV_MAX_FLUSH_REP_COUNT to
        hyperv-tlfs.h.
       3) Calculate HV_MAX_FLUSH_REP_COUNT in the macro definition
       4) Use HV_MAX_FLUSH_REP_COUNT to define length of gpa_list in
        struct hv_guest_mapping_flush_list.

Change since v1:
       1) Convert "end_gfn" of struct kvm_tlb_range to "pages" in order
          to avoid confusion as to whether "end_gfn" is inclusive or exlusive.
       2) Add hyperv tlb range struct and replace kvm tlb range struct
          with new struct in order to avoid using kvm struct in the hyperv
          code directly.



Lan Tianyu (10):
  KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
  x86/hyper-v: Add HvFlushGuestAddressList hypercall support
  x86/Hyper-v: Add trace in the
    hyperv_nested_flush_guest_mapping_range()
  KVM/VMX: Add hv tlb range flush support
  KVM/MMU: Add tlb flush with range helper function
  KVM: Replace old tlb flush function with new one to flush a specified
    range.
  KVM: Make kvm_set_spte_hva() return int
  KVM/MMU: Move tlb flush in kvm_set_pte_rmapp() to
    kvm_mmu_notifier_change_pte()
  KVM/MMU: Flush tlb directly in the kvm_set_pte_rmapp()
  KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()

 arch/arm/include/asm/kvm_host.h     |  2 +-
 arch/arm64/include/asm/kvm_host.h   |  2 +-
 arch/mips/include/asm/kvm_host.h    |  2 +-
 arch/mips/kvm/mmu.c                 |  3 +-
 arch/powerpc/include/asm/kvm_host.h |  2 +-
 arch/powerpc/kvm/book3s.c           |  3 +-
 arch/powerpc/kvm/e500_mmu_host.c    |  3 +-
 arch/x86/hyperv/nested.c            | 80 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h  | 32 +++++++++++++
 arch/x86/include/asm/kvm_host.h     |  9 +++-
 arch/x86/include/asm/mshyperv.h     | 15 ++++++
 arch/x86/include/asm/trace/hyperv.h | 14 ++++++
 arch/x86/kvm/mmu.c                  | 96 +++++++++++++++++++++++++++++--------
 arch/x86/kvm/paging_tmpl.h          |  3 +-
 arch/x86/kvm/vmx.c                  | 63 +++++++++++++++++-------
 virt/kvm/arm/mmu.c                  |  6 ++-
 virt/kvm/kvm_main.c                 |  5 +-
 17 files changed, 292 insertions(+), 48 deletions(-)

-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
