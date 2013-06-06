From: padma.kvr@gmail.com (Padma Venkat)
Date: Thu, 6 Jun 2013 09:24:30 +0530
Subject: [PATCH V5 4/5] ARM: dts: add clock provider information for i2s
 controllers in Exynos5250
In-Reply-To: <CAD=FV=VHwTNQy5oNZ0cCaydJDDTst+yxFw4onKSDJR4DQV0gSw@mail.gmail.com>
References: <1370348890-6645-1-git-send-email-padma.v@samsung.com>
 <1370348890-6645-5-git-send-email-padma.v@samsung.com>
 <CAD=FV=VHwTNQy5oNZ0cCaydJDDTst+yxFw4onKSDJR4DQV0gSw@mail.gmail.com>
Message-ID: <CAAgF-Bcg3RQ-xJL0EGfwhRsBK477bCUcMu5Zr5x884HyzVbkcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Tue, Jun 4, 2013 at 10:49 PM, Doug Anderson <dianders@chromium.org> wrote:
> Padmavathi,
>
> On Tue, Jun 4, 2013 at 5:28 AM, Padmavathi Venna <padma.v@samsung.com> wrote:
>> @@ -471,6 +477,8 @@
>>                 dmas = <&pdma1 12
>>                         &pdma1 11>;
>>                 dma-names = "tx", "rx";
>> +               clocks = <&clock 307>;
>> +               clock-names = "iis";
>
> ...actually, glancing at the driver I'm a little surprised that you
> don't need to list "i2s_opclk0".  Did you test i2s1?

I didn't test i2s1 but i2s_opclk0 is also required. I will resubmit the patch.

>
>>                 pinctrl-names = "default";
>>                 pinctrl-0 = <&i2s1_bus>;
>>         };
>> @@ -481,6 +489,8 @@
>>                 dmas = <&pdma0 12
>>                         &pdma0 11>;
>>                 dma-names = "tx", "rx";
>> +               clocks = <&clock 308>;
>> +               clock-names = "iis";
>
> ...and here.
>
>
> -Doug

Thanks
Padma
