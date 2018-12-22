Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3D2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 09:52:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D422173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 09:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m6rom68B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iB93f2Nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D422173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=b8MkBKIXjniS6Gs2Ypzl0s6ZtIKvLy/wuIv6SWyJmtg=; b=m6r
	om68B5zTEdldFuqUg3ed9An4WEdRiDWtbVHbTiDG4uQ88Y7fX2jH52hmU4RrKDDqMhN6/xHdsS5ZT
	6JdxBb5kwuhzrZu6y3/aDImOG8QJ2v4a6C7uDgQsghcccBIO3dTbsZpSG9L5kfS4a7pwAw/zXv1uT
	cDzdlREuf3rU3ZnaSrgrRjRGdXL+ggDcjUbSv/UMFcuxdcsGY5U7lwGQzzCdJXV+2mnRXOjXBlorb
	lq5cPsKBYuTgUpWZBWsOGM0dgp2iPh1la9Hx3yKSvl3UuDEbnFEvdfPfr8uawOio0uq56iaq5agJD
	TAF7/xYx5xCYCfjbEPa402WrR4lF5pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gadwz-00066r-S9; Sat, 22 Dec 2018 09:52:05 +0000
Received: from conuserg-09.nifty.com ([210.131.2.76])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gadwo-0005zl-RB
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 09:51:56 +0000
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp
 [218.220.227.105]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id wBM9p7DN014613;
 Sat, 22 Dec 2018 18:51:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wBM9p7DN014613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1545472268;
 bh=ND+aJPnbi1isezN4iF7leDctF3P1l1D8eol/rcKWEro=;
 h=From:To:Cc:Subject:Date:From;
 b=iB93f2Ntt2Ldni+uOl09oWDHfUuCCp8GwIHthpte7aG6vsEjP929ZCgsZQVLH08yw
 yNkCMYGczG3pwShOdpZMYrwMVw7nnBVR5lSgSUVLk4BPQQ4YCovb7fNBCS2l3r5Jzq
 cxUTpkz6QEVFRr2S8bVNLnKHYJ6DOR0GX6AhlqHsByGyAfqcjLJsy3WqpbQSBaiqHL
 9oSTpkOQQWj0gc+GnvAUvicm6+KKcPjnfOWIFCV0ekvThcy5ambNgcOqTXvr2wlAZ7
 p78w6cScbHkTADrNW7GT+jrPJL9CGR+4hL1hEnMKOIKGl7z8WA5wL7NnvMKvXbBkTD
 UTPjiPANlaPAw==
X-Nifty-SrcIP: [218.220.227.105]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH 1/3] treewide: remove explicit rules for *offsets.s
Date: Sat, 22 Dec 2018 18:50:33 +0900
Message-Id: <1545472235-12782-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_015155_186076_72218A38 
X-CRM114-Status: UNSURE (   8.48  )
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
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, Tony Lindgren <tony@atomide.com>,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These explicit rules are unneeded because scripts/Makefile.build
provides a pattern rule to create %.s from %.c

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Kbuild                              | 9 +--------
 arch/arm/mach-at91/Makefile         | 3 ---
 arch/arm/mach-omap2/Makefile        | 3 ---
 arch/ia64/kernel/Makefile           | 5 -----
 drivers/memory/Makefile.asm-offsets | 3 ---
 samples/bpf/Makefile                | 3 ---
 6 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/Kbuild b/Kbuild
index 0053042..b24210c 100644
--- a/Kbuild
+++ b/Kbuild
@@ -16,10 +16,6 @@ bounds-file := include/generated/bounds.h
 always  := $(bounds-file)
 targets := kernel/bounds.s
 
-# We use internal kbuild rules to avoid the "is up to date" message from make
-kernel/bounds.s: kernel/bounds.c FORCE
-	$(call if_changed_dep,cc_s_c)
-
 $(obj)/$(bounds-file): kernel/bounds.s FORCE
 	$(call filechk,offsets,__LINUX_BOUNDS_H__)
 
@@ -50,10 +46,7 @@ offsets-file := include/generated/asm-offsets.h
 always  += $(offsets-file)
 targets += arch/$(SRCARCH)/kernel/asm-offsets.s
 
-# We use internal kbuild rules to avoid the "is up to date" message from make
-arch/$(SRCARCH)/kernel/asm-offsets.s: arch/$(SRCARCH)/kernel/asm-offsets.c \
-                                      $(obj)/$(timeconst-file) $(obj)/$(bounds-file) FORCE
-	$(call if_changed_dep,cc_s_c)
+arch/$(SRCARCH)/kernel/asm-offsets.s: $(obj)/$(timeconst-file) $(obj)/$(bounds-file)
 
 $(obj)/$(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 7415f18..f87066b 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -19,9 +19,6 @@ ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
 endif
 
-arch/arm/mach-at91/pm_data-offsets.s: arch/arm/mach-at91/pm_data-offsets.c
-	$(call if_changed_dep,cc_s_c)
-
 include/generated/at91_pm_data-offsets.h: arch/arm/mach-at91/pm_data-offsets.s FORCE
 	$(call filechk,offsets,__PM_DATA_OFFSETS_H__)
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 01377c2..55c482c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -236,9 +236,6 @@ obj-y					+= omap_phy_internal.o
 
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 
-arch/arm/mach-omap2/pm-asm-offsets.s: arch/arm/mach-omap2/pm-asm-offsets.c
-	$(call if_changed_dep,cc_s_c)
-
 include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORCE
 	$(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
 
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index d0c0ccd..7372d99 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -50,10 +50,5 @@ CFLAGS_traps.o  += -mfixed-range=f2-f5,f16-f31
 # The gate DSO image is built using a special linker script.
 include $(src)/Makefile.gate
 
-# We use internal kbuild rules to avoid the "is up to date" message from make
-arch/$(SRCARCH)/kernel/nr-irqs.s: arch/$(SRCARCH)/kernel/nr-irqs.c
-	$(Q)mkdir -p $(dir $@)
-	$(call if_changed_dep,cc_s_c)
-
 include/generated/nr-irqs.h: arch/$(SRCARCH)/kernel/nr-irqs.s FORCE
 	$(call filechk,offsets,__ASM_NR_IRQS_H__)
diff --git a/drivers/memory/Makefile.asm-offsets b/drivers/memory/Makefile.asm-offsets
index 843ff60..f968dfa 100644
--- a/drivers/memory/Makefile.asm-offsets
+++ b/drivers/memory/Makefile.asm-offsets
@@ -1,5 +1,2 @@
-drivers/memory/emif-asm-offsets.s: drivers/memory/emif-asm-offsets.c
-	$(call if_changed_dep,cc_s_c)
-
 include/generated/ti-emif-asm-offsets.h: drivers/memory/emif-asm-offsets.s FORCE
 	$(call filechk,offsets,__TI_EMIF_ASM_OFFSETS_H__)
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index be0a961..100a49d 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -227,9 +227,6 @@ $(LIBBPF): FORCE
 # Fix up variables inherited from Kbuild that tools/ build system won't like
 	$(MAKE) -C $(dir $@) RM='rm -rf' LDFLAGS= srctree=$(BPF_SAMPLES_PATH)/../../ O=
 
-$(obj)/syscall_nrs.s:	$(src)/syscall_nrs.c
-	$(call if_changed_dep,cc_s_c)
-
 $(obj)/syscall_nrs.h:	$(obj)/syscall_nrs.s FORCE
 	$(call filechk,offsets,__SYSCALL_NRS_H__)
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
