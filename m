From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 28 Jun 2016 21:56:22 +0800
Subject: [RFC PATCH 3/5] thermal: Add support for the thermal sensor on
 A23/33
In-Reply-To: <20160628114640.GE5550@lukather>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
 <20160628101325.2522-3-icenowy@aosc.xyz> <20160628114640.GE5550@lukather>
Message-ID: <60021467122182@web19j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



28.06.2016, 19:46, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> Hi,
>
> Thanks for working on this.
>
> On Tue, Jun 28, 2016 at 06:13:23PM +0800, Icenowy Zheng wrote:
>> ?This patch adds support for the sun8iw3 thermal sensor on
>> ?Allwinner A23/33 SoCs.
>>
>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>
> The IP is awfully similar to the A31's, which already has a driver
> (drivers/input/touchscreen/sun4i-ts.c).
>
> There's no reason to add a new one here.
>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

The reason for a dedicate driver is:
1. This IP have only thermal function, so it's not suitable to use a driver at drivers/input/touchscreen/.
2. Control Register are quite different.
3. This IP uses AUDIO PLL (PLL2) as its clock!
