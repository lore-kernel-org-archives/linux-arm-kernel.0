From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 Jun 2012 16:10:47 +0200
Subject: [PATCH 7/9] I2C: MV64XXX: Add Device Tree support
In-Reply-To: <4FE9C14C.2030804@codethink.co.uk>
References: <1339324322-29388-8-git-send-email-andrew@lunn.ch>
 <4FE9C14C.2030804@codethink.co.uk>
Message-ID: <20120626141047.GA18804@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 03:03:56PM +0100, Ben Dooks wrote:
> On 10/06/12 11:31, Andrew Lunn wrote:
> >Extends the driver to get properties from device tree. Also extend the
> >kirkwood DT support to supply the needed properties.
> >
> >Signed-off-by: Andrew Lunn<andrew@lunn.ch>
> >---
> >  Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   35 +++++++++++++++++-
> >  arch/arm/boot/dts/kirkwood.dtsi                    |   13 +++++++
> >  arch/arm/mach-kirkwood/board-dt.c                  |    2 ++
> >  drivers/i2c/busses/i2c-mv64xxx.c                   |   38 +++++++++++++++++---
> >  4 files changed, 82 insertions(+), 6 deletions(-)
> >
> >diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> >index b891ee2..89ef899 100644
> >--- a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> >+++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> >@@ -1,4 +1,4 @@
> >-* I2C
> >+* Marvell MMP I2C controller
> >
> >  Required properties :
> >
> >@@ -32,3 +32,36 @@ Examples:
> >  		interrupts =<58>;
> >  	};
> >
> >+* Marvell MV64XXX I2C controller
> >+
> >+Required properties :
> >+
> >+ - reg         : Offset and length of the register set for the device
> >+ - compatible  : should be "marvell,mv64xxx-i2c"
> >+ - interrupts  : the interrupt number
> >+ - frequency-m : m factor in baud rate calculation
> >+
> >+Recommended properties :
> >+
> >+ - frequency-n : n factor in baud rate calculation
> >+ - timeout-ms  : How long to wait for a transaction to complete
> >+
> >+Baud Rate:
> >+
> >+The baud rate is calculated thus:
> >+
> >+Fscl =          Ftclk
> >+       ------------------------------------------
> >+                                (frequency-n + 1)
> >+       10 *(frequency-m + 1) * 2
> >+
> >+Examples:
> 
> I'd really rather see this calculated at run-time, given some
> systems can quite easily change their clocks.

Hi Ben

Well, none of the Orion systems would make use of this. They all have
fixed clocks. 

Maybe the new Armada XP systems could make use of clock scaling?  

I've no plans to implement this, but please feel free to send
patches...

     Andrew
