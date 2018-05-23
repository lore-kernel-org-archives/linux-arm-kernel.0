From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 23 May 2018 12:29:50 -0700
Subject: [PATCH 1/5] Documentation: DT: Add optional 'timeout-sec'
 property for sp805
In-Reply-To: <20180523185944.GA9989@rob-hp-laptop>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-2-git-send-email-ray.jui@broadcom.com>
 <af81ea74-fb80-11e2-7bdc-d3607bdbd46b@arm.com>
 <c542388f-e417-f624-ade1-95f9a2fc8a3b@broadcom.com>
 <20180523185944.GA9989@rob-hp-laptop>
Message-ID: <4b0ec4ab-2d9e-1e4b-e294-c175805f4013@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 5/23/2018 11:59 AM, Rob Herring wrote:
> On Wed, May 23, 2018 at 09:25:49AM -0700, Ray Jui wrote:
>>
>>
>> On 5/23/2018 3:57 AM, Robin Murphy wrote:
>>> On 22/05/18 19:47, Ray Jui wrote:
>>>> Update the SP805 binding document to add optional 'timeout-sec'
>>>> devicetree property
>>>>
>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>> ---
>>>>  ? Documentation/devicetree/bindings/watchdog/sp805-wdt.txt | 2 ++
>>>>  ? 1 file changed, 2 insertions(+)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>> b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>> index edc4f0e..f898a86 100644
>>>> --- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>> +++ b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
>>>> @@ -19,6 +19,8 @@ Required properties:
>>>>  ? Optional properties:
>>>>  ? - interrupts : Should specify WDT interrupt number.
>>>> +- timeout-sec : Should specify default WDT timeout in seconds. If
>>>> unset, the
>>>> +??????????????? default timeout is 30 seconds
>>>
>>> According to the SP805 TRM, the default interval is dependent on the
>>> rate of WDOGCLK, but would typically be a lot longer than that :/
>>>
>>> On a related note, anyone have any idea why we seem to have two subtly
>>> different SP805 bindings defined?
> 
> Sigh.
> 
>> Interesting, I did not even know that until you pointed this out (and it's
>> funny that I found that I actually reviewed arm,sp805.txt internally in
>> Broadcom code review).
>>
>> It looks like one was done by Bhupesh Sharma (sp805-wdt.txt) and the other
>> was done by Anup Patel (arm,sp805.txt). Both were merged at the same time
>> around March 20, 2016: 915c56bc01d6. I'd assume both were sent out at around
>> the same time.
>>
>> It sounds like we should definitely remove one of them. Given that
>> sp805-wdt.txt appears to have more detailed descriptions on the use of the
>> clocks, should we remove arm,sp805.txt?
> 
> Take whichever text you like, but I prefer filenames using the
> compatible string and the correct string is 'arm,sp805' because '-wdt'
> is redundant. You can probably safely just update all the dts files with
> 'arm,sp805' and just remove 'arm,sp805-wdt' because it is not actually
> used (as the ID registers are).

Okay. I'll consolidate everything into arm,sp805.txt. Will also fix all 
DTS files to use "arm,sp805". The fix for actual DTS files will be in a 
different patch series.

> 
> Rob
> 
