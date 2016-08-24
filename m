From: ayaka@soulik.info (Ayaka)
Date: Wed, 24 Aug 2016 16:29:07 +0800
Subject: [PATCH 2/2] ARM: dts: add TOPEET itop elite based board
In-Reply-To: <CAL_JsqKY=VEZ+U11kY+XbMWuXhaFDr6GpnR3AXKd1U=9_=8fgA@mail.gmail.com>
References: <4767fc2a-95b7-ee0d-f51a-7a5d6ca89d8f@samsung.com>
 <1471875489-11428-1-git-send-email-ayaka@soulik.info>
 <1471875489-11428-3-git-send-email-ayaka@soulik.info>
 <20160823181402.GA6302@rob-hp-laptop>
 <0192d6da-89ce-a158-1c15-48eebba7db3b@soulik.info>
 <CAL_JsqKY=VEZ+U11kY+XbMWuXhaFDr6GpnR3AXKd1U=9_=8fgA@mail.gmail.com>
Message-ID: <4FC4C5C4-C71B-4CC3-9A4F-E03404CF571A@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



??? iPad ??

> Rob Herring <robh@kernel.org> ? 2016?8?24? ??6:38 ???
> 
>> On Tue, Aug 23, 2016 at 1:36 PM, ayaka <ayaka@soulik.info> wrote:
>> 
>>> On 08/24/2016 02:14 AM, Rob Herring wrote:
>>> 
>>>> On Mon, Aug 22, 2016 at 10:18:09PM +0800, Randy Li wrote:
>>>> 
>>>> The TOPEET itop exynos 4412 have three versions base board. The
>>>> Elite version is the cheap one without too much peripheral devices
>>>> on it.
>>>> 
>>>> Currently supported are serial console, wired networking(USB),
>>>> USB OTG in peripheral mode, USB host, SD storage, GPIO buttons,
>>>> PWM beeper, ADC and LEDs.
> 
> [...]
> 
>>>> +/dts-v1/;
>>>> +#include "exynos4412-itop-scp-core.dtsi"
>>>> +
>>>> +/ {
>>>> +       model = "TOPEET iTop 4412 Elite board based on Exynos4412";
>>>> +       compatible = "topeet,itop4412-elite", "samsung,exynos4412",
>>>> "samsung,exynos4";
>>>> +
>>>> +       chosen {
>>>> +               bootargs ="console=ttySAC2,115200";
>>> 
>>> Don't need console set with...
>> 
>> But could I set something like rootfs here ?
>> As the bootloader(old u-boot) offered by the vendor is brick, it is
>> impossible to save any something in u-boot.
> 
> Yes, but then that is a user decision and shouldn't really be there
> either. In other words, ether the bootloader should set bootargs
> (which even a vendor u-boot should be able to do either directly or
> the zImage can take it from the ATAGS)
Yes, but you have to break the auto boot every time. I want to write a new u-boot for it, but I meet some problem with JTAG, it won't come soon.
> or a user can edit the dts and
> carry that change.
> 
> However, there are probably plenty of examples in the kernel that
> counter what I just said.
I see than you. May I ask if I specific the rootfs bootargs of in dts, should you accept such patch?
> 
> Rob
