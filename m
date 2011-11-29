From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 29 Nov 2011 10:31:35 +0800
Subject: [PATCH 1/7] pinctrl: enable pxa3xx pinmux
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174FDAF8C5@HQMAIL01.nvidia.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-2-git-send-email-haojian.zhuang@marvell.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDAF8C5@HQMAIL01.nvidia.com>
Message-ID: <CAMPhdO-K3=4errP2c9YmiPq5ebUSs284DDsBwLqrqa4R=k6Pmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 4:21 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Haojian Zhuang wrote at Friday, November 25, 2011 4:09 PM:
> ...
>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> ...
>> +config PINMUX_PXA3xx
>> + ? ? bool "PXA pinmux driver"
>> + ? ? default y if ARCH_PXA || ARCH_MMP
>> + ? ? select PINMUX
>> +
>
> I thought the plan here was for e.g. ARCH_PXA to "select PINMUX_PXA3xxx",
> since it's presumably mandatory?

Can we pass the SoC type by platform data, instead of calling cpu_is_*()?
