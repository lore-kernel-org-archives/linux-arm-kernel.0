From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Jul 2014 10:38:46 +0100
Subject: [PATCH RFC 06/15] drm/armada: move variant initialisation to
 CRTC init
In-Reply-To: <53B91B10.8060009@gmail.com>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
 <E1X3NMM-0000A5-N5@rmk-PC.arm.linux.org.uk> <53B7E86D.5040109@gmail.com>
 <20140705122115.GP21766@n2100.arm.linux.org.uk> <53B91B10.8060009@gmail.com>
Message-ID: <20140709093845.GN21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 06, 2014 at 11:46:56AM +0200, Sebastian Hesselbarth wrote:
> On 07/05/2014 02:21 PM, Russell King - ARM Linux wrote:
> > There's also the issue whether the output can cope with fractional
> > clock-skipping dividers - entirely synchronous display systems can
> > (such as synchronously clocked LCD panels), but asynchronous display
> > systems (such as HDMI, TV out, etc) can't.  That said, the other
> > parameter that needs to be taken account of here is that even with the
> > fractional divider, the minimum output clock period isn't the average
> > frequency, but the maximum frequency, which may violate a panel's minimum
> > clock period specification.
> 
> Yeah, the fractional divider isn't made for external HDMI transmitters
> for sure. I have seen from your branch that there is some Armada 610
> stub for OLPC, do they have a dumb panel directly connected?

I believe they do have a dumb panel connected directly.  I've asked
Jon what the status of OLPC is with mainline kernels, and how difficult
it would be to get to the stage where the 610 stuff could be finished
off.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
