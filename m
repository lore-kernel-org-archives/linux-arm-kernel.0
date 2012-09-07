From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 12:29:31 +0000
Subject: [PATCH 04/19] ARM: ux500: Add SDI (MMC) support to the HREF
 Device Tree
In-Reply-To: <1347016499-29354-5-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-5-git-send-email-lee.jones@linaro.org>
Message-ID: <201209071229.32027.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Lee Jones wrote:
> +               // External Micro SD slot
> +               sdi at 80126000 {
> +                       arm,primecell-periphid = <0x10480180>;
> +                       max-frequency = <50000000>;
> +                       bus-width = <8>;
> +                       mmc-cap-sd-highspeed;
> +                       mmc-cap-mmc-highspeed;
> +                       vmmc-supply = <&ab8500_ldo_aux3_reg>;
> +
> +                       #gpio-cells = <1>;
> +                       cd-gpios  = <&gpio2 31 0x4>; // 95
> +
> +                       status = "okay";
> +               };
> +

The #gpio-cells property seems misplaced here.

	Arnd
