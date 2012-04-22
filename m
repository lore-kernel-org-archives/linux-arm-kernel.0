From: mattwood2000@gmail.com (Matt Wood)
Date: Sun, 22 Apr 2012 17:07:21 -0400
Subject: SPI subsystem delays
Message-ID: <CADjezmaB7yo6W1dW11JKtH7JNSsgXQvOQy5BMqtAUfe6sy2igA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi folks, this is my first post to the list, so I apologize if I
missed similar topics from the past.

I'm working on a driver for a SPI based peripheral but have run into
some issues with the timing requirements.  The device I'm working with
is very slow, and has some specific delay requirements - specifically
the delay between bytes in a single transfer, delay between chip
select assertion and the first clock edge, and the delay between
consecutive transfers.  The platform I'm developing on and most
comfortable with is the Atmel ARM9 series.

I notice in the spi_device subsystem structure there are no provisions
for the delays in the mainline instantiation although the comments
seem to suggest additions such as these are expected or at least
anticipated.

So I guess my question is am I the only one who has been working with
a device that require very specific timings?  I know most modern SPI
devices are application specific silicon and are designed to run as
fast as possible (i.e serial flash, etc.), but I know there are some
devices out there that require more strict timings.

I suppose what I'm getting at is a patch proposal to add attributes
such as DLYBCT (Delay Between Consecutive Transfers), DLYBS (Delay
Before Serial Clock), DLYBCS (Delay Between Chip Selects) - again as
I'm most comfortable with Atmel's ARM SPI peripheral, so I'm used to
these hardware features.

With the driver I'm working on I have had to patch the SPI subsystem
to get the device operate correctly, so the code is not a question,
but I wonder what other people's thoughts are on this, and if there
are reasons why not to add these attributes - they could simply be
zeroed out by default for hardware that does not need to or cannot
implement them.

Thanks for the read.

Regards, Matt.
