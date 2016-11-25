From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Fri, 25 Nov 2016 16:05:03 +0800
Subject: [PATCH] reset: hisilicon: add a polarity cell for reset line
 specifier
In-Reply-To: <2281ff0d-2883-a78c-6106-f913da24581f@hisilicon.com>
References: <1479193794-18350-1-git-send-email-xuejiancheng@hisilicon.com>
 <1479206594.2456.24.camel@pengutronix.de>
 <db839cba-a105-fa8e-8633-c98999cd7316@hisilicon.com>
 <03bb74da-6b24-ee4c-307d-3b3f10ac2f7a@hisilicon.com>
 <2281ff0d-2883-a78c-6106-f913da24581f@hisilicon.com>
Message-ID: <d43d8f27-73da-6def-6e24-803ca24edfdb@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/11/25 11:45, Jiancheng Xue wrote:
> 
> On 2016/11/21 10:58, Jiancheng Xue wrote:
>> Hi Philipp,
>>
>>> On 2016/11/15 18:43, Philipp Zabel wrote:
>>>> Hi Jiancheng,
>>>>
>>>> Am Dienstag, den 15.11.2016, 15:09 +0800 schrieb Jiancheng Xue:
>>>>> Add a polarity cell for reset line specifier. If the reset line
>>>>> is asserted when the register bit is 1, the polarity is
>>>>> normal. Otherwise, it is inverted.
>>>>>
>>>>> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
>>>>> ---
>>> Thank you very much for replying so soon.
>>>
>>> Please allow me to decribe the reason why this patch exists first.
>>> All bits in the reset controller were designed to be active-high.
>>> But in a recent chip only one bit was implemented to be active-low :(
>>>
>>>>>  .../devicetree/bindings/clock/hisi-crg.txt         | 11 ++++---
>>>>>  arch/arm/boot/dts/hi3519.dtsi                      |  2 +-
>>>>>  drivers/clk/hisilicon/reset.c                      | 36 ++++++++++++++++------
>>>>>  3 files changed, 33 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/clock/hisi-crg.txt b/Documentation/devicetree/bindings/clock/hisi-crg.txt
>>>>> index e3919b6..fcbb4f3 100644
>>>>> --- a/Documentation/devicetree/bindings/clock/hisi-crg.txt
>>>>> +++ b/Documentation/devicetree/bindings/clock/hisi-crg.txt
>>>>> @@ -25,19 +25,20 @@ to specify the clock which they consume.
>>>>>  
>>>>>  All these identifier could be found in <dt-bindings/clock/hi3519-clock.h>.
>>>>>  
>>>>> -- #reset-cells: should be 2.
>>>>> +- #reset-cells: should be 3.
>>>>>  
>>>>>  A reset signal can be controlled by writing a bit register in the CRG module.
>>>>> -The reset specifier consists of two cells. The first cell represents the
>>>>> +The reset specifier consists of three cells. The first cell represents the
>>>>>  register offset relative to the base address. The second cell represents the
>>>>> -bit index in the register.
>>>>> +bit index in the register. The third cell represents the polarity of the reset
>>>>> +line (0 for normal, 1 for inverted).
>>>>
>> #reset-cells: Should be 2 if compatilbe string is "hisilicon,hi3519-crg". Should be 3 otherwise.
>> 	      A reset signal can be controlled by writing a bit register in the CRG module.
>> 	      The reset specifier consists of two or three cells. The first cell represents the
>> 	      register offset relative to the base address. The second cell represents the
>> 	      bit index in the register.The third cell represents the polarity of the reset
>> 	      line (0 for active-high, 1 for active-low).
>>
>> If I change the binding like this, can it be accepted?
>>
> Hi Philipp,
> 
> Could you give me more suggestions about this?  If you really don't like changing the
> reset-cells like this, I can modify the patch according to your suggestions.
> Thank you.
> 

I'll drop this patch and use "ti,syscon-reset" instead to resolve the polarity issue. Thanks.

Regards,
Jiancheng
