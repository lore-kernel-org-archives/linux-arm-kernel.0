Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCB7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDA821871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jnzMsQU/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7OB0Rv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDA821871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=rs4x7rOme3li6apPbPJ3cQsT+XNdrtsEMEWRpch6axo=; b=jnz
	MsQU/9Wsi0w6NIVLltf5xML7eZ/QGkXEyzxf64dri78Kej0kvREMyVcIdZx/55ZBRrQ4lM1g0t6ZU
	5m9is0YlQkUFbr4y99AsoANHqa121+EnmzRAnR8LAA4nf9Pncp3CQhD5tRgTf7x934DmVWQL4YGkX
	tq/+kCnt6kUTpXhLObGC1PDxrJ/PCxcfcZHeZC9w+8NjhDyj50zwh9NVZorDeO0c+F3hL6yt6wMA0
	LQAHG5GLhKBwKIkvYL3Ses8NBNqQflWbhPtn0UNaUEUQaChkrGJZliwuYRmCaoF/Y0rip3MP5avdq
	rBOY3SBD2frI9q4u82+JjBbWJjAytjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfLFH-0005sj-Eg; Fri, 04 Jan 2019 08:54:23 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfLFD-0005sM-RE
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 08:54:21 +0000
Received: by mail-pf1-x442.google.com with SMTP id b85so18003161pfc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 04 Jan 2019 00:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=s54CWoMBwC/zNmAKjZOvrFS4zL5cc4VeheWOnWbsbcs=;
 b=X7OB0Rv6x6K201MwLVR0NTSf1nCzTgQvzvZlrHC9jbh5Yn/NUxF7S9JpxOff2/a67c
 /3NkSl0D7Dactf3miq3lgBXrXbLPGEYwZVcNhlX9gbH+ahhnogWtMfnIir2t1FU8P0Ep
 Bd8uWIIrc5Y/CScBFsHSrpZCa+TXWV2fnc2zaG8foh9m/Ngph5755U9dYDS7+Hb/1hB/
 XaiDrEZD3zQ8RXSYE5FyIYQ4/xzDvNRbFkPIuonph7cd8cx7O6TAG7GpskNlktUtzTaz
 gvohfnLVuQvGbT8ubil3v+QMn68aLirQOnws2NCk1cvyGbQihEcAF2esmC+//BFrOhJs
 bGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=s54CWoMBwC/zNmAKjZOvrFS4zL5cc4VeheWOnWbsbcs=;
 b=FiMUDrjPf5fJWvP2Zb6Taa4gP3+o9PbVSynwL/XsKXORMoCt17tRlYP732W7/UHUnW
 jwSCHO00RUz3gmNXP3gkoyCe3i4axY2cgWuvG3WrYzz8BgBnVXxh81na0VVT5tWMFnxs
 0q0v/hfT0/QFpmA88Q8yPbuQdKL1/KHR/rkQHc4kFfEuzyXsv2ikSrIhOfV0nUOQnANo
 in8JuXsXXlZ4KNxzPUSpVRzDgyNKnEMBGuGwAlwJ67yxuykt5ALuQkKeLDMFJUYIH0LA
 RJYcMiTV33ergz9AYw68mICIpJWIeMHB9pc9gSbxXAuSDi5X+7q9/Y6xW4bZV69ZeT6I
 yOuw==
X-Gm-Message-State: AJcUukf6Hfm/9F6umwxKtsQfBvkfO4hvIm7ST7xFLlFh0XONDSxZSuFz
 FYig6qWzBcNfSoY5JN/1U0A=
X-Google-Smtp-Source: ALg8bN6TKO/FbJdy9H6pHPilkdPA0uBYPyFKYsWoLiF0HM2Gb0AxFE+KDE3IQXIY+upyYE2K8qdZag==
X-Received: by 2002:a63:554b:: with SMTP id f11mr923300pgm.37.1546592059172;
 Fri, 04 Jan 2019 00:54:19 -0800 (PST)
Received: from localhost.corp.microsoft.com
 ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
 by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 04 Jan 2019 00:54:18 -0800 (PST)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: 
Subject: [PATCH 00/11] X86/KVM/Hyper-V: Add HV ept tlb range list flush
 support in KVM
Date: Fri,  4 Jan 2019 16:53:54 +0800
Message-Id: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_005419_939609_12BCDBD7 
X-CRM114-Status: UNSURE (   8.23  )
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
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, benh@kernel.crashing.org,
 will.deacon@arm.com, christoffer.dall@arm.com, paulus@ozlabs.org,
 hpa@zytor.com, kys@microsoft.com, kvmarm@lists.cs.columbia.edu,
 sthemmin@microsoft.com, mpe@ellerman.id.au, x86@kernel.org,
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

Lan Tianyu (11):
  X86/Hyper-V: Add parameter offset for
    hyperv_fill_flush_guest_mapping_list()
  KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
  KVM: Add spte's point in the struct kvm_mmu_page
  KVM/MMU: Introduce tlb flush with range list
  KVM/MMU: Flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
  KVM/MMU: Flush tlb with range list in sync_page()
  KVM: Remove redundant check in the kvm_get_dirty_log_protect()
  KVM: Make kvm_arch_mmu_enable_log_dirty_pt_masked() return value
  KVM/MMU: Flush tlb in the kvm_mmu_write_protect_pt_masked()
  KVM: Add flush parameter for kvm_age_hva()
  KVM/MMU: Flush tlb in the kvm_age_rmapp()

 arch/arm/include/asm/kvm_host.h     |  3 +-
 arch/arm64/include/asm/kvm_host.h   |  3 +-
 arch/mips/include/asm/kvm_host.h    |  3 +-
 arch/mips/kvm/mmu.c                 |  8 +++-
 arch/powerpc/include/asm/kvm_host.h |  3 +-
 arch/powerpc/kvm/book3s.c           |  3 +-
 arch/powerpc/kvm/e500_mmu_host.c    |  3 +-
 arch/x86/hyperv/nested.c            |  4 +-
 arch/x86/include/asm/kvm_host.h     | 11 +++++-
 arch/x86/include/asm/mshyperv.h     |  2 +-
 arch/x86/kvm/mmu.c                  | 73 ++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/paging_tmpl.h          | 18 ++++++++-
 arch/x86/kvm/vmx/vmx.c              | 18 ++++++++-
 include/linux/kvm_host.h            |  2 +-
 virt/kvm/arm/mmu.c                  |  8 +++-
 virt/kvm/kvm_main.c                 | 18 ++++-----
 16 files changed, 141 insertions(+), 39 deletions(-)

-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
