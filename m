From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 8 Sep 2014 14:56:56 +0200
Subject: [GIT PULL] at91: cleanup for 3.18 #2
Message-ID: <1410181016-9944-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Another pull-request that can be considered as "fixes-non-critical" or
"cleanup". I choose the latest as the patches are a little bit more than just
fixes.  The bug found by Ga?l is present on AT91 kernels for a long time so I
decided to avoid trying to submit it during the "-rc phase" or adding a
"stable" tag.
This material goes on top of the previous "cleanup" pull-request that you took
but comes with no dependency.

Thanks, best regards,

The following changes since commit 2626063f86cdce500153e8550334b9331421dc6f:

  ARM: at91: remove old irq material (2014-08-19 20:32:49 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-cleanup2

for you to fetch changes up to d07a1ecdfb96b26dd665b54fee22fc7417b1cb08:

  clocksource: tcb_clksrc: sanitize IRQ request (2014-09-08 10:54:03 +0200)

----------------------------------------------------------------
Second batch of AT91 cleanup for 3.18:
- Timer Counter (TC) fixup and cleanup:
  - fix segmentation fault when kexec-ing a kernel by masking
    TC interrupts at shutdown and probe time
  - use modern driver model: devm_*, probe function, sanitize IRQ request

----------------------------------------------------------------
Ga?l PORTAY (4):
      ARM: at91/tclib: prefer using of devm_* functions
      ARM: at91/tclib: move initialization from alloc to probe
      ARM: at91/tclib: mask interruptions at shutdown and probe
      clocksource: tcb_clksrc: sanitize IRQ request

 drivers/clocksource/tcb_clksrc.c |  15 ++----
 drivers/misc/atmel_tclib.c       | 101 +++++++++++++++--------------------
 drivers/pwm/pwm-atmel-tcb.c      |   2 +-
 include/linux/atmel_tc.h         |  13 +++--
 4 files changed, 60 insertions(+), 71 deletions(-)

-- 
Nicolas Ferre
