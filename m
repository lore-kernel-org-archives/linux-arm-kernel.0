From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 29 Nov 2011 16:56:18 +0800
Subject: [PATCH 1/7] pinctrl: enable pxa3xx pinmux
In-Reply-To: <CACRpkdY0N+hC5BfKP2J=nxM44O-evv1-vU3hnyomboAp7CQa=A@mail.gmail.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-2-git-send-email-haojian.zhuang@marvell.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDAF8C5@HQMAIL01.nvidia.com>
 <CACRpkdY0N+hC5BfKP2J=nxM44O-evv1-vU3hnyomboAp7CQa=A@mail.gmail.com>
Message-ID: <CAN1soZy_6oydixj08m0imBQs0Zh-WcfWttS5fLD236V8RmVeTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 4:39 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Nov 28, 2011 at 9:21 PM, Stephen Warren <swarren@nvidia.com> wrote:
>> Haojian Zhuang wrote at Friday, November 25, 2011 4:09 PM:
>> ...
>>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
>> ...
>>> +config PINMUX_PXA3xx
>>> + ? ? bool "PXA pinmux driver"
>>> + ? ? default y if ARCH_PXA || ARCH_MMP
>
> So drop that line.
>
> The rest is correct.
>
>>> + ? ? select PINMUX
>>> +
>>
>> I thought the plan here was for e.g. ARCH_PXA to "select PINMUX_PXA3xxx",
>> since it's presumably mandatory?
>
> Yes that is correct.
>
> Haojian can you alter the patch so that arch/arm/mach*/Kconfig does
>
> select PINCTRL
> select PINMUX_PXA3XX
>
> (Both are needed.)
>
I'll change it.

Thanks
Haojian
