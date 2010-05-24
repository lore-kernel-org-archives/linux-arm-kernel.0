From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 May 2010 23:32:02 +0100
Subject: Should we pass amba device peripheral id with device structure
	or not?
In-Reply-To: <AANLkTinQqEIs3PDWJGFwYqsBZxANmrbH_xOtOchK5Nlh@mail.gmail.com>
References: <4BECF57A.4050802@st.com>
	<20100521193802.GG11042@n2100.arm.linux.org.uk>
	<4BFA02DC.6090906@st.com>
	<20100524213237.GH21117@n2100.arm.linux.org.uk>
	<AANLkTinQqEIs3PDWJGFwYqsBZxANmrbH_xOtOchK5Nlh@mail.gmail.com>
Message-ID: <20100524223202.GA21923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 25, 2010 at 12:17:02AM +0200, Linus Walleij wrote:
> [Russell]
> We'd have to add a proper bus clock to all PrimeCells to have this in
> some sane state I believe.

That's basically what I'm saying.  At the bus/driver level, we need to
deal with the bus clock dependency separately from the peripheral clock
if the bus clock can be shut off.

I had originally anticipated that all primecells on a bus would have
their bus clock fed from a common unmaskable source, and that shutting
off the bus clock to the primecell would be a very bad thing to happen
to the bus - but it seems that it's permitted after all.

This will be trivial to deal with for clkdev-based platforms...  The
non-clkdev are an entirely separate proposition - but I don't think we
have any primecell-using platforms which don't use clkdev.
