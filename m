From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Jan 2016 11:18:27 +0100
Subject: [PATCH RFC 0/2] Add a display driver to the Allwinner H3
In-Reply-To: <20160108181306.4a5a7370f0e3f3daa7c9e285@free.fr>
References: <cover.1452021349.git.moinejf@free.fr>
 <20160106212046.GD9631@lukather>
 <20160108181306.4a5a7370f0e3f3daa7c9e285@free.fr>
Message-ID: <20160118101827.GO4581@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 08, 2016 at 06:13:06PM +0100, Jean-Francois Moine wrote:
> On Wed, 6 Jan 2016 22:20:46 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > > As there is no documentation about the DE2 nor about the HDMI which
> > > are found in the H3, this driver has been built from Allwiiner's
> > > sources.
> > 
> > That's unfortunate :/
> > 
> > Have you checked in the A64 BSP if there was some useful information?
> 
> Same as the H3: no more information about the display system.

Too bad...

> > > So, there may be license problems, especially for the file
> > > de2_hdmi_h3.c which contains a lot of magic values.
> > 
> > I guess it's the biggest issue with your code right now. What licenses
> > issues are we talking about here?
> 
> The documentation about the H3, as the other Allwinner documentations,
> starts with:
> 
> 	This documentation is the original work and copyrighted
> 	property of Allwinner Technology ("Allwinner"). Reproduction in
> 	whole or in part must obtain the written approval of Allwinner
> 	and give clear acknowledgement to the copyright owner.

I'm not sure this one is an issue. This datasheet is available
publicly, and it's common to have a datasheet with restrictions (or
even an NDA).

> Then, the DE2 sources contain only:
> 
> 	All Winner Tech, All Right Reserved. 2014-2015 Copyright (c)
> 
> Eventually, there is no copyright/author/history in the HDMI sources.

That one is nasty though :/

It seems to be a GPL violation though, so we have two solutions:

A) have a clean room implementation
B) Ask allwinner to comply with the license

The former doesn't look likely to happen soon... Can you open an issue
on this on their linux github repo?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160118/ca88bf83/attachment.sig>
