From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 25 Jul 2014 19:02:34 +0200
Subject: [PATCH v2 3/4] ARM: dts: exynos5250: Fold common ChromeOS parts
 into Snow
In-Reply-To: <CAD=FV=V-7+Jj7b8-fQL1PiQhNmhiGOPJzitGd__OUQLDteO_8g@mail.gmail.com>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>
 <1405704009-8430-4-git-send-email-afaerber@suse.de>
 <CABxcv=kP2PCcNCtM1WUXx5wGG4m-jdw-P1dw0boaSwdJpoX=jQ@mail.gmail.com>
 <CAD=FV=V-7+Jj7b8-fQL1PiQhNmhiGOPJzitGd__OUQLDteO_8g@mail.gmail.com>
Message-ID: <CABxcv=nDsKSdDtVZKpcTP+=3pbeTswJRCUvvXVx98p+1Zzz0Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Doug,

On Fri, Jul 25, 2014 at 6:43 PM, Doug Anderson <dianders@chromium.org> wrote:
> Javier,
>
> On Fri, Jul 25, 2014 at 9:35 AM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
>> Hello Andreas,
>>
>> On Fri, Jul 18, 2014 at 7:20 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>>
>>> +       memory {
>>> +               reg = <0x40000000 0x80000000>;
>>> +       };
>>> +
>>> +       chosen {
>>> +       };
>>> +
>>
>> Is there a reason for an empty chosen node? Same for the Spring DTS.
>
> I know that the bootloader (U-Boot) fills this in.  I'd have to double
> check how the bootloader handles the node not being there to begin
> with.

Yes, U-Boot fills this but if the node does not exist in the FDT, it
creates one. Take a look at fdt_chosen() in common/fdt_support.c [0].

So I think it's better to just remove it since is empty.

Best regards,
Javier

[0]: https://chromium.googlesource.com/chromiumos/third_party/u-boot/+/master/common/fdt_support.c#215
