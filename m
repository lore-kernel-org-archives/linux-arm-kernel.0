From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 22 Dec 2017 09:35:08 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Add sid for a83t
In-Reply-To: <20171221190903.56ebae536acf51401c63802c@bidouilliste.com>
References: <20171219210523.10428-1-kevans91@ksu.edu>
 <20171221145512.llxvzkcrjpquhczi@flea.lan>
 <CACNAnaE9GiVTXD-TV1xXyBJKtTGKpdA6n0REk6a=qm218EgHbg@mail.gmail.com>
 <20171221152630.2vf57x5o2yi5sv3n@flea.lan>
 <20171221190903.56ebae536acf51401c63802c@bidouilliste.com>
Message-ID: <20171222083508.dfcp6egfvxykmogg@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 07:09:03PM +0100, Emmanuel Vadot wrote:
> 
>  Hi Maxime,
> 
> On Thu, 21 Dec 2017 16:26:30 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Hi,
> > 
> > On Thu, Dec 21, 2017 at 09:19:24AM -0600, Kyle Evans wrote:
> > > On Thu, Dec 21, 2017 at 8:55 AM, Maxime Ripard
> > > <maxime.ripard@free-electrons.com> wrote:
> > > > Hi Kyle,
> > > >
> > > > On Tue, Dec 19, 2017 at 03:05:23PM -0600, kevans91 at ksu.edu wrote:
> > > >> Allwinner a83t has a 1 KB sid block with efuse for security rootkey and
> > > >> thermal calibration data, add node to describe it.
> > > >>
> > > >> a83t-sid is not currently supported by nvmem/sunxi-sid, but it is
> > > >> supported in an external driver for FreeBSD.
> > > >>
> > > >> Signed-off-by: Kyle Evans <kevans91@ksu.edu>
> > > >
> > > > The patch looks fine in itself, but we've had a number of issues with
> > > > the register layout (and access patterns) in the past, so I'd rather
> > > > have something that works in Linux too if possible.
> > > 
> > > I have a patch that I think should make it work fine on Linux [1], but
> > > I'm afraid I have little to no capability to test it myself and so I
> > > did not add it as well.
> > > 
> > > I do know that the rootkey is offset 0x200 into the given space [2],
> > > as is the case with the H3, and that the readout quirk is not needed.
> > > I wasn't 100% sure that the a83t has 2Kbit worth of efuse space as the
> > > H3, but I do know that thermal data can be found at 0x34 and 0x38 in
> > > this space.
> > 
> > Then maybe we should leave it aside until someone takes some time on
> > the A83t. 
> 
>  Take some time on the Linux driver and do not apply this patch for
> now you mean ?

Yep.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171222/f9c1e545/attachment.sig>
