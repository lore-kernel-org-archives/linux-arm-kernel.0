From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 11 Jan 2014 00:04:34 +0100
Subject: [PATCH v5 4/4] i2c: mv64xxx: Document the newly introduced Armada
 XP A0 compatible
In-Reply-To: <20140110215526.GB19878@titan.lakedaemon.net>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-5-git-send-email-gregory.clement@free-electrons.com>
 <20140110215526.GB19878@titan.lakedaemon.net>
Message-ID: <52D07C82.2010106@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2014 22:55, Jason Cooper wrote:
> Gregory,
> 
> On Wed, Jan 08, 2014 at 04:06:29PM +0100, Gregory CLEMENT wrote:
>> The first variants of Armada XP SoCs (A0 stepping) have issues related
>> to the i2c controller which prevent to use the offload mechanism and
>> ead to a kernel hang during boot.
> 
> I'll fixup s/ead/lead/ here.
> 
>>
>> The commit introduces a new the compatible string
>> marvell,mv78230-a0-i2c for the i2c controller.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> cc: devicetree at vger.kernel.org
>> ---
>>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> index 82e8f6f17179..9410ed72ec45 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>> @@ -5,7 +5,7 @@ Required properties :
>>  
>>   - reg             : Offset and length of the register set for the device
>>   - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-i2c"
>> -                     or "marvell,mv78230-i2c"
>> +                     or "marvell,mv78230-i2c" or "marvell,mv78230-a0-i2c"
> 
> If it's ok with you Gregory, I'll amend this hunk as follows:
> 
> 			or "marvell,mv78230-i2c" or "marvell,mv78230-a0-i2c"
> 			Only use "marvell,mv78230-a0-i2c" for a very
> 			rare, initial version of the SoC which had
> 			broken offload support.  Linux auto-detects this
> 			and sets it appropriately.
> 
Hi Jason,

I agree with your changes

Thanks,

Gregory

> 
>>   - interrupts      : The interrupt number
>>  
>>  Optional properties :
>> -- 
>> 1.8.1.2
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
