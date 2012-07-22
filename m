From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 22 Jul 2012 11:53:28 +0200
Subject: [PATCH 2/16] SPI: Refactor spi-orion to use SPI framework queue.
In-Reply-To: <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
References: <1342805751-18048-1-git-send-email-andrew@lunn.ch>
 <1342805751-18048-3-git-send-email-andrew@lunn.ch>
 <CACRpkdYBJmh3+EVrPGb8L2TTWkJkeejfDZX1G0T1KoYY-YuBLg@mail.gmail.com>
Message-ID: <20120722095328.GB5423@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2012 at 09:22:09AM +0200, Linus Walleij wrote:
> On Fri, Jul 20, 2012 at 7:35 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > Replace the deprecated master->transfer with transfer_one_message()
> > and allow the SPI subsystem handle all the queuing of messages.
> >
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
> 
> Send these with Mark Brown on the To: line right now, I think he's
> busy collecting SPI patches for the next merge window.

Hi Linus, Mark and now Arnd.

I was planning sending all these via arm-soc. 

This patch is part of a bigger collection of Orion changes. The rest
are contributions from others which have already been ack-by, etc, on
the lists.

Somewhere near the beginning of this series is:

4385fbf SPI: Refactor spi-orion to use SPI framework queue.
d9d8293 spi-orion: remove uneeded spi_info
ee13b49 spi-orion: add device tree binding
76f0b84 ARM: kirkwood: use devicetree for SPI on dreamplug
05f504f ARM: kirkwood: use devicetree for orion-spi

You can see the chain of dependencies here. So at minimum i would need
to send the first three via Mark. I then need to cross my fingers and
hope he really picks them up, because without them, we are going to
have a number of boards which fail to find their root file system on
an SPI flash.

Now, maybe i've done all this wrong, since i'm a newbie to collecting
patches together for submission upstream....

You can see the complete set of patches here:

git://github.com/lunn/linux.git v3.5-rc7-for-next-v5

There is one exception and that is the very first patch:

I2C: MV64XXX: Add Device Tree support 

which Wolfram Sang insists goes via him. I see this less critical. If
for some reason it does not make it in, all it means is temperature
sensors and RTCs are missing, but at least the boards still boot.

	Andrew
