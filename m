From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 6 Mar 2013 08:49:32 +0900
Subject: [PATCH v3 3/3] ARM: dts: Add sbs-battery for exynos5250-snow
In-Reply-To: <1360957573-864-3-git-send-email-dianders@chromium.org>
References: <1360887677-20758-1-git-send-email-dianders@chromium.org>
 <1360957573-864-1-git-send-email-dianders@chromium.org>
 <1360957573-864-3-git-send-email-dianders@chromium.org>
Message-ID: <CAHfPSqDH3kk0t6RV1Mja+L4my+iNqkHcBgcJ9HmcT6XnBQpkmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 February 2013 04:46, Doug Anderson <dianders@chromium.org> wrote:
> Now that we have i2c-arbitrator in place on bus 4 we can add the
> sbs-battery driver.  Future devices will be added onto bus 4 once
> drivers are in good shape.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
Tested-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
The patchset v3 is tested on snow with test case which uses i2c-4 from both
EC and AP side continuously for a more than a couple of minutes
> ---
> Changes in v3: None
> Changes in v2: None
>
>  arch/arm/boot/dts/exynos5250-snow.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index d2d4b48..2127386 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -51,6 +51,12 @@
>                         reg = <0>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> +
> +                       battery: sbs-battery at b {
> +                               compatible = "sbs,sbs-battery";
> +                               reg = <0xb>;
> +                               sbs,poll-retry-count = <1>;
> +                       };
>                 };
>         };
>
> --
> 1.8.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--
Shine bright,
(: Nav :)
