From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Jul 2017 16:38:58 +0200
Subject: [linux-sunxi] [PATCH 2/5] arm: allwinner: a64: drop the dummy
 vcc3v3 regulator in Pine64 DT
In-Reply-To: <493424f1-6df3-ec19-a7cf-f76706cb2c51@arm.com>
References: <20170719161019.62133-1-icenowy@aosc.io>
 <20170719161019.62133-3-icenowy@aosc.io>
 <4e2c9486-9c0d-14e9-62e7-8642758c5472@arm.com>
 <7FACC99F-F900-437B-9642-741D7D980D25@aosc.io>
 <493424f1-6df3-ec19-a7cf-f76706cb2c51@arm.com>
Message-ID: <20170721143858.3hufnu7v3ki6xmgf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 02:02:18PM +0100, Andre Przywara wrote:
> Hi,
> 
> On 21/07/17 13:49, Icenowy Zheng wrote:
> > 
> > 
> > ? 2017?7?21? GMT+08:00 ??8:45:39, Andre Przywara <andre.przywara@arm.com> ??:
> >> Hi,
> >>
> >> On 19/07/17 17:10, Icenowy Zheng wrote:
> >>> The Pine64 DT used to contain a dummy vcc3v3 regulator, in order to
> >>> satisfy some device nodes when proper AXP803 regulator support is
> >>> available. It's in fact the DCDC1 regulator of AXP803.
> >>>
> >>> Drop the dummy regulator, and fix the reference of this regulator to
> >>> DCDC1.
> >>
> >> Do we really need to have this?
> >> While I see that this is technically correct, it breaks older kernels,
> >> which miss the AXP driver. So we can't use this DT for syncing it into
> >> U-Boot anymore, while still expecting various kernels (for instance
> >> from
> >> distribution installers) to work via UEFI (for which U-Boot provides
> >> the
> >> DT). That would be a shame, because we start to see generic arm64
> >> distribution installers to work out of the box.
> >>
> >> I see these solutions:
> >> 1) We drop this patch, instead add a comment that technically it's
> >> DCDC1. I believe we can't really turn off DCDC1 anyway.
> >> 2) We keep theses patches, but don't sync them to U-Boot to have a
> >> universal DT in there which works with every kernel.
> >> 3) We keep these patches *and* sync them to U-Boot, but add the fixed
> >> regulator back in via a U-Boot specific .dtsi "overlay" snippet. This
> >> would take care of the parts that break compatibility. The end result
> >> would be similar to 2), then.
> >>
> >> The easiest and most maintainable would be 1), but I am OK with 3) as
> >> well, though I am not sure this won't get messy in the future and will
> >> work for every change that we make.
> >>
> >> What do you think?
> > 
> > 4) Do nothing.
> > 
> > We only promise old DTs will run with newer kernel, but
> > we don't promise newer DTs to run with old kernel.And
> > U-Boot is intended to update less frequently than Linux.
> > 
> > When updateing U-Boot, please update kernel as well.
> 
> Which means you tie your firmware to a kernel. I know this is the old
> embedded approach, but we should really get rid of this, as I don't see
> how this will work nicely with the Pinebook, for instance (which is not
> really "embedded" anymore).
>
> U-Boot sits on the SPI flash there, and you are expected to just run any
> (not only Linux) distribution from a USB pen drive, for instance, with
> that one firmware version, using UEFI. This already works today, but is
> only sustainable if we have forward DT compatibility as well.

We've been discussing this over and over and over again. You're using
the pinebook as an example, fine. Please give me the full documented,
reviewed and acked-by binding for all the features the pinebook has.

If you can't, this discussion is pointless, since you will expect
changes in the DT.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170721/d8151a6f/attachment.sig>
