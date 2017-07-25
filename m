From: kilobyte@angband.pl (Adam Borowski)
Date: Tue, 25 Jul 2017 05:18:19 +0200
Subject: [PATCH 0/3] Add ethernet0 alias for several A64 boards
In-Reply-To: <f4016e61dbe4655a0e672c3377f35dd2@aosc.io>
References: <20170722022852.7868-1-icenowy@aosc.io>
 <20170724075823.7ttjq4tnvoupo776@flea>
 <f4016e61dbe4655a0e672c3377f35dd2@aosc.io>
Message-ID: <20170725031819.ryllvq5a3tdwyblj@angband.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 11:04:24AM +0800, icenowy at aosc.io wrote:
> ? 2017-07-24 15:58?Maxime Ripard ???
> > On Sat, Jul 22, 2017 at 10:28:49AM +0800, Icenowy Zheng wrote:
> > > Allwinner A64 SoC has an EMAC which is used to provide Ethernet
> > > function on several boards.
> > > 
> > > The EMAC itself doesn't have a fixed MAC address, but the sunxi
> > > mainline U-Boot have the ability to generate one based on the eFUSE
> > > SID in the chip, and add the generated MAC address to the device
> > > tree when booting.
> > > 
> > > The MAC address setting step is based on the device tree's aliases,
> > > and device tree nodes prefixed "ethernet" will get the MAC address
> > > added. However, in several A64 boards' device tree, the alias is not
> > > set up, so that the U-Boot won't set the MAC address.
> > > 
> > > Add the ethernet0 aliases to these boards.
> > > 
> > > I hope this patchset can be queued in 4.13, otherwise 4.13 kernels
> > > won't get non-volatile MAC addresses, and will use random ones
> > > instead, which is annoying to many users.
> > > 
> > > Icenowy Zheng (3):
> > >   arm64: allwinner: a64: add ethernet0 alias for BPi M64 EMAC node
> > >   arm64: allwinner: a64: add ethernet0 alias for Pine64 EMAC node
> > >   arm64: allwinner: a64: add ethernet0 alias for SoPine EMAC node
> > 
> > Applied all three, thanks!
> 
> Sorry, but could you queue them to 4.13?
> 
> Otherwise 4.13 kernel release will have annoying random MAC problem,
> which heavily affects headless usages.

Perhaps it would be better to reword the commit subject as "fix missing
ethernet0 alias ..."?  That'd convey that the previous behaviour is a defect
that needs these patches as a fix.


Meow!
-- 
// If you believe in so-called "intellectual property", please immediately
// cease using counterfeit alphabets.  Instead, contact the nearest temple
// of Amon, whose priests will provide you with scribal services for all
// your writing needs, for Reasonable and Non-Discriminatory prices.
