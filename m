From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 06 Jan 2012 14:37:41 +0100
Subject: [PATCH v3] ARM: at91: pit add DT support
In-Reply-To: <20120105180028.GB22653@ponder.secretlab.ca>
References: <1325771308-19770-1-git-send-email-nicolas.ferre@atmel.com>
 <1325784348-29481-1-git-send-email-nicolas.ferre@atmel.com>
 <20120105180028.GB22653@ponder.secretlab.ca>
Message-ID: <4F06F925.1030204@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2012 07:00 PM, Grant Likely :
> On Thu, Jan 05, 2012 at 06:25:48PM +0100, Nicolas Ferre wrote:
>> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>
>> Retreive registers address and IRQ from device tree entry. Fall back
>> to built-in values if an error occurs.
>>
>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> [nicolas.ferre at atmel.com: change error path and interrupts property handling]
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>> v3: - use irq_of_parse_and_map() for handling irq numbers specified by DT.
>>       Correction proposed by Jamie Iles.
>>
>> v2: - new specification of irq numbers in DT (due to modification of AIC code)
>>     - new error path in of_at91sam926x_pit_init()
>>     - fall back to built-in values if an error occurs
>>     - use of of_property_read_u32() to get irq property
>>
>>  .../devicetree/bindings/arm/atmel-at91.txt         |    8 +++
>>  arch/arm/boot/dts/at91sam9g20.dtsi                 |    5 ++
>>  arch/arm/boot/dts/at91sam9g45.dtsi                 |    6 ++
>>  arch/arm/mach-at91/at91sam926x_time.c              |   53 +++++++++++++++++++-
>>  4 files changed, 70 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt

[..]

>> --- a/arch/arm/mach-at91/at91sam926x_time.c
>> +++ b/arch/arm/mach-at91/at91sam926x_time.c

[..]

>> +	/* Get the interrupts property */
>> +	ret = irq_of_parse_and_map(np, 0);
>> +	if (ret <= 0)
>> +		goto ioremap_err;
> 
> if (!ret)
> 
> The DT irq functions return 0 on failure.

Ok, modified in new revision.

Best regards,
-- 
Nicolas Ferre
