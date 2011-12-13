From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Dec 2011 01:27:05 +0100
Subject: [RFC 1/3] pinctrl: add a driver for NVIDIA Tegra
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17518607C1@HQMAIL01.nvidia.com>
References: <1323382390-14892-1-git-send-email-swarren@nvidia.com>
 <1323382390-14892-2-git-send-email-swarren@nvidia.com>
 <CACRpkdYDn0V7SeQuFiFDMxGkybvg6PGf7jxid8ECGB7Azkj3zw@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17518604D7@HQMAIL01.nvidia.com>
 <CACRpkdahqb0qMVcKF9NBT5pwRgK4FOob5ABtb7ids9Bhh5XbZg@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17518607C1@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdYz4-HFf6oBZ1NNies6SqKCYrsTbFaMjh7Sr7M8wXFVPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 7:06 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Linus Walleij wrote at Friday, December 09, 2011 4:56 PM:

>> For me there are two points:
>>
>> - Avoiding clash with kernel maintainers who hate firmware-like tables and
>> ? binary data filling up the kernel. Some certain other guy bearing my
>> ? name comes to mind.
>
> Well, one of the nice things here is that everything to conctrol the HW
> is in the driver, unlike on other systems without all this data that
> have to rely on opaque BIOS/ACPI/EFI/... hooks.

Good point. I will have to play that card if the situation should arise.
Kernel devs also tend to hate stuff they can't control.

>> - Footprint: the majority of the stuff in your driver ends up in non-discardable
>> ? memory, and will be kept around. Since we have this concept of a
>> ? single zImage for a number of say ARMv7 systems, and since pin
>> ? controllers can be pretty hard to load from modules, *all* of them
>> ? may have to be compiled-in. If every driver for every board takes this
>> ? approach I am afraid it will be end up with a measurable footprint.
>
> Perhaps what we need is a way to build all these drivers as modules, but
> still link them into the kernel so they're statically available during
> early boot, but allow them to be unloaded like modules after the system
> has booted and determined they aren't needed.
>
> This would have the advantage of getting rid of the unused driver code
> as well, whereas putting the data into DT only handles ensuring the data
> for other SoCs isn't present in the kernel after boot.

Hm that sounds pretty complicated. But also extremely useful if
we forge ahead on single zImages.

I'd never be able to pull it off thoug :-/

Anyway, we'll deal with this when we run into the problem.

Yours,
Linus Walleij
