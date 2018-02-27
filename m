From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Feb 2018 16:01:35 +0000
Subject: [PATCH 0/2] SolidRun Clearfog SFP support
Message-ID: <20180227160135.GU9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that mvneta supports SFP, we can add the necessary DT changes to
Clearfog to support the SFP cages.  This series consists of two patches:

1. Increase the I2C bus speed with the GPIO expander to 400kHz, as
   there are bus timing issues that this works around - and as we
   poll the expander, we need the bus to be reliable.

2. Add the SFP entry to the clearfog DTS.  This includes the
   maximum power level specification, which is not yet reviewed or
   merged but has been sent via netdev for net-next.  I'll follow up
   when the binding has been acked by Rob.

 arch/arm/boot/dts/armada-388-clearfog.dtsi | 52 ++++++++----------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
