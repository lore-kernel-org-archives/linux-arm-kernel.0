Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18772C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:23:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F1120850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DVQdPFT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F1120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EArQnRvN28Nai5ve+ZzsGx+e1ovRVCsoCejvNYb3YEE=; b=DVQdPFT7fkXidV
	GsZmSCeIZxsTonerxENrx8lED0NSbMTyUSxW5ydzuVyka+9MeWn3U41CLyxGnSJWgNCW/GcISrQOW
	nPcHI7QIqmmOX0h6OGFzVFedrrPQaATJxWzGdkG8UEuivGtnWfDwNXucbqbriD5+fdcnO/Gi2cabS
	Ua7un0SGVP9EP0OPSO5iaPSWNYvhjJXVFafUEiiXH/Ef7B4qssrDXqBE5VVxJzBdzPcfPhMRHb/Z3
	SHQV1ooehqomIfvYJsU0aNjEmFECtFtpYGh+6WMbUXaQuvmAk8ygkzR4pK9KElHOH+jY+0kvWSOGl
	kG0FH+vBeOm/AE3Bg4Wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWv3-0003g8-Dh; Fri, 18 Jan 2019 16:22:57 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWsj-0001S1-KL
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:42 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MrQMz-1hY6tt2gfn-00oXcC; Fri, 18 Jan 2019 17:19:34 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 14/29] arch: add pkey and rseq syscall numbers everywhere
Date: Fri, 18 Jan 2019 17:18:20 +0100
Message-Id: <20190118161835.2259170-15-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:PUAJoUi9MPMzFKZe0DBo62X8FuRWHzJPXsosoO8W99HHWXnEMWj
 yWiBaqb5A+/vKiGrfJ2aMKC91/Sy2o1goKiU+CJ6WqFiXTSA2Dn773kwy83a6Wc4/mmznfS
 asYI8lFVfF4xCj5tAc6kWgrXMdRKAsPixQfwSDX5WUQ+wQ5DTaBZsM6h8BDenCM8zjt3vVH
 NWlRb5vXo7z+s79cDfJQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oNvsZng1Uck=:yj94ATHd9mEq2QgwHHl+r/
 mVEhEYSgZiL0djUdD8qpbM34h/CXtxAEV0tlSMxDHDtpFT8KFeHtRj7KPBo2DNjhOQn3H8I5n
 i1FJauHkAFrce4jxu2c+cgbocbL8oqxCuzCOlj+eQKr6lWqo53ExFiyTMzY54y3LLDoa8yIcL
 OZYE8m6A7kOlQ26qWSfoCIYecuNTHtuQHbdr9g/v044na3/0i33EJCb7z4XQi9ETIUTdmfWZb
 yjDHXuETe9rVM5jShyXEC9LIbc1X8G0VgN32iTSu1J6jK0TRpIosYE6AHWdW88Khxq4Bqx8gb
 OQ04P4nL0OAj472dI7J9dpv8vEYotymQ+1krlzQFvfYZ4/N+h6Zr8mgYlV1pkxG+uWP8C7Pvf
 LB35/4wB4xRuezv3bVEZ1w5he13xqHJAGD29eS4ONcSzcG9ebxShkPOfa7Nx9hHZNeyzFTmQ2
 ZImPdFO/MEnlyVqWw4kzlMG3A82HJqGDy57tZ/iSw4P5R+lD5ra5wcnfdkT5Fy+U0EKf9DWRd
 Viv0sLEgVRQkHG8umqNj6dFfRp3gcnsWyCAy3sTZv/AERYFdFI8HvPUWjN5L+SESEGOoyxI/D
 1Yn4FxQqsEmVhHnTTYaWzPSCKFN34WOYGBmUBJMocBueADmE87Kv+YlqvhZdiqC35yRnyNCrq
 cY8dkIzd+lU4zn5OZgMJn7UMXKM9eaKq+4Tl9QNt0+1W/GGsp6NTC0g2k164opTY6Btye2/dR
 n7pfVIm7YSRw4qLtBTc2Cqhaz+lBQCwpE6Ti8Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082034_349935_0C1D5A01 
X-CRM114-Status: GOOD (  11.02  )
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
index 0bccb01c6202..14142eb21f8f 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -391,6 +391,9 @@
 381  common	kexec_file_load		sys_kexec_file_load		sys_kexec_file_load
 382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
 383  common	rseq			sys_rseq			sys_rseq
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
