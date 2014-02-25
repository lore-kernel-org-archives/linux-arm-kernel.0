From: sre@ring0.de (Sebastian Reichel)
Date: Tue, 25 Feb 2014 14:41:48 +0100
Subject: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <20140225123921.GY27282@n2100.arm.linux.org.uk>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>
 <20140224180336.GU27282@n2100.arm.linux.org.uk>
 <CABxcv=kKxidVJWcMrueB+edW=g_6gcucvi6=7p=EZ_WooCpbMA@mail.gmail.com>
 <20140225123921.GY27282@n2100.arm.linux.org.uk>
Message-ID: <20140225134139.GA23898@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 25, 2014 at 12:39:21PM +0000, Russell King - ARM Linux wrote:
> > That compatible string is correct according to the latest series
> > posted by Tomi Valkeinen to add DT bindings for the OMAP Display
> > SubSystem (DSS) [0].
> 
> in which case:
> 
> N    N   AA     CCCC  K  K
> NN   N  A  A   C    C K K
> N N  N A    A C       KK
> N  N N AAAAAA C       KK
> N   NN A    A  C    C K K
> N    N A    A   CCCC  K  K
> 
> Yes, that's a very big nack.  Two things:
> 
> 1. OMAP really doesn't have the right to define a compatible string which
>    is as generic as "hdmi-connector".

AFAIK the idea was to have "hdmi-connector" as part of the common
display framework [1]. It's not really platform specific, since it's
just a connector.

Since omapdss does not yet implement the common display framework,
but wants to keep a stable DT API it rewrites "hdmi-connector" to
"omapdss,hdmi-connector" for now.

> 2. Even with "omapdss," before it, the convention that DT people have adopted
>    is for the prefix to be "companyname," and not a subsystem.
>
> I'm not the only one with this concern - I discussed it with Arnd last
> night and his comments were about it being "obviously bogus".
> 
> > The property is added on this patch [1] and as far as I understood the
> > idea is that it could be a generic DT binding that can be used by
> > platform specific HDMI connectors like the omap dss HDMI connector [2].
> 
> Why do the physical connectors need a DT binding?

This is the termination of the video bus and useful information for
xrandr.

> Surely what needs the DT binding is the HDMI encoder - and that
> certainly should no way be a generic name, because there's no such
> thing as a generic HDMI encoder chip.

The HDMI encoder and companion chips are described separatly and
properly prefixed [0].

[0] http://www.spinics.net/lists/linux-omap/msg102522.html
[1] https://lwn.net/Articles/563157/

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140225/958a98e6/attachment.sig>
