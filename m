From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 26 Jan 2010 12:06:02 +0000
Subject: [PATCH 2/4] mfd: update irq handler in max8925
In-Reply-To: <771cded01001260331u541cc931x361d0719cd8fe00@mail.gmail.com>
References: <771cded01001250308mfd2b3d2l76bc2a2df88e7b93@mail.gmail.com>
	<20100125115930.GE22909@sirena.org.uk>
	<771cded01001251912q67c9c2a5w3db61e9d7fe53cf9@mail.gmail.com>
	<20100126112800.GL15759@rakim.wolfsonmicro.main>
	<771cded01001260331u541cc931x361d0719cd8fe00@mail.gmail.com>
Message-ID: <20100126120602.GP15759@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 06:31:56AM -0500, Haojian Zhuang wrote:
> On Tue, Jan 26, 2010 at 6:28 AM, Mark Brown

> > and call handle_nested_irq() unconditionally, genirq should generate a
> > warning and mask the IRQ if it's not handled which is what your code
> > here is doing.

> Actually I can't find genirq reports any warning. I only find my code
> reports warning message.

There's a threashold before the warning starts displaying, IIRC.  In any
case, the handling of spurious IRQs isn't really an IRQ controller
driver issue - it's a generic issue that affects all interrupt
controllers.
