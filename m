From: dong.aisheng@linaro.org (Dong Aisheng)
Date: Wed, 15 Aug 2012 12:00:42 +0800
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <502A9476.1040500@boundarydevices.com>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <502954D2.908@boundarydevices.com>
 <CAP1dx+wm=Lj6WXWTiRk3JfqAomr8_mfjZpmToht2bb4paEYXjQ@mail.gmail.com>
 <502A9476.1040500@boundarydevices.com>
Message-ID: <CAP1dx+xGbnnU-+uQ7BPpzXEgpE50_xC9v8ZsmkfmxDmqC168Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2012 02:09, Troy Kisky <troy.kisky@boundarydevices.com> wrote:
> On 8/14/2012 12:30 AM, Dong Aisheng wrote:
>>
>> On 14 August 2012 03:26, Troy Kisky <troy.kisky@boundarydevices.com>
>> wrote:
>>>
>>> On 8/13/2012 7:47 AM, Shawn Guo wrote:
>>>>
>>>> Unlike imx6q pinctrl driver that starts nubmering pad from 0, imx5
>>>> pinctrl drivers number pad from 1.  It causes problem/confusion when
>>>> driver accesses imx51_pinctrl_pads array using pin ID as the index.
>>>>
>>>> Change imx51_pads and imx53_pads numbering start from 0.
>>>>
>>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>>> ---
>>>>    drivers/pinctrl/pinctrl-imx51.c |  490
>>>> +++++++++++++++++++-------------------
>>>>    drivers/pinctrl/pinctrl-imx53.c |  402
>>>> ++++++++++++++++----------------
>>>>    2 files changed, 446 insertions(+), 446 deletions(-)
>>>>
>>>> diff --git a/drivers/pinctrl/pinctrl-imx51.c
>>>> b/drivers/pinctrl/pinctrl-imx51.c
>>>> index 9fd0216..fb84689 100644
>>>> --- a/drivers/pinctrl/pinctrl-imx51.c
>>>> +++ b/drivers/pinctrl/pinctrl-imx51.c
>>>> @@ -23,251 +23,251 @@
>>>>    #include "pinctrl-imx.h"
>>>>      enum imx51_pads {
>>>> -       MX51_PAD_EIM_D16 = 1,
>>>> -       MX51_PAD_EIM_D17 = 2,
>>
>> ...
>>>>
>>>> +       MX53_PAD_GPIO_19 = 0,
>>>> +       MX53_PAD_KEY_COL0 = 1,
>>>
>>>
>>> Why not skip the = xx altogether??  The enum will auto-increment.
>>
>> Personally i'd like to keep it.
>> The reason is that pin id is basic property of a pin per pinctrl
>> subsystem's design
>> so explicitly define it looks more clear to me and i'm not sure but
>> it's possible that
>> the pin id may be used in device tree in the future(maybe some other
>> soc already uses it),
>> And defining it has no big harming.
>>
>> Regards
>> Dong Aisheng
>> .
>>
> Then maybe #defines should be used, so that device tree can include this
> file and be run through C pre-processor?
>
Maybe one day device tree supports include c headfile,
we can do like that.

Regards
Dong Aisheng
