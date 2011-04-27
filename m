From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2011 22:21:48 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110427201605.GW17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<201104271302.44249.arnd@arndb.de>
	<20110427201605.GW17290@n2100.arm.linux.org.uk>
Message-ID: <201104272221.48601.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2011 22:16:05 Russell King - ARM Linux wrote:
> > As for making the default being to do cache handling, I'm not completely
> > sure how that would work on architectures where most devices are coherent.
> > If I understood the DRM people correctly, some x86 machine have noncoherent
> > DMA in their GPUs while everything else is coherent.
> 
> Well, it sounds like struct device needs a flag to indicate whether it is
> coherent or not - but exactly how this gets set seems to be architecture
> dependent.  I don't see bus or driver code being able to make the necessary
> decisions - eg, tulip driver on x86 would be coherent, but tulip driver on
> ARM would be non-coherent.
> 
> Nevertheless, doing it on a per-device basis is definitely the right
> answer.

The flag would not get set by the driver that uses the device but
the driver that found it, e.g. the PCI bus or the platform code,
which should know about these things and also install the appropriate
iommu or mapping operations.

	Arnd
