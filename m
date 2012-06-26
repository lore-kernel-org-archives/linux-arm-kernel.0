From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jun 2012 11:42:44 +0200
Subject: [PATCH 1/2] ARM:MX28: Add additionnal muxing options to iMX28 DTSI
In-Reply-To: <20120625155047.GD2342@S2101-09.ap.freescale.net>
References: <1340356494-24664-1-git-send-email-maxime.ripard@free-electrons.com>
 <1340356494-24664-2-git-send-email-maxime.ripard@free-electrons.com>
 <20120625155047.GD2342@S2101-09.ap.freescale.net>
Message-ID: <4FE98414.4070903@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 25/06/2012 17:50, Shawn Guo a ?crit :
> Suggested subject prefix "ARM: dts: imx28: ..."

Ok.

> On Fri, Jun 22, 2012 at 11:14:53AM +0200, Maxime Ripard wrote:
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/imx28.dtsi |   19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
>> index 4634cb8..babc604 100644
>> --- a/arch/arm/boot/dts/imx28.dtsi
>> +++ b/arch/arm/boot/dts/imx28.dtsi
>> @@ -159,7 +159,7 @@
>>  					#interrupt-cells = <2>;
>>  				};
>>  
>> -				duart_pins_a: duart at 0 {
>> +				duart_pins_a: duart-a at 0 {
> 
> Leave this line unchanged ...
> 
>>  					reg = <0>;
>>  					fsl,pinmux-ids = <0x3102 0x3112>;
>>  					fsl,drive-strength = <0>;
>> @@ -167,6 +167,14 @@
>>  					fsl,pull-up = <0>;
>>  				};
>>  
>> +				duart_pins_b: duart-b at 0 {
>> +					reg = <0>;
> 
> ... and have the new mux option for duart like
> 
> 				duart_pins_b: duart at 1 {
> 					reg = <1>;
> 
> then, pinctrl system will be able to report there are 2 pin groups for
> function "duart" in debugfs.

Ok.

I have two questions here though.

First, I'm worrying a bit about the fact that the duart_pins_b is
actually the first pin groups in the muxing selection register by index,
before duart_pins_a. It's a bit confusing, but it would imply that we
would need to rename duart_pins_a to duart_pins_b, and change all the
references to it as well, but I can definitely send a patch for it. What
is your opinion ?

Secondly, why do we need to change the reg field as well ?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
