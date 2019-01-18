Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B86C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:25:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE2E20883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gZjyH6jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE2E20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=50WoT1ovwO3qwo5J2ruMNrsYhPno/jH5x9wKqO6E0k0=; b=gZjyH6jwKofPb8
	+a1YGGsYvlRAfQFht3GyzcB5kFBLkcc5s9XabFp+0GDa/4aVjqo0dXD/+xo2nrzj9A2mB0g5NAYnK
	4BK7MrWuuMhj4IX/3D72RrKw/ckzcuj7nzSTuDtgJL323ld/IeRbTaRg4tKdfy0JhkvxXggNCBE+H
	71ovVnlkUDCMzL8aO2kA5s9Fe3GpE/3yOMM7cEO/sdxs9SwCVLiyw1xCmU4xDYwI0ft7ZiRqmHDEv
	VfqwsMkwykFBfoCmSWl8kowj8FIuB4rYmjpM2fD5pzAk5qr3BE7AKYPdust2BjInwXDKJmpzhLQ7k
	Ja97hCfNsLWyxbxb33DQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWx7-0005FN-Aq; Fri, 18 Jan 2019 16:25:05 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWsw-0001gS-FR
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:59 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MiagL-1hPLSf2sBb-00fmAm; Fri, 18 Jan 2019 17:19:38 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 17/29] syscalls: remove obsolete __IGNORE_ macros
Date: Fri, 18 Jan 2019 17:18:23 +0100
Message-Id: <20190118161835.2259170-18-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:DdH60wNUBgz3ORuc+j1hCn614lQoDJNwbl1V5NlixSH/rexrQoE
 IdXAUNp3vob5ANgqtHQFpoAbtSvnHUC9HXHWJALVweGBrfrzYaYWlrueE5B9t5zXKCnAwBr
 ond52+JciiPSgiBA232NEEU8AqK9sIU8DoTiBaXXFD3yFnz3gDQ3dWCROZ8tzHcwjFIO1NC
 kh1mkXZqGzjI5MJnrM36w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:93rMBIOJPec=:/+lHk0bSFIJODP9zb8UMQU
 prGJ0K3OrVQDZnKOsBLZLlkyNDuinE3GuehbS0xjFM0t1TI9Ksttf/gLJyuj035c2THQykUYN
 Q0mjN1otkBDmDSF/MMVATdB4G1t4+ymLPNe7NLdUUew+5D/L85N+g0ODG3bhhJRWEPBI7NOLt
 m/tCCWx99ok/rRZ4QznSxIPK3wO43fCIWcBSyLNVTtKDzrwzn5OwPLYBHuFRymumtOL/DDCW/
 gpU/6o9AiblQACI5cqWF+By+Jzg1nmW7YfxIIdByBEJJ0bmynXHTmMprjQrirjKR0qYEMPsD7
 9dOB3Y31nXm6vliTg8EhF0aYW39XiEee90FOgqbTNse7zMek8J9zR+OK2stUEsAcm0OBjVr7S
 u7hwLU3cBR1HPnMPa0EiXgkFI3Y1Be2j4qFyVUN4CyLitt3Y4qsVs3Bg4zPyNV1rwxVj+K6kK
 5W9c4FybXySxpeQp3gyZPnqj8+PCK4FGHILZFZsCVfDd0k0gkcv3e1IttLHOV4siZxAAR8+5e
 nIoksxBaBSaUgAoigAQBZkE1wQwRZJ88Bx06+3EfS0aV1wN6Z8VK1JpYc5/PCSbb0yJ8ya5EB
 biNgjZMFKcig5eMRNe4OjV9vVLsl/jN0AcE1g66Piy8iIXvfnYAjJd2TVpWLC/xd/FVHSd83B
 q6wGDy3kxpQILeNw9h1e388Rr8v6mw9PLmcrfArNymX56aeYk3InP49ruyHUYaY9zXCMxlOkn
 kw6PY0phnOfbOEYl19zUPN1dcNx87xfQw/aMDQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082047_183856_173D47F8 
X-CRM114-Status: UNSURE (   9.87  )
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

These are all for ignoring the lack of obsolete system calls,
which have been marked the same way in scripts/checksyscall.sh,
so these can be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/unistd.h   | 16 ----------------
 arch/parisc/include/asm/unistd.h |  3 ---
 arch/s390/include/asm/unistd.h   |  2 --
 arch/xtensa/include/asm/unistd.h | 12 ------------
 4 files changed, 33 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index b23d74a601b3..5e9eeb83d8d4 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -53,22 +53,6 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
 
-/* whitelists for checksyscalls */
-#define __IGNORE_select
-#define __IGNORE_vfork
-#define __IGNORE_time
-#define __IGNORE_uselib
-#define __IGNORE_fadvise64_64
-#define __IGNORE_getdents64
-#if _MIPS_SIM == _MIPS_SIM_NABI32
-#define __IGNORE_truncate64
-#define __IGNORE_ftruncate64
-#define __IGNORE_stat64
-#define __IGNORE_lstat64
-#define __IGNORE_fstat64
-#define __IGNORE_fstatat64
-#endif
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_UNISTD_H */
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 9ec1026af877..385eae49ed02 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -10,9 +10,6 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
-#define __IGNORE_select			/* newselect */
-#define __IGNORE_fadvise64		/* fadvise64_64 */
-
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
 #endif
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index ed08f114ee91..59202ceea1f6 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -10,8 +10,6 @@
 #include <uapi/asm/unistd.h>
 #include <asm/unistd_nr.h>
 
-#define __IGNORE_time
-
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index 0d34629dafc5..81cc52ea1bd5 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -10,18 +10,6 @@
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_GETPGRP
 
-/* 
- * Ignore legacy system calls in the checksyscalls.sh script
- */
-
-#define __IGNORE_fork				/* use clone */
-#define __IGNORE_time
-#define __IGNORE_alarm				/* use setitimer */
-#define __IGNORE_pause
-#define __IGNORE_mmap				/* use mmap2 */
-#define __IGNORE_vfork				/* use clone */
-#define __IGNORE_fadvise64			/* use fadvise64_64 */
-
 #define NR_syscalls				__NR_syscalls
 
 #endif /* _XTENSA_UNISTD_H */
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
