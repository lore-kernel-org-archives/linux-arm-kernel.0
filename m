From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Wed, 5 Sep 2012 12:26:52 +0200
Subject: [PATCH 5/8] gpio: 74x164: Add output pin support
In-Reply-To: <20120905120906.12d08bf5@skate>
References: <1346834457-6257-1-git-send-email-maxime.ripard@free-electrons.com>
 <1346834457-6257-5-git-send-email-maxime.ripard@free-electrons.com>
 <20120905112012.13ce2c86@skate> <20120905114645.57bfe591@eb-e6520>
 <20120905120906.12d08bf5@skate>
Message-ID: <20120905122652.7c752e96@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le Wed, 5 Sep 2012 12:09:06 +0200,
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> a ?crit :
> I don't think the /OE pin can be used as a chip select, because when it
> is high, the state of the output pins is not maintained to their
> previous state: the pins are turned into the high impedance state. If
> used as a chip select, it would mean that the value of the output pins
> transition from their old state to high impedance at the beginning of
> the transfer, and then from the high impedance to their new state at
> the end of the transfer.

OK that's exactly what I was thinking to ;-)

> And of course, this signal is inverted compared to a normal chip select.

polarity of the chip select can vary (mc13xxx-spi has an active high CS
for example).

Eric
