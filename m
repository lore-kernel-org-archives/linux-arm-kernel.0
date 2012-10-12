From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 12 Oct 2012 08:09:36 +0100
Subject: [RESEND] [PATCH 3.6.0- 0/6] ARM: use module_platform_driver macro
Message-ID: <1350025776-30037-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Running Coccinelle lookup pattern like below on the 
latest kernel showed about 52 hits. This patch series is a subset 
of those 52 patches, so that it will be easy for maintainers to review.

@  @
- initfunc(void)
- { return platform_driver_register(&dr); }

...

- module_init(initfunc);
...

- exitfunc(void)
- { platform_driver_unregister(&dr); }

...

- module_exit(exitfunc);
+ module_platform_driver(dr); 

Srinivas Kandagatla (6):
  ARM/omap1: use module_platform_driver macro
  ARM/omap2: use module_platform_driver macro
  ARM/pxa: use module_platform_driver macro
  ARM/pxa: use module_platform_driver macro
  ARM/omap: use module_platform_driver macro
  omap_rng: use module_platform_driver macro

 arch/arm/mach-omap1/mailbox.c     |   14 +-------------
 arch/arm/mach-omap2/mailbox.c     |   14 +-------------
 arch/arm/mach-pxa/pxa3xx-ulpi.c   |   13 +------------
 arch/arm/mach-pxa/tosa-bt.c       |   15 +--------------
 arch/arm/plat-omap/dmtimer.c      |   13 +------------
 drivers/char/hw_random/omap-rng.c |   14 +-------------
 6 files changed, 6 insertions(+), 77 deletions(-)
