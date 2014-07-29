From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Tue, 29 Jul 2014 15:00:03 +0200
Subject: [PATCH v2 3/4] ARM: dts: exynos5250: Fold common ChromeOS parts
 into Snow
In-Reply-To: <CABxcv=nDsKSdDtVZKpcTP+=3pbeTswJRCUvvXVx98p+1Zzz0Bg@mail.gmail.com>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>	<1405704009-8430-4-git-send-email-afaerber@suse.de>	<CABxcv=kP2PCcNCtM1WUXx5wGG4m-jdw-P1dw0boaSwdJpoX=jQ@mail.gmail.com>	<CAD=FV=V-7+Jj7b8-fQL1PiQhNmhiGOPJzitGd__OUQLDteO_8g@mail.gmail.com>
 <CABxcv=nDsKSdDtVZKpcTP+=3pbeTswJRCUvvXVx98p+1Zzz0Bg@mail.gmail.com>
Message-ID: <53D79AD3.8020700@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier and Doug,

Am 25.07.2014 19:02, schrieb Javier Martinez Canillas:
> On Fri, Jul 25, 2014 at 6:43 PM, Doug Anderson <dianders@chromium.org> wrote:
>> On Fri, Jul 25, 2014 at 9:35 AM, Javier Martinez Canillas
>> <javier@dowhile0.org> wrote:
>>> Hello Andreas,
>>>
>>> On Fri, Jul 18, 2014 at 7:20 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>>>
>>>> +       memory {
>>>> +               reg = <0x40000000 0x80000000>;
>>>> +       };
>>>> +
>>>> +       chosen {
>>>> +       };
>>>> +
>>>
>>> Is there a reason for an empty chosen node? Same for the Spring DTS.
>>
>> I know that the bootloader (U-Boot) fills this in.  I'd have to double
>> check how the bootloader handles the node not being there to begin
>> with.
> 
> Yes, U-Boot fills this but if the node does not exist in the FDT, it
> creates one. Take a look at fdt_chosen() in common/fdt_support.c [0].
> 
> So I think it's better to just remove it since is empty.

Hm, in different context it was stated that device trees shouldn't rely
on bootloader behavior (for a /memory node on Zynq we ended up
specifying the size cell with the real value despite U-Boot overriding
it to a lesser value).

Can we instead settle on filling this node with defaults? :)
bootargs = "console=tty1"; would be my choice for Spring. Would that be
applicable for Snow as well?
Not sure how to specify that via linux,stdout-path property.

I believe this would be a follow-up patch either way.

Since there's at least two series out there trying to fiddle with
-cros-common.dtsi, including one that drops the slot sub-node of the MMC
and one that adds CPU power supply, it would be nice if we can get the
-cros-common parts sorted out and applied. Can you ack/review 1-2?
Should I squash them in a v3?

Thanks,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
