From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  7 Oct 2014 01:07:56 +0200
Subject: [PATCH v1 0/5] Fixes for the pxa common clocks
Message-ID: <1412636881-6211-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Arnd, Haojian,

Here are all the fixes I had gathered so far on pxa clocks serie.

Amongst these :
 - only patch 1/5 is a really required fix
 - patches 2/5 and 3/5, after review, could go to the next merge window
 - patch 4/5 should be carefully reviewed by pxa and arm people, but not merged
   until pxa25x support is in place.
 - patch 5/5 should only be considered if ever Tomeu's changes get in.

I'm sending these to give us time to review ahead of time. And of course they
have only been tested on a single pxa27x platform, but once my environment is
ready, I'll pass a full build test on all PXA platform.

Cheers.

--
Robert

Robert Jarzmik (5):
  clk: pxa: fix pxa27x CCCR bit usage
  clk: pxa: declare init function and data __init
  clk: pxa: keep clocks initialization separated per variant
  arm: pxa: change clocks init sequence
  clk: pxa: migrate to the clk_core API

 arch/arm/mach-pxa/generic.c  |  2 ++
 arch/arm/mach-pxa/generic.h  |  1 +
 drivers/clk/pxa/clk-pxa.c    | 51 +++++++++++++++++++++++++++-----------------
 drivers/clk/pxa/clk-pxa.h    | 11 +++++-----
 drivers/clk/pxa/clk-pxa27x.c | 16 +++++++++-----
 5 files changed, 51 insertions(+), 30 deletions(-)

-- 
2.1.0
