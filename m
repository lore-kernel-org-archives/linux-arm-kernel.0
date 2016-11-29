From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Nov 2016 22:59:32 +0100
Subject: [RFC PATCH] ARM: dts: sun8i: add simplefb node for H3
In-Reply-To: <20161128114218.14d2ed434802a20fa6b62023@free.fr>
References: <20161128095900.27615-1-icenowy@aosc.xyz>
 <20161128114218.14d2ed434802a20fa6b62023@free.fr>
Message-ID: <20161129215932.kmk6qodthicadpyb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 11:42:18AM +0100, Jean-Francois Moine wrote:
> On Mon, 28 Nov 2016 17:59:00 +0800
> Icenowy Zheng <icenowy@aosc.xyz> wrote:
> 
> > As there's currently a fork of U-Boot which provides simplefb support
> > for H3, a simplefb node can be added to the device tree.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> > ---
> > 
> > I'm still not sure which pipeline should I use.
> > 
> > And, it seems that HDMI Slow Clock is not needed?
> > 
> > (seems that it's only for EDID, but simplefb won't use EDID)
> 
> So, I don't see how this may work.
> How can the u-boot know the resolutions of the HDMI display device?
> 
> In other words: I have a new H3 board with the last u-boot and kernel.
> I plug my (rather old or brand new) HDMI display device.
> After powering on the system, I hope to get something on the screen.
> How?

If it works like the driver for the first display engine in U-Boot, it
will use the preferred mode reported by the EDID, and will fallback to
1024x768 if it cannot access it.

Maybe it would be worth exchanging on the EDID code that has been done
for the u-boot driver too, so that it can be fixed in your driver.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161129/94d75cc0/attachment-0001.sig>
