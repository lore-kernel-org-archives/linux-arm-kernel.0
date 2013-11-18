From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Nov 2013 13:57:27 +0000
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131118134022.26EE7C409EC@trevor.secretlab.ca>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131118122644.GA26046@ulmo.nvidia.com>
 <20131118134022.26EE7C409EC@trevor.secretlab.ca>
Message-ID: <20131118135727.GD14306@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 01:40:22PM +0000, Grant Likely wrote:

> Some hardware does that. That's what OHCI, EHCI, UHCI, XHCI, SDHCI, and
> similar are all about. It always helps when well understood hardware
> follows a register interface. It doesn't work for everything, but I
> agree it would be good to have preferred hw interfaces for SPI & I2C.

You'd need something class based like USB, there's such massive
variation in what the hardware is trying to do and the tradeoffs.  A big
issue is that especially with I2C many of the devices are primarily
analogue devices implemnted in larger processes where the cost of adding
additional digital logic can have a noticeable effect on the area and
hence cost of the silicon.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/adb8ad80/attachment.sig>
