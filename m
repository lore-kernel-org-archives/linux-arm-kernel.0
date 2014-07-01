From: spk.linux@gmail.com (Sachin Kamat)
Date: Tue, 1 Jul 2014 09:03:18 +0530
Subject: [PATCH] ARM: dts: Add TMU dt node to monitor the temperature for
 Exynos3250
In-Reply-To: <1404175210-9278-1-git-send-email-cw00.choi@samsung.com>
References: <1404175210-9278-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <CAK5sBcFJMK-y+MZPXCufKEmp=v1nFJHstvNTczsQ3ez3SUPbKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On Tue, Jul 1, 2014 at 6:10 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch add TMU (Thermal Management Unit) dt node to monitor the high
> temperature for Exynos3250.
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> This patch has a dependency on following patch [1]:
>  [1] https://lkml.org/lkml/2014/6/30/805
>
>  arch/arm/boot/dts/exynos3250.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 3660cab..1e566af 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -192,6 +192,16 @@
>                         status = "disabled";
>                 };
>
> +               tmu: tmu at 100C0000 {
> +                       compatible = "samsung,exynos3250-tmu";
> +                       interrupt-parent = <&gic>;
> +                       reg = <0x100C0000 0x100>;
> +                       interrupts = <0 216 0>;
> +                       clocks = <&cmu CLK_TMU_APBIF>;
> +                       clock-names = "tmu_apbif";
> +                       status = "disabled";

I don't think there would be any board specific properties needed. Hence
leave the status as enabled (by deleting the above line).

-- 
Regards,
Sachin.
