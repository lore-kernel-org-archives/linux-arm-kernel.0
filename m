From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jun 2013 16:49:50 +0100
Subject: Dove/Armada DRM driver naming
In-Reply-To: <CAMLZHHRFMmLsckBVDrxEGx9XaqhNq_sOFvDKq=Cx7HH938tkng@mail.gmail.com>
References: <CAMLZHHRFMmLsckBVDrxEGx9XaqhNq_sOFvDKq=Cx7HH938tkng@mail.gmail.com>
Message-ID: <20130610154949.GV18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 09:36:51AM -0600, Daniel Drake wrote:
> As the MMP3 does not fit under any form of "Armada" name, calling the
> new DRM driver Armada may not be 100% accurate. Although, looking at
> Documentation/arm/Marvell/README, finding a good name may not be
> trivial.

Armada seems to fit more SoCs with it than it doesn't, and is better
than calling it Dove as I did in the initial version.

However, the name is not that important; we've had these arguments before
and some maintainers outright reject name changes to existing drivers.
If we cared that much about names, we'd have masses of patches going
into the kernel constantly renaming functions and the like.
It's fine to have the discussion early on in the development of a
driver, but there comes a point when no other changes are acceptable.

> The MMP2 and MMP3 include graphics silicon developed by Vivante. Would
> it be more accurate to call this drm-vivante?

No, because Vivante is the GPU, which is a separate IP block from the
LCD interfaces, which is a separate IP block from the Vmeta video
decover.

> I must admit I don't
> have a complete understanding here: of is the whole graphics subsystem
> driven by vivante silicon, or is the vivante part more of an isolated
> add-on which can accelerate certain operations in graphics memory?

The LCD, GPU and video decoder are separate IP blocks.

However, for a proper DRM driver, we would need to have the GPU fall
under the DRM stuff as well, but my approach at the moment is to continue
using the existing solution as I have no desire mess with that stuff,
especially as doing so would be against the license terms that came
with those libraries.  If others want to work on that, and integrate it
into the driver, I'm more than happy to work with them on the integration.

Call me pedantic, but I believe in respecting the licenses on the
software I have, irrespective of whether they be open or closed source.

(Of course, if Marvell/Vivante wish to grant me permission...)

What I don't have an issue with is cleaning up the GPLv2 galcore kernel
driver - the source is spread all round the Internet in various different
versions - and there's quite an amount that can be cleaned up and the
obfuscations unobfuscated relatively easily with perl (and I already
have a hundred or so patches against that sucker.)
