From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Dec 2015 17:04:30 +0000
Subject: [PATCH v2] ARM: dts: Add SolidRun Armada 388 Clearfog A1 DT file
In-Reply-To: <87egew98ty.fsf@free-electrons.com>
References: <E1a5hDy-0002rC-Oe@rmk-PC.arm.linux.org.uk>
 <87egew98ty.fsf@free-electrons.com>
Message-ID: <20151208170429.GE8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 05:57:45PM +0100, Gregory CLEMENT wrote:
> Hi Russell,
>  
>  On dim., d?c. 06 2015, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > Add support for the SolidRun Armada 388 Clearfog A1 board.  This board
> > has an Armada 388 microsom, dedicated gigabit ethernet, six switched
> > gigabit ethernet ports, SFP cage, two Mini-PCIe/mSATA slots, a m.2 SATA
> > slot, and a MikroBUS connector to allow MikroBUS modules to be added.
> >
> > This DT file adds support for all board facilities with the exception
> > of full SFP support.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> I made some tests it on the Clearfog v2.0 I have: Ethernet (CON8 and
> J11), i2c (using i2cdetect), USB stick on CON7.
> 
> For this one I tried to use an USB3 stick, but it was enumerated using
> the High Speed profile and not the Super Speed one. But I think it is
> because of the Serdes configuration done in U-Boot.

Hmm, I don't have any USB3 hardware to check or debug.  Unless there's a
bug in uboot, it looks like it's correctly configured to use the serdes
lane 3 at the highest speed:

 | Lane # | Speed|    Type     |
 ------------------------------|
 |   0    |  3   |  SATA0      |
 |   1    |  0   |  SGMII1     |
 |   2    |  5   |  PCIe1      |
 |   3    |  5   |  USB3 HOST1 |
 |   4    |  5   |  PCIe2      |
 |   5    |  0   |  SGMII2     |
 -------------------------------

> so Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> and applied on mvebu/dt.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
