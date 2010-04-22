From: martinwguy@gmail.com (Martin Guy)
Date: Thu, 22 Apr 2010 15:28:27 +0100
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D8C8CDD@AUSP01VMBX24.collaborationhost.net>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
	<20100421071629.GL19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C84DA@AUSP01VMBX24.collaborationhost.net>
	<20100421165420.GP19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8CDD@AUSP01VMBX24.collaborationhost.net>
Message-ID: <x2g56d259a01004220728i7f07d492t4c4f63e0ef2e38d9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/22/10, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>  First, every spi transaction, including a single byte transfer, is
>  going to generate at least two interrupts.  One when the interrupts
>  are first enabled because the TX FIFO is empty.  And a second when
>  that byte has been transferred and the TX FIFO is again empty.
>
>  The first interrupt can be prevented by priming the TX FIFO before
>  enabling the interrupts.  All you need to do is call ep93xx_spi_read_write
>  right before ep93xx_spi_enable_interrupts.

Nice. That increases the data throughput from 367 to 372 kB/sec and
reduces the CPU usage from 61 to 60.2% for large transfers

    M
