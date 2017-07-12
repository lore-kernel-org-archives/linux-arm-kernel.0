From: s-anna@ti.com (Suman Anna)
Date: Wed, 12 Jul 2017 10:21:10 -0500
Subject: [PATCH] dt-bindings: clock: ti-sci: Fix incorrect usage of headers
In-Reply-To: <20170712010923.GP22780@codeaurora.org>
References: <20170711223615.29398-1-s-anna@ti.com>
 <20170712010923.GP22780@codeaurora.org>
Message-ID: <539129c3-8214-4e0d-0e97-7c6784a9b2b5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2017 08:09 PM, Stephen Boyd wrote:
> On 07/11, Suman Anna wrote:
>> The clock consumer usage description was erroneously referring to
>> couple of dt-binding headers that are no longer valid. The definition
>> and/or usage of these headers is incorrect and the only file present
>> at the moment, dt-bindings/soc/k2g.h is also being cleaned up. The
>> examples in this binding were updated properly, but the update to
>> description was missed out. So, fix this.
>>
>> Fixes: 8f306cfe4383 ("Documentation: dt: Add TI SCI clock driver")
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>> Hi Stephen,
>>
>> Looks like this was missed during the update/repost of the ti-sci-clk
>> driver/binding. FYI, Santosh is going to pickup the header file cleanup
>> patch https://patchwork.kernel.org/patch/9741279/ for the next merge
>> window.
> 
> I'll let Rob apply this as it is purely a binding document update.

OK, thanks.

> 
>>
>> regards
>> Suman
>>
>>  Documentation/devicetree/bindings/clock/ti,sci-clk.txt | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>> index 1e884c40ab50..4e59dc6b1778 100644
>> --- a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>> +++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>> @@ -14,10 +14,9 @@ Required properties:
>>  - compatible: Must be "ti,k2g-sci-clk"
>>  - #clock-cells: Shall be 2.
>>    In clock consumers, this cell represents the device ID and clock ID
>> -  exposed by the PM firmware. The assignments can be found in the header
>> -  files <dt-bindings/genpd/<soc>.h> (which covers the device IDs) and
>> -  <dt-bindings/clock/<soc>.h> (which covers the clock IDs), where <soc>
>> -  is the SoC involved, for example 'k2g'.
>> +  exposed by the PM firmware. The list of valid values for the device IDs
>> +  and clocks IDs for 66AK2G SoC are documented at
>> +  http://processors.wiki.ti.com/index.php/TISCI#66AK2G02_Data
>>  
> 
> I hope the weblink doesn't die in the future. Why can't we copy
> it into the binding document here for safe keeping?

Yeah, the weblink will be maintained, it explains our TI-SCI protocol
information and we also have couple more references to it. I don't think
the values themselves do not belong to any binding and they are specific
to each SoC. We have initially added them to dt-bindings header files,
but since those files are not really leveraged by any drivers and only
provided macro usage in DTS files, they are being cleaned up. DT nodes
will directly use the required values instead.

regards
Suman
