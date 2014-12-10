From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 10 Dec 2014 11:17:15 +0100
Subject: [PATCH 5/5] ARM: mvebu: Add Armada 385 Access Point Development
 Board support
In-Reply-To: <20141205170726.2e2335af@free-electrons.com>
References: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>	<1417790698-9792-6-git-send-email-maxime.ripard@free-electrons.com>
 <20141205170726.2e2335af@free-electrons.com>
Message-ID: <54881DAB.1080505@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

[...]

>> +		};
>> +
>> +		pcie-controller {
>> +			status = "okay";
>> +			/*
>> +			 * The two PCIe units are accessible through
>> +			 * standard PCIe slots on the board.
> 
> Two, or three ? :-)

Actually there are 3 PCIe units accessible through miniPCIe slots
and not standard PCIe slots.

> 
>> +			 */
>> +			pcie at 1,0 {
>> +				/* Port 0, Lane 0 */
>> +				status = "okay";
>> +			};
>> +
>> +			pcie at 2,0 {
>> +				/* Port 1, Lane 0 */
>> +				status = "okay";
>> +			};
>> +
>> +			pcie at 3,0 {
>> +				/* Port 2, Lane 0 */
>> +				status = "okay";
>> +			};
>> +		};
>> +	};
>> +
>> +	reg_xhci0_vbus: xhci0-vbus {
>> +		compatible = "regulator-fixed";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&xhci0_vbus_pins>;
>> +		regulator-name = "xhci0-vbus";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		enable-active-high;
>> +		regulator-always-on;
>> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
>> +	};
> 
> Maybe you could connect this to the USB controller by using the
> usb-nop-xceiv thing (which acts as a dummy USB PHY, if I understood
> correctly) ?
> 
> Thanks!
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
