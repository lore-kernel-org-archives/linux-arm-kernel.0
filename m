From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 30 Oct 2015 02:40:04 +0000
Subject: [PATCH v5 07/14] arm64: renesas: salvator-x: Sound SSI PIO support
In-Reply-To: <1446161280-23097-8-git-send-email-horms+renesas@verge.net.au>
References: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
 <1446161280-23097-8-git-send-email-horms+renesas@verge.net.au>
Message-ID: <877fm5gk33.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

Thank you for your patch.

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch adds PIO sound support for Salvator-X board.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
(snip)
> +	cs2000: clk_multiplier at 4f {
> +		#clock-cells = <0>;
> +		compatible = "cirrus,cs2000-cp";
> +		reg = <0x4f>;
> +		clocks = <&rcar_sound 0>, <&x12_clk>;
> +		clock-names = "clk_in", "ref_clk";
> +		clock-frequency = <24576000>; /* 1/1 divide */
> +	};
> +};

I have posted this cs2000 driver to clk ML, but not yet accepted.
And new version can't use "clock-frequency".
Actually, Salvator-X sound can work without cs2000,
but it can be limited sound rate
Do you want to avoid cs2000 until it was accepted ?
Then, I can create and post whole patch set.
Or we can avoid sound support so far ?
