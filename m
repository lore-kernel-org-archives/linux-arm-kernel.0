From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 May 2014 19:12:11 +0100
Subject: [PATCHv4 1/2] dt/bindings: Add the DT binding documentation
 for endianness
In-Reply-To: <20140509170255.GR12304@sirena.org.uk>
References: <1399601073-19278-1-git-send-email-Li.Xiubo@freescale.com>
 <1399601073-19278-2-git-send-email-Li.Xiubo@freescale.com>
 <20140509163243.GD16418@e106331-lin.cambridge.arm.com>
 <20140509170255.GR12304@sirena.org.uk>
Message-ID: <20140509181211.GF16418@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 06:02:55PM +0100, Mark Brown wrote:
> On Fri, May 09, 2014 at 05:32:43PM +0100, Mark Rutland wrote:
> > On Fri, May 09, 2014 at 03:04:32AM +0100, Xiubo Li wrote:
> 
> > > {big,little}-endian{,-*}: these are boolean properties, if absent
> > > meaning that the CPU and the Device are in the same endianness mode.
> 
> > That's not really true though. A device might usually be little-endian,
> > regardless of the endianness of a CPU. Some vendors may integrate it as
> > big-endian after a binding is added, and in the absence of a specified
> > endianness a driver is likely to assume LE.
> 
> The default should be device specific rather than binding specific.

I'm taking binding here to mean the binding for a praticular device
rather than a class binding, so there's only a subtle distinction
between the two.

It's entirely possible that two developers independently come up with
bindings for something that is later realised to be the same device
(just integrated differently), for which they choose opposite defaults.

In that case the default is binding-specific rather than device
specific, though I would hope that in the vast majority of cases there
is only one binding per device, at which point the distinction is
meaningless.

Cheers,
Mark.
