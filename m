From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 15 Oct 2015 14:30:49 +0200
Subject: [RFT PATCH 3/3] ARM: dts: Mark SDIO as non-removable in
 exynos5250-snow-common
In-Reply-To: <1444906530-25048-4-git-send-email-javier@osg.samsung.com>
References: <1444906530-25048-1-git-send-email-javier@osg.samsung.com>
 <1444906530-25048-4-git-send-email-javier@osg.samsung.com>
Message-ID: <CAAObsKC4QSGaqwh_4Gy3C+9ty=k=LixV8oZB1-5ZreLOxqc=aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 October 2015 at 12:55, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> The Exynos5250 Snow Chromebooks have a Marvell WiFi SDIO chip which
> can't neither be removed nor be detected. But the node isn't marked
> as non-removable and instead has the broken-cd DT property.
>
> This causes the device to be removed when the system enters into a
> suspend state and the following warnings is shown after a resume:
>
> [  181.944636] mmc2: error -2 during resume (card was removed?)

Hi Javier,

isn't wifi on snow on mmc_3?

With your patch, I don't see any change, but if I do it on mmc_3
instead, the machine fails to resume. Will try to get more info.

Regards,

Tomeu

> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> index 0a7f408824d8..bf27957fd660 100644
> --- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> @@ -520,7 +520,7 @@
>  &mmc_0 {
>         status = "okay";
>         num-slots = <1>;
> -       broken-cd;
> +       non-removable;
>         card-detect-delay = <200>;
>         samsung,dw-mshc-ciu-div = <3>;
>         samsung,dw-mshc-sdr-timing = <2 3>;
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
