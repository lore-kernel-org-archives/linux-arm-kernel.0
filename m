From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 23 Aug 2011 22:00:33 +0200
Subject: [RFC PATCH v2 00/13] arm/tegra: Initialize GPIO & pinmux from DT
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B24A38E6@HQMAIL01.nvidia.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<201108161509.17157.arnd@arndb.de>
	<CACRpkdaVx=6AJ5DFjVN1ZYQ++hu9pT6WxD9n+pqmYVaCf1xawg@mail.gmail.com>
	<201108161637.16620.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04AEA25368@HQMAIL01.nvidia.com>
	<CACRpkdY=nVQYnznTU7=_D0n1V1U_xOKH2y75-jKp7k7NzwH8Zw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A38E6@HQMAIL01.nvidia.com>
Message-ID: <CAKnu2MoEvc7KGH-Fu1FzRE1xFFvsSRVdG5Amg6FL-6PrWRw5yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/23 Stephen Warren <swarren@nvidia.com>:
> Linus Walleij wrote at Tuesday, August 23, 2011 6:51 AM:
>> Each GPIO chip may have it's respective pin controller as parent
                               ^^^^^
>> I guess, or they may simply be the same struct device * whatdoIknow.
>
> I'm not clear on why the GPIO and pinmux would have any kind of parent
> relationship. Perhaps that's how your HW is designed. In Tegra, GPIO
> and pinmux are completely separate HW blocks without much of a defined
> relationship.
>
> I can certainly see both being implemented by the same code if it makes
> sense to do so. On Tegra, I think I'd still lean towards keeping them
> as separate devices, since they have separate register spaces and are
> documented separately etc. However, I can certainly see that other HW
> might have both sets of functionality in one HW block.

Makes sense, for U300 I will probably also keep them separate
like this:

pinctrl.0 - deal with muxing
pinctrl.1 - deal with biasing, driving etc
gpio.0 - the GPIO driver using both of the above, no relationship

The only thing they have in common is some relation to the
global GPIO pin space. (When/if we get rid of that - something
better.)

Yours,
Linus Walleij
