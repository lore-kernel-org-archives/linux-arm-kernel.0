From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Nov 2016 11:04:36 +0100
Subject: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD Host
 Controller
In-Reply-To: <20161124104858.3604c11d@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <8737ihmctr.fsf@free-electrons.com>
 <20161124104858.3604c11d@free-electrons.com>
Message-ID: <8756050.yoKoJPCyHz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 24, 2016 10:48:58 AM CET Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 24 Nov 2016 10:44:48 +0100, Gregory CLEMENT wrote:
> 
> > "A single Xenon IP can support multiple slots.
> > Each slot acts as an independent SDHC. It owns independent resources, such
> > as register sets clock and PHY.
> > Each slot should have an independent device tree node."
> 
> I think this wording is still very confusing, and continues to cause
> confusion.
> 
> We should just state that each Xenon controller supports a single slot,
> and that's it.
> 
> The text still says "a single Xenon IP can support multiple slots",
> which continues to cause confusion.

Agreed. Ideally we'd find out why exactly the slot number must
be used for accessing some of the registers to have a better
explanation to put in there, aside from stating that only one
slot is supported but the number must be set.

Could it be that this is some form of pinmuxing, i.e. that each
controller could in theory be used for any of the slots but you
have to pick one of them?

	Arnd
