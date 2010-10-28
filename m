From: nils.faerber@kernelconcepts.de (Nils Faerber)
Date: Thu, 28 Oct 2010 20:34:45 +0200
Subject: New Kirkwood board support
Message-ID: <4CC9C245.3030906@kernelconcepts.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!
Attached is a patch against 2.6.36 for a new Marvell Kirkwood based
board - the TK71. For more information about the TK71 please look at the
WarpComm project page at
	http://www.warpcomm.org/

The patch is pretty much self contained and does not touch much else -
though it does add a defconfig which might not be necessary (Nicolas
pointed that out already) - in case this is not wanted I can drop that
from the patch (or you can simply not commit that part).

When looking at the patch please keep in mind that the TK71 is a SOM -
system on module. This is e.g the reason why I have commted out the
kirkwood_spi_init() - it is only necessary on baseboards that need SPI
for something. Maybe at some time I will add KConfig options for
different baseboard. For the time being I would like to keep such things
in there so that baseboard makers faster get a clue how to en- or
disable certain support.

If you have comments about the patch you are welcome!

I would very much like to see this finally go upstream.

Thank you!

Cheers
  nils

-- 
kernel concepts GbR      Tel: +49-271-771091-12
Sieghuetter Hauptweg 48  Fax: +49-271-771091-19
D-57072 Siegen           Mob: +49-176-21024535
http://www.kernelconcepts.de
