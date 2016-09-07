From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 7 Sep 2016 04:03:16 +0200
Subject: [PATCH 3/4] ARM: orion5x: avoid NO_IRQ in orion_ge00_switch_init
In-Reply-To: <20160906140623.2853066-3-arnd@arndb.de>
References: <20160906140623.2853066-1-arnd@arndb.de>
 <20160906140623.2853066-3-arnd@arndb.de>
Message-ID: <20160907020316.GC10007@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 04:06:22PM +0200, Arnd Bergmann wrote:
> As of commit 5be9fc23cdb4 ("ARM: orion5x: fix legacy orion5x IRQ numbers"),
> IRQ zero is no longer a valid interrupt on Orion5x, so we can use the
> normal convention of using '0' to indicate an invalid interrupt, rather
> than the deprecated NO_IRQ constant
> 
> My first approach was to pass a pointer to the resource into
> orion_ge00_switch_init(), but it seemed to just add complexity
> for no good.

Hi Arnd

You can simply this. DSA has never as far as i remember used an
interrupt passed via platform data. Two boards do seem to pass an
interrupt via a GPIO line, but it has never been used.

So if you want, you could strip all this interrupt code out.

There might be some patches coming soon which does add interrupt
support to DSA, but it will only be via device tree, since i don't
have a platform which is capable of using platform data for DSA.

   Andrew
