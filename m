From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 11:22:54 +0000
Subject: [PATCH 0/8] sa11x0 PCMCIA updates
Message-ID: <20150326112254.GZ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a collection of patches which cleans up and updates the SA11x0
and PXA2xx socket drivers, particularly converting them to the devm_*
APIs to ensure that resources are properly cleaned up.

I've stopped short of totally converting sa1111_generic as there are
some corner cases where we want to initialise only socket 1, but not
socket 0, which would require further testing to ensure that these
changes are correct.

I will be testing the sa11x0 changes later today, but as I gave most
of my PXA2xx platforms to Robert, I need Robert to test this on the
Lubbock.

 drivers/pcmcia/pxa2xx_base.c    | 17 +++++------------
 drivers/pcmcia/sa1100_generic.c |  2 --
 drivers/pcmcia/sa1111_generic.c | 14 +++++++-------
 drivers/pcmcia/sa11xx_base.c    | 17 ++---------------
 drivers/pcmcia/soc_common.h     |  1 -
 5 files changed, 14 insertions(+), 37 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
