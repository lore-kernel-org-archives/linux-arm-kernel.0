From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Nov 2012 22:52:23 +0100
Subject: [PATCH 6/7] ARM: dove: switch to DT clock providers
In-Reply-To: <1353014906-31566-7-git-send-email-andrew@lunn.ch>
References: <1353014906-31566-1-git-send-email-andrew@lunn.ch>
 <1353014906-31566-7-git-send-email-andrew@lunn.ch>
Message-ID: <20121115225223.1ceebfe5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 15 Nov 2012 22:28:25 +0100, Andrew Lunn wrote:

> +		core_clk: core-clocks at d0214 {
> +			compatible = "marvell,dove-core-clocks";
> +			reg = <0xd0214 0x4>;
> +			#clock-cells = <1>;
> +		};
> +
> +		clk_gate: clock-gating-control at d0038 {
> +			compatible = "marvell,dove-clock-gating";
> +			reg = <0xd0038 0x4>;
> +			clocks = <&core_clk 0>;
> +			#clock-cells = <1>;
> +		};

I'm nitpicking maybe, but names lack a bit of coherency here:

	core_clk vs. clk_gate
	marvell,dove-core-clocks vs. marvell,dove-clock-gating

Maybe:

	core_clk / gate_clk
	marvell,dove-core-clocks / marvell,dove-gating-clocks

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
