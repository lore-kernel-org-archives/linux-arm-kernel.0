From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 16 Oct 2015 14:33:51 +0200
Subject: [RFT PATCH v2 3/6] ARM: dts: Mark SDIO as non-removable in
 exynos5250-snow-common
In-Reply-To: <1444927873-15140-4-git-send-email-javier@osg.samsung.com>
References: <1444927873-15140-1-git-send-email-javier@osg.samsung.com>
 <1444927873-15140-4-git-send-email-javier@osg.samsung.com>
Message-ID: <CAAObsKCLcoNZZ9bpY20G5OPV7icPnaWWTQS=u0DNP8amCwq_oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 October 2015 at 18:51, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> The Exynos5250 Snow Chromebooks have a Marvell WiFi SDIO chip which
> can't neither be removed nor be detected. But the node isn't marked
> as non-removable and instead has the broken-cd DT property.
>
> This causes the device to be removed when the system enters into a
> suspend state and the following warnings is shown after a resume:
>
> [  181.944636] mmc2: error -2 during resume (card was removed?)
>
> Also remove the card-detect-delay property that is not needed with
> non-removable.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Tested-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Thanks,

Tomeu


>
> Changes since v1:
> - Remove card-detect-delay property as well.
> - Use the correct mmc node. Suggested by Tomeu.
>
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> index 0a7f408824d8..1822c502a25a 100644
> --- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> @@ -552,10 +552,9 @@
>  &mmc_3 {
>         status = "okay";
>         num-slots = <1>;
> -       broken-cd;
> +       non-removable;
>         cap-sdio-irq;
>         keep-power-in-suspend;
> -       card-detect-delay = <200>;
>         samsung,dw-mshc-ciu-div = <3>;
>         samsung,dw-mshc-sdr-timing = <2 3>;
>         samsung,dw-mshc-ddr-timing = <1 2>;
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
