Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F0C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:06:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B2E213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BlstofxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B2E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=q9XVo2O6jSqzy+gcL5vvSGKZbK/AcNru9HAOg/I83UM=; b=BlstofxUBZxtLI
	fMo1oSv+Q6JXgh/i1r18RGxm4A79f5lD8ILFg1FZd/Siyi3o1A+4gd12hJDvFCeriLDucwoGJhtMS
	BTbMUdv2FdqUk/DkzHNgTrRrSOIzBaD6phGeFLb+U1GnDD9NNwCTqZ8zQ74KKvyeyQO1uhT5vL96r
	U3Dg22tQoQ+o8KiApepad/gb3xG4jwB+bzC4loLwJHwG6ig41iKsfDy3WzjHnugLZaExslK0TLC5G
	KRA69TLbrswy6+w3bwKHBR/cATF4Jtj21tSffrD54YHaotsUarzA00+ZwMCU8PP46BSV0dFnfcD9p
	9vqM75lU8fAm9VTYgJYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPm0-00012w-VD; Thu, 29 Nov 2018 17:06:44 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPlP-0000HY-Am
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:06:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DACAA78;
 Thu, 29 Nov 2018 09:05:55 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29E973F59C;
 Thu, 29 Nov 2018 09:05:53 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/28] Unify vDSOs across more architectures
Date: Thu, 29 Nov 2018 17:05:02 +0000
Message-Id: <20181129170530.37789-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_090608_289034_DD63F11D 
X-CRM114-Status: GOOD (  22.11  )
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

To simplify the testing, a copy of the patchset on top of a recent linux tree
can be found at [3].

[1] https://github.com/nlynch-mentor/vdsotest
[2] https://github.com/fvincenzo/vdsotest
[3] git://linux-arm.org/linux-vf.git vdso/v2
[4] git://linux-arm.org/linux-vf.git vdso-mips/v2

Changes:
--------
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

Vincenzo Frascino (27):
  kernel: Standardize vdso_datapage
  kernel: Add Monotonic boot time support
  kernel: Add International Atomic Time support
  kernel: Add masks support for Raw and NTP time
  kernel: Add clock_mode support
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
 arch/arm/include/asm/vdso/gettimeofday.h      |  82 ++++
 arch/arm/include/asm/vdso_datapage.h          |  25 +-
 arch/arm/kernel/vdso.c                        |  28 +-
 arch/arm/vdso/Makefile                        |  13 +-
 arch/arm/vdso/note.c                          |  15 +
 arch/arm/vdso/vdso.lds.S                      |   1 +
 arch/arm/vdso/vgettimeofday.c                 | 267 +----------
 arch/arm64/Kconfig                            |  25 +
 arch/arm64/Makefile                           |  21 +-
 arch/arm64/configs/defconfig                  |   1 +
 arch/arm64/include/asm/elf.h                  |  20 +-
 arch/arm64/include/asm/processor.h            |   4 +-
 arch/arm64/include/asm/signal32.h             |  58 ++-
 arch/arm64/include/asm/unistd.h               |   3 +
 arch/arm64/include/asm/vdso.h                 |   3 +
 arch/arm64/include/asm/vdso/compat_barrier.h  |  36 ++
 .../include/asm/vdso/compat_gettimeofday.h    | 111 +++++
 arch/arm64/include/asm/vdso/gettimeofday.h    |  85 ++++
 arch/arm64/kernel/Makefile                    |   7 +-
 arch/arm64/kernel/asm-offsets.c               |  13 +-
 arch/arm64/kernel/kuser32.S                   |  65 +--
 arch/arm64/kernel/signal32.c                  |  76 ++-
 arch/arm64/kernel/sigreturn32.S               |  46 ++
 arch/arm64/kernel/vdso.c                      | 413 +++++++++++++----
 arch/arm64/kernel/vdso/Makefile               |  28 +-
 arch/arm64/kernel/vdso/gettimeofday.S         | 328 -------------
 arch/arm64/kernel/vdso/vgettimeofday.c        |  28 ++
 arch/arm64/kernel/vdso32/.gitignore           |   2 +
 arch/arm64/kernel/vdso32/Makefile             | 184 ++++++++
 arch/arm64/kernel/vdso32/note.c               |  15 +
 arch/arm64/kernel/vdso32/sigreturn.S          |  62 +++
 arch/arm64/kernel/vdso32/vdso.S               |  19 +
 arch/arm64/kernel/vdso32/vdso.lds.S           |  81 ++++
 arch/arm64/kernel/vdso32/vgettimeofday.c      |  41 ++
 arch/mips/Kconfig                             |   3 +
 arch/mips/include/asm/clocksource.h           |   1 +
 arch/mips/include/asm/vdso.h                  |  53 +--
 arch/mips/include/asm/vdso/gettimeofday.h     | 165 +++++++
 arch/mips/{ => include/asm}/vdso/vdso.h       |   6 +-
 arch/mips/kernel/csrc-r4k.c                   |   4 +-
 arch/mips/kernel/vdso.c                       |  56 ++-
 arch/mips/vdso/Makefile                       |  23 +-
 arch/mips/vdso/elf.S                          |   2 +-
 arch/mips/vdso/gettimeofday.c                 | 273 -----------
 arch/mips/vdso/sigreturn.S                    |   2 +-
 arch/mips/vdso/vdso.lds.S                     |   1 +
 arch/mips/vdso/vgettimeofday.c                |  28 ++
 drivers/clocksource/mips-gic-timer.c          |   5 +-
 .../vdso/datapage.h                           |  15 +-
 include/vdso/types.h                          |  39 ++
 lib/Kconfig                                   |   5 +
 lib/vdso/Kconfig                              |  41 ++
 lib/vdso/Makefile                             |  22 +
 lib/vdso/gettimeofday.c                       | 432 ++++++++++++++++++
 55 files changed, 2192 insertions(+), 1194 deletions(-)
 create mode 100644 arch/arm/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/arm/vdso/note.c
 create mode 100644 arch/arm64/include/asm/vdso/compat_barrier.h
 create mode 100644 arch/arm64/include/asm/vdso/compat_gettimeofday.h
 create mode 100644 arch/arm64/include/asm/vdso/gettimeofday.h
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
 rename arch/arm64/include/asm/vdso_datapage.h => include/vdso/datapage.h (79%)
 create mode 100644 include/vdso/types.h
 create mode 100644 lib/vdso/Kconfig
 create mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/gettimeofday.c

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
