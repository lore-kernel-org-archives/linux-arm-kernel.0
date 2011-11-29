From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Nov 2011 09:39:06 +0100
Subject: [PATCH 1/7] pinctrl: enable pxa3xx pinmux
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174FDAF8C5@HQMAIL01.nvidia.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-2-git-send-email-haojian.zhuang@marvell.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDAF8C5@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdY0N+hC5BfKP2J=nxM44O-evv1-vU3hnyomboAp7CQa=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 9:21 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Haojian Zhuang wrote at Friday, November 25, 2011 4:09 PM:
> ...
>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> ...
>> +config PINMUX_PXA3xx
>> + ? ? bool "PXA pinmux driver"
>> + ? ? default y if ARCH_PXA || ARCH_MMP

So drop that line.

The rest is correct.

>> + ? ? select PINMUX
>> +
>
> I thought the plan here was for e.g. ARCH_PXA to "select PINMUX_PXA3xxx",
> since it's presumably mandatory?

Yes that is correct.

Haojian can you alter the patch so that arch/arm/mach*/Kconfig does

select PINCTRL
select PINMUX_PXA3XX

(Both are needed.)

And

Yours,
Linus Walleij
