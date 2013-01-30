From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 30 Jan 2013 13:10:35 -0500
Subject: [PATCH] arm: mvebu: support for the new Armada XP evaluation
 board(DB-MV784MP-GP)
In-Reply-To: <510959D5.1010305@free-electrons.com>
References: <1359566774-27669-1-git-send-email-gregory.clement@free-electrons.com>
 <1359566774-27669-2-git-send-email-gregory.clement@free-electrons.com>
 <20130130173306.GO7717@titan.lakedaemon.net>
 <510959D5.1010305@free-electrons.com>
Message-ID: <20130130181035.GP7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Gregory,

Adding devicetree-discuss.

Guys, how do you prefer to handle plug-in RAM modules?  describe the
soldered-in amount, or?

On Wed, Jan 30, 2013 at 06:35:17PM +0100, Gregory CLEMENT wrote:
> On 01/30/2013 06:33 PM, Jason Cooper wrote:
> > On Wed, Jan 30, 2013 at 06:26:14PM +0100, Gregory CLEMENT wrote:
> >> This is the new Armada XP evaluation board from Marvell. It comes with
> >> a RS232 port over USB, a SATA link, an internal SSD, 4 Ethernet
> >> Gigabit links.
> >>
> >> Support for USB (Host and device), SDIO, PCIe will be added as drivers
> >> when they become available for Armada XP in mainline.
> >>
> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> >> ---
> >>  arch/arm/boot/dts/Makefile         |    1 +
> >>  arch/arm/boot/dts/armada-xp-gp.dts |   94 ++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 95 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts
> >>
...
> >> +	memory {
> >> +		device_type = "memory";
> >> +		reg = <0x00000000 0xC0000000>; /* 3 GB */
> > 
> > Is this the soldered on the board amount, or the amount with an
> > expandable slot filled?
> 
> It is not soldered, so you can change the amount of memory

Well, there's something we don't encounter too much in the embedded
world.  ;-)  I'm inclined to think the entry here should be the soldered
on amount, and the bootloader would (hypothetically) change the DT to
the probed amount.  But I haven't seen a precedent set yet...

thx,

Jason.
