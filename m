From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 16 Jun 2015 19:42:04 +0800
Subject: [PATCH v3 1/2] arm64: dts: mt8173: Add watchdog device node
In-Reply-To: <1434101229-32695-2-git-send-email-eddie.huang@mediatek.com>
References: <1434101229-32695-1-git-send-email-eddie.huang@mediatek.com>
 <1434101229-32695-2-git-send-email-eddie.huang@mediatek.com>
Message-ID: <CAGS+omAi-5mikJfsBhFW1xuqU6r2jNpKWjB9a1DLifptb8q93w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 5:27 PM, Eddie Huang <eddie.huang@mediatek.com> wrote:
> Add MT8173 watchdog device node.
>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>

This one is:
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

It is also independent of the i2c nodes, and as far as I can tell can
go in already.

Thanks!
-Dan

> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 30ac8dd..b52ec43 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -160,6 +160,12 @@
>                                                 <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
> +               watchdog: watchdog at 10007000 {
> +                       compatible = "mediatek,mt8173-wdt",
> +                                    "mediatek,mt6589-wdt";
> +                       reg = <0 0x10007000 0 0x100>;
> +               };
> +
>                 sysirq: intpol-controller at 10200620 {
>                         compatible = "mediatek,mt8173-sysirq",
>                                         "mediatek,mt6577-sysirq";
> --
> 1.8.1.1.dirty
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
