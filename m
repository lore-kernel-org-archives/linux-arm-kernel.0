Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C55C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:22:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC3D20896
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V8qAeDSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC3D20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+LhGHXquq3796dgUaGAVOw/prwQFDd/ZV6EFt3ozqbo=; b=V8qAeDSzg9AVnl
	vxhdD/OyRAHtxhdYD0itMUUOOaucuqlsddtuSgxKh6M8Fw5UOW842KrR1yDbqNIPZ7qSa7iWcFuXR
	jGqBxnSG0OfM6CYLH2TLLZBuP0Udp4SCLoTdKaED4R9618l9MVKrltkCZaHiVbAohoBxmP9qRnIsv
	rMgffEmv0bqPwiTXnslcPwTJv/PGewjlBW61yrvORs7q8TpC5DaJb/pm4qwCSQAFSyK67xEllK3MW
	6oBT6LxOzNnHjsOoUd7Rv3h0/SYp2c03FjA9b9m88FTe1z/Mrg8vl7G2iWnIbtdY5ZykG9eRz/cLC
	G7t4Es+0x646OObIdciw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWuX-0003Ci-Ai; Fri, 18 Jan 2019 16:22:25 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWsh-0001P5-8h
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:35 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MhDEq-1hOWW63G5q-00eOav; Fri, 18 Jan 2019 17:19:17 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 01/29] ia64: add __NR_umount2 definition
Date: Fri, 18 Jan 2019 17:18:07 +0100
Message-Id: <20190118161835.2259170-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:GsZHhQhcPdYS4XukUdggM06UYDYQwvsQdNjGwXDfVX+xMhWKJ6A
 b6/sxfBHiaOoQOIfuvjuKAlbNSGl602rDk7co3ulFVrnu6AKrROQ37HYQQgaNO9HW3rfMgT
 FMqKekrLMWzwblX2j4DmUwfbjCWxf1hP2S9PKyEsdmmXxHyyNyE9nP/tEZePtCFi+EiC++u
 TwwGDSPYukstzfC9BHnUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4oZGV99i9Es=:zl3RJLFwRuzHjpYAd7JXSy
 j0Xr6hYoVER8/EkE78L0FBpqWwSLiBt89ov75d/lCcZ8EIPJCLfWWFnH4+7vvf1vB0y6PuK+2
 WaQf+0AtlFjXvLDdEdcMfSVEu/oXlSSWgNamYZLhGZ469/XTMPelaTtuGD0qTnhq9O4+UTQho
 lQ0cYwI5yK+bdi3rW56xu/JrQKZ3Mc1eKAmhyP7Z8XnKBd7J/KOv5SpnB5vmiZ9UgJWN1mQ0J
 uElFIJ0O2dyFc82y6vkLE5T7GEigtI0A+75aroKm5Pr+FsnqXqdeb3TURXICg4MGwRgAzGwPT
 ITyTsJU1n9m3+bWS/Td9uI50Cw4obDtx9WUsztTbvRp2ZuXc65G3AXcxY3vSmW+3skW70wera
 SSLEyT/Gr4KCiupFJyCDi0raovIDwiSf7ZEtj4gemjCUQo9j5MsLTvlQqk/nOKVQb4szjPspx
 pemTbbbXRaAzFnfHeAPXsidNtWDfPBiDc8+gvvlcHF4MOkxlHk/ozkznGMZBNIqSskSzpHqa8
 P+BEBZ6X/A2+EO89EKRYprcX7n5o/MRTz1FepCZZugEIueimrUdkjuA8172O5g5FlhKQlzvri
 FSGR9gNOwxSYqCoQsvsK24vYcAGrNxemQqL4YZe0xmRKtuYFyC76eHvi5sDyS8nEqyaRAY0wL
 pUlB8onvyLyM59By8CcmkN7xWdub+PUluNRNrCK+5RhogR3dXC3L21/ad0rw8vt14eCjSILR0
 mRa28hy080RWtHtwzkFq2kRvrYNuY4DpJgJv7A==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082032_117154_F10D732C 
X-CRM114-Status: GOOD (  10.67  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 benh@kernel.crashing.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-fsdevel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Other architectures commonly use __NR_umount2 for sys_umount,
only ia64 and alpha use __NR_umount here. In order to synchronize
the generated tables, use umount2 like everyone else, and add back
the old name from asm/unistd.h for compatibility.

The __IGNORE_* lines are now all obsolete and can be removed as
a side-effect.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/asm/unistd.h        | 14 --------------
 arch/ia64/include/uapi/asm/unistd.h   |  2 ++
 arch/ia64/kernel/syscalls/syscall.tbl |  2 +-
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index 0b08ebd2dfde..9ba6110b10b9 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -12,20 +12,6 @@
 
 #define NR_syscalls		__NR_syscalls /* length of syscall table */
 
-/*
- * The following defines stop scripts/checksyscalls.sh from complaining about
- * unimplemented system calls.  Glibc provides for each of these by using
- * more modern equivalent system calls.
- */
-#define __IGNORE_fork		/* clone() */
-#define __IGNORE_time		/* gettimeofday() */
-#define __IGNORE_alarm		/* setitimer(ITIMER_REAL, ... */
-#define __IGNORE_pause		/* rt_sigprocmask(), rt_sigsuspend() */
-#define __IGNORE_utime		/* utimes() */
-#define __IGNORE_getpgrp	/* getpgid() */
-#define __IGNORE_vfork		/* clone() */
-#define __IGNORE_umount2	/* umount() */
-
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_UTIME
 
diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index b2513922dcb5..013e0bcacc39 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -15,6 +15,8 @@
 
 #define __NR_Linux      1024
 
+#define __NR_umount __NR_umount2
+
 #include <asm/unistd_64.h>
 
 #endif /* _UAPI_ASM_IA64_UNISTD_H */
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index b22203b40bfe..e97caf51be42 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -29,7 +29,7 @@
 17	common	getpid				sys_getpid
 18	common	getppid				sys_getppid
 19	common	mount				sys_mount
-20	common	umount				sys_umount
+20	common	umount2				sys_umount
 21	common	setuid				sys_setuid
 22	common	getuid				sys_getuid
 23	common	geteuid				sys_geteuid
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
