From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 9 Jul 2013 12:11:17 +0530
Subject: [PATCH v2 3/3] of/documentation: Update G2D documentation
In-Reply-To: <1373350364-2952-1-git-send-email-sachin.kamat@linaro.org>
References: <1373350364-2952-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAK9yfHw-Ry0NTKhrbVApz6-7r4R1jhnh34+fFHmA3FPgvdyTWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 July 2013 11:42, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Exynos5250 G2D IP requires only the gate clock. Update the
> binding documentation accordingly.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Inki Dae <inki.dae@samsung.com>
> ---
> Updated the description of clock-names as suggested by Tomasz Figa.
> ---
>  .../devicetree/bindings/gpu/samsung-g2d.txt        |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-g2d.txt b/Documentation/devicetree/bindings/gpu/samsung-g2d.txt
> index 3f454ff..c4f358d 100644
> --- a/Documentation/devicetree/bindings/gpu/samsung-g2d.txt
> +++ b/Documentation/devicetree/bindings/gpu/samsung-g2d.txt
> @@ -11,8 +11,11 @@ Required properties:
>
>    - interrupts : G2D interrupt number to the CPU.
>    - clocks : from common clock binding: handle to G2D clocks.
> -  - clock-names : from common clock binding: must contain "sclk_fimg2d" and
> -                 "fimg2d", corresponding to entries in the clocks property.
> +  - clock-names : names of clocks listed in clocks property, in the same
> +                 order, depending on SoC type:
> +                 - for S5PV210 and Exynos4 based SoCs: "fimg2d" and
> +                   "sclk_fimg2d"
> +                 - for Exynos5250 SoC: "fimg2d".
>
>  Example:
>         g2d at 12800000 {
> --
> 1.7.9.5
>

Please ignore this patch. Will re-send. Sorry for the noise.

-- 
With warm regards,
Sachin
