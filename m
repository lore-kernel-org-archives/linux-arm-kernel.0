Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D37EC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:23:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5403C20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jeq8hpUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5403C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RUpuQ12ZeaBfn9Pc6FxAiZfvE1x/PecRL3kv2ndMtHA=; b=Jeq8hpUnmegtye
	V2uPauzXvyPkTo3TO/NPMEivCdg0qEdCWtb4yvjKMYzLTex3TEufIRQ5TK8wNm4t0ou2jEOR46JNl
	AgTChS9OHdN/XZVBj1ePJMb6XZntkxb3r2gIjiK287m1Ypbfb3KEGBIDJVfPPyOZBRsG/Zz2GTC6b
	yu3Nda8R6ypnREtVwMsaXoPr9NUOg0Z6M95UI3ZQAzJ5IEgjDbispPgkkw91hiEPbmLhKTPRDbzJn
	D2bnNQRR/INhOH+EvoHFZFKQinoKR3Jfx+cHsvSiJh7eJQjUmTwh4WSszS7mnskAMp5Ox4OD8f0nN
	aQ6ejqH9UdcAG8XOCJ4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWvl-0004N0-79; Fri, 18 Jan 2019 16:23:41 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWsu-0001dZ-72
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:53 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MZTyi-1gheoB1V02-00WSdJ; Fri, 18 Jan 2019 17:19:37 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 16/29] alpha: add generic get{eg,eu,g,p,u,pp}id() syscalls
Date: Fri, 18 Jan 2019 17:18:22 +0100
Message-Id: <20190118161835.2259170-17-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:jsOw7NqQKS2zQ2Kn3Rl+vMqYljPTdUEHSKVnWEW+0Z+etDrnxOY
 fHRBu4AJ2H9ITzOOnIQmu/LvPg6oaokuIwQkItp+qBdIdD7bxckPyZ8Sxs4NOwtEHCSAnUH
 PATcQhNN+ieYB856u8/+6Y9ZbSsp4EBrFe61HTPJVqvuCuDQ4awBecyCY2Y/F+xR0K6VrtS
 S0fFIjG7g4/x+H+4JviEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JL+1HsoFxsM=:cBJFwJBy7OBl33SJgynGOf
 EmNur2v4677HGSFzkbfaknFA95n0HTqqKB3lK8G36N+kfz/YYAgyNSQ0vsAdfHv8lhYMjGt9p
 M8WUKHlEr7hakd0YFqTMmYqzuRvf5OQhCO6VJWob6XAwR6tpdkRzOCkrG6G8sfDz0d6VY/hNz
 upEFggyCa4tZuOyNQJx/K1uvR42DpkBjNILmF7YFo+UwNzmRIGTttYrsBYHTpe1PkzRgVit+r
 j7SLw9Mb4BkxItIIOg0Qt2c5Oq54DLbA/d+tWgz6QwpjgSfDyguWB8kYlWaqTPuPH9rvSikR/
 z5iJ6+Y+g9zoUxtfCYnatVYC9tJKDuimc9MbGNzttROXmBklb/ksFc6NTsXvlop93uHH8kFZW
 EH8Uk0MtSGHSMNTx7TfNxVjZQD2p41Af7cdpQ0q7LLJMZ12Wiz3jRYV1s++sEe5YekYRPxPzI
 0UeWAqx5PBKwf0P5EIiRcD7zYJVp12kr6tChz9H4IAiwv9yHUyveQLYhjbD63KLNdQmOWwgxQ
 FDoUySY8h2BSH/6fWX31CKmRwF+KPHvEnrGvFcULjAx96+rWzASZopKWtsi/Oj9ONCxHrFK77
 zfvU9jlkJIiLbhOXwmibd0u52gtfrTcK5qxrB/RMFagbDTt5V/H0K7p98rbF0qtMgChfmWlw6
 9js9moRUD3b7UoD0g2g2uzOd41lIuDs6xFGHIXcYshauq1Q8Mf7vrPy5HgZEfkX3yFqd1V5g5
 9v/xHx798WmtLAP2+pB9Fa8UydU7D6olbZ12sQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082045_013297_B7E2E76F 
X-CRM114-Status: UNSURE (   8.81  )
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

Alpha has traditionally followed the OSF1 calling conventions
here, with its getxpid, getxuid, getxgid system calls returning
two different values in separate registers.

Following what glibc has done here, we can define getpid,
getuid and getgid to be aliases for getxpid, getxuid and getxgid
respectively, and add new system call numbers for getppid, geteuid
and getegid.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h        | 11 -----------
 arch/alpha/include/uapi/asm/unistd.h   |  5 +++++
 arch/alpha/kernel/syscalls/syscall.tbl |  3 +++
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 31ad350b58a0..986f5da9b7d8 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -19,15 +19,4 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
 
-/*
- * Ignore legacy syscalls that we don't use.
- */
-#define __IGNORE_getegid
-#define __IGNORE_geteuid
-#define __IGNORE_getgid
-#define __IGNORE_getpid
-#define __IGNORE_getppid
-#define __IGNORE_getuid
-
-
 #endif /* _ALPHA_UNISTD_H */
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 4507071f995f..71fd5db06866 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -7,6 +7,11 @@
 #define __NR_umount	__NR_umount2
 #define __NR_osf_shmat	__NR_shmat
 
+/* These return an extra value but can be used as aliases */
+#define __NR_getpid	__NR_getxpid
+#define __NR_getuid	__NR_getxuid
+#define __NR_getgid	__NR_getxgid
+
 #include <asm/unistd_32.h>
 
 #endif /* _UAPI_ALPHA_UNISTD_H */
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 0ebd59fdcb8b..337b8108771a 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -458,3 +458,6 @@
 527	common	rseq				sys_rseq
 528	common	statfs64			sys_statfs64
 529	common	fstatfs64			sys_fstatfs64
+530	common	getegid				sys_getegid
+531	common	geteuid				sys_geteuid
+532	common	getppid				sys_getppid
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
