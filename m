From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 29 Jun 2016 21:33:31 +0800
Subject: [RFC PATCH 3/5] thermal: Add support for the thermal sensor on
 A23/33
In-Reply-To: <20160629121021.GD6095@lukather>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
 <20160628101325.2522-3-icenowy@aosc.xyz>
 <20160628114640.GE5550@lukather>
 <60021467122182@web19j.yandex.ru> <20160629121021.GD6095@lukather>
Message-ID: <1209771467207211@web22j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



29.06.2016, 20:10, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> Hi,
>
> On Tue, Jun 28, 2016 at 09:56:22PM +0800, Icenowy Zheng wrote:
>> ?The reason for a dedicate driver is:
>> ?1. This IP have only thermal function, so it's not suitable to use a
>> ?driver at drivers/input/touchscreen/.
>
> That's not a problem, and it's being worked on [1].
>
>> ?2. Control Register are quite different.
>
> That's not a problem either, there's just a bit that you don't need to
> set in the control 1 register, and that's pretty much it. It doesn't
> justify a whole new driver.
>
>> ?3. This IP uses AUDIO PLL (PLL2) as its clock!
>
> It's listed as the input, but all the rest of the documentation refers
> only to 24MHz, which seems to indicate that it's only running on the
> oscillator, which would make much more sense.
>
> Thanks,
> Maxime
>
> 1: http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/439487.html
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

I will try to use it without pll2 enabled.
