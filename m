From: mturquette@ti.com (Turquette, Mike)
Date: Thu, 19 Apr 2012 13:01:15 -0700
Subject: [PATCH 1/4] clk: select CLKDEV_LOOKUP for COMMON_CLK
In-Reply-To: <4F902858.9040905@gmail.com>
References: <1334003101-17274-1-git-send-email-robherring2@gmail.com>
 <1334003101-17274-2-git-send-email-robherring2@gmail.com>
 <CAJOA=zMPqiH2fQJ5JWJ=COnju7Cmur6J2ATYUTcx41C4WMjFQQ@mail.gmail.com>
 <20120418070721.GL3852@pengutronix.de> <4F902858.9040905@gmail.com>
Message-ID: <CAJOA=zNwueCeSjT2F-M1+Ffu49t5tMBow=8baGrvZdGjrUCMrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 7:59 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 04/18/2012 02:07 AM, Sascha Hauer wrote:
>> On Tue, Apr 17, 2012 at 03:13:49PM -0700, Turquette, Mike wrote:
>>> On Mon, Apr 9, 2012 at 1:24 PM, Rob Herring <robherring2@gmail.com> wrote:
>>>> From: Rob Herring <rob.herring@calxeda.com>
>>>>
>>>> Using the common clock infrastructure without the common clkdev code makes
>>>> little sense, so select CLKDEV_LOOKUP for COMMON_CLK.
>>>>
>>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>>>> ---
>>>> ?drivers/clk/Kconfig | ? ?1 +
>>>> ?1 files changed, 1 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
>>>> index 165e1fe..f05a60d 100644
>>>> --- a/drivers/clk/Kconfig
>>>> +++ b/drivers/clk/Kconfig
>>>> @@ -12,6 +12,7 @@ config HAVE_MACH_CLKDEV
>>>> ?config COMMON_CLK
>>>> ? ? ? ?bool
>>>> ? ? ? ?select HAVE_CLK_PREPARE
>>>> + ? ? ? select CLKDEV_LOOKUP
>>>> ? ? ? ?---help---
>>>> ? ? ? ? ?The common clock framework is a single definition of struct
>>>> ? ? ? ? ?clk, useful across many platforms, as well as an
>>>
>>> Hi Rob,
>>>
>>> I agree that the common clk framework is not particularly useful
>>> without clkdev. ?However the core code has no dependency on clkdev.
>>> Why not just select it from an arch Kconfig, or even make it a
>>> dependency based on your own platform clock data/code?
>>
>> Selecting it from COMMON_CLK means that the compiler/linker will point
>> everybody trying to implement it without CLKDEV into the right
>> direction.
>
> Right. That was part of my rationale as well.
>
> The DT clock support is dependent on both options, so without this patch
> we'll have to add an otherwise unneeded OF_CLOCK option to select both.

Ok.  I'll take this into my -next branch.

Thanks,
Mike
