From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Aug 2015 18:23:08 +0100
Subject: [PATCHv2] arm64: dts: Add base stratix 10 dtsi
In-Reply-To: <1439308127-7412-1-git-send-email-dinguyen@opensource.altera.com>
References: <1439308127-7412-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20150820172308.GA2711@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> +/ {
> +	compatible = "altr,socfpga-stratix10";
> +	#address-cells = <1>;
> +	#size-cells = <1>;

I would recommend that you make your root #address-cells and #size-cells equal
to 2, as that will simplify matters later if/when you need to add anything
beyond the first 4GB for some particular board.

If everything in the SoC falls within the first 4GB you can have a ranges
property on your /soc node and have only one cell below that.

[...]

> +	intc: intc at ffff8000 {

The unit-address doesn't match the first address in the reg entry.

> +		compatible = "arm,gic-400", "arm,cortex-a15-gic";
> +		#interrupt-cells = <3>;
> +		interrupt-controller;
> +		reg = <0x0 0xffff9000 0x1000>,
> +		      <0x0 0xffffa000 0x2000>,
> +		      <0x0 0xffffc000 0x1000>,
> +		      <0x0 0xffffd000 0x1000>;
> +	};

Shouldn't the virtual CPU interface also be 0x2000 long?

Mark.
