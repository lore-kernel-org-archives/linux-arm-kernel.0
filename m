From: joel@porquet.org (Joel Porquet)
Date: Sun,  9 Oct 2016 17:03:06 -0700
Subject: [PATCH 0/2] make asm-generic/futex.h usable for more arch ports
Message-ID: <20161010000308.13212-1-joel@porquet.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've had a patch on my shelf for a couple of years, from when I ported Linux on
a new processor architecture for an academic project, and thought I could send
it and let you decide if it's worth taking or not.

During my port, I basically modified the generic header "asm-generic/futex.h"
and made it into a more generic version so that I could include it in my code
and only redefine the necessary arch-specific bits.

Right now, most of the arch ports redefine their own "asm/futex.h" completely
although, for example for "futex_atomic_op_inuser()", they often share the exact
same preamble and epilogue and could benefit from some code refactoring.

My (short) series is made of two patches: 1/ refactoring "asm-generic/futex.h"
in order to make the arch-specific routines into overload-able macros that arch
ports can redefine when required, 2/ an example of how to use this refactoring
with the ARM port.

Let me know what you think.

Cheers,
Jo?l

Joel Porquet (2):
  asm-generic/futex.h: code refactoring
  arm: futex: Use asm-generic/futex.h instead of redefining the entire
    header

 arch/arm/include/asm/futex.h | 203 +++++++++++++++++----------------------
 include/asm-generic/futex.h  | 219 ++++++++++++++++++++++---------------------
 2 files changed, 196 insertions(+), 226 deletions(-)

-- 
2.10.0
