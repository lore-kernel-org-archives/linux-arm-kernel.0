From: rjui@broadcom.com (Ray Jui)
Date: Mon, 8 Dec 2014 11:45:18 -0800
Subject: [PATCH v3 1/5] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <2129851.JzMQjVqeL2@wuerfel>
References: <1418064468-8512-3-git-send-email-rjui@broadcom.com>
 <2129851.JzMQjVqeL2@wuerfel>
Message-ID: <5485FFCE.9000009@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/8/2014 11:38 AM, Arnd Bergmann wrote:
> On Monday 08 December 2014 10:47:44 Ray Jui wrote:
>> +
>> +- no-drv-stregnth:
>> +    Specifies the GPIO controller does not support drive strength configuration
>> +
>>
>
> Typo:
>
> 	strength, not stregnth
>
> Otherwise looks good.
>
> 	Arnd
>
Right...Let me fix that. Also noticed the following in the device tree 
binding example that needs to be fixed:
	gpio_crmu: gpio at 03024800 {

		compatible = "brcm,cygnus-crmu-gpio";
The above line needs to be fixed with:
		compatible = "brcm,cygnus-gpio";

		reg = <0x03024800 0x50>;
		ngpios = <6>;
		#gpio-cells = <2>;
		gpio-controller;
		no-drv-stregnth;
	};
