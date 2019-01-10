Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E438BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:29:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A97206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ainZjSth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A97206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xuXOO9N6L2mmtv7PwCXXByiXmhbeaVSiWCSXbEY9tyw=; b=ainZjSthbBo+yS
	d+baIUnraUeZbwnn3jKJvSSs8bKJqDJgCAq0/GvkRhJoaIHJCzwyzogQb3n2fuV9ISjTK/iy/R3yn
	5iTuT/iPuDo8NLmMncFoW/irK65fQcGaaHQCy7Kv+lOU7C9HjAkfURBfBmIoSu22cRBGKDFaU0Far
	mFYeN+2kbpG5cm+B0dUX8LuhFKGE02tdJcXM+CWwfyJt7YTE7ccmdYq2iwsshitH9PQli9M69DTGr
	UWUFMUIfSCcBWxlgALXiHurbzBhVAu2zKvVnKsGYWhfV8b/dqP9nQyj11qGGF27p35kv+pMd3tETa
	mM+u+yK9Y32IlgY8A85A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdCh-00074j-Gw; Thu, 10 Jan 2019 16:29:11 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghd9u-0004K8-Hh
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:26:24 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N1Ok1-1hR2tC1rfn-012tSW; Thu, 10 Jan 2019 17:25:25 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] arch: add pkey and rseq syscall numbers everywhere
Date: Thu, 10 Jan 2019 17:24:35 +0100
Message-Id: <20190110162435.309262-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:cYFUki4ctg41NCVsfRZXUlD/defZca+1m4t7TyTRppdNihmgpcn
 20YcInCpgALpocQ3Jdh1oHW/YKt7D64ONPT9zaXB3P8cOXumHp+iHoO4kuPkFqthq9BiZWE
 f57EHmyQMPAV1cS+v4g4u0oJ9P6Tkhmo7tgSHPr6K2b25DrGAMnqjs/cMheYY+CqkoxnxB7
 Mq+Y+9Ek0yyLx4SlJWh2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iRRlBNlFQmE=:eDMM32XbCzmD6SCNgg7FTM
 k4iOaZgv6ronSXUCWa4InGcGrpdms31zNKEDClmikSnvROrvA1aQx6BFW6r2Xe/iWBSWLLYzs
 aTENWiI8AUKs505t8mjE9z4GNtfFPJpzAYVQzxsz4pfcSKWj86soPydDe4WqfuxGb5aQ3vjdN
 zU0UzEV9FrRcb4e/vUKTn8c9XEqv4/5GV9Hti1CXsRb6qhitM3Qk0NglJnVGATtFO7c3YVhr0
 JPpG7QbHd86qRnIr0kd0WrIoQ6OYPhP/XJRmSkixFPR1R35F/dU+Jq6TP7D5NVJMROAOeIQnb
 XcoGfTB138+MpOhGMRaQy/kJTfeps0C5Sk92n4Sop9LlhmlLXOygb48iOUNu4KwSagSiyoTFu
 kbXjVrHa+zOf7sgQVOWEL6cV4FdgyX8Vp2PjfPFqMiIOvjqkyUPL/GxbY+XlvPKPVH/D60Q3H
 Uc6/71oVYNw6+I2qz7hI65X9sS1o6A5VpCegpRtJN5npiHVGUdct1fgOIJgodezlDGLrSpf9y
 OM6/YaYOZk132CH6lU+qjAPe3LvbcctRgrT6YZb+FpcNmEmqauUg8eAgahwgLk8e9VJzbSH1U
 ImgjzqVhXeOczN0Nj4SgLhj8djS1CCQ3jeun/WVPD4J8JT2NOhUKV/8oHl2vPCmwWv1qfWZgk
 RxwvRed//pEueIvTQxAKQKw7F8MovHJBhdpuzUIUbM7OH4AuA2gCYWgtC7iSYd9SNnMn/akGX
 6MVq5BZZIYyWOHI0EK+qzEdNxaEkmb4H8a6FrA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_082619_140512_25083546 
X-CRM114-Status: GOOD (  11.54  )
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
 catalin.marinas@arm.com, will.deacon@arm.com, linux@dominikbrodowski.net,
 jcmvbkbc@gmail.com, deepa.kernel@gmail.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, dave@stgolabs.net,
 mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk,
 mingo@redhat.com, geert@linux-m68k.org, firoz.khan@linaro.org,
 mattst88@gmail.com, fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>,
 heiko.carstens@de.ibm.com, linux-m68k@lists.linux-m68k.org,
 ink@jurassic.park.msu.ru, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Most architectures define system call numbers for the rseq and pkey system
calls, even when they don't support the features, and perhaps never will.

Only a few architectures are missing these, so just define them anyway
for consistency. If we decide to add them later to one of these, the
system call numbers won't get out of sync then.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h         | 4 ----
 arch/alpha/kernel/syscalls/syscall.tbl  | 4 ++++
 arch/ia64/kernel/syscalls/syscall.tbl   | 4 ++++
 arch/m68k/kernel/syscalls/syscall.tbl   | 4 ++++
 arch/parisc/include/asm/unistd.h        | 3 ---
 arch/parisc/kernel/syscalls/syscall.tbl | 4 ++++
 arch/s390/include/asm/unistd.h          | 3 ---
 arch/s390/kernel/syscalls/syscall.tbl   | 3 +++
 arch/sh/kernel/syscalls/syscall.tbl     | 4 ++++
 arch/sparc/include/asm/unistd.h         | 5 -----
 arch/sparc/kernel/syscalls/syscall.tbl  | 4 ++++
 arch/xtensa/kernel/syscalls/syscall.tbl | 1 +
 12 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 564ba87bdc38..31ad350b58a0 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -29,9 +29,5 @@
 #define __IGNORE_getppid
 #define __IGNORE_getuid
 
-/* Alpha doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
 
 #endif /* _ALPHA_UNISTD_H */
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index b0e247287908..25b4a7e76943 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -452,3 +452,7 @@
 521	common	pwritev2			sys_pwritev2
 522	common	statx				sys_statx
 523	common	io_pgetevents			sys_io_pgetevents
+524	common	pkey_alloc			sys_pkey_alloc
+525	common	pkey_free			sys_pkey_free
+526	common	pkey_mprotect			sys_pkey_mprotect
+527	common	rseq				sys_rseq
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 2e93dbdcdb80..84e03de00177 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -339,3 +339,7 @@
 327	common	io_pgetevents			sys_io_pgetevents
 328	common	perf_event_open			sys_perf_event_open
 329	common	seccomp				sys_seccomp
+330	common	pkey_alloc			sys_pkey_alloc
+331	common	pkey_free			sys_pkey_free
+332	common	pkey_mprotect			sys_pkey_mprotect
+333	common	rseq				sys_rseq
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 5354ba02eed2..ae88b85d068e 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -388,6 +388,10 @@
 378	common	pwritev2			sys_pwritev2
 379	common	statx				sys_statx
 380	common	seccomp				sys_seccomp
+381	common	pkey_alloc			sys_pkey_alloc
+382	common	pkey_free			sys_pkey_free
+383	common	pkey_mprotect			sys_pkey_mprotect
+384	common	rseq				sys_rseq
 # room for arch specific calls
 393	common	semget				sys_semget
 394	common	semctl				sys_semctl
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index c2c2afb28941..9ec1026af877 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -12,9 +12,6 @@
 
 #define __IGNORE_select			/* newselect */
 #define __IGNORE_fadvise64		/* fadvise64_64 */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
 
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 9bbd2f9f56c8..e07231de3597 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -367,3 +367,7 @@
 348	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
 349	common	statx			sys_statx
 350	common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
+351	common	pkey_alloc		sys_pkey_alloc
+352	common	pkey_free		sys_pkey_free
+353	common	pkey_mprotect		sys_pkey_mprotect
+354	common	rseq			sys_rseq
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index a1fbf15d53aa..ed08f114ee91 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -11,9 +11,6 @@
 #include <asm/unistd_nr.h>
 
 #define __IGNORE_time
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 428cf512a757..f84ea364a302 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -391,6 +391,9 @@
 381  common	kexec_file_load		sys_kexec_file_load		compat_sys_kexec_file_load
 382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
 383  common	rseq			sys_rseq			compat_sys_rseq
+384  common	pkey_alloc		sys_pkey_alloc			sys_pkey_alloc
+385  common	pkey_free		sys_pkey_free			sys_pkey_free
+386  common	pkey_mprotect		sys_pkey_mprotect		sys_pkey_mprotect
 # room for arch specific syscalls
 392	64	semtimedop		sys_semtimedop			-
 393  common	semget			sys_semget			sys_semget
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 6d0b84e3ef2d..3f96ad0424e1 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -391,6 +391,10 @@
 381	common	preadv2				sys_preadv2
 382	common	pwritev2			sys_pwritev2
 383	common	statx				sys_statx
+384	common	pkey_alloc			sys_pkey_alloc
+385	common	pkey_free			sys_pkey_free
+386	common	pkey_mprotect			sys_pkey_mprotect
+387	common	rseq				sys_rseq
 # room for arch specific syscalls
 393	common	semget				sys_semget
 394	common	semctl				sys_semctl
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 5194d86ef72d..08696ea5dca8 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -59,9 +59,4 @@
 #define __IGNORE_getresgid
 #endif
 
-/* Sparc doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 8c9580302422..24ebef675184 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -407,6 +407,10 @@
 359	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
 360	common	statx			sys_statx
 361	common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
+362	common	pkey_alloc		sys_pkey_alloc
+363	common	pkey_free		sys_pkey_free
+364	common	pkey_mprotect		sys_pkey_mprotect
+365	common	rseq			sys_rseq
 # room for arch specific syscalls
 392	64	semtimedop			sys_semtimedop
 393	common	semget			sys_semget
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index f8befa11b0c4..c699e014e0dd 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -372,3 +372,4 @@
 349	common	pkey_alloc			sys_pkey_alloc
 350	common	pkey_free			sys_pkey_free
 351	common	statx				sys_statx
+352	common	rseq				sys_rseq
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
