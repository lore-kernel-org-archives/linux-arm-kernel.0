From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 19 Oct 2016 10:20:59 +0530
Subject: [PATCH 4/9] regulator: lp873x: Add support for populating input
 supply
In-Reply-To: <20161018142743.xfgjuaw4wlssmoxq@rob-hp-laptop>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
 <20161014130033.14172-5-lokeshvutla@ti.com>
 <20161018142743.xfgjuaw4wlssmoxq@rob-hp-laptop>
Message-ID: <57988545-4319-0bcf-df1a-55c78111aa5b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 18 October 2016 07:57 PM, Rob Herring wrote:
> On Fri, Oct 14, 2016 at 06:30:28PM +0530, Lokesh Vutla wrote:
>> In order to have a proper topology of regulators for a platform, each
>> registering regulator needs to populate supply_name field for identifying
>> its supply's name. Add supply_name field for lp873x regulators.
>>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Keerthy <j-keerthy@ti.com>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/lp873x.txt | 8 ++++++++
>>  drivers/regulator/lp873x-regulator.c             | 1 +
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
>> index 52766c2..936cba3 100644
>> --- a/Documentation/devicetree/bindings/mfd/lp873x.txt
>> +++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
>> @@ -7,6 +7,9 @@ Required properties:
>>    - #gpio-cells:	Should be two.  The first cell is the pin number and
>>  			the second cell is used to specify flags.
>>  			See ../gpio/gpio.txt for more information.
>> +  - xxx-supply:		Phandle to parent supply node of each regulator
>> +			populated under regulators node. xxx should match
>> +			the supply_name populated in driver.
> 
> xxx-in-supply?

Oops. Right. Ill update it and repost.

Thanks and regards,
Lokesh
