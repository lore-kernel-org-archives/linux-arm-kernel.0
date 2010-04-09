From: martinwguy@gmail.com (Martin Guy)
Date: Fri, 9 Apr 2010 19:08:16 +0100
Subject: [PATCH v2 1/3] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <l2j56d259a01004091056i91598adub4201b47c4a86a90@mail.gmail.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>
	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>
	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>
	<20100325184316.GB20512@gw.healthdatacare.com>
	<s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
	<20100406054418.GA27465@gw.healthdatacare.com>
	<s2g56d259a01004060550me72bd64cr35e4a83c495d6909@mail.gmail.com>
	<20100406181839.GA2685@gw.healthdatacare.com>
	<x2r56d259a01004061428raffb32e9o1d42570c79c0ee56@mail.gmail.com>
	<l2j56d259a01004091056i91598adub4201b47c4a86a90@mail.gmail.com>
Message-ID: <t2o56d259a01004091108y7b17c2dw2cded23120d670de@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, I mean

-	unsigned n;	/* Number of bytes to send to the TX FIFO */
+	unsigned n;	/* Number of words to send to the TX FIFO */

and

-	n = t->len - espi->tx;	/* Total number of bytes waiting to be
-				 * sent to the TX FIFO for this transfer */
+	/* Number of words still to be sent to the TX FIFO */
+	n = (t->len - espi->tx) / (bits_per_word(espi) > 8 ? 2 : 1);

sorry about that.

    M
