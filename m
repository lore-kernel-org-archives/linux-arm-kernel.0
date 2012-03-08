From: robherring2@gmail.com (Rob Herring)
Date: Thu, 08 Mar 2012 14:36:05 -0600
Subject: [PATCH 5/5 v3] ARM: at91: sam9x5 add i2c DT support
In-Reply-To: <20120308175204.GJ27213@game.jcrosoft.org>
References: <1331196635-27203-1-git-send-email-plagnioj@jcrosoft.com>
 <1331196635-27203-5-git-send-email-plagnioj@jcrosoft.com>
 <4F58E87D.9040701@gmail.com> <20120308175204.GJ27213@game.jcrosoft.org>
Message-ID: <4F591835.5040702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2012 11:52 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:12 Thu 08 Mar     , Rob Herring wrote:
>> On 03/08/2012 02:50 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> For now on use i2c-gpio driver on the same pin as the hardware IP.
>>>
>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>> Cc: devicetree-discuss at lists.ozlabs.org
>>> ---
>>> v3:
>>>
>>> 	update i2c binding (Rob comments)
>>>
>>> Best Regards,
>>> J.
>>>  arch/arm/boot/dts/at91sam9x5.dtsi |   39 +++++++++++++++++++++++++++++++++++++
>>>  1 files changed, 39 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
>>> index c294657..fdd1ac6 100644
>>> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
>>> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
>>> @@ -188,4 +188,43 @@
>>>  			status = "disabled";
>>>  		};
>>>  	};
>>> +
>>> +	i2c-gpio at 0 {
>>> +		compatible = "i2c-gpio";
>>> +		gpios = <&pioA 30 0 /* sda */
>>> +			 &pioA 31 0 /* scl */
>>> +			>;
>>> +		i2c-gpio,sda-open-drain;
>>> +		i2c-gpio,scl-open-drain;
>>> +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +		status = "disabled";
>>> +	};
>>> +
>>> +	i2c-gpio at 1 {
>>> +		compatible = "i2c-gpio";
>>> +		gpios = <&pioC 0 0 /* sda */
>>> +			 &pioC 1 0 /* scl */
>>> +			>;
>>> +		i2c-gpio,sda-open-drain;
>>> +		i2c-gpio,scl-open-drain;
>>> +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +		status = "disabled";
>>> +	};
>>> +
>>> +	i2c-gpio at 2 {
>>> +		compatible = "i2c-gpio";
>>> +		gpios = <&pioB 4 0 /* sda */
>>> +			 &pioB 5 0 /* scl */
>>> +			>;
>>> +		i2c-gpio,sda-open-drain;
>>> +		i2c-gpio,scl-open-drain;
>>> +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +		status = "disabled";
>>> +	};
>>
>> If these are just any random gpio lines, it seems strange to define
>> these in a SOC dtsi and then disable them.
> they are not, they are the same pin as the i2c hardware IP.
> 
> Today the hw driver is not ready or will not work correctly (IP issue)
> 
> On hardware design we use the I2C pin but can not use the hw driver
> 

Okay. Then other than the i2c-gpio node name, ack for all of these.

Rob
