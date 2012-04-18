From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 18 Apr 2012 10:04:40 -0400
Subject: [PATCH V5 0/4] ARM: Kirkwood: Add support for DNS-320 and
 DNS-325 using devicetree
In-Reply-To: <20120418132445.GB25584@lunn.ch>
References: <1334743603-8488-1-git-send-email-jm@lentin.co.uk>
 <20120418131635.GK15711@titan.lakedaemon.net>
 <20120418132445.GB25584@lunn.ch>
Message-ID: <20120418140440.GL15711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 03:24:45PM +0200, Andrew Lunn wrote:
> > > dies at "Gating clock of unused units", presumably as CGC_RUNIT isn't set.
> > > Is this something known or is it worth further investigation?
> > 
> > That could potentially mess up a future bisect.  However, it would only
> > crop up for dnskw boards.  I'll let Grant weigh in on this since he's
> > the one who asked that the nand init be removed.
> 
> Turning off RUNIT is bad. Both the NAND and SPI controllers use this
> clock. You can only safely turn it off if none of these are active.

Jamie,

If we hear no objections, call kirkwood_nand_init() with no partition
entries, then put the partition entries in the commandline in the dts.
This is what Arnaud Patard is doing with the Iomega iConnect:

mtdparts=orion_nand:0xc0000 at 0x0(uboot),0x20000 at 0xa0000(env),0x300000 at 0x100000(zImage),0x300000 at 0x540000(initrd)...

Then, in the last patch remove the mtdparts from the commandline in the
dts and add the partition entries appropriately.

thx,

Jason.
