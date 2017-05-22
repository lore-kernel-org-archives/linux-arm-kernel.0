From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 22 May 2017 10:40:58 +0200
Subject: [PATCH 0/8] arm64: hi6220-hikey: Fix WiFi support
In-Reply-To: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAPDyKFqi2jiqKESdz8izq6thr6GT0HQDKt6xRKzwaCQ-mkMNSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Arnd, Rob

On 8 May 2017 at 18:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The Hikey board has a Wifi chip attached to the SDIO bus, which is managed by a
> dwmmc controller. This is currently broken in that way that not even the SDIO
> card is being detected.
>
> To fix this we need to make sure the correct resources are described for the
> dwmmc controller, so the mmc core can power on/off the SDIO/WiFi chip
> correctly. This is the main issue today.
>
> I have picked up one change from Daniel Lezcano's earlier submission [1] and
> folded that into this series, as the Wifi support depends on it. As a matter of
> fact I have even split Daniel's change into two halves, one for DT
> documentation and one for arm64 hikey dts.
>
> It's important that this series goes together as to conform with TI's HW spec
> of the wl18xx Wifi chip, as to prevent it from being damaged. We can either go
> via arm-soc, unless Wei Xu the Hikey SoC maintainer, prefers to ack the dts
> changes, then I can pick the series via my mmc tree.
>
> Moreover, I would suggest we send this as fixes for the 4.12 rcs to get the
> Wifi working for Hikey again.
>
> Kind regards
> Ulf Hansson
>
> [1]
> https://patchwork.kernel.org/patch/9697189/
>
> Daniel Lezcano (2):
>   mfd: dts: hi655x: Add clock binding for the pmic
>   arm64: dts: hikey: Add clock for the pmic mfd
>
> Ulf Hansson (6):
>   mmc: dt: pwrseq-simple: Invent power-off-delay-us
>   mmc: pwrseq_simple: Parse DTS for the power-off-delay-us property
>   arm64: dts: hi6220: Move the fixed_5v_hub regulator to the hikey dts
>   arm64: dts: hikey: Add the SYS_5V and the VDD_3V3 regulators
>   arm64: dts: hi6220: Move board data from the dwmmc nodes to hikey dts
>   arm64: dts: hikey: Fix WiFi support
>
>  .../devicetree/bindings/mfd/hisilicon,hi655x.txt   |  6 ++
>  .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  2 +
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     | 78 +++++++++++++++++-----
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi          | 31 +--------
>  drivers/mmc/core/pwrseq_simple.c                   |  7 ++
>  5 files changed, 79 insertions(+), 45 deletions(-)
>
> --
> 2.7.4
>

Wei Xu,

This series fixes my wifi issues on the Hikey board and currently all
but the hikey dts changes seems to be okay/acked.

Rob and me had some discussions regarding the new mmc DT binding,
however in the last response from Rob he indicates that he is not
objecting to adding the new binding.

So, unless I hear some objection from any of you, I am going to queue
this up for fixes via my mmc tree within a day or so.

Kind regards
Uffe
