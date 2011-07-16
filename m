From: dv@vollmann.ch (Detlef Vollmann)
Date: Sat, 16 Jul 2011 16:00:58 +0200
Subject: [PATCH 4/7] at91: remove non used at91_spi.h
In-Reply-To: <20110716115655.GA1992@pengutronix.de>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
	<1310687525-22486-4-git-send-email-plagnioj@jcrosoft.com>
	<4E2028E1.1060603@vollmann.ch>
	<20110715154636.GA20678@game.jcrosoft.org>
	<4E206E7D.2070708@vollmann.ch>
	<20110716105752.GD20678@game.jcrosoft.org>
	<20110716115655.GA1992@pengutronix.de>
Message-ID: <4E21999A.6060105@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/11 13:56, Wolfram Sang wrote:
>
>>> About the SPI driver:
>>>  From Documentation/spi/spi-summary:
>>> "At this writing, Linux has no slave side programming interface."
>>> So there's no SPI framwork that covers the slave side.
>> This what I mean use the SPI framework and add the SPI Slave support there
>
> [CCing spi-devel]
>
> If you talk about SPI slaves, be sure to have read Grant's comments in
>
> http://thread.gmane.org/gmane.linux.kernel.spi.devel/7401
>
> to see what would be needed for slave support.
I completely agree with Gran't comments here.

> Short note: Would be
> seperate subsystem, master subsystem is of limited use. I think a few
> slave-drivers would be nice to evaluate, so one can get a feeling if a
> subsystem makes sense and if so, how it could look like.
>
> Detlef, have you posted your slave driver so far?
No, and I didn't plan to do so.
Not because I don't want to publish it, if you want to look at it,
I'm happy to send the driver.
But I don't think it makes much sense to put my driver into mainline
Linux.
The reason for this is very simple: the protocol is specific for this
hardware, and the driver needs this specific protocol.
The Atmel hardware is not able to maintain information about frame
ends when running in DMA mode, so we need to put the length of the
frame to the beginning of the frame, and also need to put in some
extra information to be able to re-sync in case of transmission errors.

So this driver is very specific for this hardware, and I wrote SPI
slave drivers in the past for other hardware that were also very
specific.  I really doubt that an SPI slave framework really makes
sense.

And that's the reason why I'm keen that the hardware description
headers are available to out-of-tree drivers.

   Detlef
