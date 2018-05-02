From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 2 May 2018 11:36:01 +0200
Subject: [linux-sunxi] [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
In-Reply-To: <45956397-a593-e51e-8637-655178c5901c@arm.com>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-4-icenowy@aosc.io>
 <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com>
 <83EDF187-5EB2-4FEB-99BC-9D5B728D3A45@aosc.io>
 <45956397-a593-e51e-8637-655178c5901c@arm.com>
Message-ID: <20180502093601.fvkacdv62aqxshbr@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 10:47:35AM +0100, Andre Przywara wrote:
> >> I am just asking because I want to avoid running into the same problem
> >> as with the A64 before: that future DTs become incompatible with older
> >> kernels, because we change the power supply to point to the AXP
> >> regulators, which this kernel does not support yet.
> > 
> > The answer is just not to keep this compatibility, as it's not
> > supported option to update DT without updating kernel.
> 
> Well, I recognise that statement.. ;-) and I understand that it's far
> easier to handle it this way. But:
> - Which .dtb are we going to write into the SPI flash? An older one,
> which covers all kernels, but lacks features? Or a newer one, which
> limits the bootable kernels to recent versions?
> - Which DT are we going to give to EFI applications?
> - Which DT are the BSDs suspected to take? They don't ship their own DTs
> (which is good!).
> 
> So I understand that "shipping the DT with the kernel" is the old
> (embedded!) way of doing things, but I really believe we should stop
> relying on this and try to come up with backwards compatible DTs, which
> live in the firmware and get updated there. Because this is what the
> distros seem to expect from ARM64 boards these days.

You're not talking about backward compatibility, you're talking about
forward compatibility. All the changes in this patch and the one
predicted by Icenowy are backward compatible.

> >> It looks like there are more users of those power rails, so we could
> >> keep those supplies connected to these fixed regulators here, even with
> >> AXP-805 support in the kernel.
> > 
> > It's not a good choice.
> > 
> >>
> >> Or we keep this back until we get proper AXP support in the kernel? I
> >> guess it's quite close to the existing PMICs, so it might be more a
> >> copy&paste exercise to support the AXP-805?
> > 
> > It's not a reason to keep it back.
> 
> So I compared the manuals of the AXP806 and the AXP805, the register
> interface looks identical to me. I only have a (somewhat) Chinese
> version of the AXP806 manual, so couldn't really find the difference
> between the two. Do you know more about it? Is it just maybe the
> packaging and the electrical properties (like max current supported)?
>
> If the I2C register interface is really the same, we could just add the
> DT nodes for the regulator and be done.

And that argument is only valid if you 100% trust the fact that both
datasheet are complete and accurate.

And experience show that you can't.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/c172e477/attachment.sig>
