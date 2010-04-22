From: martinwguy@gmail.com (Martin Guy)
Date: Thu, 22 Apr 2010 21:19:32 +0100
Subject: [PATCH v4 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D940C95@AUSP01VMBX24.collaborationhost.net>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
	<20100421071629.GL19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C84DA@AUSP01VMBX24.collaborationhost.net>
	<20100421165420.GP19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8CDD@AUSP01VMBX24.collaborationhost.net>
	<x2g56d259a01004220728i7f07d492t4c4f63e0ef2e38d9@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D940C95@AUSP01VMBX24.collaborationhost.net>
Message-ID: <x2w56d259a01004221319y27d25d30sbe8b548c4d7932fd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/22/10, H Hartley Sweeten <hartleys@visionengravers.com> wrote:
>  > Further, on a suspicion about the silliness of the per-transfer
>  > bits_per_word being checked right down the bottom of the lowest lever
>  > byte-read/writing routine instead of once per transfer, I split
>  > ep93xx_spi_read and _write into 8 and 16-bit variants, and checked
>  > t->bits_per_word once outside the read and write loops.
>  >
>  > This gives:
>  >      60.0% 59.3%  285906 irq/MB
>
>
> It looks like splitting the 8/16-bit read/write routines does help
>  with cpu usage compared to the tests above.  Was the data transfer
>  (kB/sec) any better?

No, exactly the same.
