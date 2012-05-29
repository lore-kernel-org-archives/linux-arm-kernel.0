From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 May 2012 10:30:15 +0100
Subject: [RFC 00/34] PL08x DMA conversion to virt-dma
Message-ID: <20120529093015.GF12217@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is merely a posting to show folk where I am with this; this is
still work in progress.

What this represents is a _significant_ rework of the PL08x driver.
It's guaranteed that any patches to this driver will conflict with
this work - moreover, patches which have already gone into this
merge window for this driver _already_ conflict with it.  This set
is based on v3.4.

 drivers/dma/Kconfig        |    5 +
 drivers/dma/Makefile       |    1 +
 drivers/dma/amba-pl08x.c   |  938 ++++++++++++++++++++++----------------------
 drivers/dma/sa11x0-dma.c   |  249 ++++--------
 drivers/dma/virt-dma.c     |  123 ++++++
 drivers/dma/virt-dma.h     |  152 +++++++
 include/linux/amba/pl08x.h |  153 +-------
 7 files changed, 837 insertions(+), 784 deletions(-)

Also note that the first few patches in this series are common to some
other branches (namely OMAP, and SA11x0 DMA engine branches so may appear
separately in other postings.)
