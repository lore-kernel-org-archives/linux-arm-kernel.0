From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Fri, 18 Nov 2011 08:49:01 +0100
Subject: [PATCH 18/41] ARM: restart: ixp4xx: use new restart hook
In-Reply-To: <20111117173027.GE9581@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 17 Nov 2011 17:30:27 +0000")
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6nE-0001Xl-8i@rmk-PC.arm.linux.org.uk>
 <20111117173027.GE9581@n2100.arm.linux.org.uk>
Message-ID: <m339dlsweq.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> Hook these platforms restart code into the new restart hook rather
>> than using arch_reset().

Looks good basically, except a detail:

>> --- a/arch/arm/mach-ixp4xx/common.c
>> +++ b/arch/arm/mach-ixp4xx/common.c
>> @@ -500,3 +500,23 @@ static void __init ixp4xx_clockevent_init(void)
>>  
>>  	clockevents_register_device(&clockevent_ixp4xx);
>>  }
>> +
>> +void ixp4xx_restart(char mode, const char *cmd)
>> +{
>> +	if ( 1 && mode == 's') {
           ^^^^^^^
This one. Yeah, I can see where does it come from.
Otherwise,
Acked-by: Krzysztof Ha?asa <khc@pm.waw.pl>

>> +		/* Jump into ROM at address 0 */
>> +		soft_restart(0);

OTOH I probably need to investigate this soft_restart, "when time
permits", that's another story of course.
-- 
Krzysztof Halasa
