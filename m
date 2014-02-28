From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Feb 2014 16:27:52 +0000
Subject: [PATCH 0/9] Doc/DT: DT bindings for various display components
In-Reply-To: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <20140228162752.GU21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 02:20:07PM +0200, Tomi Valkeinen wrote:
> Shortly about the display components in the series, in the order of probable
> public interest:
> 
> * Analog TV, DVI and HDMI Connectors represent a respective connector on the
>   board. They don't do much, but they do mark the end of the video pipeline (from
>   the board's pov), and they should also in the future offer ways to handle
>   things like the +5V pin on DVI and HDMI connector and HPD pin.

The big thing which concerns me is that we're using very generic
compatible strings here - has anyone done any searches to see whether
there are any existing standards for this kind of stuff already?

Even if none can be found, if we're going to create something like
this, it should probably become a public standard not just for Linux.

If we're not willing to do that, I'd suggest prefixing the compatible
strings with "linux," as a "company" identifier so that there's no
chance that we may hit some major problem caused by a conflicting
implementation in the future.

We could alternatively take the view that Linux will only ever be used
with Linux specific DT files, but I think that's a rather broken
approach given what DT is supposed to be.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
