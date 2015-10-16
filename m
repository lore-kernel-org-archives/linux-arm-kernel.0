From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 16 Oct 2015 14:33:18 +0200
Subject: [RFT PATCH v2 6/6] ARM: dts: Mark eMMC as non-removable in
 exynos5250-snow-common
In-Reply-To: <1444927873-15140-7-git-send-email-javier@osg.samsung.com>
References: <1444927873-15140-1-git-send-email-javier@osg.samsung.com>
 <1444927873-15140-7-git-send-email-javier@osg.samsung.com>
Message-ID: <CAAObsKCuSvwnbKmB6gskoGTkvHBrz2rqu3Qif7WHn_fDbF7_wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 October 2015 at 18:51, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> The eMMC is non-removable so mark it using the non-removable DT
> property to avoid having to redetect it after a suspend/resume.
>
> Also remove the card-detect-delay property that is not needed with
> non-removable.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Tested-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Thanks,

Tomeu

> ---
>
> Changes since v1:
> - None, new patch.
>
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> index 1822c502a25a..5cb33ba5e296 100644
> --- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> @@ -520,8 +520,7 @@
>  &mmc_0 {
>         status = "okay";
>         num-slots = <1>;
> -       broken-cd;
> -       card-detect-delay = <200>;
> +       non-removable;
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
