From: joelf@ti.com (Joel Fernandes)
Date: Mon, 28 Apr 2014 11:38:33 -0500
Subject: [PATCH 07/10] ARM: dts: DRA7: Add DT node for DES IP
In-Reply-To: <535BE096.2060407@cogentembedded.com>
References: <1398466968-29506-1-git-send-email-joelf@ti.com>
 <1398466968-29506-8-git-send-email-joelf@ti.com>
 <535BE096.2060407@cogentembedded.com>
Message-ID: <535E8409.10905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2014 11:36 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 26-04-2014 3:02, Joel Fernandes wrote:
> 
>> DRA7xx SoCs have a DES3DES IP. Add DT data for the same.
> 
>> Signed-off-by: Joel Fernandes <joelf@ti.com>
>> ---
>>   arch/arm/boot/dts/dra7.dtsi |   11 +++++++++++
>>   1 file changed, 11 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 1c0f8e1..0533b89 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -789,6 +789,17 @@
>>               dma-names = "tx0", "rx0";
>>               status = "disabled";
>>           };
>> +
>> +        des: des at 480a5000 {
> 
>    Shouldn't the node name be "crypto at 480a5000", according to the ePAPR
> standard?
> 
Actually I'm not a big fan of the standard here in this regard.
"crypto at 480a5000" doesn't mean anything and serves no purpose for
anyone. There are quite a few crypto modules and such a name doesn't
help and is confusing at best.

There's no property either in the device tree node itself to describe it
as des, except for the phandle label which is used only at dt
compile-time if I'm right. So makes sense to have the name be more specific.

This is how we have added dts nodes for other crypto modules in the past...

thanks,
 -Joel
