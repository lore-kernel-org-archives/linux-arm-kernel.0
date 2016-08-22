From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 22 Aug 2016 13:34:12 +0300
Subject: [PATCH] ARM: dts: blanche: add DU support
In-Reply-To: <20160822074111.GE28034@verge.net.au>
References: <5383928.8UnDsUpmkz@wasted.cogentembedded.com>
 <1783132.r9t2y3QUUq@wasted.cogentembedded.com>
 <20160822074111.GE28034@verge.net.au>
Message-ID: <de79981f-9aff-5491-c97b-48542b860af2@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 8/22/2016 10:41 AM, Simon Horman wrote:

>> Define  the  Blanche board dependent part of the DU device node.
>> Add the device nodes for the  Analog Devices ADV7511W  HDMI transmitter
>> (connected to DU0) and ADV7123 video DAC (connected to DU1).  Add the
>> necessary subnodes to interconnect DU, HDMI/VDAC devices, and HDMI/VGA
>> connectors.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> This patch is against the 'renesas-devel-20160817-v4.8-rc2' of Simon Horman's
>> 'renesas.git' repo plus the general purpose switches patch and the SDHI0 patch
>> posted earlier.
>>
>>  arch/arm/boot/dts/r8a7792-blanche.dts |  125 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 125 insertions(+)
>>
>> Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
>> ===================================================================
>> --- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
>> +++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
>
> ...
>
>> @@ -186,3 +251,63 @@
>>  	cd-gpios = <&gpio11 11 GPIO_ACTIVE_LOW>;
>>  	status = "okay";
>>  };
>> +
>> +&i2c1 {
>> +	status = "okay";
>> +	clock-frequency = <400000>;
>
> Is it intentional that there are no pinctrl properties here?

    Yes, as I commented in r8a7792.dtsi, all I2C pins are not multiplexed.

MBR, Sergei
