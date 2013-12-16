From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 16 Dec 2013 10:51:18 +0000 (UTC)
Subject: [PATCHv10 22/41] ARM: dts: omap5 clock data
In-Reply-To: <1385453182-24421-23-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-23-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1312161046530.31680@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> This patch creates a unique node for each clock in the OMAP5 power,
> reset and clock manager (PRCM).

...

> +&cm_core_aon {
> +	pad_clks_src_ck: pad_clks_src_ck {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <12000000>;
> +	};
> +
> +	pad_clks_ck: pad_clks_ck {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&pad_clks_src_ck>;
> +		ti,bit-shift = <8>;
> +		reg = <0x0108>;
> +	};

All of the clock data should be underneath a "clocks {" node, for all of 
the chips.  Please see the Calxeda ECX clocks DT data as an example of how 
this should look:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/ecx-common.dtsi#n141


- Paul
