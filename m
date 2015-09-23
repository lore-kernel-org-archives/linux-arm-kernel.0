From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 23 Sep 2015 06:54:50 +0100
Subject: [RESEND PATCHv3] arm64: dts: Add base stratix 10 dtsi
In-Reply-To: <1442353625-4552-1-git-send-email-dinguyen@opensource.altera.com>
References: <1442353625-4552-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20150923055450.GA4883@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/ {
> +	compatible = "altr,socfpga-stratix10";
> +	#address-cells = <2>;
> +	#size-cells = <2>;

[...]

> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		device_type = "soc";
> +		interrupt-parent = <&intc>;

As far as I am aware, this requires a (non-empty) ranges property, given the
parent node has {address,size}-cells = <2>.

Does the kernel not complain currently?

Otherwise this looks OK to me. Please fix the rangers property and ask for this
to be taken via arm-soc. I note neither Arnd nor Olof are on Cc currently.

Thanks,
Mark.
