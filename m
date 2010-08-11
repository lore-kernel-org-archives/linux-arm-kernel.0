From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Aug 2010 21:35:05 +0100
Subject: Problem with non aligned DMA in usbnet on ARM
In-Reply-To: <4C62C7B3.2030706@nvidia.com>
References: <AANLkTi=ycg=adcizNWKMCb7EdfDANM=6Es7r_gF1LbhV@mail.gmail.com>
	<4C627479.4060400@parrot.com>
	<AANLkTinU2JEkeYJHo4tA+kD9Pd_F3YcUTbK9w6igc7s8@mail.gmail.com>
	<4C62C7B3.2030706@nvidia.com>
Message-ID: <20100811203505.GA463@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 08:54:27AM -0700, Gary King wrote:
> On 08/11/2010 04:38 AM, Martin Fuzzey wrote:
> > It seems to me these fixup functions are not intended to solve
> > alignment issues but rather implement device specific framing (such as
> > when the hardware packs multiple ethernet frames into a single urb)
> >
> I sent a patch to the list about 2 weeks ago that added support to
> DMA bounce to bounce for misaligned buffers. We have a similar
> problem with URB alignment for usbnet on Tegra's HCD:
> 
> http://lists.arm.linux.org.uk/lurker/message/20100729.005746.b43fa1d9.en.html

We don't want to add support for this to DMA bounce.  DMA bounce is already
a pain in the backside and causes its own set of problems - please let it
die a long slow but quite death.

If you want to see the kind of pain dmabounce causes, look at this long
standing and as yet unsolved bug:

  http://bugzilla.kernel.org/show_bug.cgi?id=7760
