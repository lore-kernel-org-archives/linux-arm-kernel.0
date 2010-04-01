From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 01 Apr 2010 16:00:30 +1300
Subject: [PATCH v2 1/3] spi: implemented driver for Cirrus EP93xx SPI
	controller
In-Reply-To: <s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
References: <cover.1268930557.git.mika.westerberg@iki.fi>	<9de3769ae253830fb0eebc98d299137c59c69b8c.1268930557.git.mika.westerberg@iki.fi>	<56d259a01003250649ubf0e32ejc15e4f3b45ec43cd@mail.gmail.com>	<20100325184316.GB20512@gw.healthdatacare.com>
	<s2n56d259a01003311715ke5b93a96v9d453ec32f08ec29@mail.gmail.com>
Message-ID: <4BB40C4E.2010204@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Guy wrote:
> On 3/25/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
>>  > > This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
>>  > >  in EP93xx chips (EP9301, EP9302, EP9307, EP9312 and EP9315).
>>  > >
>>  > >  Driver currently supports only interrupt driven mode but in future we may add
>>  > >  polling mode support as well.
> 
> I've been staring more at this again and it looks (2 clock
> strangenesses and extensive control reg setting apart) like good code.
> I have another question: like the Cirrus driver, this takes 100% CPU
> doing busy wait for the current transfer to complete.
> Given that this driver is interrupt-based, is there any reason why it
> can't do something else in the meanwhile?
> Not that that's a reason not to include it in 2.6.35 - it works well
> and we can think whether to make it more efficient in N+1...

I can't see anything outstanding in the driver which would make it do
that. I haven't had time to test the driver out yet, but it would be
nice to fix this before it gets committed. Hopefully it shouldn't be too
hard to fix. Any idea where the bulk of the time is being spent?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
