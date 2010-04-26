From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 26 Apr 2010 13:09:30 +0300
Subject: [spi-devel-general] [PATCH v4 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
In-Reply-To: <0D753D10438DA54287A00B0270842697636D9B7E66@AUSP01VMBX24.collaborationhost.net>
References: <20100421104651.GO19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D8C8672@AUSP01VMBX24.collaborationhost.net>
	<20100422175503.GE26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9410F0@AUSP01VMBX24.collaborationhost.net>
	<20100423052003.GF26418@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D9419BC@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B0270842697636D9B794A@AUSP01VMBX24.collaborationhost.net>
	<y2x56d259a01004250229he9cb2ee3pf69669c9226f80fb@mail.gmail.com>
	<m2l56d259a01004250238s99d6c869s1ee084b36f9736a0@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D9B7E66@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100426100930.GH26418@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 25, 2010 at 03:25:16PM -0500, H Hartley Sweeten wrote:
> With a slow enough clock you can probably get to a point where SFRMOUT
> will stay deasserted during the entire 512 byte transfer.  But it would
> still de-assert during the switch to the next transfer in the message.
> 
> Regardless, I tend to agree with you.  Because of the chip design, it's
> impossible (or at least you can't guarantee) to keep the SFRMOUT low
> during a transfer.  Some devices can live with this others can't.  Oh well.

One more thing I forgot to mention. With DMA there are 2 buffers per channel which
means that the controller can continue right to the next transfer so SFRMOUT might
work better.

Regards,
MW
