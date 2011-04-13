From: nbowler@elliptictech.com (Nick Bowler)
Date: Wed, 13 Apr 2011 16:49:24 -0400
Subject: [RFC][PATCH] axi: add AXI bus driver
In-Reply-To: <BANLkTik6JZ-n3sVjCFK_x1yNRH3_o3_6rg@mail.gmail.com>
References: <BANLkTi=0sM2+nPYyd09G=Uy9rcEvaFErnA@mail.gmail.com>
	<1302635550.14216.21.camel@dev.znau.edu.ua>
	<BANLkTi=8mB9ZDTjF4yds6mkx+PmM+B_6Cg@mail.gmail.com>
	<4DA4AC4B.90409@hauke-m.de>
	<BANLkTiknRYWaDM1ThAxgXcdGqK8jeFaBPA@mail.gmail.com>
	<BANLkTikqKtJuDS17mfFvxzMoXuBtJvCgTA@mail.gmail.com>
	<1302640546.14216.65.camel@dev.znau.edu.ua>
	<BANLkTim8dmTL-BVK3fcWHNBU9Eyz1k_T+Q@mail.gmail.com>
	<op.vtvalzu33ri7v4@arend-laptop>
	<BANLkTik6JZ-n3sVjCFK_x1yNRH3_o3_6rg@mail.gmail.com>
Message-ID: <20110413204924.GA1063@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2011-04-13 21:50 +0200, Rafa? Mi?ecki wrote:
> Note for not involved: AMBA is family with few buses/interfaces
> possible: AXI, AHB, ASB, APB, ATB [1].
> 
> So what are you saying is that drivers/amba/ is for AMBA APB? OK, I
> can accept such a explanation and it makes me even more sure we need
> another AMBA driver (this time: AMBA AXI).

I believe the drivers/amba code is mainly (only?) for ARM PrimeCell
cores which all include identification information at the end of their
memory maps.  There are PrimeCell cores available for most if not all
AMBA bus interfaces.

Non-primecell cores might not have such identification, and therefore
would not be usable with drivers/amba.  They are generally used with
the platform bus.

> The left question is: how much of the implemented code is AMBA AXI
> specific and how much is Broadcom specific?
> 1) Does AMBA AXI identify cores by manuf, id, rev and class? Is this
> really AMBA AXI specific and a evolution from simple "id" in AMBA APB?
> 2) Is this standard for AMBA AXI to keep list of available cores in
> some specific memory (is this always EPROM like in case of Bcm?)?

I don't believe AXI (the physical bus) nor any other AMBA bus interface
provides any mechanism whatsoever for device identification or
enumeration.

-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
