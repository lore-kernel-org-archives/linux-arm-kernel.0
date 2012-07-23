From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Jul 2012 12:11:22 +0100
Subject: [PATCH 2/16] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <20120723104911.GF18778@lunn.ch>
References: <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
 <20120722095328.GB5423@lunn.ch>
 <20120722190700.GD4557@opensource.wolfsonmicro.com>
 <20120722193243.GF5423@lunn.ch>
 <20120722224241.GH4557@opensource.wolfsonmicro.com>
 <20120723072749.GA18778@lunn.ch>
 <20120723093747.GD4435@opensource.wolfsonmicro.com>
 <20120723101641.GD18778@lunn.ch>
 <20120723102336.GH4435@opensource.wolfsonmicro.com>
 <20120723104911.GF18778@lunn.ch>
Message-ID: <20120723111122.GM4435@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 12:49:11PM +0200, Andrew Lunn wrote:

> There is no logic in the board code to first try DT, and if that
> fails, use old fashioned platform_device instantiating of the drivers.

Well, I'd really expect this to be done the other way around.

> I've also had bad experiences when we have the old platform_device
> instantiating plus DT also instantiating the same device.

Hopefully we can arrange for them to collide with each other...

> The only way i've found to convert an existing board from
> platform_device to DT is to first add DT support to the driver, and
> then atomically swap platform_device structures for DT descriptions.

I guess if it's not working then we need to do that, but it's really sad
that the DT deployment is this painful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120723/0dd23d02/attachment.sig>
