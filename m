From: david-b@pacbell.net (David Brownell)
Date: Mon, 19 Jul 2010 18:32:30 -0700 (PDT)
Subject: [spi-devel-general] [PATCH 2/2] SPI: make the moved loopback test
	work
In-Reply-To: <AANLkTinm_bvpcQogsTgVy5ZX1MFajVvDxBtVJ056sTyq@mail.gmail.com>
Message-ID: <812288.2599.qm@web180314.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> No matter how much I look at it, it seems like
> all use of this require you to first register
> *some* device, 

OBVIOUSLY.  You can't use SPI without a device;
it's like any other driver framework in Linux.
What else should you expect???

Look at the sample code though, ISTR you'll see
that when the SPI master works correctly, putting
it into loopback mode just means that the writes
and reads (should) get the same data -- full duplex.
No matter what the device is (given SPI_LOOP).

- Dave
