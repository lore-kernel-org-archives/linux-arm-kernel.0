From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jan 2014 15:47:54 +0100
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
Message-ID: <201401171547.55384.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 January 2014, Nicolas Pitre wrote:
> On Thu, 16 Jan 2014, Olof Johansson wrote:
> 
> > "for SDIO slots" is somewhat misleading; nearly all controllers only
> > do one slot/device per controller. The designware controller can do
> > multiple slots, and that adds a bit of driver and binding complexity
> > for something that seemingly not a single vendor has actually
> > implemented.
> 
> The Marvell 8688, just to name one, does both WIFI and BlueTooth over 
> the same SDIO controller using separate functions/slots.
> 
> Or maybe I'm misunderstanding you?
> 

I wasn't aware of this but I just checked (in mmc_attach_sdio) that
there can be multiple functions on a slot. I assume the sd8688 has
a single slot with two functions, so that potentially extends the
problem space if we need to supply clocks and regulators per
function rather than just per slot.

	Arnd
