From: varkabhadram@gmail.com (Varka Bhadram)
Date: Wed, 30 Jul 2014 16:07:14 +0530
Subject: [PATCH v4 1/6] rtc: sun6i: Add sun6i RTC driver
In-Reply-To: <CAGb2v641zgGuV7NZSXprNgMCKCzejCT6UZhBSw6SUyrL5Ar4LA@mail.gmail.com>
References: <1406535661-25072-1-git-send-email-wens@csie.org>
 <1406535661-25072-2-git-send-email-wens@csie.org>
 <20140730085713.GX3952@lukather>
 <CAGb2v641zgGuV7NZSXprNgMCKCzejCT6UZhBSw6SUyrL5Ar4LA@mail.gmail.com>
Message-ID: <53D8CADA.1010607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2014 03:03 PM, Chen-Yu Tsai wrote:
> Hi,
>
> On Wed, Jul 30, 2014 at 4:57 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Hi Chen-Yu,
>>
>> On Mon, Jul 28, 2014 at 04:20:56PM +0800, Chen-Yu Tsai wrote:
>>> This patch introduces the driver for the RTC in the Allwinner A31 and
>>> A23 SoCs.
>>>
>>> Unlike the RTC found in A10/A20 SoCs, which was part of the timer, the
>>> RTC in A31/A23 are a separate hardware block, which also contain a few
>>> controls for the RTC block hardware (a regulator and RTC block GPIO pin
>>> latches), while also having separate interrupts for the alarms.
>>>
>>> The hardware is different enough to make a different driver for it.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>   .../devicetree/bindings/rtc/sun6i-rtc.txt          |  17 +
>>>   drivers/rtc/Kconfig                                |   7 +
>>>   drivers/rtc/Makefile                               |   1 +
>>>   drivers/rtc/rtc-sun6i.c                            | 447 +++++++++++++++++++++
>>>   4 files changed, 472 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
>>>   create mode 100644 drivers/rtc/rtc-sun6i.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
>>> new file mode 100644
>>> index 0000000..b7fb7a8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
>>> @@ -0,0 +1,17 @@
>>> +* sun6i Real Time Clock
>>> +
>>> +RTC controller for the Allwinner A31
>>> +
>>> +Required properties:
>>> +- compatible : Should be "allwinner,sun6i-a31-rtc"
>>> +- reg                : physical base address of the controller and length of
>>> +               memory mapped region.
>>> +- interrupts : IRQ line for the RTC alarm 0.
>> Even if we're using only one interrupt in the code, the hardware has
>> two, so it would be great if you could ask for these two in the
>> bindings.
> Sure. It's just a minor change here and in the example:
>
> - interrupts : IRQ lines for the RTC alarm 0 and alarm 1, in that order.
>
> Varka, may I keep your Reviewed-by with the changes?

Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>

-- 
Regards,
Varka Bhadram.
