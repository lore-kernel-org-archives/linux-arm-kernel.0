From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 12 May 2014 11:06:07 +0200
Subject: [PATCH 1/2] ARM: at91: add PWM pinctrl to SAMA5D3
In-Reply-To: <20140510091017.GA22329@piout.net>
References: <a5a0a9b8090f80f40daf3a13849b3961d9d617d6.1399642907.git.nicolas.ferre@atmel.com>
 <20140510091017.GA22329@piout.net>
Message-ID: <53708EFF.1030604@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2014 11:10, Alexandre Belloni :
> Hi Nicolas,
> 
> On 09/05/2014 at 15:44:27 +0200, Nicolas Ferre wrote :
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  arch/arm/boot/dts/sama5d3.dtsi | 82 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 82 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
>> index 9caa06b3641e..ed7943745f23 100644
>> --- a/arch/arm/boot/dts/sama5d3.dtsi
>> +++ b/arch/arm/boot/dts/sama5d3.dtsi
>> @@ -583,6 +583,88 @@
>>  					};
>>  				};
>>  
>> +				pwm0 {
>> +					pinctrl_pwm0_pwmh0_0: pwm0_pwmh0-0 {
>> +						atmel,pins =
>> +							<AT91_PIOA 20 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PA20 periph B, conflicts with ISI_D4 and LCDDAT20 */
> 
> Didn't we decide at some point to stop adding comments for the pinctrl ?
> At least, I would say that "PA20 periph B" doesn't add any useful
> information.

Yes, we said that for the description and you are right saying that
saying again the pin configuration doesn't make sense. On the other
hand, I tend to like the "conflicts with ..." part of it (and it is
automatically generated).

So, should we keep this part?

>> +					};
>> +					pinctrl_pwm0_pwmh0_1: pwm0_pwmh0-1 {
>> +						atmel,pins =
>> +							<AT91_PIOB 0 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB0 periph B, conflicts with GTX0 */
>> +					};
>> +
>> +					pinctrl_pwm0_pwmh1_0: pwm0_pwmh1-0 {
>> +						atmel,pins =
>> +							<AT91_PIOA 22 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PA22 periph B, conflicts with ISI_D6 and LCDDAT22 */
>> +					};
>> +					pinctrl_pwm0_pwmh1_1: pwm0_pwmh1-1 {
>> +						atmel,pins =
>> +							<AT91_PIOB 4 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB4 periph B, conflicts with GRX0 */
>> +					};
>> +					pinctrl_pwm0_pwmh1_2: pwm0_pwmh1-2 {
>> +						atmel,pins =
>> +							<AT91_PIOB 27 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PB27 periph C, conflicts with G125CKO and RTS1 */
>> +					};
>> +
>> +					pinctrl_pwm0_pwmh2_0: pwm0_pwmh2-0 {
>> +						atmel,pins =
>> +							<AT91_PIOB 8 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB8 periph B, conflicts with GTXCK */
>> +					};
>> +					pinctrl_pwm0_pwmh2_1: pwm0_pwmh2-1 {
>> +						atmel,pins =
>> +							<AT91_PIOD 5 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PD5 periph C, conflicts with MCI0_DA4 and TIOA0 */
>> +					};
>> +
>> +					pinctrl_pwm0_pwmh3_0: pwm0_pwmh3-0 {
>> +						atmel,pins =
>> +							<AT91_PIOB 12 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB12 periph B, conflicts with GRXDV */
>> +					};
>> +					pinctrl_pwm0_pwmh3_1: pwm0_pwmh3-1 {
>> +						atmel,pins =
>> +							<AT91_PIOD 7 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PD7 periph C, conflicts with MCI0_DA6 and TCLK0 */
>> +					};
>> +
>> +					pinctrl_pwm0_pwml0_0: pwm0_pwml0-0 {
>> +						atmel,pins =
>> +							<AT91_PIOA 21 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PA21 periph B, conflicts with ISI_D5 and LCDDAT21 */
>> +					};
>> +					pinctrl_pwm0_pwml0_1: pwm0_pwml0-1 {
>> +						atmel,pins =
>> +							<AT91_PIOB 1 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB1 periph B, conflicts with GTX1 */
>> +					};
> 
> I would group pwm0_pwmhx and pwm0_pwmlx together.

Ah, ok, I can do this, sure.

> 
>> +
>> +					pinctrl_pwm0_pwml1_0: pwm0_pwml1-0 {
>> +						atmel,pins =
>> +							<AT91_PIOA 23 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PA23 periph B, conflicts with ISI_D7 and LCDDAT23 */
>> +					};
>> +					pinctrl_pwm0_pwml1_1: pwm0_pwml1-1 {
>> +						atmel,pins =
>> +							<AT91_PIOB 5 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB5 periph B, conflicts with GRX1 */
>> +					};
>> +					pinctrl_pwm0_pwml1_2: pwm0_pwml1-2 {
>> +						atmel,pins =
>> +							<AT91_PIOE 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PE31 periph B, conflicts with IRQ */
>> +					};
>> +
> 


-- 
Nicolas Ferre
