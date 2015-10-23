From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 Oct 2015 20:14:06 +0200
Subject: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
Message-ID: <20151023181406.GK10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 06:20:27PM +0200, Jens Kuske wrote:
> +		bus_gates: clk at 01c20060 {
> +			#clock-cells = <1>;
> +			compatible = "allwinner,sun8i-h3-bus-gates-clk";
> +			reg = <0x01c20060 0x14>;
> +			clock-indices = <5>, <6>, <8>,
> +					<9>, <10>, <13>,
> +					<14>, <17>, <18>,
> +					<19>, <20>,
> +					<21>, <23>,
> +					<24>, <25>,
> +					<26>, <27>,
> +					<28>, <29>,
> +					<30>, <31>, <32>,
> +					<35>, <36>, <37>,
> +					<40>, <41>, <43>,
> +					<44>, <52>, <53>,
> +					<54>, <64>,
> +					<65>, <69>, <72>,
> +					<76>, <77>, <78>,
> +					<96>, <97>, <98>,
> +					<112>, <113>,
> +					<114>, <115>, <116>,
> +					<128>, <135>;
> +			clocks = <&ahb1>, <&ahb1>, <&ahb1>,
> +				 <&ahb1>, <&ahb1>, <&ahb1>,
> +				 <&ahb1>, <&ahb2>, <&ahb1>,
> +				 <&ahb1>, <&ahb1>,
> +				 <&ahb1>, <&ahb1>,
> +				 <&ahb1>, <&ahb1>,
> +				 <&ahb1>, <&ahb1>,
> +				 <&ahb1>, <&ahb2>,
> +				 <&ahb2>, <&ahb2>, <&ahb1>,
> +				 <&ahb1>, <&ahb1>, <&ahb1>,
> +				 <&ahb1>, <&ahb1>, <&ahb1>,
> +				 <&ahb1>, <&ahb1>, <&ahb1>,
> +				 <&ahb1>, <&apb1>,
> +				 <&apb1>, <&apb1>, <&apb1>,
> +				 <&apb1>, <&apb1>, <&apb1>,
> +				 <&apb2>, <&apb2>, <&apb2>,
> +				 <&apb2>, <&apb2>,
> +				 <&apb2>, <&apb2>, <&apb2>,
> +				 <&ahb1>, <&ahb1>;

This is not really what I had in mind...

This IP has 2 parents, and only two parents. The mapping between the
IPs should be done in the driver itself, not in the DT where it is
very error prone and barely readable.

And note that I never have expected you to use clk-simple-gates
either. This is a complicated clock, unlike the other we've seen so
far, it definitely deserves a driver of its own.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151023/9f0295df/attachment.sig>
