From: rogerq@ti.com (Roger Quadros)
Date: Wed, 8 Jan 2014 15:42:58 +0530
Subject: [PATCH v4 1/5] mfd: omap-usb-host: Update DT clock binding
 information
In-Reply-To: <20140108095652.GD6701@e106331-lin.cambridge.arm.com>
References: <1389161742-10533-1-git-send-email-rogerq@ti.com>
 <1389161742-10533-2-git-send-email-rogerq@ti.com>
 <20140108095652.GD6701@e106331-lin.cambridge.arm.com>
Message-ID: <52CD24AA.8080605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 01/08/2014 03:26 PM, Mark Rutland wrote:
> On Wed, Jan 08, 2014 at 06:15:38AM +0000, Roger Quadros wrote:
>> The omap-usb-host driver expects the 60MHz functional clock
>> of the USB host module to be named as "init_60m_fclk".
>> Add this information in the DT binding document.
>>
>> CC: Lee Jones <lee.jones@linaro.org>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/omap-usb-host.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
>> index b381fa6..5635202 100644
>> --- a/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
>> +++ b/Documentation/devicetree/bindings/mfd/omap-usb-host.txt
>> @@ -32,6 +32,10 @@ Optional properties:
>>  - single-ulpi-bypass: Must be present if the controller contains a single
>>    ULPI bypass control bit. e.g. OMAP3 silicon <= ES2.1
>>  
>> +- clocks: phandle to 60MHz functional clock to the USB Host module.
>> +
>> +- clock-names: must be "init_60m_fclk"
>> +
> 
> Nit: clocks aren't just phandles, there's a clock-specifier too.
> 
> Also, it would be nicer if clocks was defined in terms of clock-names,
> as it makes the relationship between clocks and clock-names clear, and
> makes it easier to extend the list in future. Something like:
> 
> - clocks: a list of phandles + clock-specifiers, one for each entry in
>   clock-names
> 
> - clock-names: should include:
>   * "init_60m_fclk" - the 60MHz functional clock to the USB host module.
> 

OK, I'll update it as per your suggestion.

cheers,
-roger
