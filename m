From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Jun 2014 16:36:04 +0200
Subject: [PATCH v5 2/2] i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface)
 controller support
In-Reply-To: <6454089.IP8IFVsofj@wuerfel>
References: <1402408036-5235-1-git-send-email-boris.brezillon@free-electrons.com>
 <1402408036-5235-3-git-send-email-boris.brezillon@free-electrons.com>
 <6454089.IP8IFVsofj@wuerfel>
Message-ID: <20140610143604.GC7054@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Jun 10, 2014 at 03:54:56PM +0200, Arnd Bergmann wrote:
> On Tuesday 10 June 2014 15:47:16 Boris BREZILLON wrote:
> > 
> > +config I2C_SUN6I_P2WI
> > +       tristate "Allwinner sun6i internal P2WI controller"
> > +       depends on ARCH_SUNXI
> > +       help
> > +         If you say yes to this option, support will be included for the
> > +         P2WI (Push/Pull 2 Wire Interface) controller embedded in some sunxi
> > +         SOCs.
> > +         The P2WI looks like an SMBus controller (which supports only byte
> > +         accesses), except that it only supports one slave device.
> > +         This interface is used to connect to specific PMIC devices (like the
> > +         AXP221).
> > +
> 
> Sorry for the stupid question, but why is this an i2c driver if the
> hardware protocol is completely different?

It's not completely different. It deviates, but still looks very
similar to i2c, and to be precise, SMBus.

You'll have the full discussion that led to do this in i2c here:
http://www.spinics.net/lists/linux-i2c/msg15066.html

Also, one significant thing to take into account is that the
communication with a device starts as I2C, only to switch to this
protocol after some initialization sequence.

> I understand that a lot of devices can be driven using either spi or
> i2c, and we have two sets of {directories,maintainers,bus_types,...}
> for them. Your description sounds like this is a separate option
> that isn't any closer to i2c than it is to spi.

That's not true. It's *much* closer from I2C than it is from SPI.

> Would it perhaps be better to expose it only as a regmap rather than
> an i2c host?

That could be a solution, but is it a common practice to define a bus
adapter driver in a regmap driver?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140610/45786f14/attachment.sig>
