From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 19 Mar 2012 13:02:22 +0000
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <20120317104751.4F00E3E0910@localhost>
References: <4F22DEF2.5000807@ti.com>
 <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <201203150922.06379.arnd@arndb.de>
 <20120315102736.GA25371@avionic-0098.adnet.avionic-design.de>
 <20120317104751.4F00E3E0910@localhost>
Message-ID: <20120319130222.GC5705@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2012 at 10:47:51AM +0000, Grant Likely wrote:

> After implementing both schemes (ie. interrupts+interrupt-names && [*-]gpios)
> I definitely prefer the fixed property name plus a separate names property.
> It is easier to use common code with that scheme, and easier to statically
> check for correctness.

It's not a fantastic experience when using the bindings as the arrays
grow large, though - keeping things matched up isn't much fun especially
if any of the elements in the array are optional.
