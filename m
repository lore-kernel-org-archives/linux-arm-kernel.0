Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D845C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:30:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0F2206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tTZumlF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0F2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YuZRTy0tHhMUXeGtmYCEgrSuKZl6gOTta3ySoid7f1U=; b=tTZumlF1B54Y9o
	fWSCIWwhn6D13BooYiw14AUbygZVSGPMteBfe9TCGUTF2Tz5kFCaY2P0UMoPweJab26MWvgIrx+TO
	G5RO39Cou2l+rA5Y9dF2LB1jKvBTEugTIIsLQLSBgdq1+RsB6z3rwO3HtZ8hiraiWpVwMKQxKHqwk
	AOI7ODpaMM63V+445YxPXOOTwUWQZ0meE+4dl1RdRsdXpNUadUKxoPqjqKbpjvHtpNorm9hgk1Kc/
	gy+L0zsy493u5dilXhCajAvRfIK3WNY+CWB8Xd824JzxDv82KL9U6+t0S/j+wmMTE55FT7vzIAD85
	78x6BB7X2F77q7WIFzMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdDR-0007h0-Qo; Thu, 10 Jan 2019 16:29:57 +0000
Received: from mout.kundenserver.de ([217.72.192.75])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdAD-0004d3-0H
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 16:26:48 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M8yoa-1gbZP519vi-0063I1; Thu, 10 Jan 2019 17:25:05 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] arch: synchronize syscall tables in preparation for
 y2038
Date: Thu, 10 Jan 2019 17:24:20 +0100
Message-Id: <20190110162435.309262-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:jhoE6/odjdfdBd6yrYoTQRylO8KTHs0vFajSRSOy3XKF9bGfqko
 KtSukK0N0eaTZv6m1MEw3rEB/9fW1GAIssAzz4uJd1F6vdHonvwYJKMyB1s1aApsfbiJEC9
 5okxLH6hKdq1eSKydX2+7l6cR7QwTqF7aGCx8EhvPkPF3W7xFOzG77OECp6a+2EDAchEiTB
 wNs3RaKtpG4cOPTeZ6RSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5xO5hqiOarE=:c+iZ9kLMNq1WpvagfFixUK
 KblxgxXKOzW/ayE0xHmHoXJnWMfNLm+d1W4SA6omPPTDDVuCF8E6MnCsIP7s262/5hLKjuZwO
 qw/U5gYgrED/GkEzYSGdZaw/AA4vdYj6X0aLPj0izwKjFa6jsx/59jseIoJa1W8bngmyt7353
 jD8gBiL6F0FE+MbZgrHlVRclpEjuRNgEF9lUI3uL01eWryW+YtgueG06/Am2G2e1NsCx3Z/XD
 VBRGKKTfNtFdrsc28Df5rzFIRmhvuPU57AHF9Cvcr7QoQ/Wl4L8OY/Qo2R8D5VvCf6SRKNkcS
 JGefvNLcFQn+69gKWR7va/qMvAJbZPDrMOzIJyo9O7zQG956eZKK1JIQd0htZBjBO514W1Kxc
 WAEAFcOmZfO50u8+Wr7cWmJtpCwN7HJ9zJqAXw8Yfjzb6NoZG8JHzaTkkTvfhc+Clrfgro1dp
 1O2r7nREhlppbmsMUz79/ZwxtZVsv1oMIL0sr8ZQFE0Tf0fKAunIpUxm6BLLNhszcpYtg8UfU
 Yd/1M20ISzeIz/yiMCJ+2ithBwz84ZnftBpTFUeaqlQVJWLjVOcdH0+szWRuJ23O38qxwshFL
 baJqqC1kB7kYZEwYHGYQprS4087AY4Exfl0pO+wSKjdPuAMQg0guC1OS9j7DGBCqkN+wQXQEV
 z4ytAVckRafv+zejAZlDq+sZdRZ0w1XQCh24HQXujupgvCQKysD6SsYVl0QrM7VGNMM85xyI5
 LBr4cgrZBGMkoOS2wYlsAoXV3QRR/h5DzYM9Dw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_082638_368521_74F7A03C 
X-CRM114-Status: GOOD (  14.82  )
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

The system call tables have diverged a bit over the years, and a number
of the recent additions never made it into all architectures, for one
reason or another.

This is an attempt to clean it up as far as we can without breaking
compatibility, doing a number of steps:

- Add system calls that have not yet been integrated into all
  architectures but that we definitely want there.

- Add the separate ipc syscalls on all architectures that
  traditionally only had sys_ipc(). This version is done without
  support for IPC_OLD that is we have in sys_ipc. The
  new semtimedop_time64 syscall will only be added here, not
  in sys_ipc

- Add syscall numbers for a couple of syscalls that we probably
  don't need everywhere, in particular pkey_* and rseq,
  for the purpose of symmetry: if it's in asm-generic/unistd.h,
  it makes sense to have it everywhere.

- Prepare for having the same system call numbers for any future
  calls. In combination with the generated tables, this hopefully
  makes it easier to add new calls across all architectures
  together.

Most of the contents of this series are unrelated to the actual
y2038 work, but for the moment, that second series is based on
this one. If there are any concerns about changes here, I
can drop or rewrite any individual patch in this series.

My plan is to merge any patches in this series that are found
to be good together with the y2038 patches for linux-5.1, so
please review and provide Acks for merging through my tree,
or pick them up for 5.0 if they seem urgent enough.

      Arnd

Arnd Bergmann (15):
  ia64: add __NR_umount2 definition
  ia64: add statx and io_pgetevents syscalls
  ia64: assign syscall numbers for perf and seccomp
  alpha: wire up io_pgetevents system call
  alpha: update syscall macro definitions
  ARM: add migrate_pages() system call
  ARM: add kexec_file_load system call number
  m68k: assign syscall number for seccomp
  sh: remove duplicate unistd_32.h file
  sh: add statx system call
  mips: fix n32 compat_ipc_parse_version
  sparc64: fix sparc_ipc type conversion
  ipc: rename old-style shmctl/semctl/msgctl syscalls
  arch: add split IPC system calls where needed
  arch: add pkey and rseq syscall numbers everywhere

 arch/alpha/include/asm/unistd.h             |  10 -
 arch/alpha/include/uapi/asm/unistd.h        |   5 +
 arch/alpha/kernel/syscalls/syscall.tbl      |  15 +-
 arch/arm/include/asm/unistd.h               |   1 -
 arch/arm/tools/syscall.tbl                  |   8 +-
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |  10 +-
 arch/ia64/include/asm/unistd.h              |  14 -
 arch/ia64/include/uapi/asm/unistd.h         |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  10 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |  16 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   6 +-
 arch/mips/Kconfig                           |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   6 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   6 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  11 +
 arch/parisc/include/asm/unistd.h            |   3 -
 arch/parisc/kernel/syscalls/syscall.tbl     |   4 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  12 +
 arch/s390/include/asm/unistd.h              |   3 -
 arch/s390/kernel/syscalls/syscall.tbl       |  15 +
 arch/sh/include/uapi/asm/unistd_32.h        | 403 --------------------
 arch/sh/kernel/syscalls/syscall.tbl         |  16 +
 arch/sparc/include/asm/unistd.h             |   5 -
 arch/sparc/kernel/sys_sparc_64.c            |   2 +-
 arch/sparc/kernel/syscalls/syscall.tbl      |  16 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  11 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   7 +-
 include/linux/syscalls.h                    |   3 +
 ipc/msg.c                                   |  39 +-
 ipc/sem.c                                   |  39 +-
 ipc/shm.c                                   |  40 +-
 ipc/syscall.c                               |  12 +-
 ipc/util.h                                  |  21 +-
 kernel/sys_ni.c                             |   3 +
 35 files changed, 271 insertions(+), 506 deletions(-)
 delete mode 100644 arch/sh/include/uapi/asm/unistd_32.h

-- 
2.20.0
Cc: ink@jurassic.park.msu.ru
Cc: mattst88@gmail.com
Cc: linux@armlinux.org.uk
Cc: catalin.marinas@arm.com
Cc: will.deacon@arm.com
Cc: tony.luck@intel.com
Cc: fenghua.yu@intel.com
Cc: geert@linux-m68k.org
Cc: monstr@monstr.eu
Cc: paul.burton@mips.com
Cc: deller@gmx.de
Cc: mpe@ellerman.id.au
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: dalias@libc.org
Cc: davem@davemloft.net
Cc: luto@kernel.org
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: jcmvbkbc@gmail.com
Cc: arnd@arndb.de
Cc: firoz.khan@linaro.org
Cc: ebiederm@xmission.com
Cc: deepa.kernel@gmail.com
Cc: linux@dominikbrodowski.net
Cc: akpm@linux-foundation.org
Cc: dave@stgolabs.net
Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-api@vger.kernel.org
CC: y2038@lists.linaro.org

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
