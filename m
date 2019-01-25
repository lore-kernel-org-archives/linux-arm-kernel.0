Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE9EC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:04:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8B7217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OIl4IjI5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oAvVdoC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8B7217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Rqn5eqrz4MsWET9+Z39E1jix52tyrT3zw7KhM3dmZQg=; b=OIl4IjI5LMA6Nn
	gG6gNA1KmjFeWP8C6vF521m3sDXB+EOWBNbwcitcbSnGsJKk8wAG7UtvnHLUJ9EL4wH90DQsk2tdR
	9rSCnUCeBKppd4KRbKG7d9utuJVfo+wlUyoG8E9+uH1r2putTw3qilDo5ZvQCQGfdAdPOpqYlZpe+
	BojDyLaQz/1mSUv8lA0INsxjGhQgRlnCyW33sb9EHzt9IGeF1BXEozHwnAKYZMkaDl5kxz8nttpYx
	n8gx3+mbPbM6DZ1ASTrhgWnaXVqV4O7ChX9qGQ6Pa8u1CpQwVQxHDemVdiCdPJdFEP4qMiQ+Osvs1
	DaEgU1fqshQlh6WWxrgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn8e6-0003RR-CW; Fri, 25 Jan 2019 21:04:14 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn8e2-0003Qq-J6
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 21:04:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Kjj7eRshgq93vDJtrtOxHhVq8E1Nc+ZiQHLU+jKsluk=; b=oAvVdoC/0ij0Lip2PEoikbLKLQ
 SwqfGIXMvVagAe2T3XRX/SdDhRbT/g80b7HRR+t+S7HJazGJXIa+Axyl691GSQfBi3jJ5wc2GPb2y
 prkhsExKdPDq6+mBz078Si/rchhpQzWtXCM7mo/Eg+CjaD3deQSiHZykP+Mm7vwMFhyg=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:46256 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1gn8dp-00058e-Ra; Fri, 25 Jan 2019 21:03:57 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1gn8dp-0004Ai-AW; Fri, 25 Jan 2019 21:03:57 +0000
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org
Subject: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
Date: Fri, 25 Jan 2019 21:03:57 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_130410_634372_63CA4B38 
X-CRM114-Status: GOOD (  11.24  )
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
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
 Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Executing loops such as:

	while (1)
		cpu_relax();

with interrupts disabled results in a livelock of the entire system,
as other CPUs are prevented making progress.  This is most noticable
as a failure of crashdump kexec, which stops just after issuing:

	Loading crashdump kernel...

to the system console.  A workaround for this is to use 10 nops in
cpu_relax().

We also use wfe() in while (1) loops to avoid burning cycles in a
tight loop, giving the CPU a hint that we're not doing anything
useful.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
It's been a while since this was posted, Will's suggestion was to use
10 nops in cpu_relax() last time around.  I still prefer wfe() in
these infinite-not-doing-anything-ever loops.

 arch/arm/include/asm/barrier.h   | 2 ++
 arch/arm/include/asm/processor.h | 6 +++++-
 arch/arm/kernel/machine_kexec.c  | 5 ++++-
 arch/arm/kernel/smp.c            | 4 +++-
 arch/arm/mach-omap2/prm_common.c | 4 +++-
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 69772e742a0a..83ae97c049d9 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -11,6 +11,8 @@
 #define sev()	__asm__ __volatile__ ("sev" : : : "memory")
 #define wfe()	__asm__ __volatile__ ("wfe" : : : "memory")
 #define wfi()	__asm__ __volatile__ ("wfi" : : : "memory")
+#else
+#define wfe()	do { } while (0)
 #endif
 
 #if __LINUX_ARM_ARCH__ >= 7
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 120f4c9bbfde..57fe73ea0f72 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -89,7 +89,11 @@ extern void release_thread(struct task_struct *);
 unsigned long get_wchan(struct task_struct *p);
 
 #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
-#define cpu_relax()			smp_mb()
+#define cpu_relax()						\
+	do {							\
+		smp_mb();					\
+		__asm__ __volatile__("nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;");	\
+	} while (0)
 #else
 #define cpu_relax()			barrier()
 #endif
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index dd2eb5f76b9f..76300f3813e8 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -91,8 +91,11 @@ void machine_crash_nonpanic_core(void *unused)
 
 	set_cpu_online(smp_processor_id(), false);
 	atomic_dec(&waiting_for_crash_ipi);
-	while (1)
+
+	while (1) {
 		cpu_relax();
+		wfe();
+	}
 }
 
 void crash_smp_send_stop(void)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ebac63fe458b..4e785d025771 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -595,8 +595,10 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_fiq_disable();
 	local_irq_disable();
 
-	while (1)
+	while (1) {
 		cpu_relax();
+		wfe();
+	}
 }
 
 static DEFINE_PER_CPU(struct completion *, cpu_completion);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 058a37e6d11c..fd6e0671f957 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -523,8 +523,10 @@ void omap_prm_reset_system(void)
 
 	prm_ll_data->reset_system();
 
-	while (1)
+	while (1) {
 		cpu_relax();
+		wfe();
+	}
 }
 
 /**
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
