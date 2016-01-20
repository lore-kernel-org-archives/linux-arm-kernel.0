From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Jan 2016 16:42:58 +0000
Subject: [PATCH 1/2] regulator: ltc3589: make IRQ optional
In-Reply-To: <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160120164258.GF6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 01:29:51PM +0100, Lothar Wa?mann wrote:

> This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-Ro
> electronics TX48 module. Make the IRQ optional in the driver and use a
> polling routine instead if no IRQ is specified in DT.
> Otherwise the driver will continuously generate interrupts and make
> the system unusable.

How will the driver generate interrupts if there is no interrupt
physically present in the system?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160120/a0fbe171/attachment-0001.sig>
