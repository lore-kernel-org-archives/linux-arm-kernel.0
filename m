From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 10 Jan 2014 14:45:50 -0500
Subject: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the
 OpenBlocks AX3-4 board
In-Reply-To: <20140110190521.GI18269@obsidianresearch.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
 <20140110182240.GK19878@titan.lakedaemon.net>
 <20140110190521.GI18269@obsidianresearch.com>
Message-ID: <20140110194550.GT19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 12:05:21PM -0700, Jason Gunthorpe wrote:
> On Fri, Jan 10, 2014 at 01:22:40PM -0500, Jason Cooper wrote:
> 
> > Do we create new compatible strings to indicate errata, or to indicate
> > 'from this version forward there are new features'?  The former would
> > indicate as Gregory has written '...-a0-i2c', the latter would warrant
> > '...-b0-i2c' and disabling offloading if we don't see '...-b0-i2c'.

s/-b0-i2c'./-b0-i2c' or newer./

> IMHO the compatible string should represent a specific HW/SW ABI. So
> you need a unique compatible string for every variation of that ABI.

My concern is that we tend to do things like "marvell,orion-sata" for
the first version of the IP block we can work with.  orion5x, kirkwood,
dove, and armada 370/xp all use that compatible string to refer to that
IP block.

Given that we look at it as 'and newer', '...-a0-i2c' would mean no
offloading until we introduce '-b0-i2c'.  Or am I mis-understanding what
you're saying?

> We already have a compatible string defined for the ABI that B0
> presents.

So 'mv78230-i2c' is newer than 'mv78230-a0-i2c', or are you referring to
something else?

thx,

Jason.
