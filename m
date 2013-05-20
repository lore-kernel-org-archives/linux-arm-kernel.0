From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 20 May 2013 13:28:32 -0400
Subject: [RFC PATCH 4/5] ARM: mv78x00: Add the Device Tree support for
 MV78X00 family
In-Reply-To: <519A5C1D.9030307@gmail.com>
References: <1368999578-19938-1-git-send-email-gregory.clement@free-electrons.com>
 <1368999578-19938-5-git-send-email-gregory.clement@free-electrons.com>
 <20130520172151.GW31290@titan.lakedaemon.net>
 <519A5C1D.9030307@gmail.com>
Message-ID: <20130520172832.GX31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 07:23:41PM +0200, Sebastian Hesselbarth wrote:
> On 05/20/2013 07:21 PM, Jason Cooper wrote:
> >On Sun, May 19, 2013 at 11:39:37PM +0200, Gregory CLEMENT wrote:
> >>This commit adds the Device Tree support for the mv78x00 SoC
> >>family. It adds an mv78x00.dtsi description of the mv78x00 SoC
> >>
> >>So far, the Device Tree contains the interrupt controller, the GPIO
> >>bank, the UART controllers, the USB host controllers, the SATA
> >>controllers and the I2C controllers.
> >>
> >>Signed-off-by: Gregory CLEMENT<gregory.clement@free-electrons.com>
> >>---
> ...
> >>+		serial at 12300 {
> >>+			compatible = "ns16550a";
> >>+			reg =<0x12300 0x100>;
> >>+			reg-shift =<2>;
> >>+			interrupts =<15>;
> >>+			/* set clock-frequency in board dts */
> >
> >We should probably add a note to these comments that this is only until
> >mv78x00 is converted to the clock infrastructure.
> 
> Or use a fixed-rate clock node, reference here, and set that in board
> dts?

Yes, I realized (of course _after_ hitting send), that the whole issue I
was recalling was wrt gated clocks.  iirc now, mv78xx0 doesn't have
gated clocks.

thx,

Jason.
