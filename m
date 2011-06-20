From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 20:09:45 +0100
Subject: [PATCH 0/3] Improve MMC error handling (3rd rev)
Message-ID: <20110620190945.GK26089@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the third revision of my improvements to the MMC block
device error handling, which makes error handling more robust
and permits MMC/SD to continue working in the presence of
not-quite-perfect setups.

Without this, my Versatile Express tends to fail to mount its rootfs
on SD.  With this, it can successfully read and write data from the
card in the presence of FIFO overruns and underruns, and also sensibly
recover from command channel errors.

There is more to come, but this is the "safer" bits of the improvements.

 drivers/mmc/card/block.c |  279 ++++++++++++++++++++++++++++++++++-----------
 include/linux/mmc/mmc.h  |   10 ++
 2 files changed, 221 insertions(+), 68 deletions(-)
