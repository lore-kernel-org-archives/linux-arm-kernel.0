From: benoitm@perenite.com (Benoit Masson)
Date: Mon, 28 Jul 2014 01:35:35 +0200
Subject: [PATCH 2/2] V3 ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <20140727223258.36b050b9@free-electrons.com>
References: <1406418490-61502-1-git-send-email-yahoo@perenite.com>
 <20140727223258.36b050b9@free-electrons.com>
Message-ID: <C2BE2F4B-1045-484F-9E12-A757EE3CD1F6@perenite.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
Le 27 juil. 2014 ? 22:32, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> a ?crit :

> Dear Benoit Masson,
> 

Dear Thomas,

> On Sat, 26 Jul 2014 16:48:10 -0700, Benoit Masson wrote:
> 
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +		pinctrl-0 = <&power_button_pin &reset_button_pin
>> +			&select_button_pin &scroll_button_pin>;
>> +		pinctrl-names = "default";
>> +
>> +		power-button {
>> +			label = "Power Button";
>> +			linux,code = <KEY_POWER>;
>> +			gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
>> +		};
>> +
>> +		reset-button {
>> +			label = "Reset Button";
>> +			linux,code = <KEY_RESTART>;
>> +			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		select-button {
>> +			label = "Select Button";
>> +			linux,code = <BTN_SELECT>;
>> +			gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		scroll-button {
>> +			label = "Scroll Button";
>> +			linux,code = <KEY_SCROLLDOWN>;
>> +			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> 
> So you're using the GPIO_ACTIVE_<foo> defines here.
> 
>> +		};
>> +	};
>> +
>> +	spi3 {
>> +		compatible = "spi-gpio";
>> +		status = "okay";
>> +		gpio-sck = <&gpio0 25 0>;
>> +		gpio-mosi = <&gpio1 15 0>; /*gpio 47*/
>> +		cs-gpios = <&gpio0 27 0 >;
> 
> But not here. Any reason?

Indeed I think Jason made this comment already and I seem to have missed -> Corrected in V4

> 
> Also, nitpick: unneeded space in <&gpio0 27 0 > (i.e the space right
> before the closing >).
> 

-> Corrected in V4

>> +		num-chipselects = <1>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		gpio2: gpio2 at 0 {
>> +			compatible = "fairchild,74hc595";
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			reg = <0>;
>> +			registers-number = <2>;
>> +			spi-max-frequency = <100000>;
>> +		};
> 
> I'm not sure "gpio2" is a good name, as we might think of it as being
> the third GPIO controller internal to the SoC.
> 

Renamed to gpio_spi, tested ok  -> Corrected in V4

> Thanks,
> 

You're welcome, patch issued as V4 just now.

> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
