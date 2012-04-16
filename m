From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 16 Apr 2012 09:27:33 -0400
Subject: dreamplug kernel and uboot code and apparent dreamplug board
 design change
In-Reply-To: <384286E8-E5C8-4069-9702-8A24C70D799C@gmail.com>
References: <cover.1331601448.git.jason@lakedaemon.net>
 <0032addd7e94c5d4d1a3a0be77fe79bcffee53db.1331601448.git.jason@lakedaemon.net>
 <1333663656.12209.62.camel@dagon.hellion.org.uk>
 <20120405224143.GL817@titan.lakedaemon.net>
 <384286E8-E5C8-4069-9702-8A24C70D799C@gmail.com>
Message-ID: <20120416132733.GK14790@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 15, 2012 at 09:13:13PM -0700, rihoward1 at gmail.com wrote:
> First I would like to say thank you for all the work you have
> performed with DT support for kirkwood and the dreamplug board.

No problem, just scratching an itch.  ;-)

> It seems that recently Globalscale in their wisdom has changed the
> dreamplug board design.  See
> http://www.plugcomputer.org/plugforum/index.php?topic=6098.0

Hmm, once devicetree is in place, it should just be a matter of swapping
out the dtbs.  I wonder if the SPI NOR flash was EOL'd?  If so, this is
a good sign that Globalscale intends to continue producing Dreamplugs.
They wouldn't invest the engineering effort to make the change
otherwise.

> If this is true then some code fix up for the new version may be
> needed including a new machtype.

mach-type isn't necessary.  This is all handled by the devicetree, now.
The most specific model string in the device tree is
"globalscale,dreamplug-003-ds2001".  Is this the same on the new
version?  You can find it on the underside of the dreamplug, first line
"DreamPlug model: XXX".  If it's different, then we'll use that to tell
them apart.

If they unwisely left that the same, I'll gin up a patch to use the
'0901' and '1001' they refer to in the readme.  Based on the forum link,
it looks like the only change is the nand flash.  Are there any other
changes folks are aware of?

Looks like I'll have to take another look at Simon Glass' (I always mess
up the apostrophe in those grammar situations, sorry Simon) fdt support
in u-boot.  That might be the easiest way to solve this there.

thx,

Jason.
