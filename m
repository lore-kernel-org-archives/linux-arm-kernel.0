From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 12 Oct 2015 18:32:27 +0200
Subject: [PATCH v2 0/3] Fix random hang up issue while kernel init
In-Reply-To: <1444209281-25536-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1444209281-25536-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <561BE09B.3040702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/10/15 11:14, James Liao wrote:
> This patch is based on v4.3-rc4, to fix system hanging up issue
> while disabling unused clocks.
>
> There is nothing different in mtk-scpsys.c and mt8173.dtsi from v1 [1].
>
> Changes since v1:
> - Rebase to v4.3-rc4.
> - Add a patch to change the corresponding binding document.
> - Add a separated patch to change the dtsi.
>
> [1] https://patchwork.kernel.org/patch/7262411/
>
> James Liao (3):
>    dt-bindings: soc: Add clocks for Mediatek SCPSYS unit
>    soc: mediatek: Fix random hang up issue while kernel init
>    arm64: dts: mt8173: Add clocks for SCPSYS unit
>
>   .../devicetree/bindings/soc/mediatek/scpsys.txt    | 10 ++--
>   arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  6 +-
>   drivers/soc/mediatek/mtk-scpsys.c                  | 67 ++++++++++++++--------
>   3 files changed, 54 insertions(+), 29 deletions(-)
>
> --
> 1.9.1
>
>

Applied. Does this fix also needs to be applied to earlier kernel versions?

Thanks,
Matthias
