From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 10 Apr 2018 16:05:04 +0200
Subject: [PATCH v3 3/6] spi: sun6i: restrict transfer length in PIO-mode
In-Reply-To: <0e2fefa5-b6e7-5e42-cf6e-8fc921f972dd@orpaltech.com>
References: <20180405131735.GB12349@sirena.org.uk>
 <8159c3a5-af74-9f13-aedb-7ecc708bdff6@orpaltech.com>
 <20180406073441.xesojvzc3deljhoy@flea>
 <204e97cb-2f39-00f0-fd4e-3aa9a51f7cac@orpaltech.com>
 <20180409092730.2moyhl5aaktjwbyn@flea>
 <94a394bd-89bf-9334-c500-4cbadf4c1044@orpaltech.com>
 <20180409105001.GC11532@sirena.org.uk>
 <67c2006b-17f2-2459-e3c9-e91e3c694d8c@orpaltech.com>
 <20180409113603.2iexkqvyeqmysp5e@flea>
 <0e2fefa5-b6e7-5e42-cf6e-8fc921f972dd@orpaltech.com>
Message-ID: <20180410140504.i7kszskwxuoygt5s@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 02:59:57PM +0300, Sergey Suloev wrote:
> > > But as soon as sun4i SPI driver? is correctly declaring
> > > max_transfer_size then "smart" clients will work well by limiting a
> > > single transfer size to FIFO depth. I tested it with real hardware,
> > > again.
> > This is really not my point. What would prevent you from doing
> > multiple transfers in that case, and filling the FIFO entirely,
> > waiting for it to be done, then resuming until you have sent the right
> > number of bytes?
>
> Because it makes no sense IMHO. I can't see any single point in allowing
> long PIO transfers. Can you find at least one ?

I'm probably going to state the obvious here, but to allow long transfers?

> I think we should reuse as much SPI core code as possible. The SPI
> core can handle an SPI message with multiple transfers, all we need
> is to have max_transfer_size = FIFO depth and restrict it in
> transfer_one().

There's not a single call to the max_transfer_size hook in the SPI
core in 4.16, so that seems a bit too optimistic.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180410/ab69b7d9/attachment-0001.sig>
