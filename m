Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A6DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:24:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94ED120850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="raD4Viyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94ED120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c5NZkemJFPrLCtQMl3QIJpiTFVlu6fgwEwB9yVma/EU=; b=raD4ViyuxEszcQ
	llRhCtr6TSIl7vIt5EMF5Q2rcivMAgaB0LjwNwEXQqNPbhIYR3slHrI1Sz6PVRQv6TYmvJR4794tA
	evNdo1HO58RFuhn6BLiE2F4X+3OOp7JjE6UbN0qvFQyP0ISOPWcgvoYl1o23nDan0gsgSHfLQFvk8
	BcL4ik5DSCU0bCv49VRviqXDKJZqvhm2iSqz52uurVJK6ksdUuJ1zIXi7Aiu/xgIMBlKIfmjTjR7w
	wDCXU7Bg87XQidrk/fh8uW+7HcQX/9HOAvrvbyl61MuLXII40PQrdZg2UbwSNqndU94UB1JZSsPML
	f2N941ZlxU3fhO/P7jyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWwc-0004pe-9o; Fri, 18 Jan 2019 16:24:34 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWsu-0001cS-2D
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:55 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1McpW8-1hK8nV3pWE-00a0sD; Fri, 18 Jan 2019 17:19:28 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 09/29] sh: remove duplicate unistd_32.h file
Date: Fri, 18 Jan 2019 17:18:15 +0100
Message-Id: <20190118161835.2259170-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:LzFStTb/bEtBD+XLMjroFK5Bz6x1/z5o7hhTySXkY0a2eGMako1
 drHx7la3Or3Ki4MtjVokCJfXBziZQ/yjYu5SGX4sKBUWKO3PCkmPNuQObOyy+PCN4Oku0P1
 v2qzSHhbcq4YlxTtCn/iBo2Ng49y7xinAH+szqvkwM3TvScwKvKpBB7+u9GsPxthb3HMhw3
 bxqKAfRsn98unsHGXslAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pN6nXwYCodw=:bpn81CvKHhLXGS99uTQ0vE
 cr3kZdLDpxrjNWRWqcXpNM90UK1KNbJ+ItctPrc9wb9dP2IEuhihvCUCuKaShqykcVNrzLE06
 sizUEV//q+OJ41fD7z1Z7iYvA8vtFJGYJiPczLMqytwf5P0pCyNZiXaKhSux6XWNEadTmNmGT
 3xVr0yeS6oMJ4XAGWoiArqBrI0hkHvs+DilANt0gqT478aqIoMM8bgP+D8KHddESp/7Je9Quc
 TO8RjwtrNbp4B6GpmEKIh5UZ0Elqlz1XBDX+WKMEJ/QY1MW/msp/itB4bmHL8tYLawr+xFhAm
 iAzDJ10nvE6tjvRfJg4zXUN4gqgQFmraeik+Pd8RtreBN93ULIX5hZUWVx0C6AEAilOdGSsMQ
 OuInjtYVok7+MR5LLaKFzXJ0TXH43n48u9mxIitKDt+yqBnQC9aMBetu4xhfBLz1zWtvRx3fV
 pzWjYPWRmqJRVAITsj0zu0tzt6CzNcKzerKRv+TntG7TjCm5YT/nom/QeacZqwxux932pSIeW
 C/O9MiCOCt6uKmBLEL5Av/lXk9RMncSqsumb0cHijB31fDxK8fqfNSB4LiVNOTHlldp8xZTZW
 eUDkhcxRZutX7qGV0ZLgs7YRNauE6su2DPf4KbJ1eDJBghHAjih9gwp5kxhvySy6D+mM55bg5
 jPmlrmEPhX+1ITXrTf6sNYCN+sE1RyHApT0JJb8E66MFWp3S4Bx6isp//Sgs3SeZ+dzQrUr5L
 bfMni2MBRqbzV8YqxLGjeU6NeESj3fi07SXehQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082044_759769_0377047D 
X-CRM114-Status: GOOD (  10.23  )
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

When I merged this patch, the file was accidentally left intact
instead of being removed, which means any changes to syscall.tbl
have no effect.

Fixes: 2b3c5a99d5f3 ("sh: generate uapi header and syscall table header files")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/uapi/asm/unistd_32.h | 403 ---------------------------
 1 file changed, 403 deletions(-)
 delete mode 100644 arch/sh/include/uapi/asm/unistd_32.h

diff --git a/arch/sh/include/uapi/asm/unistd_32.h b/arch/sh/include/uapi/asm/unistd_32.h
deleted file mode 100644
index 31c85aa251ab..000000000000
--- a/arch/sh/include/uapi/asm/unistd_32.h
+++ /dev/null
@@ -1,403 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __ASM_SH_UNISTD_32_H
-#define __ASM_SH_UNISTD_32_H
-
-/*
- * Copyright (C) 1999  Niibe Yutaka
- */
-
-/*
- * This file contains the system call numbers.
- */
-
-#define __NR_restart_syscall	  0
-#define __NR_exit		  1
-#define __NR_fork		  2
-#define __NR_read		  3
-#define __NR_write		  4
-#define __NR_open		  5
-#define __NR_close		  6
-#define __NR_waitpid		  7
-#define __NR_creat		  8
-#define __NR_link		  9
-#define __NR_unlink		 10
-#define __NR_execve		 11
-#define __NR_chdir		 12
-#define __NR_time		 13
-#define __NR_mknod		 14
-#define __NR_chmod		 15
-#define __NR_lchown		 16
-				 /* 17 was sys_break */
-#define __NR_oldstat		 18
-#define __NR_lseek		 19
-#define __NR_getpid		 20
-#define __NR_mount		 21
-#define __NR_umount		 22
-#define __NR_setuid		 23
-#define __NR_getuid		 24
-#define __NR_stime		 25
-#define __NR_ptrace		 26
-#define __NR_alarm		 27
-#define __NR_oldfstat		 28
-#define __NR_pause		 29
-#define __NR_utime		 30
-				 /* 31 was sys_stty */
-				 /* 32 was sys_gtty */
-#define __NR_access		 33
-#define __NR_nice		 34
-				 /* 35 was sys_ftime */
-#define __NR_sync		 36
-#define __NR_kill		 37
-#define __NR_rename		 38
-#define __NR_mkdir		 39
-#define __NR_rmdir		 40
-#define __NR_dup		 41
-#define __NR_pipe		 42
-#define __NR_times		 43
-				 /* 44 was sys_prof */
-#define __NR_brk		 45
-#define __NR_setgid		 46
-#define __NR_getgid		 47
-#define __NR_signal		 48
-#define __NR_geteuid		 49
-#define __NR_getegid		 50
-#define __NR_acct		 51
-#define __NR_umount2		 52
-				 /* 53 was sys_lock */
-#define __NR_ioctl		 54
-#define __NR_fcntl		 55
-				 /* 56 was sys_mpx */
-#define __NR_setpgid		 57
-				 /* 58 was sys_ulimit */
-				 /* 59 was sys_olduname */
-#define __NR_umask		 60
-#define __NR_chroot		 61
-#define __NR_ustat		 62
-#define __NR_dup2		 63
-#define __NR_getppid		 64
-#define __NR_getpgrp		 65
-#define __NR_setsid		 66
-#define __NR_sigaction		 67
-#define __NR_sgetmask		 68
-#define __NR_ssetmask		 69
-#define __NR_setreuid		 70
-#define __NR_setregid		 71
-#define __NR_sigsuspend		 72
-#define __NR_sigpending		 73
-#define __NR_sethostname	 74
-#define __NR_setrlimit		 75
-#define __NR_getrlimit		 76	/* Back compatible 2Gig limited rlimit */
-#define __NR_getrusage		 77
-#define __NR_gettimeofday	 78
-#define __NR_settimeofday	 79
-#define __NR_getgroups		 80
-#define __NR_setgroups		 81
-				 /* 82 was sys_oldselect */
-#define __NR_symlink		 83
-#define __NR_oldlstat		 84
-#define __NR_readlink		 85
-#define __NR_uselib		 86
-#define __NR_swapon		 87
-#define __NR_reboot		 88
-#define __NR_readdir		 89
-#define __NR_mmap		 90
-#define __NR_munmap		 91
-#define __NR_truncate		 92
-#define __NR_ftruncate		 93
-#define __NR_fchmod		 94
-#define __NR_fchown		 95
-#define __NR_getpriority	 96
-#define __NR_setpriority	 97
-				 /* 98 was sys_profil */
-#define __NR_statfs		 99
-#define __NR_fstatfs		100
-				/* 101 was sys_ioperm */
-#define __NR_socketcall		102
-#define __NR_syslog		103
-#define __NR_setitimer		104
-#define __NR_getitimer		105
-#define __NR_stat		106
-#define __NR_lstat		107
-#define __NR_fstat		108
-#define __NR_olduname		109
-				/* 110 was sys_iopl */
-#define __NR_vhangup		111
-				/* 112 was sys_idle */
-				/* 113 was sys_vm86old */
-#define __NR_wait4		114
-#define __NR_swapoff		115
-#define __NR_sysinfo		116
-#define __NR_ipc		117
-#define __NR_fsync		118
-#define __NR_sigreturn		119
-#define __NR_clone		120
-#define __NR_setdomainname	121
-#define __NR_uname		122
-#define __NR_cacheflush		123
-#define __NR_adjtimex		124
-#define __NR_mprotect		125
-#define __NR_sigprocmask	126
-				/* 127 was sys_create_module */
-#define __NR_init_module	128
-#define __NR_delete_module	129
-				/* 130 was sys_get_kernel_syms */
-#define __NR_quotactl		131
-#define __NR_getpgid		132
-#define __NR_fchdir		133
-#define __NR_bdflush		134
-#define __NR_sysfs		135
-#define __NR_personality	136
-				/* 137 was sys_afs_syscall */
-#define __NR_setfsuid		138
-#define __NR_setfsgid		139
-#define __NR__llseek		140
-#define __NR_getdents		141
-#define __NR__newselect		142
-#define __NR_flock		143
-#define __NR_msync		144
-#define __NR_readv		145
-#define __NR_writev		146
-#define __NR_getsid		147
-#define __NR_fdatasync		148
-#define __NR__sysctl		149
-#define __NR_mlock		150
-#define __NR_munlock		151
-#define __NR_mlockall		152
-#define __NR_munlockall		153
-#define __NR_sched_setparam		154
-#define __NR_sched_getparam		155
-#define __NR_sched_setscheduler		156
-#define __NR_sched_getscheduler		157
-#define __NR_sched_yield		158
-#define __NR_sched_get_priority_max	159
-#define __NR_sched_get_priority_min	160
-#define __NR_sched_rr_get_interval	161
-#define __NR_nanosleep		162
-#define __NR_mremap		163
-#define __NR_setresuid		164
-#define __NR_getresuid		165
-				/* 166 was sys_vm86 */
-				/* 167 was sys_query_module */
-#define __NR_poll		168
-#define __NR_nfsservctl		169
-#define __NR_setresgid		170
-#define __NR_getresgid		171
-#define __NR_prctl              172
-#define __NR_rt_sigreturn	173
-#define __NR_rt_sigaction	174
-#define __NR_rt_sigprocmask	175
-#define __NR_rt_sigpending	176
-#define __NR_rt_sigtimedwait	177
-#define __NR_rt_sigqueueinfo	178
-#define __NR_rt_sigsuspend	179
-#define __NR_pread64		180
-#define __NR_pwrite64		181
-#define __NR_chown		182
-#define __NR_getcwd		183
-#define __NR_capget		184
-#define __NR_capset		185
-#define __NR_sigaltstack	186
-#define __NR_sendfile		187
-				/* 188 reserved for sys_getpmsg */
-				/* 189 reserved for sys_putpmsg */
-#define __NR_vfork		190
-#define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
-#define __NR_mmap2		192
-#define __NR_truncate64		193
-#define __NR_ftruncate64	194
-#define __NR_stat64		195
-#define __NR_lstat64		196
-#define __NR_fstat64		197
-#define __NR_lchown32		198
-#define __NR_getuid32		199
-#define __NR_getgid32		200
-#define __NR_geteuid32		201
-#define __NR_getegid32		202
-#define __NR_setreuid32		203
-#define __NR_setregid32		204
-#define __NR_getgroups32	205
-#define __NR_setgroups32	206
-#define __NR_fchown32		207
-#define __NR_setresuid32	208
-#define __NR_getresuid32	209
-#define __NR_setresgid32	210
-#define __NR_getresgid32	211
-#define __NR_chown32		212
-#define __NR_setuid32		213
-#define __NR_setgid32		214
-#define __NR_setfsuid32		215
-#define __NR_setfsgid32		216
-#define __NR_pivot_root		217
-#define __NR_mincore		218
-#define __NR_madvise		219
-#define __NR_getdents64		220
-#define __NR_fcntl64		221
-				/* 222 is reserved for tux */
-				/* 223 is unused */
-#define __NR_gettid		224
-#define __NR_readahead		225
-#define __NR_setxattr		226
-#define __NR_lsetxattr		227
-#define __NR_fsetxattr		228
-#define __NR_getxattr		229
-#define __NR_lgetxattr		230
-#define __NR_fgetxattr		231
-#define __NR_listxattr		232
-#define __NR_llistxattr		233
-#define __NR_flistxattr		234
-#define __NR_removexattr	235
-#define __NR_lremovexattr	236
-#define __NR_fremovexattr	237
-#define __NR_tkill		238
-#define __NR_sendfile64		239
-#define __NR_futex		240
-#define __NR_sched_setaffinity	241
-#define __NR_sched_getaffinity	242
-				/* 243 is reserved for set_thread_area */
-				/* 244 is reserved for get_thread_area */
-#define __NR_io_setup		245
-#define __NR_io_destroy		246
-#define __NR_io_getevents	247
-#define __NR_io_submit		248
-#define __NR_io_cancel		249
-#define __NR_fadvise64		250
-				/* 251 is unused */
-#define __NR_exit_group		252
-#define __NR_lookup_dcookie	253
-#define __NR_epoll_create	254
-#define __NR_epoll_ctl		255
-#define __NR_epoll_wait		256
-#define __NR_remap_file_pages	257
-#define __NR_set_tid_address	258
-#define __NR_timer_create	259
-#define __NR_timer_settime	(__NR_timer_create+1)
-#define __NR_timer_gettime	(__NR_timer_create+2)
-#define __NR_timer_getoverrun	(__NR_timer_create+3)
-#define __NR_timer_delete	(__NR_timer_create+4)
-#define __NR_clock_settime	(__NR_timer_create+5)
-#define __NR_clock_gettime	(__NR_timer_create+6)
-#define __NR_clock_getres	(__NR_timer_create+7)
-#define __NR_clock_nanosleep	(__NR_timer_create+8)
-#define __NR_statfs64		268
-#define __NR_fstatfs64		269
-#define __NR_tgkill		270
-#define __NR_utimes		271
-#define __NR_fadvise64_64	272
-				/* 273 is reserved for vserver */
-#define __NR_mbind              274
-#define __NR_get_mempolicy      275
-#define __NR_set_mempolicy      276
-#define __NR_mq_open            277
-#define __NR_mq_unlink          (__NR_mq_open+1)
-#define __NR_mq_timedsend       (__NR_mq_open+2)
-#define __NR_mq_timedreceive    (__NR_mq_open+3)
-#define __NR_mq_notify          (__NR_mq_open+4)
-#define __NR_mq_getsetattr      (__NR_mq_open+5)
-#define __NR_kexec_load		283
-#define __NR_waitid		284
-#define __NR_add_key		285
-#define __NR_request_key	286
-#define __NR_keyctl		287
-#define __NR_ioprio_set		288
-#define __NR_ioprio_get		289
-#define __NR_inotify_init	290
-#define __NR_inotify_add_watch	291
-#define __NR_inotify_rm_watch	292
-				/* 293 is unused */
-#define __NR_migrate_pages	294
-#define __NR_openat		295
-#define __NR_mkdirat		296
-#define __NR_mknodat		297
-#define __NR_fchownat		298
-#define __NR_futimesat		299
-#define __NR_fstatat64		300
-#define __NR_unlinkat		301
-#define __NR_renameat		302
-#define __NR_linkat		303
-#define __NR_symlinkat		304
-#define __NR_readlinkat		305
-#define __NR_fchmodat		306
-#define __NR_faccessat		307
-#define __NR_pselect6		308
-#define __NR_ppoll		309
-#define __NR_unshare		310
-#define __NR_set_robust_list	311
-#define __NR_get_robust_list	312
-#define __NR_splice		313
-#define __NR_sync_file_range	314
-#define __NR_tee		315
-#define __NR_vmsplice		316
-#define __NR_move_pages		317
-#define __NR_getcpu		318
-#define __NR_epoll_pwait	319
-#define __NR_utimensat		320
-#define __NR_signalfd		321
-#define __NR_timerfd_create	322
-#define __NR_eventfd		323
-#define __NR_fallocate		324
-#define __NR_timerfd_settime	325
-#define __NR_timerfd_gettime	326
-#define __NR_signalfd4		327
-#define __NR_eventfd2		328
-#define __NR_epoll_create1	329
-#define __NR_dup3		330
-#define __NR_pipe2		331
-#define __NR_inotify_init1	332
-#define __NR_preadv		333
-#define __NR_pwritev		334
-#define __NR_rt_tgsigqueueinfo	335
-#define __NR_perf_event_open	336
-#define __NR_fanotify_init	337
-#define __NR_fanotify_mark	338
-#define __NR_prlimit64		339
-
-/* Non-multiplexed socket family */
-#define __NR_socket		340
-#define __NR_bind		341
-#define __NR_connect		342
-#define __NR_listen		343
-#define __NR_accept		344
-#define __NR_getsockname	345
-#define __NR_getpeername	346
-#define __NR_socketpair		347
-#define __NR_send		348
-#define __NR_sendto		349
-#define __NR_recv		350
-#define __NR_recvfrom		351
-#define __NR_shutdown		352
-#define __NR_setsockopt		353
-#define __NR_getsockopt		354
-#define __NR_sendmsg		355
-#define __NR_recvmsg		356
-#define __NR_recvmmsg		357
-#define __NR_accept4		358
-#define __NR_name_to_handle_at	359
-#define __NR_open_by_handle_at	360
-#define __NR_clock_adjtime	361
-#define __NR_syncfs		362
-#define __NR_sendmmsg		363
-#define __NR_setns		364
-#define __NR_process_vm_readv	365
-#define __NR_process_vm_writev	366
-#define __NR_kcmp		367
-#define __NR_finit_module	368
-#define __NR_sched_getattr	369
-#define __NR_sched_setattr	370
-#define __NR_renameat2		371
-#define __NR_seccomp		372
-#define __NR_getrandom		373
-#define __NR_memfd_create	374
-#define __NR_bpf		375
-#define __NR_execveat		376
-#define __NR_userfaultfd	377
-#define __NR_membarrier		378
-#define __NR_mlock2		379
-#define __NR_copy_file_range	380
-#define __NR_preadv2		381
-#define __NR_pwritev2		382
-
-#ifdef __KERNEL__
-#define __NR_syscalls		383
-#endif
-
-#endif /* __ASM_SH_UNISTD_32_H */
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
