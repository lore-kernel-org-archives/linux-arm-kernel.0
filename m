Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044A4C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:56:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C349420866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dVXNnWQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C349420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/7emEDmqp4L6aLGQY5t6g77z7mYgXi5/J5lj9ARRRvo=; b=dVXNnWQsDXQh7S
	BQSu2B198RlVzpv2yZEoe5LAdfeyP1e+gd/8BHDp1A9ntJ5Dy4Z1IVJreaiF2moCiZdlskOX5za9q
	dDJybAjxuve9300bR/eriHMChNSu3+CnihPcZZIlrwKHG+G8j8urL7/VmXcYnzwTv7CKjdbnmU5NP
	quyam+RpuOLW+lu68TYhdjho2PBCN+7/kBlFfwJvPkZkV3u5/2w0i5Ppb/VhsPXceJ1o9Yyp3De40
	CG9tJqsyKZ+tv1HmHvZwhKpmxmFRuEjp22Z5ZXMpvZm0lMDGpCSOrpCt49CdS+WQhNpFmSXjRoGFQ
	ctJDOgcEzdRJTy1Pt9lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPCr-0003zf-GH; Tue, 15 Jan 2019 13:56:41 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPCb-0003ng-V5
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 13:56:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BC5AA78;
 Tue, 15 Jan 2019 05:56:23 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86B7E3F70D;
 Tue, 15 Jan 2019 05:56:21 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 00/24] Unify vDSOs across more architectures
Date: Tue, 15 Jan 2019 13:55:15 +0000
Message-Id: <20190115135539.24762-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_055626_013695_4DBCB390 
X-CRM114-Status: GOOD (  23.35  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

vDSO (virtual dynamic shared object) is a mechanism that the Linux
kernel provides as an alternative to system calls to reduce where
possible the costs in terms of cycles.
This is possible because certain syscalls like gettimeofday() do
not write any data and return one or more values that are stored
in the kernel, which makes relatively safe calling them directly
as a library function.

Even if the mechanism is pretty much standard, every architecture
in the last few years ended up implementing their own vDSO library
in the architectural code.

The purpose of this patch-set is to identify the commonalities in
between the architectures and try to consolidate the common code
paths, starting with gettimeofday().

This implementation contains the following design choices:
 * Every architecture defines the arch specific code in an header in
   "asm/vdso/".
 * The generic implementation includes the arch specific one and lives
   in "lib/vdso".
 * The arch specific code for gettimeofday lives in
   "<arch path>/vdso/gettimeofday.c" and includes the generic code only.
 * This approach allows to consolidate the common code in a single place
   with the benefit of avoiding code duplication.

This implementation contains the portings to the common library for: arm64,
compat mode for arm64, arm and mips.

The mips porting has been tested on qemu for mips32el. A configuration to
repeat the tests can be found at [4].

Last but not least from this porting arm64, compat arm64, arm and mips gain
the support for:
 * CLOCK_BOOTTIME that can be useful in certain scenarios since it keeps
   track of the time during sleep as well.
 * CLOCK_TAI that is like CLOCK_REALTIME, but uses the International
   Atomic Time (TAI) reference instead of UTC to avoid jumping on leap
   second updates.
for both clock_gettime and clock_getres.

The porting has been validated using the vdsotest test-suite [1] extended
to cover all the clock ids [2].

To simplify the testing, a copy of the patchset on top of a recent linux
tree can be found at [3] and [4].

[1] https://github.com/nathanlynch/vdsotest
[2] https://github.com/fvincenzo/vdsotest
[3] git://linux-arm.org/linux-vf.git vdso/v4
[4] git://linux-arm.org/linux-vf.git vdso-mips/v4

Changes:
--------
v4:
  - Rebased on 5.0-rc2.
  - Addressed review comments.
  - Disabled compat vdso on arm64 when the kernel is compiled with
    clang.
v3:
  - Ported the latest fixes and optimizations done on the x86
    architecture to the generic library.
  - Addressed review comments.
  - Improved the documentation of the interfaces.
  - Changed the HAVE_ARCH_TIMER config option to a more generic
    HAVE_HW_COUNTER.
v2:
  - Added -ffixed-x18 to arm64
  - Repleced occurrences of timeval and timespec
  - Modified datapage.h to be compliant with y2038 on all the architectures
  - Removed __u_vdso type

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Peter Collingbourne <pcc@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Peter Collingbourne (1):
  arm64: Build vDSO with -ffixed-x18

Vincenzo Frascino (23):
  kernel: Standardize vdso_datapage
  kernel: Define gettimeofday vdso common code
  arm64: Substitute gettimeofday with C implementation
  arm64: compat: Alloc separate pages for vectors and sigpage
  arm64: compat: Split kuser32
  arm64: compat: Refactor aarch32_alloc_vdso_pages()
  arm64: compat: Add KUSER_HELPERS config option
  arm64: compat: Add missing syscall numbers
  arm64: compat: Expose signal related structures
  arm64: compat: Generate asm offsets for signals
  lib: vdso: Add compat support
  arm64: compat: Add vDSO
  arm64: Refactor vDSO code
  arm64: compat: vDSO setup for compat layer
  arm64: elf: vDSO code page discovery
  arm64: compat: Get sigreturn trampolines from vDSO
  arm64: Add vDSO compat support
  arm64: Enable compat vDSO support
  arm: Add support for generic vDSO
  mips: Introduce vdso_direct
  clock: csrc-4k: Add support for vdso_direct
  clock: gic-timer: Add support for vdso_direct
  mips: Add support for generic vDSO

 arch/arm/Kconfig                              |   4 +
 arch/arm/include/asm/vdso/gettimeofday.h      |  85 +++
 arch/arm/include/asm/vdso_datapage.h          |  25 +-
 arch/arm/kernel/vdso.c                        | 100 ++--
 arch/arm/vdso/Makefile                        |  13 +-
 arch/arm/vdso/note.c                          |  15 +
 arch/arm/vdso/vdso.lds.S                      |   1 +
 arch/arm/vdso/vgettimeofday.c                 | 267 +---------
 arch/arm64/Kconfig                            |  25 +
 arch/arm64/Makefile                           |  23 +-
 arch/arm64/configs/defconfig                  |   1 +
 arch/arm64/include/asm/elf.h                  |  20 +-
 arch/arm64/include/asm/processor.h            |   4 +-
 arch/arm64/include/asm/signal32.h             |  58 +-
 arch/arm64/include/asm/unistd.h               |   3 +
 arch/arm64/include/asm/vdso.h                 |   3 +
 arch/arm64/include/asm/vdso/compat_barrier.h  |  36 ++
 .../include/asm/vdso/compat_gettimeofday.h    | 122 +++++
 arch/arm64/include/asm/vdso/gettimeofday.h    |  88 ++++
 arch/arm64/include/asm/vdso_datapage.h        |  47 --
 arch/arm64/kernel/Makefile                    |   7 +-
 arch/arm64/kernel/asm-offsets.c               |  41 +-
 arch/arm64/kernel/kuser32.S                   |  65 +--
 arch/arm64/kernel/signal32.c                  |  76 +--
 arch/arm64/kernel/sigreturn32.S               |  46 ++
 arch/arm64/kernel/vdso.c                      | 498 +++++++++++++-----
 arch/arm64/kernel/vdso/Makefile               |  28 +-
 arch/arm64/kernel/vdso/gettimeofday.S         | 328 ------------
 arch/arm64/kernel/vdso/vgettimeofday.c        |  28 +
 arch/arm64/kernel/vdso32/.gitignore           |   2 +
 arch/arm64/kernel/vdso32/Makefile             | 184 +++++++
 arch/arm64/kernel/vdso32/note.c               |  15 +
 arch/arm64/kernel/vdso32/sigreturn.S          |  62 +++
 arch/arm64/kernel/vdso32/vdso.S               |  19 +
 arch/arm64/kernel/vdso32/vdso.lds.S           |  81 +++
 arch/arm64/kernel/vdso32/vgettimeofday.c      |  41 ++
 arch/mips/Kconfig                             |   3 +
 arch/mips/include/asm/clocksource.h           |   1 +
 arch/mips/include/asm/vdso.h                  |  60 +--
 arch/mips/include/asm/vdso/gettimeofday.h     | 168 ++++++
 arch/mips/{ => include/asm}/vdso/vdso.h       |   6 +-
 arch/mips/kernel/csrc-r4k.c                   |   4 +-
 arch/mips/kernel/vdso.c                       | 103 +++-
 arch/mips/vdso/Makefile                       |  23 +-
 arch/mips/vdso/elf.S                          |   2 +-
 arch/mips/vdso/gettimeofday.c                 | 273 ----------
 arch/mips/vdso/sigreturn.S                    |   2 +-
 arch/mips/vdso/vdso.lds.S                     |   1 +
 arch/mips/vdso/vgettimeofday.c                |  28 +
 drivers/clocksource/mips-gic-timer.c          |   5 +-
 include/vdso/datapage.h                       |  61 +++
 include/vdso/helpers.h                        |  58 ++
 include/vdso/types.h                          |  39 ++
 lib/Kconfig                                   |   5 +
 lib/vdso/Kconfig                              |  41 ++
 lib/vdso/Makefile                             |  22 +
 lib/vdso/gettimeofday.c                       | 192 +++++++
 57 files changed, 2255 insertions(+), 1303 deletions(-)
 create mode 100644 arch/arm/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/arm/vdso/note.c
 create mode 100644 arch/arm64/include/asm/vdso/compat_barrier.h
 create mode 100644 arch/arm64/include/asm/vdso/compat_gettimeofday.h
 create mode 100644 arch/arm64/include/asm/vdso/gettimeofday.h
 delete mode 100644 arch/arm64/include/asm/vdso_datapage.h
 create mode 100644 arch/arm64/kernel/sigreturn32.S
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S
 create mode 100644 arch/arm64/kernel/vdso/vgettimeofday.c
 create mode 100644 arch/arm64/kernel/vdso32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso32/Makefile
 create mode 100644 arch/arm64/kernel/vdso32/note.c
 create mode 100644 arch/arm64/kernel/vdso32/sigreturn.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.lds.S
 create mode 100644 arch/arm64/kernel/vdso32/vgettimeofday.c
 create mode 100644 arch/mips/include/asm/vdso/gettimeofday.h
 rename arch/mips/{ => include/asm}/vdso/vdso.h (90%)
 delete mode 100644 arch/mips/vdso/gettimeofday.c
 create mode 100644 arch/mips/vdso/vgettimeofday.c
 create mode 100644 include/vdso/datapage.h
 create mode 100644 include/vdso/helpers.h
 create mode 100644 include/vdso/types.h
 create mode 100644 lib/vdso/Kconfig
 create mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/gettimeofday.c

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
