From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 May 2017 16:44:27 +0200
Subject: [linux-sunxi] [PATCH v6 9/9] arm64: allwinner: a64: enable Wi-Fi
 for Pine64
In-Reply-To: <16dee602b96510170ee1117cfaae0025@aosc.io>
References: <20170518071653.36561-1-icenowy@aosc.io>
 <20170518071653.36561-10-icenowy@aosc.io>
 <CAGb2v66mqMveibKKU9LiBm8jzAOj46hFCK6HvJx0k6077fqLZw@mail.gmail.com>
 <79B00D42-3F95-4D5E-9A23-8E893CCF2462@aosc.io>
 <20170519071922.awmib4qphl6ac6mj@flea.home>
 <16dee602b96510170ee1117cfaae0025@aosc.io>
Message-ID: <20170523144427.vi4szmy4f6gpyj3n@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 03:22:28PM +0800, icenowy at aosc.io wrote:
> ? 2017-05-19 15:19?Maxime Ripard ???
> > On Fri, May 19, 2017 at 11:03:33AM +0800, Icenowy Zheng wrote:
> > > >The patch looks OK, but given the module is removable, I think it
> > > >should be
> > > >an overlay. The overlay would enable WiFi + Bluetooth, and all the
> > > >peripherals needed to connect them.
> > > >
> > > >That way, if the module is not installed, we avoid confusing the user
> > > >with
> > > >unused peripherals, and avoid having live voltage on an unoccupied
> > > >header.
> > > 
> > > But as this header have specific usage, we will also confuse user
> > > if it's not enabled as its target usage.
> > 
> > Yet you would enable unused resources.
> > 
> > This was already pointed out here:
> > https://patchwork.kernel.org/patch/9670235/
> 
> I think, before we have an official repository of device tree
> overlays (either directly in torvalds/linux or maintained by
> linux-sunxi), we shouldn't rely on device tree overlay
> functionality.

This is a board specific overlay, and having some upstream repository
with all the possible combinations of SoC / daughter board is just not
realistic.

This should be shipped by the board vendors. RPi does that, the
beaglebone does that, the CHIP does that, surely, if it works for
them, it should work for you.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170523/9d24abc0/attachment.sig>
