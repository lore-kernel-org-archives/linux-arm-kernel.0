Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25139C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79372070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uMXcMtqn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHeHpCpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79372070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=a2HACFaunbeEpKJe5aiWxiqGiEDcksVqoKiwMk4MLmc=; b=uMX
	cMtqne/Pq/P6XBU0MeZmkABuL7zfjxvJ/a06DbTh5SpKdc+cGV2HsjfQgYV8QsGdTlfCexYBVjeeK
	0u4INkozKZCoZkQihN18C9++VNs1PjnhVmX+ymEubB6h/2u5T3TU1mPptHTdOLJX5sZuNvTA8qNfm
	7/y/UJyZUPTQI+5ZaQan7WzETAN46EjCzaiKJE/L55qCKRlUxcvRadWCkHrk6aw9pPc0t8BFsJNwo
	JRmnNLF5Kjkg2bCRrPwH3Y0wlTENqK088Kk/xl3k7t2I6U9Ocz7d7fcGftb6+Te2df3TLsCrJkGzk
	438yWgazJhbSdQjfWJY7jhB3pEoIcPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCPj-00084U-B4; Fri, 22 Feb 2019 15:06:59 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCPg-00084A-0N
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:06:57 +0000
Received: by mail-pl1-x642.google.com with SMTP id r14so1207094pls.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=EiQBCSDAIf/suoeIwapm+FX4BR230o85XgcWooq6xpo=;
 b=oHeHpCpvC2AoMktGH/FylVXGTrHXAAlZwXTLNGNTPVr+jXY93hFWcuEeceYTyB2prt
 2rvvFgZ3gQU9hBYqEtXQWn4hXd7/3XkuVewfkGv86mW/NUOf2IvLU9H7mEBwl9Gp1u5L
 +jVImO1D2WzSZMxc7RsGxQtHnhV52l0CIjRzNeg1ujDJqpuVFpblk6qFUaS5lAJagbAQ
 BAyxleQsFdr6Gar/VUDt0QtIf4RMlt73YvIZG7rrHMOcsQUVh68pS/QQCfbhRVvtNJN7
 yZbM5BhQLh6tbXzh5iSAT/wgHpkQqs+pDJZ27Fh8wqM/R9hDywOjjUORLVOpG/utNIkI
 X0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=EiQBCSDAIf/suoeIwapm+FX4BR230o85XgcWooq6xpo=;
 b=ScZdJ3qpdW2EuOJlY+m87LJpmwfZi/Sf6GxOZamUmdRCq0AsB16EYUeCL6lKUOyBkp
 mAk4P8T589hNqFuSCEMyqwlOYG0QJQTSkNfQEzCR89oiwtvR3pNVFHqsL+mWwcb8MrvW
 lKZKuYNjIRZX5IJuquAkv85i4ytcaTbUz7YyP/bN3bB+Lu8YjG2yjLGupG2xmYp2t0Pz
 1TPZZQJDqx9Uxxsa2HWHm2akgrMolGbHHgxaVnVkOvTk7GDCVd2I5ahW/zMOxlaB0XZI
 6GXfEHpuJy/eV/A2g2uh7STQLCb1kJ3o76YI9f6jT48NwSKO2RZ3AEk0WrxRZRXbipPm
 qX/g==
X-Gm-Message-State: AHQUAuYk2MUJ2xbCnXlqDsOtuXWdd02OmvYg6bYT6TQy2Y7TpSqh0ZJ0
 UKfJSGabNoE6FUb+4Bf843c=
X-Google-Smtp-Source: AHgI3IZbPWlYQzuwjEhbQFDPOboaR5xFVm1PNF+pNbeBeCaY7FX4MLfmcdiKb1W6D3NMvqNF02xA3A==
X-Received: by 2002:a17:902:2de4:: with SMTP id
 p91mr4658872plb.215.1550848015074; 
 Fri, 22 Feb 2019 07:06:55 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
 by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.06.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 07:06:54 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH V3 00/10] X86/KVM/Hyper-V: Add HV ept tlb range list flush
 support in KVM 
Date: Fri, 22 Feb 2019 23:06:27 +0800
Message-Id: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_070656_048640_B1C549C3 
X-CRM114-Status: GOOD (  10.05  )
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

This patchset is based on the fix patch "x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT".
(https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1939455.html)

Change since v2:
	1) Fix calculation of flush pages in the kvm_fill_hv_flush_list_func()
	2) Change the logic of setting/clearing last_level flag

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
  KVM/MMU: Introduce tlb flush with range list
  KVM/MMU: Use range flush in sync_page()
  KVM/MMU: Flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
  KVM: Add kvm_get_memslot() to get memslot via slot id
  KVM: Use tlb range flush in the kvm_vm_ioctl_get/clear_dirty_log()
  KVM: Add flush parameter for kvm_age_hva()
  KVM/MMU: Use tlb range flush in the kvm_age_hva()
  KVM/MMU: Add last_level flag in the struct mmu_spte_page

 arch/arm/include/asm/kvm_host.h     |  3 +-
 arch/arm64/include/asm/kvm_host.h   |  3 +-
 arch/mips/include/asm/kvm_host.h    |  3 +-
 arch/mips/kvm/mmu.c                 | 11 ++++++--
 arch/powerpc/include/asm/kvm_host.h |  3 +-
 arch/powerpc/kvm/book3s.c           | 10 +++++--
 arch/powerpc/kvm/e500_mmu_host.c    |  3 +-
 arch/x86/hyperv/nested.c            |  4 +--
 arch/x86/include/asm/kvm_host.h     | 11 +++++++-
 arch/x86/include/asm/mshyperv.h     |  2 +-
 arch/x86/kvm/mmu.c                  | 55 ++++++++++++++++++++++++++++++-------
 arch/x86/kvm/mmu.h                  |  7 +++++
 arch/x86/kvm/paging_tmpl.h          |  5 ++--
 arch/x86/kvm/vmx/vmx.c              | 18 ++++++++++--
 arch/x86/kvm/x86.c                  | 16 ++++++++---
 include/linux/kvm_host.h            |  1 +
 virt/kvm/arm/mmu.c                  | 13 +++++++--
 virt/kvm/kvm_main.c                 | 51 ++++++++++++++--------------------
 18 files changed, 156 insertions(+), 63 deletions(-)

-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
