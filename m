From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 20 Apr 2016 23:20:52 +0300
Subject: Looking for information on modern(ish) use of spidev
In-Reply-To: <CAF_dkJDRaidOF5p1B+ssx=SKgUHonMj5TbG2mT3wE5bOdDw69g@mail.gmail.com>
References: <CAF_dkJDRaidOF5p1B+ssx=SKgUHonMj5TbG2mT3wE5bOdDw69g@mail.gmail.com>
Message-ID: <20160420202052.GM2476@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrick,

On Wed, Apr 20, 2016 at 03:55:42PM -0400, Patrick Doyle wrote:
> Can anybody point me at a relatively recent tutorial/explanation of
> the current usage of spidev?

There is a dedicated list to the SPI subsystem (linux-spi at vger.kernel.org). 
See MAINTAINERS.

> What should I put in my device tree?  Should I modprobe spidev?

The spidev binding is not documented, but you can find a few examples under 
arch/arm/boot/dts/.

> I have 2 devices hanging off a SPI bus and I would like to verify that
> they work.  All I need to be able to do is to transfer some data to
> and from the devices and see that it looks reasonable.  I'll figure
> out the correct device driver later, but I just want to see some
> transactions on the bus today.
> 
> What's the simplest way to do that?  If spidev isn't the right tree to
> climb, where should I look instead?

For half duplex transfers just read/write the spidev device node. For 
something more complex see the examples under tools/spi/.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
