From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Jan 2017 10:09:10 +0100
Subject: [PATCH v3 05/10] arm: dts: sun8i: split Allwinner H3 .dtsi
In-Reply-To: <2b8672bc-58ae-66a9-46d7-c7f3c5825a9d@arm.com>
References: <20170129023331.62106-1-icenowy@aosc.xyz>
 <20170129023331.62106-6-icenowy@aosc.xyz>
 <2b8672bc-58ae-66a9-46d7-c7f3c5825a9d@arm.com>
Message-ID: <20170130090910.cer2nvedq3tjleih@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 01:42:40AM +0000, Andr? Przywara wrote:
> > +&ccu {
> > +	compatible = "allwinner,sun8i-h3-ccu";
> > +};
> 
> I believe this kind of sharing nodes is a bit frowned upon in connection
> with sharing .dtsi's. If the compatible name differs, I think it
> deserves to be a separate node spelt out in each SoC's .dtsi.
> This also makes the DT more readable, since a reader doesn't have to
> refer to two files to see what's in that node.
> 
> >  
> > -		codec_analog: codec-analog at 01f015c0 {
> > -			compatible = "allwinner,sun8i-h3-codec-analog";
> > -			reg = <0x01f015c0 0x4>;
> > -		};
> > +&mmc0 {
> > +	compatible = "allwinner,sun7i-a20-mmc";
> > +	clocks = <&ccu CLK_BUS_MMC0>,
> > +		 <&ccu CLK_MMC0>,
> > +		 <&ccu CLK_MMC0_OUTPUT>,
> > +		 <&ccu CLK_MMC0_SAMPLE>;
> > +	clock-names = "ahb",
> > +		      "mmc",
> > +		      "output",
> > +		      "sample";
> 
> This applies even more here, since the MMC controllers also have
> different clock requirements.
> 
> So why can't we just leave the CCU, MMC and possibly the pinctrl nodes
> completely out of the shared h3-h5.dtsi and introduce them from scratch
> in the SoC specific .dtsi?
> 
> I think we still have enough identical nodes to justify this kind of
> .dtsi sharing.

We did it that way in the past in order to reduce the unneeded
duplication, but I can definitely understand your point. We'll wait
for the DT maintainers answer on this one.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/cafa1483/attachment.sig>
