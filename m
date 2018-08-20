From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 20 Aug 2018 14:00:46 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun8i: r40/v40: rewrite BPi
 M2 Berry DTS to rebase on M2 Ultra
In-Reply-To: <dc8a28bcfbe082158bac5b097badb3ddf0f51ce8.camel@aosc.io>
References: <20180724163655.61365-1-icenowy@aosc.io>
 <20180726124119.dwne2sncws2p3sdi@flea>
 <dc8a28bcfbe082158bac5b097badb3ddf0f51ce8.camel@aosc.io>
Message-ID: <20180820120046.7tonxtb52q43ocfq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed, Aug 08, 2018 at 06:36:56PM +0800, Icenowy Zheng wrote:
> ? 2018-07-26?? 14:41 +0200?Maxime Ripard???
> > On Wed, Jul 25, 2018 at 12:36:55AM +0800, Icenowy Zheng wrote:
> > > Banana Pi designs the BPi M2 Berry board to be software compatible
> > > with
> > > BPi M2 Ultra,
> > 
> > Do you have a reference for this?
> > 
> > > so it's based on M2 Ultra with some function cuts, including:
> > > 
> > > - 2048MiB DRAM -> 1024MiB (this should be proceed by the
> > > bootloader);
> > > - dropped a LED;
> > > - dropped eMMC;
> > > - dropped USB2 and connect USB1 to a 4-port HUB.
> > 
> > Is it the exhaustive list?
> 
> I have asked Mikey from Sinovoip, and he has agreed this.
> 
> Here's a list provided by him, which covers some things I forgot:
> - 2GiB -> 1GiB
> - no eMMC
> - no onboard microphone
> - no IR
> - no charging (and power jack to USB)
> - USB change
> - one less LED
> 
> Should I add this to the device tree's comment?

Not really, because...

> > 
> > I'm a bit reluctant to merge that kind of patches usually, since that
> > would also imply that each time someone will commit something to the
> > M2-Ultra, it would automatically apply to the M2-Berry, without any
> > easy way to tell and / or test.

... this still applies.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180820/31fb9ebc/attachment-0001.sig>
