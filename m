From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 30 Nov 2016 10:35:03 +0100
Subject: [RFC PATCH] ARM: dts: sun8i: add simplefb node for H3
In-Reply-To: <20161129215932.kmk6qodthicadpyb@lukather>
References: <20161128095900.27615-1-icenowy@aosc.xyz>
 <20161128114218.14d2ed434802a20fa6b62023@free.fr>
 <20161129215932.kmk6qodthicadpyb@lukather>
Message-ID: <20161130103503.01061303ace71c74e1cac66f@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Nov 2016 22:59:32 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > > I'm still not sure which pipeline should I use.
> > > 
> > > And, it seems that HDMI Slow Clock is not needed?
> > > 
> > > (seems that it's only for EDID, but simplefb won't use EDID)
> > 
> > So, I don't see how this may work.
> > How can the u-boot know the resolutions of the HDMI display device?
> > 
> > In other words: I have a new H3 board with the last u-boot and kernel.
> > I plug my (rather old or brand new) HDMI display device.
> > After powering on the system, I hope to get something on the screen.
> > How?
> 
> If it works like the driver for the first display engine in U-Boot, it
> will use the preferred mode reported by the EDID, and will fallback to
> 1024x768 if it cannot access it.

Icenowy wrote: "simplefb won't use EDID"

Then, if it is like in the kernel, the 1024x768 mode is VGA. It does
not work with HDMI (different timings).

> Maybe it would be worth exchanging on the EDID code that has been done
> for the u-boot driver too, so that it can be fixed in your driver.

The u-boot got my code, and, up to now, I could not fix the random or
permanent failures of EDID reading in some boards.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
