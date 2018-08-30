From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 30 Aug 2018 17:57:01 +0200
Subject: [PATCH mvebu-dt64] arm64: dts: marvell: armada-37xx: Add DTS
 file for Turris Mox
In-Reply-To: <20180830152326.15562-1-marek.behun@nic.cz>
References: <20180830152326.15562-1-marek.behun@nic.cz>
Message-ID: <20180830155701.GA31581@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	switch0 at 10 {
> +		compatible = "marvell,mv88e6190";
> +		reg = <0x10 0>;

MDO reg should have a single value, i think.

> +	switch0 at 2 {
> +		status = "disabled";
...
> +	};
> +
> +	switch1 at 11 {
> +		status = "disabled";
...
> +	};
> +
> +	switch1 at 2 {
> +		status = "disabled";
...
> +	};
> +
> +	switch2 at 12 {
> +		status = "disabled";
...
> +	};
> +
> +	switch2 at 2 {
> +		status = "disabled";
...
> +	};
> +};

I'm assuming the boatloader is probing the hardware, and then enabling
what it finds? This is a poor mans DT fragments. Lets see that Rob has
to say about this.

> +	moxtet at 1 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "cznic,moxtet";
> +		reg = <1>;
> +		devrst-gpio = <&gpiosb 2 GPIO_ACTIVE_LOW>;
> +		spi-max-frequency = <1000000>;
> +		spi-cpol;
> +		spi-cpha;
> +
> +		moxtet_sfp: moxtet-sfp at 0 {
> +			compatible = "cznic,moxtet-gpio";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			reg = <0>;
> +			moxtet,id = <1>;
> +			moxtet,input-mask = <0x7>;
> +			moxtet,output-mask = <0x3>;
> +			status = "disabled";
> +		};
> +	};
> +};

Have the drivers for this been merged yet?

     Andrew
