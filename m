From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 6 Jun 2016 16:45:22 +0800
Subject: [PATCH V2 3/4] ARM: mxs: dts: Add Creative X-Fi3 support
In-Reply-To: <1462740621-7557-3-git-send-email-marex@denx.de>
References: <1462740621-7557-1-git-send-email-marex@denx.de>
 <1462740621-7557-3-git-send-email-marex@denx.de>
Message-ID: <20160606084521.GA25155@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 08, 2016 at 10:50:20PM +0200, Marek Vasut wrote:
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_vddio_sd0: vddio-sd0 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "vddio-sd0";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio0 7 0>;
> +		};
> +	};

For new dts, we suggest put fixed regulator node directly under root in
the following naming scheme:

	reg_xxx: regulator-xxx {
		...
	};

Also, the order of subject prefix is like ARM: dts: mxs: ...

Shawn
