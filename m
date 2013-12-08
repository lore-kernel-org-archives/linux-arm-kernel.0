From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 7 Dec 2013 19:56:52 -0500
Subject: [PATCH] ARM: Kirkwood: DT board setup for LaPlug
In-Reply-To: <20131124171319.GK29241@titan.lakedaemon.net>
References: <1384639708-6868-1-git-send-email-maxime.hadjinlian@gmail.com>
 <5288C2B5.7040903@gmail.com>
 <20131124171319.GK29241@titan.lakedaemon.net>
Message-ID: <20131208005652.GF11251@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 24, 2013 at 12:13:19PM -0500, Jason Cooper wrote:
> On Sun, Nov 17, 2013 at 02:20:53PM +0100, Sebastian Hesselbarth wrote:
> > On 11/16/2013 11:08 PM, Maxime Hadjinlian wrote:
> > >This patch adds DT board setup for the LaCie NAS LaPlug.
> > 
> > [adding MVEBU maintainers, please do that always from now on]
> > 
> > Maxime,
> > 
> > first of all, thanks for providing this. Anyway, I do have some
> > remarks below.
> > 
> > >Chipset list:
> > >- CPU MARVELL 88FR131 800Mhz
> > >- SDRAM memory: 128MB DDR2-800 400Mhz
> > >- 1 Ethernet Gigabit port (PHY MARVELL 88E1318)
> > >- 1 Mini PCI-Express port
> > >- 1 NAND 512 MB
> > >- 1 push button
> > >- 2 LEDs (red and blue)
> > >- 4 USB Ports
> > >
> > >Signed-off-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
> > >---
> > >  arch/arm/boot/dts/Makefile            |   1 +
> > >  arch/arm/boot/dts/kirkwood-nsplug.dts | 178 ++++++++++++++++++++++++++++++++++
> > >  2 files changed, 179 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/kirkwood-nsplug.dts
> ...
> > >+&mdio {
> > >+  status = "okay";
> > >+
> > >+  ethphy0: ethernet-phy at 0 {
> > >+    device_type = "ethernet-phy";
> > 
> > If you know the type of PHY used here, please add
> > a compatible like "marvell,88e1318s"
> 
> Please be aware of the current conversation [1] started by Jason
> Gunthorpe regarding the compatible string choice here.  Once that's
> resolved, please resend.

Looks like we chose to dodge the issue.  Mind resending with the
a comment identifying the phy?

thx,

Jason.

> [1] http://www.spinics.net/lists/arm-kernel/msg288496.html
