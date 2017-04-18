From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon, 17 Apr 2017 18:31:56 -0700
Subject: arm64: Question about warnings due to unspecified ASM operand width
Message-ID: <20170418013156.GB105296@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

During my work on improving support for kernel builds with clang I
came across a bunch of warnings on arm64 builds about the width of
operands in assembly not being specified:

arch/arm64/include/asm/arch_timer.h:92:46: error: value size does
      not match register size specified by the constraint and modifier [-Werror,-Wasm-operand-widths]
        asm volatile("mrs %0,   cntfrq_el0" : "=r" (val));

I understand that this is usually not a problem and might even be
desired to give the compiler more flexiblity in the use of the
available registers.

My goal is to eventually build the kernel without warnings, not
necessarily fixing all of them, warnings can also be disabled, e.g.
in case of spurious warnings or a high number of occurrences that is
too expensive to fix.

Before delving into 'fixing' these 'asm-operand-widths' warnings I'd
be interested to know if this is actually desirable or if it is
preferred to keep the operand width unspecified in certain cases.

Thanks

Matthias
