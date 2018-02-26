From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Feb 2018 10:26:45 +0100
Subject: [PATCH v3 6/7] arm64: allwinner: h6: add the basical Allwinner
 H6 DTSI file
In-Reply-To: <81D53DC5-7622-430E-A530-ED0DE5397DC3@aosc.io>
References: <20180223123555.64009-6-icenowy@aosc.io>
 <20180223123555.64009-7-icenowy@aosc.io>
 <20180223152038.2bflylwa6vj4gzfj@flea.lan>
 <81D53DC5-7622-430E-A530-ED0DE5397DC3@aosc.io>
Message-ID: <20180226092645.xghkmfowenzlbm42@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 11:22:06PM +0800, Icenowy Zheng wrote:
> >> +	psci {
> >> +		compatible = "arm,psci-0.2";
> >> +		method = "smc";
> >> +	};
> >
> >Is it needed? The bootloader should fill it with whatever version it
> >has, shouldn't it?
> 
> But we now use ATF rather than U-Boot PSCI. U-Boot will not fill ATF
> info.
> 
> See A64/H5 device trees.

So if the PSCI version implemented in ATF ever changes, we would have
to update all the DT everywhere, but only if you're running the new
version?

Sigh.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/433a414e/attachment.sig>
