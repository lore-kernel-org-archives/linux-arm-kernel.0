Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABCAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:10:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748132070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aciqSRUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748132070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/MbaSe6liFWCmUKn5SPoSo6lr0VsDYf9w1nsNfgghnk=; b=aciqSRUNvPx3zA
	+b6MOPSNuskc4PMXNcFmLj9RUBVW1x/GV+nLYdRwyrmvrGD5kdvqBwmeGZCOa/vIyL0QWROkDdkWw
	YplgtXJ7/6HWCkTwXcKE+uS5Upwd9o+7nZTO6wao3DoQOH8T+JNdF2Fd1yvDXBh+yAbVWJf4E9pqc
	k+HQB1LWdzLGjRz+jqYYiksQozoT+vn1MF8qVpTJ/rktBODeiVpm3Npz1i5c2zH1hvTZuvkkr3Guc
	GBQBAegwZE0aTZMOcNRwYbM0kZTsowvQ0RvZ9OHPPZu9cP6l174adBM3HUyZUJ45ZA2rFQYgfwP47
	Vy0bFw2VFSUdj+rZFaGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqAp-0007pa-R8; Mon, 18 Feb 2019 21:09:59 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvq95-0005nO-G2; Mon, 18 Feb 2019 21:08:25 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mn1mb-1hMgAq0I9n-00k4eT; Mon, 18 Feb 2019 22:07:27 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org
Subject: [PATCH 3/8] asm-generic: Drop getrlimit and setrlimit syscalls from
 default list
Date: Mon, 18 Feb 2019 22:07:07 +0100
Message-Id: <20190218210712.3503891-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:lT1OI/VwUk1+FUWmyIpKG7wXuRB7DmxUPsLwzNLktjPbj2Hh83E
 96T3ALCFUrg4xNIagimy8FxBL4ytfUziaZaop1mls1d+9UFwmmpupObeIYE+NDEMAFuMXji
 kGuejQ4kER67FzspXmDjBfKuA6qVhpcKauK+R8xo4d20CFRWy5yiQBwikdBQ3UHO4pOsJ7o
 0Pzvm/tGPQ94ZVQdEyvDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uqfg5Jc4WoY=:Goljy+lYdWhAiy8Sxw3qQ4
 vIQeUZZDQi5bRNWfp++lBHnnyG80QMpeXiXdXS/MZGYHEtYnZnDXelOibu4djnQqK3ovlVNnf
 DbHxa/sYuftU3065EyjcrcL9B1tLJkmJffPdSxKYBR2+OggdNSeUeEtiDCE+ssAKcY+I/oU16
 mLzQ9xAUoywKlq/c2uXCsh6rRLGAq21Jw8AZOO4QgTFmdJGPHom93Te0BVKxMQ+nsKh482fTr
 zeMqbGganEaYhItVgpJC1u5s3gTeH5Du52yxRy0dz5Csym3WvuLMayVGKpDQ3r6AKs/lhH7fO
 y7OFef2q5p/YitbmcVE34/E0U69WK166cJSOh7Tvy/E8cjOBfIww00DuTyXHT0HFLpjPUQDAJ
 uxNdo9/A6gP/0PhcvwkAawHFIwMReId/wGMPPEviW/bXBaodSg96xEWCj8phs4eL4SV6ns8JK
 GTQgjEYlJDHAygyspjnfcNCCVpoBoxHNnNOhmtjphcTB6a1RGcMCFkEsTz2HToqeso3ujwgdj
 ahJ5ic1T0MNf+u9Z1WrmvFWLs9N/dPfDurl50sflM4UTWC0LGmjXI7nZhGegRlH3P+aeyGBN9
 xh2ExAUy0e14JpA8Srv7ztOEs8IG+f2E9/KtSlUZA+v6ZlIBCdNyfpTJKh0nu2oSMvLakzkAp
 NBU9OR1htnoYZvg/OX7hqdJr1ZehZIUAi6lxgOekE7PuTwLjC47diCXThN/4WzDPdMClmXjKr
 wmCC+QyrjmTpVu1GBW7tdjy8u5qM1bNMP2zjNQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_130812_400850_E937AF96 
X-CRM114-Status: UNSURE (   9.80  )
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
Cc: Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
 Yury Norov <ynorov@caviumnetworks.com>, Guo Ren <guoren@kernel.org>,
 linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>,
 linux-arch@vger.kernel.org, yury.norov@gmail.com,
 linux-hexagon@vger.kernel.org, Mark Salter <msalter@redhat.com>,
 uclinux-h8-devel@lists.sourceforge.jp, James Hogan <james.hogan@imgtec.com>,
 arnd@arndb.de, Greentime Hu <green.hu@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Yury Norov <ynorov@marvell.com>,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vineet Gupta <vgupta@synopsys.com>, Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Yury Norov <ynorov@caviumnetworks.com>

The newer prlimit64 syscall provides all the functionality of getrlimit
and setrlimit syscalls and adds the pid of target process, so future
architectures won't need to include getrlimit and setrlimit.

Therefore drop getrlimit and setrlimit syscalls from the generic syscall
list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
unistd.h prior to including asm-generic/unistd.h, and adjust all
architectures using the generic syscall list to define it so that no
in-tree architectures are affected.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-hexagon@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Mark Salter <msalter@redhat.com> [c6x]
Acked-by: James Hogan <james.hogan@imgtec.com> [metag]
Acked-by: Ley Foon Tan <lftan@altera.com> [nios2]
Acked-by: Stafford Horne <shorne@gmail.com> [openrisc]
Acked-by: Will Deacon <will.deacon@arm.com> [arm64]
Acked-by: Vineet Gupta <vgupta@synopsys.com> #arch/arc bits
Signed-off-by: Yury Norov <ynorov@marvell.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/include/uapi/asm/unistd.h       | 1 +
 arch/arm64/include/uapi/asm/unistd.h     | 1 +
 arch/c6x/include/uapi/asm/unistd.h       | 1 +
 arch/csky/include/uapi/asm/unistd.h      | 1 +
 arch/h8300/include/uapi/asm/unistd.h     | 1 +
 arch/hexagon/include/uapi/asm/unistd.h   | 1 +
 arch/nds32/include/uapi/asm/unistd.h     | 1 +
 arch/nios2/include/uapi/asm/unistd.h     | 1 +
 arch/openrisc/include/uapi/asm/unistd.h  | 1 +
 arch/riscv/include/uapi/asm/unistd.h     | 1 +
 arch/unicore32/include/uapi/asm/unistd.h | 1 +
 include/uapi/asm-generic/unistd.h        | 5 +++++
 scripts/checksyscalls.sh                 | 5 +++++
 13 files changed, 21 insertions(+)

diff --git a/arch/arc/include/uapi/asm/unistd.h b/arch/arc/include/uapi/asm/unistd.h
index 3b3543fd151c..6a1a62a979dd 100644
--- a/arch/arc/include/uapi/asm/unistd.h
+++ b/arch/arc/include/uapi/asm/unistd.h
@@ -18,6 +18,7 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index dae1584cf017..79937de2a0cc 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -17,5 +17,6 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
 
 #include <asm-generic/unistd.h>
diff --git a/arch/c6x/include/uapi/asm/unistd.h b/arch/c6x/include/uapi/asm/unistd.h
index 6b2fe792de9d..e3721b2cfd6a 100644
--- a/arch/c6x/include/uapi/asm/unistd.h
+++ b/arch/c6x/include/uapi/asm/unistd.h
@@ -17,6 +17,7 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_CLONE
 
 /* Use the standard ABI for syscalls. */
diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index 224c9a9ab45b..f5c83492136f 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -2,6 +2,7 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SET_GET_RLIMIT
 #include <asm-generic/unistd.h>
 
 #define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
diff --git a/arch/h8300/include/uapi/asm/unistd.h b/arch/h8300/include/uapi/asm/unistd.h
index 628195823816..b9e9352f2328 100644
--- a/arch/h8300/include/uapi/asm/unistd.h
+++ b/arch/h8300/include/uapi/asm/unistd.h
@@ -2,5 +2,6 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
 
 #include <asm-generic/unistd.h>
diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/include/uapi/asm/unistd.h
index c91ca7d02461..6bb392a33c35 100644
--- a/arch/hexagon/include/uapi/asm/unistd.h
+++ b/arch/hexagon/include/uapi/asm/unistd.h
@@ -30,6 +30,7 @@
 #define sys_mmap2 sys_mmap_pgoff
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_VFORK
diff --git a/arch/nds32/include/uapi/asm/unistd.h b/arch/nds32/include/uapi/asm/unistd.h
index c2c3a3e34083..eb98d24d3190 100644
--- a/arch/nds32/include/uapi/asm/unistd.h
+++ b/arch/nds32/include/uapi/asm/unistd.h
@@ -3,6 +3,7 @@
 
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYNC_FILE_RANGE2
+#define __ARCH_WANT_SET_GET_RLIMIT
 
 /* Use the standard ABI for syscalls */
 #include <asm-generic/unistd.h>
diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
index d9948d88790b..fa68e68bc26d 100644
--- a/arch/nios2/include/uapi/asm/unistd.h
+++ b/arch/nios2/include/uapi/asm/unistd.h
@@ -20,6 +20,7 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
 
 /* Use the standard ABI for syscalls */
 #include <asm-generic/unistd.h>
diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
index ec37df18d8ed..2e0bc0ff9f31 100644
--- a/arch/openrisc/include/uapi/asm/unistd.h
+++ b/arch/openrisc/include/uapi/asm/unistd.h
@@ -21,6 +21,7 @@
 
 #define __ARCH_WANT_RENAMEAT
 #define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
 
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 1f3bd3ebbb0d..d9340c52e7ad 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -18,6 +18,7 @@
 #ifdef __LP64__
 #define __ARCH_WANT_NEW_STAT
 #endif /* __LP64__ */
+#define __ARCH_WANT_SET_GET_RLIMIT
 
 #include <asm-generic/unistd.h>
 
diff --git a/arch/unicore32/include/uapi/asm/unistd.h b/arch/unicore32/include/uapi/asm/unistd.h
index 1e8fe5941b8a..2b575c0cf177 100644
--- a/arch/unicore32/include/uapi/asm/unistd.h
+++ b/arch/unicore32/include/uapi/asm/unistd.h
@@ -12,6 +12,7 @@
  */
 
 #define __ARCH_WANT_RENAMEAT
+#define __ARCH_WANT_SET_GET_RLIMIT
 
 /* Use the standard ABI for syscalls. */
 #include <asm-generic/unistd.h>
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index b928eff3bf92..2cdf600b05fa 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -467,10 +467,15 @@ __SYSCALL(__NR_uname, sys_newuname)
 __SYSCALL(__NR_sethostname, sys_sethostname)
 #define __NR_setdomainname 162
 __SYSCALL(__NR_setdomainname, sys_setdomainname)
+
+#ifdef __ARCH_WANT_SET_GET_RLIMIT
+/* getrlimit and setrlimit are superseded with prlimit64 */
 #define __NR_getrlimit 163
 __SC_COMP(__NR_getrlimit, sys_getrlimit, compat_sys_getrlimit)
 #define __NR_setrlimit 164
 __SC_COMP(__NR_setrlimit, sys_setrlimit, compat_sys_setrlimit)
+#endif
+
 #define __NR_getrusage 165
 __SC_COMP(__NR_getrusage, sys_getrusage, compat_sys_getrusage)
 #define __NR_umask 166
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index cc70a64fa81f..53c5677d7e82 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -38,6 +38,11 @@ cat << EOF
 #define __IGNORE_lstat64	/* fstatat64 */
 #endif
 
+#ifndef __ARCH_WANT_SET_GET_RLIMIT
+#define __IGNORE_getrlimit	/* getrlimit */
+#define __IGNORE_setrlimit	/* setrlimit */
+#endif
+
 /* Missing flags argument */
 #define __IGNORE_renameat	/* renameat2 */
 
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
