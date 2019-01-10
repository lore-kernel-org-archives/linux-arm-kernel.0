Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76689C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4F320685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CVGWhYsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4F320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9oldES7E2XSGRYVWgFKisS/651erJ5jtY8HHA4r8qUo=; b=CVGWhYsYOsJslR
	99rW9IWnewFlbidMX9+b9oh9JKiiY4VmVIQ34YoWHM9JOllfEA5LVJzZF8Jt8C9RPixPQIRz4PkZZ
	yZSayW1p/DlkCceMjHMxY7Z3OrFZqJMJ1uhjy8WzN0RVxf96YoZxmMix0J7XXmz6qIhI8YABCnAnp
	2Fxr8fgsoAG+aKnM/qK2eeXeDl6cpsQzKOHKWXFWbaDBsMLmKhtMfHfX927L8gvrFQnHzEt+XulQj
	oNtw0ockq4badl27g9bjXYjPEK/07DaiqCsopX4+kzbQnv1jZr6RYoR4cegIs7pL305hRox1iqvXi
	+3+Z+CCV3aTLdLqJJFpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdA8-0004Ux-7P; Thu, 10 Jan 2019 16:26:32 +0000
Received: from mout.kundenserver.de ([217.72.192.73])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghd9p-0004HS-IH
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:26:15 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M593i-1ggXD93nkq-0017L1; Thu, 10 Jan 2019 17:25:12 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] alpha: update syscall macro definitions
Date: Thu, 10 Jan 2019 17:24:25 +0100
Message-Id: <20190110162435.309262-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:JaQTJw5IhBRBC2/6Imn8HYcjqB4MHaiiobuN4ghlkrehtwgL8Rs
 Om/p9Mvf9KUTv0ovPj+nkYbOjIrQVd59nItiJla5YSaZbq+qloS3HYQZU50BIHllzGR/THF
 NPHj7ajtaHf9VTmMMB/peuIirgT6VutGHSSeOEkLUTP+R91V9eAfVy/KG9JHW9scAVvyUGQ
 th8ldIY5dyMjfeLNAPZ1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bkB9r4Vk1sc=:sJc1qmzUvK0oBRRZONmtJg
 QBqF1J9G5VStme5ymXgctEjAGseHlpa4zMlH/2h1eSTtExkY8ZV7AhpQwAJeOe7hC6NrrmtwW
 XOnmkUz1hLorA02NU1es8UVxyXrxBoNCAIPA6t1AKKRR9xGqGIfduZrHbMvwhIIoIgGYR9ir+
 gq68RvTao4z313vO6GLbjIxzhz1aZ+lAZ2SiEaekGBP3E2a6eFtZ71cHm2Q0x/bICwE2nliNn
 V1CfZvH7DNy8QST5cox2a7U/CjrgIV6qfCCH5JHwHttAQUPDTl+XF4lm6FlcA+3F/FPpQM1vk
 /lnaZT9XgzQbSBcN/68mqCcqr6CLgcjU+7k31xlmkL2F4RlIFDP6mRGeEoS+U7UjnJD4aU6Hq
 seeuywFX6pwwudzC6zPJ27LxJfH8Cu0g3nr9PAA1T3U1dEUonAJr//jm7RNiJzNAJhAs50TUa
 dzwijfhGGCNoaxA5IbGWUo5ltlR+Ea1Ff5AaVo2wbXBPhLJsBc5aTYiQoBr6ktL9KpMMLURww
 GOqGJeE0vY3niN5qlNdJrhIadP/AN9jfICFLFm8x/eC6XlsJE+kKdPWOwIqBS+0OAC5apGNoV
 o37L/8B5SBOUHm4Xs5l2ue/h6ZiCga8SE/4kOU37Dq+QKMhq+mwwmET2Z+TTRKxTC8ur5HynP
 57yz2XdIYW9/avAHM+ANp/KUHDNK3JMLaeNfZYePJBtxzYl49lgPnMs/1hm/N2pxHQJ5UGbuL
 cUwaMJfdlixeCbGGFJEIS+bwwQfnrFa9zuOyfA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_082613_944390_53A0F60B 
X-CRM114-Status: GOOD (  11.88  )
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

Other architectures commonly use __NR_umount2 for sys_umount,
only ia64 and alpha use __NR_umount here. In order to synchronize
the generated tables, use umount2 like everyone else, and add back
the old name from asm/unistd.h for compatibility.

For shmat, alpha uses the osf_shmat name, we can do the same thing
here, which means we don't have to add an entry in the __IGNORE
list now that shmat is mandatory everywhere

alarm, creat, pause, time, and utime are optional everywhere
these days, no need to list them here any more.

I considered also adding the regular versions of the get*id system
calls that have different names and calling conventions on alpha,
which would further help unify the syscall ABI, but for now
I decided against that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h        | 6 ------
 arch/alpha/include/uapi/asm/unistd.h   | 5 +++++
 arch/alpha/kernel/syscalls/syscall.tbl | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 21b706a5b772..564ba87bdc38 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -22,18 +22,12 @@
 /*
  * Ignore legacy syscalls that we don't use.
  */
-#define __IGNORE_alarm
-#define __IGNORE_creat
 #define __IGNORE_getegid
 #define __IGNORE_geteuid
 #define __IGNORE_getgid
 #define __IGNORE_getpid
 #define __IGNORE_getppid
 #define __IGNORE_getuid
-#define __IGNORE_pause
-#define __IGNORE_time
-#define __IGNORE_utime
-#define __IGNORE_umount2
 
 /* Alpha doesn't have protection keys. */
 #define __IGNORE_pkey_mprotect
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 9ba724f116f1..4507071f995f 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -2,6 +2,11 @@
 #ifndef _UAPI_ALPHA_UNISTD_H
 #define _UAPI_ALPHA_UNISTD_H
 
+/* These are traditionally the names linux-alpha uses for
+ * the two otherwise generic system calls */
+#define __NR_umount	__NR_umount2
+#define __NR_osf_shmat	__NR_shmat
+
 #include <asm/unistd_32.h>
 
 #endif /* _UAPI_ALPHA_UNISTD_H */
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index e09558edae73..f920b65e8c49 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -29,7 +29,7 @@
 19	common	lseek				sys_lseek
 20	common	getxpid				sys_getxpid
 21	common	osf_mount			sys_osf_mount
-22	common	umount				sys_umount
+22	common	umount2				sys_umount
 23	common	setuid				sys_setuid
 24	common	getxuid				sys_getxuid
 25	common	exec_with_loader		sys_ni_syscall
@@ -183,7 +183,7 @@
 206	common	semop				sys_semop
 207	common	osf_utsname			sys_osf_utsname
 208	common	lchown				sys_lchown
-209	common	osf_shmat			sys_shmat
+209	common	shmat				sys_shmat
 210	common	shmctl				sys_shmctl
 211	common	shmdt				sys_shmdt
 212	common	shmget				sys_shmget
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
