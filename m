From: knut.wohlrab@de.bosch.com (Knut Wohlrab)
Date: Mon, 27 Aug 2012 15:18:41 +0200
Subject: [PATCH] SPI: IMX5/6: Set inactive state of SPI clock (SCLK CTL)
 according to SPI clock polarity
Message-ID: <503B73B1.9010801@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For our SPI device we need a SPI clock with active low polarity and a a 
high inactive state.

We add the setting of the inactive state ECSPIx_CONFIGREG:SCLK CTL 
according to the clock polarity ECSPIx_CONFIGREG:SCLK POL:

Device tree _without_ "spi-cpol" = 0 = clock active high polarity = 
inactive state low
Device tree with "spi-cpol" = 1 = clock active low polarity = inactive 
state high

Are there real world examples for a need of an individual setting of 
clock polarity/inactive state?


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-SPI-IMX-Set-inactive-state-of-SPI-clock-SCLK-CTL.patch
Type: text/x-patch
Size: 1373 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120827/51b4fafd/attachment.bin>
