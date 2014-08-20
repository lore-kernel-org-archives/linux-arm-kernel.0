From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Wed, 20 Aug 2014 14:50:30 +0200
Subject: [PATCH v6 10/10] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <CAD=FV=WFP53bZAks7t9xybUxpna89Nz=KG+PQwAcxFEH0D+3mw@mail.gmail.com>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>	<1406940750-15880-11-git-send-email-afaerber@suse.de>
 <CAD=FV=WFP53bZAks7t9xybUxpna89Nz=KG+PQwAcxFEH0D+3mw@mail.gmail.com>
Message-ID: <53F49996.30007@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

Am 04.08.2014 17:22, schrieb Doug Anderson:
> On Fri, Aug 1, 2014 at 5:52 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
>> new file mode 100644
>> index 000000000000..f5566f84d885
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/exynos5250-spring.dts
[...]
>> +       usb-hub {
>> +               compatible = "smsc,usb3503a";
>> +               reset-gpios = <&gpe1 0 GPIO_ACTIVE_LOW>;
>> +       };
> 
> Last I remember hearing about this, Julius said that the generic
> usb-hub driver didn't work right for asserting the reset line.
> Something about needing the reset at a very specific time in the USB
> enumeration, I think.  Maybe it's somehow been fixed since then and
> that's why it's working?
> 
> Also: you technically should have a pinctrl-0 and pinctrl-names
> referencing "hsic_reset" below to make sure the pin gets initted
> properly.
[...]
> Technically the missing pinctrl for hsic-reset is something that out
> to be fixed and we should figure out whether the reset line is
> actually working properly anyway.  ...but I think this has been
> through enough spins and any additional fixup can happen later, so you
> can add my:
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>

I wonder how to proceed now... Are you planning to continue inserting my
remaining snow/smdk/arndale refactoring patches [1,2,3,4] before the mmc
slot node refactoring on v3.18-next/dt-samsung branch?
I.e., should I send out a v7 rebasing either the remainder or just
Spring on top of your for-next, or should I just post new follow-up
patches to this series and wait?

I've prepared and successfully tested a patch adding the pinctrl Doug
requested above. Additionally, I have another follow-up ready, adding a
gmt,g781 temperature sensor (with v3.17-rc1 that actually works).

Also I understood that Javier is waiting for my remaining Snow bits to
be applied before sending out further Snow DT cleanups/fixes of his.

Thanks,
Andreas

[1] https://patchwork.kernel.org/patch/4664881/
[2] https://patchwork.kernel.org/patch/4664801/
[3] https://patchwork.kernel.org/patch/4664731/
[4] https://patchwork.kernel.org/patch/4664751/

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
