From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 11:43:15 +0100
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131129095703.GV16735@n2100.arm.linux.org.uk>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129023554.GA14239@kroah.com>
 <20131129093713.GC22771@ulmo.nvidia.com>
 <20131129095703.GV16735@n2100.arm.linux.org.uk>
Message-ID: <20131129104313.GG22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 09:57:03AM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 29, 2013 at 10:37:14AM +0100, Thierry Reding wrote:
> > There's a large gap between how fast new SoCs are supposed to tape out
> > and the rate at which new code can be merged upstream. Perhaps some of
> > that could be mitigated by putting more of the complexity into firmware
> > and that's already happening to some degree for ARMv8. But I suspect
> > there's a limit to what you can hide away in firmware while at the same
> > time giving the kernel enough information to do the right thing.
> 
> One of the bigger issues which stands in the way of companies caring
> about mainstream support is closed source IPs like VPUs and GPUs.
> 
> If you have one of those on your chip, even if the kernel side code
> is already under the GPL, normally that code is not "mainline worthy".
> Also, as the userspace code may not be open source, some people object
> to having the open source part in the kernel.
> 
> So for customers to be able to get the performance out of the chip,
> they have to stick with having non-mainline kernel.
> 
> At that point, why bother spending too much time getting mainline
> support for the device.  It's never going to be fully functional in
> mainline.  It doesn't make sense for these SoC companies.

Well, there are advantages to having large parts, even if not all, of an
SoC supported in the mainline kernel. The closer you are to mainline,
the easier it becomes for customers and users to use a mainline kernel.

The better an SoC is supported upstream the fewer vendor-specific
patches are required to get feature parity, which in turn makes it
easier for customers to forward-port (and back-port for that matter)
those patches to whatever kernel they want. It also allows vendors to
concentrate on the more contentious patches and spend time on making
them worthy of mainline.

Customers aren't only end-users but also embedded partners that want to
use the SoC in their products. It's no secret that many vendor trees lag
behind upstream and that causes all kinds of pain such as having to port
drivers for new hardware that's not supported in whatever vendor tree
you happen to get. Tracking upstream is invaluable because it makes it
almost trivial to support new hardware and it helps in turn with getting
your own changes merged.

So upstreaming SoC support isn't only for the benefit of SoC vendors. It
also is very convenient for all users of the SoC. It's true that ideally
an SoC would be fully functional in mainline. That's not the case today,
but that doesn't mean it will always be true.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/ca96f5ec/attachment.sig>
