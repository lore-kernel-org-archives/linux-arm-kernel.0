Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBC7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:22:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6265520883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="db2Daf/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6265520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IWxMMK9mCFwGAsrJEvIhx7DtJcYXgwxjPP+1EPd9P3E=; b=db2Daf/n8o5t9L
	uvi8dxMdEDLi0FoVDlkoKFXLN6y/mxVwAoRhDqnA3XRIQIti7oIuihvnOWvU45xH+3mHU81uBwQ1j
	BBg5X6T6ouhhg98pXYxNXJCo5W4CuMnOeKP1JXq+wBTgqSGg3WwQyxNvRW1p9e+bQJVq1kERnOieo
	WZ296ENHblSBfzoCHl3EEQBQr0bncn1hhkUaWoZ6Emiqn7q0zBE7lvYwd9AnnAyRrShrRIrDxUDhp
	G17bi8KUsc3Teb/+amjhL+T3uYNC1ZsX7Oz2tyX0zPaVrGYK8kwIe+O4mPZ75LfJx8fax2smuWVg2
	NK9fR7zinfHKPH0K1JZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWu3-0002jn-I7; Fri, 18 Jan 2019 16:21:55 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWse-0001OF-7j
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 16:20:30 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M8QNy-1gouaL0Udc-004VsZ; Fri, 18 Jan 2019 17:19:25 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 07/29] ARM: add kexec_file_load system call number
Date: Fri, 18 Jan 2019 17:18:13 +0100
Message-Id: <20190118161835.2259170-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:8ym37e+lD/lgSGacCaoLSHBwvMbYSdoq935/+50m0n+e2+nfjyl
 Uc3eCCUqAr3iiX9tp3dh/UjTnNU1TWM344t7SmBQecjF8G3qbieGmrEuRnYfdVzVTXxlNMn
 1F6pSIpGD86JSkJzsxanqoPTEb+l+XA5OO3U0pzk6a/S0BMyuhTWrH4HTr95PQFlXgEL4sD
 b/smjhXtOquSiUivlB38g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hPFjMXC73D8=:yIT7bb4MDFSWj86wHD5l4c
 Dw71KKy4lEMciOZt+W7BOiEuK2mNuN+kh5N3AiCr4vfMUFyOd0gUpMGVvzlD5ys8kVC8UFHy1
 GF3XDa3FhTBMA3K+9JRQ8rmAsDSolTFqDYWCMPAT63yZzygeYo+H4Gb28+uNbUdwlsZqY9gO8
 6lK6+sEIXt8TvMB4ddTaGomaNQPmxg4p1hEhaovZAfReP98dH5330uzzrgeqRsnqM2eHkKNHE
 IPPBPHtvsyz2uSE81DXrtfxuBWnljymZkblHoH/MPVnSr/2bCgJGktCOvWDoVamsF7nbJsafo
 2OignWTVnOttBAtdSjEfSQ6CDTNo9IioOYs6f/rgrWALcLtl8cQBqMMcwSuRSeg7LAk4hc7Oj
 vKqxXzmE6UzScOdNEzF+a+2KnoI+oavrpydZ3aezYjXL9WJt6eh/9b1NMWLoLioZhktu7kZ6b
 mZh1EEbibQK8F64O6oN3sLL4qqNGDpvKpnMdtyBo2RHlZhWm2ACWT6TJIaGxLHEQjzxZGToRN
 IFf4ybmEY0PVOn3IHZu/nuvhVYHTeILnajyNYSzLFJ3VZ9kru5A/DCKSsLyoeKTCUNnQHigs5
 2bl5d22j1GPBmdXFJiXmupqH8HXQEkhm2IhAGe2JkhUkSAvGLFP1YeJ1fCfrGDG34cx2/LUcp
 JcCpam5vxV5OOFiQEFF/gbY/veubTMQIf5uhL2znlb1HwTgwa3y+NgPSsmX9zdfo3Hj9Ix3G5
 AQJldjI7SaGcXfDZb0CIJB58fi1O6B6dUcSGIQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_082028_735845_4DF27AA4 
X-CRM114-Status: GOOD (  12.83  )
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

A couple of architectures including arm64 already implement the
kexec_file_load system call, on many others we have assigned a system
call number for it, but not implemented it yet.

Adding the number in arch/arm/ lets us use the system call on arm64
systems in compat mode, and also reduces the number of differences
between architectures. If we want to implement kexec_file_load on ARM
in the future, the number assignment means that kexec tools can already
be built with the now current set of kernel headers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/tools/syscall.tbl        | 1 +
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 86de9eb34296..20ed7e026723 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -415,3 +415,4 @@
 398	common	rseq			sys_rseq
 399	common	io_pgetevents		sys_io_pgetevents
 400	common	migrate_pages		sys_migrate_pages
+401	common	kexec_file_load		sys_kexec_file_load
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 261216c3336e..2c30e6f145ff 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		401
+#define __NR_compat_syscalls		402
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index f15bcbacb8f6..8ca1d4c304f4 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -823,6 +823,8 @@ __SYSCALL(__NR_rseq, sys_rseq)
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_migrate_pages 400
 __SYSCALL(__NR_migrate_pages, compat_sys_migrate_pages)
+#define __NR_kexec_file_load 401
+__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
