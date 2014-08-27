From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Aug 2014 13:32:20 +0200
Subject: [PATCH 12/14] arm64: dts: add Exynos7 based Espresso board dts
 file
In-Reply-To: <1409132660-1898-4-git-send-email-ch.naveen@samsung.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-4-git-send-email-ch.naveen@samsung.com>
Message-ID: <53FDC1C4.2010201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naveen,

Please see my comments inline.

On 27.08.2014 11:44, Naveen Krishna Chatradhi wrote:
> This patch adds initial dts file for the Espresso board
> based on Exynos7 from Samsung.

[snip]

> +	mmc at 15740000 {

Please migrate this dts file to the reference-based syntax.

> +		status = "okay";
> +		num-slots = <1>;
> +		broken-cd;
> +		caps2-mmc-hs200-1_8v;
> +		supports-highspeed;
> +		non-removable;
> +		card-detect-delay = <200>;
> +		clock-frequency = <800000000>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <0 4>;
> +		samsung,dw-mshc-ddr-timing = <0 2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_rdqs &sd0_bus1 &sd0_bus4 &sd0_bus8>;
> +		bus-width = <8>;
> +
> +		slot at 0 {
> +			reg = <0>;
> +			bus-width = <8>;

Why is bus-width repeated?

Best regards,
Tomasz
