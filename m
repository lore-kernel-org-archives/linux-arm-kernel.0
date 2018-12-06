Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83926C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:07:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5258D20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rySFqlNi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cdx5yfZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5258D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jqY1uedydoKWaB3WY60DgbjOrltmz4OZAbsY3mG6kns=; b=rySFqlNiyRGsP8
	Wea+w4c0D44nXV0E9E/CfalHN+SUfmiK+ZEqSpdyRejNFJomHjytLm7ZKlUGJ2/Abg17z8tQpOOKU
	t/CkJv/Hkx1/tSZWv+NH8zWygadh1I0sxQN1MN49LpzS3jWc82VCIqvj4iKcsH0a9E/PM3kSNwGdA
	nmjlRHEJmwmF0ZRUsYKs9S0sRBWxkuVoRHz5Y4u9gmAGmX9z+Dr7ziqipJccEbnIqNB8eEQjb/H8v
	CpY7UMjlba7unAH5w7HaU/Whq7AJY5xJU/3Iy9fezNcW2QzOX4yum/lT+l6Nenfh7DOduyVFKeRUE
	FVFHokD9z8v2dFV05K8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuJl-0007OO-8e; Thu, 06 Dec 2018 14:07:53 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuJZ-00077c-KH
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:07:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UyMSo+naR99Pv0F0aWFN2jTp9Fzo46J0z2hR4/NXHFw=; b=Cdx5yfZj4J1beacPCEe6beZ91
 iFhMGqf45/ABinU0EHp9lt3k2e03ZrNcJs0oVMLS5dgpTw6q6WZBk7gzNxwnyK3Nci2BiQqtO2u1Y
 qAN3w9hCXclxfJ/0R1ABUCfzmSB3xwCo8AlxxqUXAeueZHJNHpqPHrgCdDSdTniH0p2Gc=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:40226)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gUuJH-00023a-7X; Thu, 06 Dec 2018 14:07:23 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gUuJD-0002sF-82; Thu, 06 Dec 2018 14:07:19 +0000
Date: Thu, 6 Dec 2018 14:07:17 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 5/5] ARM: spectre-v2: per-CPU vtables to work around
 big.Little systems
Message-ID: <20181206140717.GU30658@n2100.armlinux.org.uk>
References: <20181106123700.GA30658@n2100.armlinux.org.uk>
 <CGME20181106124037epcas4p35f0ed44d430e44310e764190f15c2883@epcas4p3.samsung.com>
 <E1gK0dU-0007Mp-4h@rmk-PC.armlinux.org.uk>
 <dda0be26-5ac8-a158-3210-4bc6861bede2@samsung.com>
 <20181206100052.GR30658@n2100.armlinux.org.uk>
 <CAJKOXPdUFfOXqMkgdv4fjhpbrmjNmw_f9cMj03a2h65snNJ4qw@mail.gmail.com>
 <20181206123956.GS30658@n2100.armlinux.org.uk>
 <CAJKOXPf=nGN53EK=+bjhKyaY_knMnY5J+JSW2Jb6KRQuJy37vA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJKOXPf=nGN53EK=+bjhKyaY_knMnY5J+JSW2Jb6KRQuJy37vA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_060742_697805_37F55934 
X-CRM114-Status: GOOD (  27.54  )
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
Cc: mark.rutland@arm.com, julien.thierry@arm.com, marc.zyngier@arm.com,
 will.deacon@arm.com, Morten.Rasmussen@arm.com, Qais.Yousef@arm.com,
 dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 02:54:10PM +0100, Krzysztof Kozlowski wrote:
> On Thu, 6 Dec 2018 at 13:40, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Dec 06, 2018 at 11:24:27AM +0100, Krzysztof Kozlowski wrote:
> > > On Thu, 6 Dec 2018 at 11:01, Russell King - ARM Linux
> > > <linux@armlinux.org.uk> wrote:
> > > > I've no idea based on what you've supplied given that the SoC
> > > > maintainers are responsible for writing the code to deal with hotplug
> > > > etc, and Exynos's code there is something of a maze.  It's not clear
> > > > which bits are being used.  I think you at the very least need to debug
> > > > to find out whether the problem is at CPU down or CPU up.
> > > >
> > > > From the ARM architecture point of view, for Cortex A9, all the
> > > > processor function instances should be identical.  The only difference
> > > > as a result of the patch is that we'll be calling smp_processor_id()
> > > > early (which should be fine), and indirecting through the cpu_vtable[]
> > > > array rather than merely dereferencing the processor struct.
> > > >
> > > > What about checking dmesg - messages from offline CPUs do not appear
> > > > on the console(s) but are still logged in the kernel log.
> > > >
> > > > You could try making PROC_VTABLE() the same as PROC_TABLE() (iow,
> > > > always access cpu_vtable[0]) to see whether it's the smp_processor_id()
> > > > that's causing your problem or not.  If it is, then try and work out
> > > > which of the processor functions is causing it by restoring
> > > > PROC_VTABLE() and then switching each from PROC_VTABLE() to
> > > > PROC_TABLE() until it does work.
> > >
> > > Thanks for hints!
> >
> > So I can plan, how long do you think it will take to get some results
> > from my suggestions above?
> 
> For Suspend to RAM, on v4.20-rc3, this warning appears:
> [   84.046722] WARNING: CPU: 1 PID: 0 at
> ../arch/arm/include/asm/proc-fns.h:124
> secondary_start_kernel+0x214/0x26c
> (difference between dcache_clean_area)
> The secondary CPUs bringup fails with ETIMEDOUT.

That basically means that the dcache_clean_area method for CPU1
differs from the dcache_clean_area method for CPU0.  If all your
CPUs are identical, that definitely should not be happening.

Hmm.  Interestingly, OMAP4430 passes hotplug tests just fine.

Please try this patch.

 arch/arm/mm/proc-arm1020.S  | 6 ++----
 arch/arm/mm/proc-arm1020e.S | 5 ++---
 arch/arm/mm/proc-arm1022.S  | 5 ++---
 arch/arm/mm/proc-arm1026.S  | 5 ++---
 arch/arm/mm/proc-arm720.S   | 5 ++---
 arch/arm/mm/proc-arm740.S   | 4 +---
 arch/arm/mm/proc-arm7tdmi.S | 4 +---
 arch/arm/mm/proc-arm920.S   | 5 ++---
 arch/arm/mm/proc-arm922.S   | 5 ++---
 arch/arm/mm/proc-arm925.S   | 5 ++---
 arch/arm/mm/proc-arm926.S   | 4 +---
 arch/arm/mm/proc-arm940.S   | 4 +---
 arch/arm/mm/proc-arm946.S   | 4 +---
 arch/arm/mm/proc-arm9tdmi.S | 4 +---
 arch/arm/mm/proc-fa526.S    | 4 +---
 arch/arm/mm/proc-feroceon.S | 4 +---
 arch/arm/mm/proc-mohawk.S   | 4 +---
 arch/arm/mm/proc-sa110.S    | 4 +---
 arch/arm/mm/proc-sa1100.S   | 5 +----
 arch/arm/mm/proc-v6.S       | 4 +---
 arch/arm/mm/proc-v7.S       | 4 +---
 arch/arm/mm/proc-v7m.S      | 3 ++-
 arch/arm/mm/proc-xsc3.S     | 4 +---
 arch/arm/mm/proc-xscale.S   | 4 +---
 24 files changed, 33 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index 774ef1323554..48e72b1a6351 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -470,13 +470,11 @@ ENTRY(cpu_arm1020_set_pte_ext)
 arm1020_crval:
 	crval	clear=0x0000593f, mmuset=0x00003935, ucset=0x00001930
 
-	__INITDATA
+	.section ".rodata"
+
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm1020, dabort=v4t_early_abort, pabort=legacy_pabort
 
-
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv5t"
 	string	cpu_elf_name, "v5"
 
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index ae3c27b71594..1efc99b158b4 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -451,12 +451,11 @@ ENTRY(cpu_arm1020e_set_pte_ext)
 arm1020e_crval:
 	crval	clear=0x00007f3f, mmuset=0x00003935, ucset=0x00001930
 
-	__INITDATA
+	.section ".rodata"
+
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm1020e, dabort=v4t_early_abort, pabort=legacy_pabort
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv5te"
 	string	cpu_elf_name, "v5"
 	string	cpu_arm1020e_name, "ARM1020E"
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index dbb2413fe04d..84b911236d9c 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -436,12 +436,11 @@ ENTRY(cpu_arm1022_set_pte_ext)
 arm1022_crval:
 	crval	clear=0x00007f3f, mmuset=0x00003935, ucset=0x00001930
 
-	__INITDATA
+	.section ".rodata"
+
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm1022, dabort=v4t_early_abort, pabort=legacy_pabort
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv5te"
 	string	cpu_elf_name, "v5"
 	string	cpu_arm1022_name, "ARM1022"
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 0b37b2cef9d3..802a54128041 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -430,12 +430,11 @@ ENTRY(cpu_arm1026_set_pte_ext)
 arm1026_crval:
 	crval	clear=0x00007f3f, mmuset=0x00003935, ucset=0x00001934
 
-	__INITDATA
+	.section .rodata
+
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm1026, dabort=v5t_early_abort, pabort=legacy_pabort
 
-	.section .rodata
-
 	string	cpu_arch_name, "armv5tej"
 	string	cpu_elf_name, "v5"
 	.align
diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
index 3651cd70e418..6b2215ea8b25 100644
--- a/arch/arm/mm/proc-arm720.S
+++ b/arch/arm/mm/proc-arm720.S
@@ -169,12 +169,11 @@ ENDPROC(cpu_arm720_reset)
 arm720_crval:
 	crval	clear=0x00002f3f, mmuset=0x0000213d, ucset=0x00000130
 
-		__INITDATA
+		.section ".rodata"
+
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm720, dabort=v4t_late_abort, pabort=legacy_pabort
 
-		.section ".rodata"
-
 	string	cpu_arch_name, "armv4t"
 	string	cpu_elf_name, "v4"
 	string	cpu_arm710_name, "ARM710T"
diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
index 024fb7732407..95a3a2ea0076 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -119,13 +119,11 @@ ENDPROC(cpu_arm740_reset)
 
 	.size	__arm740_setup, . - __arm740_setup
 
-	__INITDATA
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm740, dabort=v4t_late_abort, pabort=legacy_pabort, nommu=1
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv4"
 	string	cpu_elf_name, "v4"
 	string	cpu_arm740_name, "ARM740T"
diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
index 25472d94426d..32e55e146ce1 100644
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ b/arch/arm/mm/proc-arm7tdmi.S
@@ -56,13 +56,11 @@ ENDPROC(cpu_arm7tdmi_reset)
 		ret	lr
 		.size	__arm7tdmi_setup, . - __arm7tdmi_setup
 
-		__INITDATA
+		.section ".rodata"
 
 		@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 		define_processor_functions arm7tdmi, dabort=v4t_late_abort, pabort=legacy_pabort, nommu=1
 
-		.section ".rodata"
-
 		string	cpu_arch_name, "armv4t"
 		string	cpu_elf_name, "v4"
 		string	cpu_arm7tdmi_name, "ARM7TDMI"
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 7a14bd4414c9..68ffbdafe3bd 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -436,12 +436,11 @@ ENDPROC(cpu_arm920_do_resume)
 arm920_crval:
 	crval	clear=0x00003f3f, mmuset=0x00003135, ucset=0x00001130
 
-	__INITDATA
+	.section ".rodata"
+
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm920, dabort=v4t_early_abort, pabort=legacy_pabort, suspend=1
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv4t"
 	string	cpu_elf_name, "v4"
 	string	cpu_arm920_name, "ARM920T"
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index edccfcdcd551..dddff4955e63 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -414,12 +414,11 @@ ENTRY(cpu_arm922_set_pte_ext)
 arm922_crval:
 	crval	clear=0x00003f3f, mmuset=0x00003135, ucset=0x00001130
 
-	__INITDATA
+	.section ".rodata"
+
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm922, dabort=v4t_early_abort, pabort=legacy_pabort
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv4t"
 	string	cpu_elf_name, "v4"
 	string	cpu_arm922_name, "ARM922T"
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 32a47cc19076..0a5006a04fb9 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -479,12 +479,11 @@ ENTRY(cpu_arm925_set_pte_ext)
 arm925_crval:
 	crval	clear=0x00007f3f, mmuset=0x0000313d, ucset=0x00001130
 
-	__INITDATA
+	.section ".rodata"
+
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm925, dabort=v4t_early_abort, pabort=legacy_pabort
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv4t"
 	string	cpu_elf_name, "v4"
 	string	cpu_arm925_name, "ARM925T"
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index fb827c633693..e6582a96c11f 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -461,13 +461,11 @@ ENDPROC(cpu_arm926_do_resume)
 arm926_crval:
 	crval	clear=0x00007f3f, mmuset=0x00003135, ucset=0x00001134
 
-	__INITDATA
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm926, dabort=v5tj_early_abort, pabort=legacy_pabort, suspend=1
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv5tej"
 	string	cpu_elf_name, "v5"
 	string	cpu_arm926_name, "ARM926EJ-S"
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index ee5b66f847c4..afb2d8018bbf 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -331,13 +331,11 @@ ENDPROC(arm940_dma_unmap_area)
 
 	.size	__arm940_setup, . - __arm940_setup
 
-	__INITDATA
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm940, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv4t"
 	string	cpu_elf_name, "v4"
 	string	cpu_arm940_name, "ARM940T"
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 7361837edc31..bff88a20c37d 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -386,13 +386,11 @@ ENTRY(cpu_arm946_dcache_clean_area)
 
 	.size	__arm946_setup, . - __arm946_setup
 
-	__INITDATA
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions arm946, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv5te"
 	string	cpu_elf_name, "v5t"
 	string	cpu_arm946_name, "ARM946E-S"
diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
index 7fac8c612134..06b3503b5513 100644
--- a/arch/arm/mm/proc-arm9tdmi.S
+++ b/arch/arm/mm/proc-arm9tdmi.S
@@ -56,13 +56,11 @@ ENDPROC(cpu_arm9tdmi_reset)
 		ret	lr
 		.size	__arm9tdmi_setup, . - __arm9tdmi_setup
 
-		__INITDATA
+		.section ".rodata"
 
 		@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 		define_processor_functions arm9tdmi, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 
-		.section ".rodata"
-
 		string	cpu_arch_name, "armv4t"
 		string	cpu_elf_name, "v4"
 		string	cpu_arm9tdmi_name, "ARM9TDMI"
diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
index 4001b73af4ee..c54d26708961 100644
--- a/arch/arm/mm/proc-fa526.S
+++ b/arch/arm/mm/proc-fa526.S
@@ -177,13 +177,11 @@ ENTRY(cpu_fa526_set_pte_ext)
 fa526_cr1_set:
 	.word	0x397D
 
-	__INITDATA
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions fa526, dabort=v4_early_abort, pabort=legacy_pabort
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv4"
 	string	cpu_elf_name, "v4"
 	string	cpu_fa526_name, "FA526"
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index 92e08bf37aad..f2e4ee0de8ba 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -568,13 +568,11 @@ ENDPROC(cpu_feroceon_do_resume)
 feroceon_crval:
 	crval	clear=0x0000773f, mmuset=0x00003135, ucset=0x00001134
 
-	__INITDATA
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions feroceon, dabort=v5t_early_abort, pabort=legacy_pabort
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv5te"
 	string	cpu_elf_name, "v5"
 	string	cpu_feroceon_name, "Feroceon"
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index 6f07d2ef4ff2..6de3bb48ede4 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -416,13 +416,11 @@ ENDPROC(cpu_mohawk_do_resume)
 mohawk_crval:
 	crval	clear=0x00007f3f, mmuset=0x00003905, ucset=0x00001134
 
-	__INITDATA
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions mohawk, dabort=v5t_early_abort, pabort=legacy_pabort
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv5te"
 	string	cpu_elf_name, "v5"
 	string	cpu_mohawk_name, "Marvell 88SV331x"
diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
index ee2ce496239f..73818d7c19d2 100644
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -186,13 +186,11 @@ ENTRY(cpu_sa110_set_pte_ext)
 sa110_crval:
 	crval	clear=0x00003f3f, mmuset=0x0000113d, ucset=0x00001130
 
-	__INITDATA
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions sa110, dabort=v4_early_abort, pabort=legacy_pabort
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv4"
 	string	cpu_elf_name, "v4"
 	string	cpu_sa110_name, "StrongARM-110"
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 222d5836f666..377b06831b4c 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -224,17 +224,14 @@ ENDPROC(cpu_sa1100_do_resume)
 sa1100_crval:
 	crval	clear=0x00003f3f, mmuset=0x0000313d, ucset=0x00001130
 
-	__INITDATA
-
 /*
  * SA1100 and SA1110 share the same function calls
  */
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions sa1100, dabort=v4_early_abort, pabort=legacy_pabort, suspend=1
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv4"
 	string	cpu_elf_name, "v4"
 	string	cpu_sa1100_name, "StrongARM-1100"
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 06d890a2342b..7d18cda06b35 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -253,13 +253,11 @@ ENDPROC(cpu_v6_do_resume)
 v6_crval:
 	crval	clear=0x01e0fb7f, mmuset=0x00c0387d, ucset=0x00c0187c
 
-	__INITDATA
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions v6, dabort=v6_early_abort, pabort=v6_pabort, suspend=1
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv6"
 	string	cpu_elf_name, "v6"
 	.align
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 339eb17c9808..bc028c5f262a 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -552,7 +552,7 @@ ENDPROC(__v7_setup)
 __v7_setup_stack:
 	.space	4 * 7				@ 7 registers
 
-	__INITDATA
+	.section ".rodata"
 
 	.weak cpu_v7_bugs_init
 
@@ -631,8 +631,6 @@ ENDPROC(__v7_setup)
 	define_processor_functions pj4b, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 #endif
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv7"
 	string	cpu_elf_name, "v7"
 	.align
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 47a5acc64433..8daf1b320fb4 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -166,6 +166,8 @@ ENDPROC(__v7m_setup)
 /*
  * Cortex-M7 processor functions
  */
+	.section ".rodata"
+
 	globl_equ	cpu_cm7_proc_init,	cpu_v7m_proc_init
 	globl_equ	cpu_cm7_reset,		cpu_v7m_reset
 	globl_equ	cpu_cm7_do_idle,	cpu_v7m_do_idle
@@ -174,7 +176,6 @@ ENDPROC(__v7m_setup)
 	define_processor_functions v7m, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 	define_processor_functions cm7, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 
-	.section ".rodata"
 	string cpu_arch_name, "armv7m"
 	string cpu_elf_name "v7m"
 	string cpu_v7m_name "ARMv7-M"
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 293dcc2c441f..ceffd974dd30 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -486,13 +486,11 @@ ENDPROC(cpu_xsc3_do_resume)
 xsc3_crval:
 	crval	clear=0x04002202, mmuset=0x00003905, ucset=0x00001900
 
-	__INITDATA
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions xsc3, dabort=v5t_early_abort, pabort=legacy_pabort, suspend=1
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv5te"
 	string	cpu_elf_name, "v5"
 	string	cpu_xsc3_name, "XScale-V3 based processor"
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 3d75b7972fd1..27e1a9df561e 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -586,13 +586,11 @@ ENDPROC(cpu_xscale_do_resume)
 xscale_crval:
 	crval	clear=0x00003b07, mmuset=0x00003905, ucset=0x00001900
 
-	__INITDATA
+	.section ".rodata"
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions xscale, dabort=v5t_early_abort, pabort=legacy_pabort, suspend=1
 
-	.section ".rodata"
-
 	string	cpu_arch_name, "armv5te"
 	string	cpu_elf_name, "v5"
 


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
