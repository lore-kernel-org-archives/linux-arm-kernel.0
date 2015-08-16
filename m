From: dianders@chromium.org (Doug Anderson)
Date: Sun, 16 Aug 2015 14:10:46 -0700
Subject: [RFC PATCH v5 1/9] mmc: dw_mmc: Add external dma interface support
In-Reply-To: <1522710.BT6Gc0L6oH@diego>
References: <1439541232-30100-1-git-send-email-shawn.lin@rock-chips.com>
 <1439541275-30146-1-git-send-email-shawn.lin@rock-chips.com>
 <1522710.BT6Gc0L6oH@diego>
Message-ID: <CAD=FV=W1dzqoJuJtJsD5TPKmSBpUbBcifGz654o9x8J1rX6-GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Fri, Aug 14, 2015 at 3:13 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Shawn,
>
> Am Freitag, 14. August 2015, 16:34:35 schrieb Shawn Lin:
>> DesignWare MMC Controller can supports two types of DMA
>> mode: external dma and internal dma. We get a RK312x platform
>> integrated dw_mmc and ARM pl330 dma controller. This patch add
>> edmac ops to support these platforms. I've tested it on RK312x
>> platform with edmac mode and RK3288 platform with idmac mode.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> judging by your "from", I guess you're running this on some older Rockchip soc
> without the idma? Because I tried testing this on a Radxa Rock, but only got
> failures, from the start (failed to read card status register). In PIO mode
> everything works again.
>
>
> I guess I overlooked just some tiny detail, but to me the dma channel ids seem
> correct after all. Maybe you have any hints what I'm doing wrong?

If I were a guessing man (which I'm not), I'd guess that perhaps
you're running into troubles with our friend the PL330.

There appear to be strange issues with the PL330 on Rockchip SoCs.  I
was only peripherally involved with them, but I know at least about
some of the patches in our tree, like:

https://chromium-review.googlesource.com/237607
FROMLIST: DMA: pl330: support burst mode for dev-to-mem and mem-to-dev transmit

https://chromium-review.googlesource.com/237393
CHROMIUM: dmaengine: pl330: support quirks for some broken

https://chromium-review.googlesource.com/237396
CHROMIUM: dmaengine: pl330: add quirk for broken no flushp

https://chromium-review.googlesource.com/237394
CHROMIUM: ARM: dts: rockchip: Add broken-no-flushp into rk3288.dtsi

https://chromium-review.googlesource.com/242063
CHROMIUM: ASoC: rockchip_i2s: modify DMA max burst to 1
