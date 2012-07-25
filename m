From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Jul 2012 23:17:40 +0200
Subject: Orion Pull request
In-Reply-To: <201207251420.48634.arnd@arndb.de>
References: <20120724081732.GR18778@lunn.ch> <201207251420.48634.arnd@arndb.de>
Message-ID: <20120725211740.GD13619@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Please split the other patches into branches according to what
> they do, and make sure that each branch is based on an -rc release
> rather than a random point in the git history or patches that
> are not upstream. We can then decide which ones to still send
> for v3.6 and which branches to delay for v3.7.

Hi Arnd

If i make the branches based on the -rc7 release, how do i test them?
The patches have dependencies on the I2C patch now accepted by the I2C
maintainer and the SPI patches accepted by the SPI maintainer.  These
patches implement the DT support in the drivers. Without those
patches, all i2c devices are missing, and worst still, the root FS is
missing on my Kirkwood QNAP device i test with.

Note there is no compile time dependencies, just run time. So i could
initially build a patchset with those driver patches included, test
the combination works, rebase to discard the driver patches, and then
send a pull-request?

Or is there a better way to handle this?

I'm also not sure what topic branches would be appropriate. All that
is left is DT. One branch could be driver changes and the other
actually using the driver from DT. But there is a clear dependency
between the two. I cannot split the three new boards support via DT
into three topic branches because they cause merge conflicts when you
try to bring them together. What would you suggest?

   Thanks
	Andrew
