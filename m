From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Jul 2015 14:59:41 +0100
Subject: next-20150716 build: 4 failures 88 warnings (next-20150716)
In-Reply-To: <E1ZFg2R-0001bO-R5@optimist>
References: <E1ZFg2R-0001bO-R5@optimist>
Message-ID: <20150716135941.GK4039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 11:05:11AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 defconfig and allmodconfig due to
"mm: mlock: add new mlock, munlock, and munlockall system calls" which
triggers:

> ../arch/arm64/include/asm/unistd32.h:801:1: error: array index in initializer exceeds array bounds
> ../arch/arm64/include/asm/unistd32.h:801:1: error: (near initialization for 'compat_sys_call_table')
> ../arch/arm64/include/asm/unistd32.h:803:1: error: array index in initializer exceeds array bounds
> ../arch/arm64/include/asm/unistd32.h:803:1: error: (near initialization for 'compat_sys_call_table')
> ../arch/arm64/include/asm/unistd32.h:805:1: error: array index in initializer exceeds array bounds
> ../arch/arm64/include/asm/unistd32.h:805:1: error: (near initialization for 'compat_sys_call_table')

since it adds new syscalls but does not update __NR_compat_syscalls in
arch/arm64/include/asm/unistd.h so there are no array slots for the new
data.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150716/22949c09/attachment-0001.sig>
