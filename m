From: nm@ti.com (Nishanth Menon)
Date: Wed, 16 Oct 2013 07:58:57 -0500
Subject: [PATCH] ARM: dts: OMAP5: Add i2c aliases
In-Reply-To: <525E7A86.4090507@ti.com>
References: <1381856405-30970-1-git-send-email-nm@ti.com>
 <525E7A86.4090507@ti.com>
Message-ID: <525E8D91.5090400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2013 06:37 AM, Rajendra Nayak wrote:
> On Tuesday 15 October 2013 10:30 PM, Nishanth Menon wrote:
>> Currently, i2c1 and i2c5 defer probe due to pinctrl dependencies.
>> This changes the i2c ID each bus is registered with in i2c-dev
>> interface.
>>
>> As a result of this, many userspace tools break and there is no
>> consistent manner to fix the same if the i2c dev interface have no
>> consistent numbering. Provide alias to allow ordering the i2c devices
>> correctly.
> 
> This looks good Nishanth. Shouldn't we just go ahead and fix these for
> all OMAPs/AMxx devices which would have the same problem as OMAP5 ;)

yes ofcourse. i can do a couple of patches:
1 - for all OMAPs
2 - for all AM platforms.

> 
> Acked-by: Rajendra Nayak <rnayak@ti.com> 
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>
>>  arch/arm/boot/dts/omap5.dtsi |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index e18ee7e..8970deb 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -21,6 +21,11 @@
>>  	interrupt-parent = <&gic>;
>>  
>>  	aliases {
>> +		i2c0 = &i2c1;
>> +		i2c1 = &i2c2;
>> +		i2c2 = &i2c3;
>> +		i2c3 = &i2c4;
>> +		i2c4 = &i2c5;
>>  		serial0 = &uart1;
>>  		serial1 = &uart2;
>>  		serial2 = &uart3;
>>
> 


-- 
Regards,
Nishanth Menon
