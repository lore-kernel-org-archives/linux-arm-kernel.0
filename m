From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Wed, 5 Sep 2012 11:46:45 +0200
Subject: [PATCH 5/8] gpio: 74x164: Add output pin support
In-Reply-To: <20120905112012.13ce2c86@skate>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346834457-6257-5-git-send-email-maxime.ripard@free-electrons.com>
 <20120905112012.13ce2c86@skate>
Message-ID: <20120905114645.57bfe591@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Le Wed, 5 Sep 2012 11:20:12 +0200,
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> a ?crit :

> Le Wed,  5 Sep 2012 10:40:54 +0200,
> Maxime Ripard <maxime.ripard@free-electrons.com> a ?crit :
> 
> > The shift registers have an output that, when enabled, propagates the
> > values of its internal register to the pins. Make use of this pin
> > through the output-latch-gpio dt property.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Well, thinking more about this, and reviewing the i.MX 28 datasheet a
> bit more thoroughly, I don't think you need this GPIO thing. It is an
> active-low pin that should be kept low during the entire duration of
> the transfer, which basically is a chip select. And in turns out that
> the CFA10049 board uses pins that can be controlled as chip selects
> directly by the SPI controller, so you should rather use this rather
> than introduce a specially handled GPIO. This needs testing, but I
> don't see why it wouldn't work.
> 
are you talking of the /OE pin of the 74HC595 ?

Eric
