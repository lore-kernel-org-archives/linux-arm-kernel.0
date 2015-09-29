From: nitin.garg@freescale.com (Nitin Garg)
Date: Mon, 28 Sep 2015 19:17:12 -0500
Subject: [PATCH] ARM: dts: imx7d: Fix UART2 base address
In-Reply-To: <20150926050154.GF3529@tiger>
References: <1443122292-29385-1-git-send-email-festevam@gmail.com>
 <20150926050154.GF3529@tiger>
Message-ID: <5609D888.3080505@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2015 12:01 AM, Shawn Guo wrote:
> On Thu, Sep 24, 2015 at 04:18:12PM -0300, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> The UART2 memory space starts at address 0x30890000 (UART2_URXD).
>>
>> Fix it so that UART2 can be used.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Frank, can you confirm it?
> 
Shawn,
Yes, this change is correct. I confirmed in the SoC design db.

> Shawn
> 
>> ---
>>  arch/arm/boot/dts/imx7d.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
>> index 15c2193..9569d0a 100644
>> --- a/arch/arm/boot/dts/imx7d.dtsi
>> +++ b/arch/arm/boot/dts/imx7d.dtsi
>> @@ -640,10 +640,10 @@
>>  				status = "disabled";
>>  			};
>>  
>> -			uart2: serial at 30870000 {
>> +			uart2: serial at 30890000 {
>>  				compatible = "fsl,imx7d-uart",
>>  					     "fsl,imx6q-uart";
>> -				reg = <0x30870000 0x10000>;
>> +				reg = <0x30890000 0x10000>;
>>  				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
>>  				clocks = <&clks IMX7D_UART2_ROOT_CLK>,
>>  					<&clks IMX7D_UART2_ROOT_CLK>;
>> -- 
>> 1.9.1
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Regards,
Nitin
