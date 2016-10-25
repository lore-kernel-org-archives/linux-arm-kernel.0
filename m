From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 25 Oct 2016 18:21:42 +0200
Subject: [PATCH/RFT v2 11/17] USB: OHCI: make ohci-da8xx a separate driver
In-Reply-To: <21019d11-3b01-3e0e-60bc-c4873cf20237@lechnology.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-12-ahaslam@baylibre.com>
 <403743d8-dff2-3389-105b-1082b674b0b8@lechnology.com>
 <CAKXjFTPvEXPRyq0HZiF7mcHWFaFoH7MjFqEKnTyuSCUOB=U7Aw@mail.gmail.com>
 <21019d11-3b01-3e0e-60bc-c4873cf20237@lechnology.com>
Message-ID: <CAKXjFTM8RwsAut8cD0n0foxueSjR4VB4k4WJizXo9SyaW3viOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 6:12 PM, David Lechner <david@lechnology.com> wrote:
> On 10/25/2016 02:39 AM, Axel Haslam wrote:
>>
>> On Tue, Oct 25, 2016 at 2:38 AM, David Lechner <david@lechnology.com>
>> wrote:
>>>
>>> On 10/24/2016 11:46 AM, ahaslam at baylibre.com wrote:
>>>>
>>>>
>>>> -#ifndef CONFIG_ARCH_DAVINCI_DA8XX
>>>> -#error "This file is DA8xx bus glue.  Define
>>>> CONFIG_ARCH_DAVINCI_DA8XX."
>>>> -#endif
>>>> +#include "ohci.h"
>>>> +
>>>> +#define DRIVER_DESC "OHCI DA8XX driver"
>>>> +
>>>> +static const char hcd_name[] = "ohci-da8xx";
>>>
>>>
>>>
>>> why static const char instead of #define? This is only used one time in a
>>> pr_info, so it seems kind of pointless anyway.
>>
>>
>> Other drivers are using static const for the same variable.
>> i think static const is preferred over #define because #define doet give a
>> type.
>> If you dont mind ill keep it static const.
>>
>
> If this string was used in this file more than one place, I would agree with
> you, but currently it is only used as the argument of a pr_info(). The
> string "ohci-da8xx" could just be included in the fmt string instead of
> using "%s".

I think the purpose was to use it in the .name of the platform_driver
structure, too. only that not everybody is doing that, i looked at some bad
 examples :(

would you agree to keep it if we use it in .name too?

-Axel

>
