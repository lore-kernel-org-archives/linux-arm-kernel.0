From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Jul 2014 17:53:52 +0100
Subject: i.MX6 graphics status
In-Reply-To: <m34myxrsad.fsf@intrepid.localdomain>
References: <m34myxrsad.fsf@intrepid.localdomain>
Message-ID: <20140704165352.GI21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 06:40:42PM +0200, Krzysztof Halasa wrote:
> Hi,
> 
> do any of you have, by chance, information about status of i.MX6
> graphics? I mean things like GLX and H.264 encoding and decoding.
>
> I know Freescale has some (partially binary-only) packages which can do,
> to some degree, GLX and perhaps other things. Is it all I can use, or
> maybe etnaviv/etc. could be used as well? What about IMX DRM driver?

It's still early very days for that.  etnaviv is progressing along,
and (I hope) there's moves to integrate it as an entirely separate
DRM driver along side the DRM stuff (but I've not been looking at it.)
That's something I do need to give some attention so that it works
between imx-drm and armada-drm.

For the video stuff, there's people working on it.  There are members
of the Cubox community who have been working away on that side of
things.  I'm not going to start making any further statements on that
as there's some issues involved there which I've only been a casual
observer to the IRC discussions...

Going back to the DRM stuff, there's one annoying thing about it,
which is the overlay plane doesn't do scaling - which totally screws
apps which want to do video playback via XVideo overlay.  That's one
of the biggest reasons that iMX6 video playback isn't that interesting
for me - at least not until etnaviv progresses to a point where there
is sane userspace and kernel stuff.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
