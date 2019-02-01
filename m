Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40990C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:48:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2D3218FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WW+iKeFA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VclUM1Gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2D3218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=gSPumaI017l2mFMEJpRUZMkpsAX4aG4Bf6KbjNKNdTw=; b=WW+
	iKeFA95o3Lc2QFUz3SK3MwGrs9goGTRs8EVxou6vgU6vzVBwnaRyaLbFBTNEmJoJj9SryZH6JeYmg
	rZVuKGlNCl1q+zTOUZJc8RAgPkhOkipmhFBQRKGebGpRrf/wkJ9uAly/wRBoIubrdsNmK4nWi9aMX
	KniR/lvEvrBV61QJFj/r/NgVV8LfceOKxn3uFJiPxh9ZL19WjovGxPNqBXRChOm8xg/aj2R84EmEc
	+fJ5eEt3M6iHOnskqHAV9LTHYOkPZgSwvbnZdsYfHEFa9qCFtfFBdNm0spPT3sJKXeGgeH7L+JdZU
	tjQ+2DQ3d54zV5DGbZbQdQSLG5cDV9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpa7a-0001Jo-Rl; Fri, 01 Feb 2019 14:48:46 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpa7Y-0001JU-5Y
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 14:48:45 +0000
Received: by mail-pl1-x642.google.com with SMTP id e5so3321826plb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 06:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=BQS7eYX9HGve9LVug8wOO94RnbbcOyjLdKnO/lDDp2I=;
 b=VclUM1Gr6vplH2lc6Ex2uMcst7OpLUwzYdrhBjSpiDgIZg76ZHVjpKJ4U4SExjF3QV
 Od3ncVcWLzN8HgUVQB3KUYeup4HFmP2iE1LT+/OtaQTbCvbGUwggPiD6Pm/POl+Qa6BJ
 Md0Xm3LYjrStc9gxfllVcDGzfzcB78fp+FLJTEFRLG/J+Vi+TlYL2STO78l/1+ysLbe9
 gHtU5rJNNQMbJbNDj9yPz7VuQ6bZrSfnwP1kjrFJlgoKfVOTkOp5Qj/mst+wK1BwGFRm
 5YHV9KRzExaWbwjLj7uIzqTVFmXCxOB44fYAqN5swmaQaifUYQagLR1fr/V7merQuAco
 YdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=BQS7eYX9HGve9LVug8wOO94RnbbcOyjLdKnO/lDDp2I=;
 b=K2Fo+BevCNW6W3hMD2F2OLqW4UtdFWk9qHqvYROvEdoLz1MoCXIuEuIyxGAwGNwbv1
 mkZ0U0QJBg3IiQEv54Q0P2EzXwCPmdk1+TwTfK5wUyQSjvEWEC3t7kvxo5sODAGFS5Z7
 H2EzzJYt81CVBJ6ChISW3LAnTn/01AmTWaHT1y5KkTlmboCIy6BCif99Jd62oopf84ma
 BXyuHpNVhfElOuQPfPoJ5Y+JhpidrWJPWn28hMSQ+tnMghIbKb2TXZvHExQRejL7eMTl
 8sFw178IoczkN6QCmrZI+d0BWyZcBcRxi5R6JozQBDG0gUSsrngjizpi+0/63dH0ipvX
 cbWg==
X-Gm-Message-State: AJcUukdFJs+ZUXzbnJTKHPTzKH2hesZCarhM5nF5pO7b+wJv9EKxR0fD
 yj+qnV301cD5JT5ziwowCSg=
X-Google-Smtp-Source: ALg8bN5eyyO1GjD67omoBBXbC4wUV9Hny7kZddb4cDJA6juGAKguzsu8tLq3FRvPinM9K65VT/+xzg==
X-Received: by 2002:a17:902:8641:: with SMTP id
 y1mr39725750plt.159.1549032522270; 
 Fri, 01 Feb 2019 06:48:42 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id n74sm2309674pfi.163.2019.02.01.06.48.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 06:48:41 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V2 00/10] X86/KVM/Hyper-V: Add HV ept tlb range list flush
 support in KVM 
Date: Fri,  1 Feb 2019 22:48:12 +0800
Message-Id: <20190201144821.50409-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_064844_228443_AA75F458 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, benh@kernel.crashing.org,
 will.deacon@arm.com, christoffer.dall@arm.com, paulus@ozlabs.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 sashal@kernel.org, sthemmin@microsoft.com, mpe@ellerman.id.au, x86@kernel.org,
 linux@armlinux.org.uk, michael.h.kelley@microsoft.com, mingo@redhat.com,
 catalin.marinas@arm.com, jhogan@kernel.org, linux-mips@vger.kernel.org,
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

This patchset is to introduce hv ept tlb range list flush function
support in the KVM MMU component. Flushing ept tlbs of several address
range can be done via single hypercall and new list flush function is
used in the kvm_mmu_commit_zap_page() and FNAME(sync_page). This patchset
also adds more hv ept tlb range flush support in more KVM MMU function.

Change since v1:
       1) Make flush list as a hlist instead of list in order to 
       keep struct kvm_mmu_page size.
       2) Add last_level flag in the struct kvm_mmu_page instead
       of spte pointer
       3) Move tlb flush from kvm_mmu_notifier_clear_flush_young() to kvm_age_hva()
       4) Use range flush in the kvm_vm_ioctl_get/clear_dirty_log()

Lan Tianyu (10):
  X86/Hyper-V: Add parameter offset for
    hyperv_fill_flush_guest_mapping_list()
  KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
  KVM/MMU: Add last_level in the struct mmu_spte_page
  KVM/MMU: Introduce tlb flush with range list
  KVM/MMU: Flush tlb with range list in sync_page()
  KVM/MMU: Flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
  KVM: Add kvm_get_memslot() to get memslot via slot id
  KVM: Use tlb range flush in the kvm_vm_ioctl_get/clear_dirty_log()
  KVM: Add flush parameter for kvm_age_hva()
  KVM/MMU: Use tlb range flush  in the kvm_age_hva()

 arch/arm/include/asm/kvm_host.h     |  3 ++-
 arch/arm64/include/asm/kvm_host.h   |  3 ++-
 arch/mips/include/asm/kvm_host.h    |  3 ++-
 arch/mips/kvm/mmu.c                 | 11 ++++++--
 arch/powerpc/include/asm/kvm_host.h |  3 ++-
 arch/powerpc/kvm/book3s.c           | 10 ++++++--
 arch/powerpc/kvm/e500_mmu_host.c    |  3 ++-
 arch/x86/hyperv/nested.c            |  4 +--
 arch/x86/include/asm/kvm_host.h     | 11 +++++++-
 arch/x86/include/asm/mshyperv.h     |  2 +-
 arch/x86/kvm/mmu.c                  | 51 +++++++++++++++++++++++++++++--------
 arch/x86/kvm/mmu.h                  |  7 +++++
 arch/x86/kvm/paging_tmpl.h          | 15 ++++++++---
 arch/x86/kvm/vmx/vmx.c              | 18 +++++++++++--
 arch/x86/kvm/x86.c                  | 16 +++++++++---
 include/linux/kvm_host.h            |  1 +
 virt/kvm/arm/mmu.c                  | 13 ++++++++--
 virt/kvm/kvm_main.c                 | 51 +++++++++++++++----------------------
 18 files changed, 160 insertions(+), 65 deletions(-)

-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
