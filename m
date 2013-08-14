From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Aug 2013 17:38:02 -0500
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <2CD735CE-3FCF-4AB5-89C0-D813ECD19F11@codeaurora.org>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
 <2CD735CE-3FCF-4AB5-89C0-D813ECD19F11@codeaurora.org>
Message-ID: <520C06CA.3060406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 04:03 PM, Kumar Gala wrote:
> 
> On Jul 23, 2013, at 4:19 AM, Punit Agrawal wrote:
> 
>> The CCI PMU can profile bus transactions at the master and slave
>> interfaces of the CCI. The PMU can be used to observe an aggregated view
>> of the bus traffic between the various components connected to the CCI.
>>
>> Extend the existing CCI driver to support the PMU by registering a perf
>> backend for it.
>>
>> Document the device tree binding to describe the CCI PMU.
>>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Nicolas Pitre <nico@linaro.org>
>> Cc: Dave Martin <dave.martin@linaro.org>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Reviewed-by: Will Deacon <will.deacon@arm.com>
>> ---
>> Documentation/devicetree/bindings/arm/cci.txt |   38 ++
>> drivers/bus/arm-cci.c                         |  642 +++++++++++++++++++++++++
>> 2 files changed, 680 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
>> index 92d36e2..5bc95e5 100644
>> --- a/Documentation/devicetree/bindings/arm/cci.txt
>> +++ b/Documentation/devicetree/bindings/arm/cci.txt

[snip]

>> +
>> +		- interrupts:
>> +			Usage: required
>> +			Value type: <prop-encoded-array>
>> +			Definition: comma-separated list of unique PMU
>> +				    interrupts
> 
> What is the list of interrupts related to, should there be an associated interrupts-names

No, interrupt-names is optional, but you are correct that what function
each interrupt is for must be defined.

Rob
