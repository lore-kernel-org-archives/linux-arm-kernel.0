From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Nov 2013 13:29:26 +0000
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131129131359.GH4634@e103592.cambridge.arm.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129023554.GA14239@kroah.com> <20131129093713.GC22771@ulmo.nvidia.com>
 <20131129095703.GV16735@n2100.arm.linux.org.uk>
 <20131129131359.GH4634@e103592.cambridge.arm.com>
Message-ID: <20131129132926.GX16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 01:13:59PM +0000, Dave Martin wrote:
> On Fri, Nov 29, 2013 at 09:57:03AM +0000, Russell King - ARM Linux wrote:
> > On Fri, Nov 29, 2013 at 10:37:14AM +0100, Thierry Reding wrote:
> > > There's a large gap between how fast new SoCs are supposed to tape out
> > > and the rate at which new code can be merged upstream. Perhaps some of
> > > that could be mitigated by putting more of the complexity into firmware
> > > and that's already happening to some degree for ARMv8. But I suspect
> > > there's a limit to what you can hide away in firmware while at the same
> > > time giving the kernel enough information to do the right thing.
> > 
> > One of the bigger issues which stands in the way of companies caring
> > about mainstream support is closed source IPs like VPUs and GPUs.
> > 
> > If you have one of those on your chip, even if the kernel side code
> > is already under the GPL, normally that code is not "mainline worthy".
> > Also, as the userspace code may not be open source, some people object
> > to having the open source part in the kernel.
> > 
> > So for customers to be able to get the performance out of the chip,
> > they have to stick with having non-mainline kernel.
> > 
> > At that point, why bother spending too much time getting mainline
> > support for the device.  It's never going to be fully functional in
> > mainline.  It doesn't make sense for these SoC companies.
> 
> Putting effort into upstream support for something that is only relevant
> to GPUs (or VPUs) does look less valuable for us right now, unless it
> encourages people to start posting more GPU/VPU code upstream, and we
> know there are other blockers there.

I think you miss my point.  Manufacturers want their chips to be useful
to people, and they want all the features on their chip to be usable.
They don't want something which sort-of works but has chunks of support
for various IP that they spent time integrating not supported.

So they have two options: either they develop a kernel out of mainline
which supports everything, which isn't subject to the whims of mainline
kernel developers breaking it all the time because of lack of testing,
or they decide that they're not going to support everything and work on
mainline only.

The problem with the latter is they're explicitly saying to some
customers that they're on their own as far as that's concerned, and
they're not prepared to do that: customers are the people who pay the
bills, remember, and you don't turn them away without good reason.

For example, I doubt that SolidRun would've picked Freescale's IMX6
for their next board unless there was support for the GPU and VPU in
some kernel somewhere.  Remember, not everyone is interested in producing
yet another toy board which can only really be used as a NAS.  Some want
accelerated graphics and hardware assisted video decode today too, and
want to sell products based on those features.
