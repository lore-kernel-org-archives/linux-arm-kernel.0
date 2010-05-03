From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 3 May 2010 15:18:09 +0200
Subject: [spi-devel-general] [PATCH v6 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
In-Reply-To: <20100503042123.GM26418@gw.healthdatacare.com>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<0dce0e9fdb6af35854d26d7bd0d8af5a5ea8f76a.1272805161.git.mika.westerberg@iki.fi>
	<h2r63386a3d1005021718k31125e4fz43a08025997b5c5c@mail.gmail.com>
	<20100503042123.GM26418@gw.healthdatacare.com>
Message-ID: <o2l63386a3d1005030618q1914e04x471ce544c6be82dc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/3 Mika Westerberg <mika.westerberg@iki.fi>:

> Yeah. It looks pretty similar. Although there seems to be differences. Documentation
> of the controller can be found in:
>
> ? ? ? ?http://www.cirrus.com/en/pubs/manual/EP93xx_Users_Guide_UM1.pdf
>
> It does not mention anything about AMBA PL022.

They have surely based the hardware on the PL022. A diff document would
surely be useful, can Cirrus answer that kind of questions for you?

Hm, it has to be *really* different to warrant a totally new driver
duplicate code is never fun...

>> Can you make a hexdump of the PrimeCell ID registers at offset
>> base+0xffe0..0xffff and post the contents?
>
> Here it is, you probably meant base + 0xfe0 .. 0xfff, right?
>
> [ ? ?2.410000] 0xc6070fe0: 0x0
> [ ? ?2.410000] 0xc6070fe4: 0x0
> [ ? ?2.410000] 0xc6070fe8: 0x0
> [ ? ?2.420000] 0xc6070fec: 0x0
> [ ? ?2.420000] 0xc6070ff0: 0x0
> [ ? ?2.420000] 0xc6070ff4: 0x0
> [ ? ?2.430000] 0xc6070ff8: 0x0
> [ ? ?2.430000] 0xc6070ffc: 0x0

Looks like it's been blanked out so atleast it is not identifying itself as
a PL022 anymore.

It could also be that PL022 and the Cirrus controller has some common
ancestor...

Yours,
Linus Walleij
