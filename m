From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 24 Aug 2016 16:21:35 +0800
Subject: [PATCH] ARM: dts: sun8i: add NAND controller node for A23/A33
In-Reply-To: <20160824060222.GT2598@lukather>
References: <20160823135546.60179-1-icenowy@aosc.xyz>
 <20160824060222.GT2598@lukather>
Message-ID: <16141472026895@web4j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

24.08.2016, 14:02, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> Hi,
>
> On Tue, Aug 23, 2016 at 09:55:46PM +0800, Icenowy Zheng wrote:
>> ?A23/A33 has a NAND controller which can now be used properly.
>>
>> ?Add a device node for it.
>>
>> ?The DMA function cannot work because of changed DMA IP block, so it's
>> ?temporarily removed in the device node. However, with PIO mode it can still
>> ?work.
>
> What is preventing the NAND driver to work with DMA with the sun6i driver?
It seems that under sun6i we should use dedicated rx and tx DMAs, but not a
"rxtx" DMA.
>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
