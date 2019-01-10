Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E12C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:28:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0E4214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FxpNcQ4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0E4214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uFvPdMuaX691j9uydPxtV5tPhAq2L6UmPpLNuzLzP94=; b=FxpNcQ4LgbO1jx
	iNbnxO8NhNg0s+fhA5EScoR+L/uOBxynhNV/na/0PDl6cWC2Y45MKNYZ7lAEz+cfD2N/OvJw6aFkm
	/ZD2C05bX1MUPHwgEs+nlHX/vqm3x1dPy73x7PbjK4sMSY2BmNuWi4LYVcRXsmW5k+7zmTzhgFYda
	lnXP+W0kSJJgdMiykRWp4hThLRByBrlATgvQHWTQRNTRZ0Pe4r8WF1ttiQIzfEFZDBQE8qTQGjOd9
	J4k/xtScLy9EzRnLoc+iuRfcOMLlRMwSMY5f4Dz1Bsk/M0aIvpIWlF0mfEopEpp5kTkW+BZ/xVNnf
	XWOcXtRAyuEQ5rH//4Ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdBr-0006Iv-CB; Thu, 10 Jan 2019 16:28:19 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghd9s-0004Im-05
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:26:19 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M26n9-1gjYwt2XdZ-002VJW; Thu, 10 Jan 2019 17:25:14 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] ARM: add kexec_file_load system call number
Date: Thu, 10 Jan 2019 17:24:27 +0100
Message-Id: <20190110162435.309262-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:bbQTa8+RVq8uOU5pbxDK+0/4n2oFwdb20J9rbCJvp69tR6LbpUE
 BGw9PvuvotSd1z/CxUlN3LgFpu8c2eaVfhJU913d+y+4OuiKFe0x+5pUiPKr+A8JyoqUNYl
 +HzTAqMZP6muHMdLv1v6FLhgS7jrtc4eJiWfRbo6++zUEUKkS/plrzdPDX4N3ebSRZ82vdU
 29ipN8xprnY8eaAdBUF1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KcIkOw8POYU=:PlPoKFpPERWmgM//oISQHu
 FSulXma/Pg8PEBbrHXiPuKmqgQPSJjkYE+IphJVFUZAY6EDeu6AtFVVptEDSdANsrovpTXcAL
 b/AS9w9/SN/itOc8+uv+gP7/lQwmYzvDK1BbwMZpnXwYFjfMvbHPoKh9HcCWPXrhFDSGmw+8y
 5noFZR9dcb/SHixiXSpF1Uzzrt/1D05eMzRme6bDd6MQ8vzxvH9RxaowXKWyPsrHShPT5Yns3
 RvFMOs0GUK3O83DVUX7KxpyabIrqW2LWJqx+aQ/5s1+2NDh5iBfmAYGenrjOjg1Dw7D3x2DO6
 CbwGY7gKDYkp0Xv059QhC7u7F1tqgEzxTdrIb4K+LJQWNhFWZE6dFMlppU8my+3kMD+cIT6a4
 /lKUb9S1bXaWBFRozDTYAQ/dWsNDdcosUEbHB8AsA5zHlOClTE881gOj7PkZjhSIyEpiIEioD
 iBQFivwkpvXegsxBX3XNPos5ITLYPP00OJlLDCNuDqXAAMqMGQWMyaOHiSPo+J0RuYfofVFUk
 +ZA+taJ3UVicsNsNzgjrOb/MA1fkK79L0NYP12Nqoq7c8R8vhby74mvgU8cyLD8zYnzaa6jLH
 4nGKiLGdIzNVujVY6D9aWQawS+VNaFBXbqJ55jmmne047urmDt0vQV5Lg53Yze4OpTMtc1ZKL
 bEcAVanw4q5TBWN6nFcFgDqVzMcE+qwbf76mZR1JQw1kZojx200VU6Wc77Ggq+t14WHPxEt3u
 fc4ZKBNefarvA8bAMh25iORuVAYJ+Kk4mxSxzQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_082616_336652_FDA93122 
X-CRM114-Status: GOOD (  13.53  )
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
index 355fe2bc035b..19f3f58b6146 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -823,6 +823,8 @@ __SYSCALL(__NR_rseq, sys_rseq)
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
 #define __NR_migrate_pages 400
 __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
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
