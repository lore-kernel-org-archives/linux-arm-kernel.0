From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Jun 2010 16:33:18 -0400
Subject: [PATCH 0/5] enablement of some security features missing on ARM
Message-ID: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those are simple patches adding address space layout randomization for
the user space heap and mmap(), as well as stack protector support.

The stack protector support depends on GCC's ability to insert a canary
on the stack upon entering a function, and validating it before leaving
that function. The included test module in patch #5 intends to test that,
but (at least with the GCC version I have here) the canary code is not
inserted in that particular test code unless it is forced with
-fstack-protector-all (if anyone has a clue to why I'd be interested).

 [PATCH 1/5] [ARM] implement arch_randomize_brk()
 [PATCH 2/5] [ARM] add address randomization to mmap()
 [PATCH 3/5] ARM: initial stack protector (-fstack-protector) support
 [PATCH 4/5] ARM: stack protector: change the canary value per task
 [PATCH 5/5] Stack protector: test module


Nicolas
