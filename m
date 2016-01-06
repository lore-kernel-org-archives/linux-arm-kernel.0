From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 Jan 2016 15:05:31 +0100
Subject: [PATCH v4 2/3] ARM: dts: sun8i: Add Allwinner A83T dtsi
In-Reply-To: <20160106132505.GJ563@leverpostej>
References: <1452085914-29340-1-git-send-email-vishnupatekar0510@gmail.com>
 <1452085914-29340-3-git-send-email-vishnupatekar0510@gmail.com>
 <20160106132505.GJ563@leverpostej>
Message-ID: <20160106140531.GK11722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Jan 06, 2016 at 01:25:05PM +0000, Mark Rutland wrote:
> > +	clocks {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges;
> > +
> > +		osc24M: osc24M_clk {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <24000000>;
> > +			clock-output-names = "osc24M";
> > +		};
> > +
> > +		osc32k: osc32k_clk {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <32768>;
> > +			clock-output-names = "osc32k";
> > +		};
> > +	};
> 
> Just put the clocks under the root node. 'clocks' is not a special
> node.

No, it's not a special node, but it's a very convenient one. It avoids
"crippling" the main SoC definition with all the clocks definition,
and keep the noise relatively low.

And a bunch of other maintainers seem to agree:
$ git grep "clocks {"  -- arch/arm/boot/dts/ arch/arm64/boot/dts/ | wc -l
271

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160106/ea16b767/attachment.sig>
