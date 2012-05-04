From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 4 May 2012 22:52:30 +0100
Subject: Handling of modular boards
In-Reply-To: <4FA4457F.1010900@wwwdotorg.org>
References: <20120504185850.GO14230@opensource.wolfsonmicro.com>
 <201205042039.25794.arnd@arndb.de>
 <20120504205441.D293120645E@gemini.denx.de>
 <201205042103.34285.arnd@arndb.de> <4FA4457F.1010900@wwwdotorg.org>
Message-ID: <20120504215230.GS14230@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 03:09:19PM -0600, Stephen Warren wrote:
> On 05/04/2012 03:03 PM, Arnd Bergmann wrote:

> > Sure, there are a lot of things that the boot loader can use from the
> > device tree, but I'm not sure if the LCD panel connection fits into
> > the same category as the devices that Mark was thinking of.

> A board I have sitting on my desk right now has separate boards for (and
> multiple options for each of):

> * Motherboard
> * CPU+DRAM
> * PMU/PMIC
> * Display (LCD)
> ... and many more.

> Interaction with the PMU/PMIC is required for at least some of the boot
> media options.

Yeah, similar setup for our boards except the PMICs are soldered down
onto other boards.  We've got a mainboard, three audio boards of various
kinds, a random non-audio components board and a CPU/DRAM board.

There's good solid engineering reasons for doing this.  CPUs and RAMs
tend to be very high density devices with lots of pins and be difficult
enough to route to require large numbers of layers (and ideally you want
the PMIC to be physically close to them since long traces tend to become
electrically interesting for CPU style loads, especially when routed
through connectors) all of which leads to an expensive board which you
pay for by area.  With reference boards with large form factors it's
worth the effort to have a separate, smaller, board manufactured to meet
these requirements - even in very low volumes the cost wins are
noticable.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120504/c7b0362a/attachment.sig>
