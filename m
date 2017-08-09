From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Aug 2017 10:22:10 +0200
Subject: [PATCH 00/10] ARM, arm64: dts: renesas: Use R-Car GPIO Gen[123]
 fallback compat strings
In-Reply-To: <20170809075526.GE2705@verge.net.au>
References: <1502181568-12299-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoRcsAhvFB=DNoJHzJt4dejKX+Z8ar04D8O1cFq1XkxWkw@mail.gmail.com>
 <20170809075526.GE2705@verge.net.au>
Message-ID: <20170809082210.GH2705@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 09:55:26AM +0200, Simon Horman wrote:
> On Tue, Aug 08, 2017 at 07:29:28PM +0900, Magnus Damm wrote:
> > Hi Simon,
> > 
> > On Tue, Aug 8, 2017 at 5:39 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > > Use newly added R-Car GPIO Gen 1, 2 and 3 fallback compat strings in place
> > > of now deprecated non-generation specific R-Car GPIO fallback compat string
> > > in the DT of Renesas ARM and arm64 based SoCs.
> > >
> > > This should have no run-time effect as the driver matches against the
> > > per-SoC compat string before considering the fallback compat string.
> > 
> > Thanks for your efforts.I have no issue with your series (apart from
> > the GPIO and SATA mistake), but at the same time I believe the GPIO
> > hardware itself is backwards compatible between various generations.
> > 
> > In the nitpick department I would like to point out that the level of
> > hardware difference between say R-Car Gen1 GPIO and R-Car Gen2 GPIO is
> > similar to say good old uarts like 8250 and 16450 hardware. Basically
> > a couple of registers were added to the hardware in a
> > backwards-compatible way if I recall correctly.
> > 
> > So if we are going to use "compatible" to point out if hardware is
> > compatible or not then I would do this instead:
> 
> Thanks for your feedback.
> 
> When the generation specific compat strings were recently
> added the renesas,gpio-rcar compat string was marked as deprecated
> as I was under the understanding that it was only compatibile with gen 1 SoCs.
> 
> It now seems that was not the best thing to do and renesas,gpio-rcar should
> be re-instated as being a generic fallback for all R-Car versions supported
> in upstream.
> 
> Do you concur?

I posted a patch to un-deprecate the renesas,gpio-rcar compat string
in the bindings documentation.

[PATCH] gpio: rcar: reinstate generic compat string
