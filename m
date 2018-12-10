Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19357C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:32:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9EA20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BIbQZYCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9EA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XnFJ+f2WaeEHo5WO3zfZGP9QX7okXuVPLZfZbq9oHbs=; b=BIbQZYCT2hA+Ez
	KNoiYKq8A9cuzCPJgfiRqI5BGWDroDts7EFuXSlGMfOHvqlILZgLsD2lMcW2JppI61YC6boN7wD2W
	Lb8mu/0ZFRH/S57APvKf5TPPUtL6r6Ksgf1J0cxwqE/OWSv5LNHwAML1tT9pmF3UgJmbX05USZ+Mb
	gcoWBd5nYaua7aDfTnAWefhdVNZ+w+lfMq7Hobw6ViIl0mLHHArz4rqszQIbcosg2Ztw9or1VsS8Q
	GgbVibz1Al27m6KbGxmfdFONkgBPN7geztr9zGNe56b9a2BJsy+qjMVS+M64xR9y/vlR3TQo+N5ce
	IE0c5T0enGouJ6NKeAxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWMbH-0001AF-2y; Mon, 10 Dec 2018 14:31:59 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWMaq-0000gk-2b
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 14:31:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E807B1596;
 Mon, 10 Dec 2018 06:31:19 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 837193F575;
 Mon, 10 Dec 2018 06:31:15 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 0/3] arm64 relaxed ABI
Date: Mon, 10 Dec 2018 14:30:41 +0000
Message-Id: <20181210143044.12714-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1544445454.git.andreyknvl@google.com>
References: <cover.1544445454.git.andreyknvl@google.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_063132_206026_AD44B788 
X-CRM114-Status: GOOD (  19.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Kostya Serebryany <kcc@google.com>, Chintan Pandya <cpandya@codeaurora.org>,
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Jacob Bramley <Jacob.Bramley@arm.com>, Evgeniy Stepanov <eugenis@google.com>,
 Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Dmitry Vyukov <dvyukov@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On arm64 the TCR_EL1.TBI0 bit has been set since Linux 3.x hence
the userspace (EL0) is allowed to set a non-zero value in the top
byte but the resulting pointers are not allowed at the user-kernel
syscall ABI boundary.

This patchset proposes a relaxation of the ABI and a mechanism to
advertise it to the userspace via an AT_FLAGS.

The rationale behind the choice of AT_FLAGS is that the Unix System V
ABI defines AT_FLAGS as "flags", leaving some degree of freedom in
interpretation.
There are two previous attempts of using AT_FLAGS in the Linux Kernel
for different reasons: the first was more generic and was used to expose
the support for the GNU STACK NX feature [1] and the second was done for
the MIPS architecture and was used to expose the support of "MIPS ABI
Extension for IEEE Std 754 Non-Compliant Interlinking" [2].
Both the changes are currently _not_ merged in mainline.
The only architecture that reserves some of the bits in AT_FLAGS is
currently MIPS, which introduced the concept of platform specific ABI
(psABI) reserving the top-byte [3].

When ARM64_AT_FLAGS_SYSCALL_TBI is set the kernel is advertising
to the userspace that a relaxed ABI is supported hence this type
of pointers are now allowed to be passed to the syscalls when they are
in memory ranges obtained by anonymous mmap() or brk().

The userspace _must_ verify that the flag is set before passing tagged
pointers to the syscalls allowed by this relaxation.

More in general, exposing the ARM64_AT_FLAGS_SYSCALL_TBI flag and mandating
to the software to check that the feature is present, before using the
associated functionality, it provides a degree of control on the decision
of disabling such a feature in future without consequently breaking the
userspace.

The change required a modification of the elf common code, because in Linux
the AT_FLAGS are currently set to zero by default by the kernel.

The newly added flag has been verified on arm64 using the code below.
#include <stdio.h>
#include <stdbool.h>
#include <sys/auxv.h>

#define ARM64_AT_FLAGS_SYSCALL_TBI     (1 << 0)

bool arm64_syscall_tbi_is_present(void)
{
        unsigned long at_flags = getauxval(AT_FLAGS);
        if (at_flags & ARM64_AT_FLAGS_SYSCALL_TBI)
                return true;

        return false;
}

void main()
{
        if (arm64_syscall_tbi_is_present())
                printf("ARM64_AT_FLAGS_SYSCALL_TBI is present\n");
}

This patchset should be merged together with [4].

[1] https://patchwork.ozlabs.org/patch/579578/
[2] https://lore.kernel.org/patchwork/cover/618280/
[3] ftp://www.linux-mips.org/pub/linux/mips/doc/ABI/psABI_mips3.0.pdf
[4] https://patchwork.kernel.org/cover/10674351/

ABI References:
---------------
Sco SysV ABI: http://www.sco.com/developers/gabi/2003-12-17/contents.html
PowerPC AUXV: http://openpowerfoundation.org/wp-content/uploads/resources/leabi/content/dbdoclet.50655242_98651.html
AMD64 ABI: https://www.cs.tufts.edu/comp/40-2012f/readings/amd64-abi.pdf
x86 ABI: https://www.uclibc.org/docs/psABI-i386.pdf
MIPS ABI: ftp://www.linux-mips.org/pub/linux/mips/doc/ABI/psABI_mips3.0.pdf
ARM ABI: http://infocenter.arm.com/help/topic/com.arm.doc.ihi0044f/IHI0044F_aaelf.pdf
SPARC ABI: http://math-atlas.sourceforge.net/devel/assembly/abi_sysV_sparc.pdf

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Chintan Pandya <cpandya@codeaurora.org>
Cc: Jacob Bramley <Jacob.Bramley@arm.com>
Cc: Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Lee Smith <Lee.Smith@arm.com>
Cc: Kostya Serebryany <kcc@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
Cc: Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Evgeniy Stepanov <eugenis@google.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (3):
  elf: Make AT_FLAGS arch configurable
  arm64: Define Documentation/arm64/elf_at_flags.txt
  arm64: elf: Advertise relaxed ABI

 Documentation/arm64/elf_at_flags.txt  | 111 ++++++++++++++++++++++++++
 arch/arm64/include/asm/atflags.h      |   7 ++
 arch/arm64/include/asm/elf.h          |   5 ++
 arch/arm64/include/uapi/asm/atflags.h |   8 ++
 fs/binfmt_elf.c                       |   6 +-
 fs/binfmt_elf_fdpic.c                 |   6 +-
 fs/compat_binfmt_elf.c                |   5 ++
 7 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/arm64/elf_at_flags.txt
 create mode 100644 arch/arm64/include/asm/atflags.h
 create mode 100644 arch/arm64/include/uapi/asm/atflags.h

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
