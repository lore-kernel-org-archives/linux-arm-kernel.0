From: jason77.wang@gmail.com (Hui Wang)
Date: Thu, 16 Aug 2012 14:53:23 +0800
Subject: [PATCH v3 3/3] ARM: dts: imx6q-sabrelite: add eeti egalax
In-Reply-To: <20120815130108.GB2258@S2101-09.ap.freescale.net>
References: <1345026708-14139-1-git-send-email-jason77.wang@gmail.com>
 <1345026708-14139-2-git-send-email-jason77.wang@gmail.com>
 <1345026708-14139-3-git-send-email-jason77.wang@gmail.com>
 <1345026708-14139-4-git-send-email-jason77.wang@gmail.com>
 <20120815130108.GB2258@S2101-09.ap.freescale.net>
Message-ID: <502C98E3.5080306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> On Wed, Aug 15, 2012 at 06:31:48PM +0800, Hui Wang wrote:
>   
>> i.MX6Q sabrelite board uses i2c3 to connect an eeti egalax
>> touchscreen controller, add it as an i2c slave device in the dts.
>>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>> ---
>>  arch/arm/boot/dts/imx6q-sabrelite.dts |   16 ++++++++++++++++
>>  arch/arm/boot/dts/imx6q.dtsi          |    7 +++++++
>>  2 files changed, 23 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
>> index 72f30f3..4a68e1f 100644
>> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
>> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
>> @@ -54,6 +54,7 @@
>>  							   144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
>>  							   121  0x80000000	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
>>  							   953  0x80000000	/* MX6Q_PAD_GPIO_0__CCM_CLKO */
>> +							   972  0x10		/* MX6Q_PAD_GPIO_9__GPIO_1_9 */
>>  							   >;
>>  					};
>>  				};
>> @@ -115,6 +116,21 @@
>>  					VDDIO-supply = <&reg_3p3v>;
>>  				};
>>  			};
>> +
>> +			i2c at 021a8000 { /* I2C3 */
>> +				status = "okay";
>> +				clock-frequency = <100000>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&pinctrl_i2c3_1>;
>> +
>> +				egalax_ts at 04 {
>> +					compatible = "eeti,egalax_ts";
>> +					reg = <0x04>;
>> +					interrupt-parent = <&gpio1>;
>> +					interrupts = <9 2>;
>>     
>
> So you take this interrupt as falling-edge, while I see IRQF_TRIGGER_LOW
> is used in driver with request_threaded_irq call.
>
> Regards,
> Shawn
>
>   
Yes, you are right. Should be 8 instead of 2.

Regards,
Hui.
