From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Mar 2017 14:31:18 +0200
Subject: [PATCH 7/15] dt-bindings: display: sun4i: Add
 allwinner,tcon-channel property
In-Reply-To: <20170328100519.145DE203419@relay.mailchannels.net>
References: <20170328100519.145DE203419@relay.mailchannels.net>
Message-ID: <20170329123118.yvwnqpgtamc5pjqf@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 06:05:08PM +0800, Icenowy Zheng wrote:
> 
> 2017?3?27? ??5:11? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > On Fri, Mar 17, 2017 at 11:34:45AM +0800, Chen-Yu Tsai wrote: 
> > > On Thu, Mar 16, 2017 at 1:37 AM, Rob Herring <robh@kernel.org> wrote: 
> > > > On Tue, Mar 07, 2017 at 09:56:26AM +0100, Maxime Ripard wrote: 
> > > >> The Allwinner Timings Controller has two, mutually exclusive, channels. 
> > > >> When the binding has been introduced, it was assumed that there would be 
> > > >> only a single user per channel in the system. 
> > > >> 
> > > >> While this is likely for the channel 0 which only connects to LCD displays, 
> > > >> it turns out that the channel 1 can be connected to multiple controllers in 
> > > >> the SoC (HDMI and TV encoders for example). And while the simultaneous use 
> > > >> of HDMI and TV outputs cannot be achieved, switching from one to the other 
> > > >> at runtime definitely sounds plausible. 
> > > >> 
> > > >> Add an extra property, allwinner,tcon-channel, to specify for a given 
> > > >> endpoint which TCON channel it is connected to, while falling back to the 
> > > >> previous mechanism if that property is missing. 
> > > > 
> > > > I think perhaps TCON channels should have been ports rather than 
> > > > endpoints. The fact that the channels are mutually exclusive can be 
> > > > handled in the driver and doesn't really matter in the binding. How 
> > > > painful would it be to rework things to move TCON channel 1 from port 0, 
> > > > endpoint 1 to port 1? 
> > > 
> > > Having a separate output port for channel 1 was one option we discussed. 
> > > However it wouldn't work well with the kernel's of_graph based crtc 
> > > detection (drm_of_find_possible_crtcs / drm_of_find_possible_crtcs), 
> > > which has the crtcs bound via the output port. As the logic is used 
> > > by multiple drivers, I'm not sure it's easy to rework or test. 
> >
> > Can't we use a different logic than drm_of_find_possible_crtcs to fill 
> > the same role? 
> >
> > > Also, we still have to support old device trees using channel 1 from 
> > > output port 0 endpoint 1. This is the TV encoder on sun5i (A10s/A13/R8). 
> 
> And from A83T on we will face channel-1 only TCONs., which do not
> have channel 0 at all in hardware.

Yes, but those patches have not been merged yet, so we don't have to
care about the backward compatibility.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170329/9c8f46ed/attachment.sig>
