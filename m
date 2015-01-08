From: wigyori@uid0.hu (Zoltan HERPAI)
Date: Thu, 8 Jan 2015 16:12:27 +0100 (CET)
Subject: [PATCH 1/1] ARM: dts: pcduino: Enable user LED and button support
 for pcDuino
In-Reply-To: <20150108135953.GU7853@lukather>
References: <1420709664-12687-1-git-send-email-wigyori@uid0.hu>
 <20150108135953.GU7853@lukather>
Message-ID: <alpine.DEB.2.02.1501081518370.29083@trabant.deployis.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thu, 8 Jan 2015, Maxime Ripard wrote:

>> +	gpio_keys {
>> +		compatible = "gpio-keys";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&key_pins_pcduino>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		button at 0 {
>> +			label = "Key Back";
>> +			linux,code = <KEY_BACK>;
>> +			gpios = <&pio 7 17 GPIO_ACTIVE_LOW>;
>> +		};
>> +		button at 1 {
>> +			label = "Key Home";
>> +			linux,code = <KEY_HOME>;
>> +			gpios = <&pio 7 18 GPIO_ACTIVE_LOW>;
>> +		};
>> +		button at 2 {
>> +			label = "Key Menu";
>> +			linux,code = <KEY_MENU>;
>> +			gpios = <&pio 7 19 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>
> Some newlines here would have been nice between the button nodes. I
> added them and applied the patch.

First I did it with newlines between the nodes, then spotted that many of 
the button specs in other DTSes are without them, so I just removed them. 
Thanks for applying anyway!

Regards,
Zoltan H
