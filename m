From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jul 2015 19:03:42 +0100
Subject: [PATCH 0/8] sa11x0 PCMCIA updates
Message-ID: <20150715180342.GB7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A series of PCMCIA updates for SA11x0/PXA devices consisting mainly
of patches switching the code to use the devm_* APIs, thus cleaning the
code up.

The first patch fixes an omitted clk_put() in sa11xx_base.c by switching
the clk_get to devm_clk_get().

 drivers/pcmcia/pxa2xx_base.c    | 17 +++++------------
 drivers/pcmcia/sa1100_generic.c |  2 --
 drivers/pcmcia/sa1111_generic.c | 14 +++++++-------
 drivers/pcmcia/sa11xx_base.c    | 17 ++---------------
 drivers/pcmcia/soc_common.h     |  1 -
 5 files changed, 14 insertions(+), 37 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
