From: eliad@wizery.com (Eliad Peller)
Date: Wed, 11 Mar 2015 13:54:52 +0200
Subject: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
In-Reply-To: <CABxcv=kL3Hw43VVxAsZ=DnY4Z+5431PO2YehcK2zTkFGBG0cNA@mail.gmail.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <1425915402-10012-3-git-send-email-eliad@wizery.com>
 <CABxcv=kL3Hw43VVxAsZ=DnY4Z+5431PO2YehcK2zTkFGBG0cNA@mail.gmail.com>
Message-ID: <CAB3XZEfrqVkq+wCByZfT2kqSEQP6xJS2enQMJQv8DZf9Sj2VKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Javier,

On Wed, Mar 11, 2015 at 2:28 AM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> Hello Eliad,
>
> On Mon, Mar 9, 2015 at 4:36 PM, Eliad Peller <eliad@wizery.com> wrote:
>> Add wl18xx (wilink8) bindings to omap3-igep0030-rev-g and
>> omap3-igep0020-rev-f dts files, instead of defining the
>> platform data through the pdata-quirks.
>>
>> The patch was compile-tested only.
>>
>
> You should look at MAINTAINERS or use ./scripts/get_maintainer.pl to
> know who should be cc'ed. Specially for this kind of patches where you
> are not able to test on the actual platform. Added Enric to cc as well
> since he also maintains the IGEP boards an has access to the hw too.
>
right. sorry about that.
i assumed adding the relevant mailing lists should be enough, but i
guess i should have added the relevant maintainers as well.

>>  arch/arm/boot/dts/omap3-igep0020-rev-f.dts | 9 +++++++++
>>  arch/arm/boot/dts/omap3-igep0030-rev-g.dts | 9 +++++++++
>>  arch/arm/mach-omap2/pdata-quirks.c         | 2 --
>>  3 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
>> index cc8bd0c..8e5b44e 100644
>> --- a/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
>> +++ b/arch/arm/boot/dts/omap3-igep0020-rev-f.dts
>> @@ -42,4 +42,13 @@
>>         vmmc-supply = <&lbep5clwmc_wlen>;
>>         bus-width = <4>;
>>         non-removable;
>> +
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       wlcore: wlcore at 2 {
>> +               compatible = "ti,wl1835";
>> +               reg = <2>;
>> +               interrupt-parent = <&gpio6>;
>> +               interrupts = <17 IRQ_TYPE_NONE>;
>
> As Arnd said, it seems this should be IRQ_TYPE_LEVEL_HIGH to match
> what the platform code is currently doing.
>
will be fixed.

thanks,
Eliad.
