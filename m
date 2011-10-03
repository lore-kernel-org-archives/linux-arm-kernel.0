From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 3 Oct 2011 18:05:03 +0100
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <20111003164309.GA19925@n2100.arm.linux.org.uk>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<4E89C3FA.9020206@gmail.com>
	<20111003142524.GN3731@opensource.wolfsonmicro.com>
	<4E89D3C4.8090001@gmail.com>
	<20111003163107.GQ3731@opensource.wolfsonmicro.com>
	<20111003164309.GA19925@n2100.arm.linux.org.uk>
Message-ID: <20111003170503.GI23811@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 05:43:09PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 03, 2011 at 05:31:08PM +0100, Mark Brown wrote:

[Not being many off-SoC clocks]
> > I dunno, I get the impression that some of this is due to the current
> > limitations of the clock API rather than due to a lack of clocks -
> > perhaps that's specific to the applications I look at, though.
> > applications 

> The clk API per-se has nothing to do with how clocks are registered.
> There are two things that are the clk API:

Right, it's consumer side only which is the limitation I'm talking about
- at the minute it's only possible to use the clk API for on-SoC clocks
(or at least clocks that the SoC cares about), we don't have a clock API
for cross platform clock providers.  I don't know if getting a cross
platform implementation will change that situation much.
