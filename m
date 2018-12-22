Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4A5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 09:52:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E226219FC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 09:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Epjmxdfc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Uj35dlCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E226219FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=x7jpabw3gzlsweOFflvTZFw/t4dz6wGAT8Z6RC2YkeE=; b=EpjmxdfcgHLLKLWbQleEwRuecJ
	ji4NzaNIzmhsfw0XBGBk3O7xCLQBk6xs9ADNjbMH3ek538mvRD7QrXK4Yuo6+cb1nSxEBtrqifGKt
	28h/TV5aw96omIWWDkZR/nwXjVpQ4LP6GXaH8zqzDOb11ZnjqqHzGi5alFwCZT4cM2dn0p0TzvlVH
	88LIkuFZ1+mH/wPrxB4dqmjh6lTLstPN6L3mlLx6tbXimaYRMskp9nceQXrUc5OiogNbp7clhdfhE
	iFpfaAtv2xlZF35yOnEOAWPltfkItrwOy3ZRoG3fl2FwO8qOw3KVj/u63N9DfC2yCZKENifEWEjFg
	tPB+Q0Ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gadws-00060m-C5; Sat, 22 Dec 2018 09:51:58 +0000
Received: from conuserg-09.nifty.com ([210.131.2.76])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gadwo-0005zm-Q9; Sat, 22 Dec 2018 09:51:56 +0000
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp
 [218.220.227.105]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id wBM9p7DO014613;
 Sat, 22 Dec 2018 18:51:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wBM9p7DO014613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1545472270;
 bh=wiIUzgc+fysfmDuxKAkmwaprsNIQhVxjxb/GXgFvzRs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Uj35dlCjpYUATghrAgk9dVF7mNbFFvEQ2gVPCbncqlT35c5N6+OIC2oU4Mt58orHo
 3f74sas/9hAo23IUa4hcwuvxME27/oaW92kP+oPV1eVeR1dSuH1GtD84aZXyWEYISe
 YupW5gqHOpRi3nDSJ/F/AYxw6xyG7ppPSInlYJeWUafCUn6nCcDi0rSUsnJsIxbYWr
 qkbAro2J2Ha3eWvKF93z8g/vCOUcP2CgmWMzDNhkkvITA+jsQM7gL2m+S6nIaI6C79
 jgUpEVzFZPikxvZcz341HYrPX19aPt4et2ICtNVZxR/pAdZnaq8+VsaMw40mIXrGpe
 h55lbS8smdkzw==
X-Nifty-SrcIP: [218.220.227.105]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH 2/3] treewide: add intermediate .s files to targets
Date: Sat, 22 Dec 2018 18:50:34 +0900
Message-Id: <1545472235-12782-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545472235-12782-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545472235-12782-1-git-send-email-yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_015155_186546_1B2B079F 
X-CRM114-Status: UNSURE (   8.18  )
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-ia64@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tony Luck <tony.luck@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Avoid unneeded recreation of these in the incremental build.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-at91/Makefile         | 2 ++
 arch/arm/mach-omap2/Makefile        | 2 ++
 arch/ia64/kernel/Makefile           | 2 ++
 arch/x86/um/Makefile                | 1 +
 drivers/memory/Makefile.asm-offsets | 2 ++
 samples/bpf/Makefile                | 1 +
 6 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index f87066b..31b61f0 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -23,3 +23,5 @@ include/generated/at91_pm_data-offsets.h: arch/arm/mach-at91/pm_data-offsets.s F
 	$(call filechk,offsets,__PM_DATA_OFFSETS_H__)
 
 arch/arm/mach-at91/pm_suspend.o: include/generated/at91_pm_data-offsets.h
+
+targets += pm_data-offsets.s
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 55c482c..4afdf56 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -240,3 +240,5 @@ include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORC
 	$(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
 
 $(obj)/sleep33xx.o $(obj)/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
+
+targets += pm-asm-offsets.s
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 7372d99..4ba0514 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -52,3 +52,5 @@ include $(src)/Makefile.gate
 
 include/generated/nr-irqs.h: arch/$(SRCARCH)/kernel/nr-irqs.s FORCE
 	$(call filechk,offsets,__ASM_NR_IRQS_H__)
+
+targets += nr-irqs.s
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 1792464..2d686ae 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -38,6 +38,7 @@ USER_OBJS := bugs_$(BITS).o ptrace_user.o fault.o
 
 $(obj)/user-offsets.s: c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
 	-Iarch/x86/include/generated
+targets += user-offsets.s
 
 include/generated/user_constants.h: $(obj)/user-offsets.s
 	$(call filechk,offsets,__USER_CONSTANT_H__)
diff --git a/drivers/memory/Makefile.asm-offsets b/drivers/memory/Makefile.asm-offsets
index f968dfa..0447e17 100644
--- a/drivers/memory/Makefile.asm-offsets
+++ b/drivers/memory/Makefile.asm-offsets
@@ -1,2 +1,4 @@
 include/generated/ti-emif-asm-offsets.h: drivers/memory/emif-asm-offsets.s FORCE
 	$(call filechk,offsets,__TI_EMIF_ASM_OFFSETS_H__)
+
+targets += emif-asm-offsets.s
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 100a49d..82d5a38 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -230,6 +230,7 @@ $(LIBBPF): FORCE
 $(obj)/syscall_nrs.h:	$(obj)/syscall_nrs.s FORCE
 	$(call filechk,offsets,__SYSCALL_NRS_H__)
 
+targets += syscall_nrs.s
 clean-files += syscall_nrs.h
 
 FORCE:
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
