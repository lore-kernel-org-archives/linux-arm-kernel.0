From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 8 Mar 2015 10:42:30 +0800
Subject: [linux-sunxi] [PATCH 7/7] ARM: dts: sun7i: Enable cap-sdio-irq
 for bananapro sdio wifi
In-Reply-To: <1425754884-7875-7-git-send-email-hdegoede@redhat.com>
References: <1425754884-7875-1-git-send-email-hdegoede@redhat.com>
 <1425754884-7875-7-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v65tcCrg3njNN0owLrM-MUepRBwjxpU46dpXkLhy9mceEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 8, 2015 at 3:01 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The sdio wifi on the Banana Pro does not appear to have an oob irq hooked
> up, so enable sdio-irq support to avoid unnecessary polling.

I wonder if this is stable enough to put back into the mmc driver, i.e.
declare the capability in the driver itself? IIRC at one point it did.

ChenYu

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-bananapro.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> index fb89fe7..d0cd78f 100644
> --- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> @@ -164,6 +164,7 @@
>         vmmc-supply = <&reg_vmmc3>;
>         bus-width = <4>;
>         non-removable;
> +       cap-sdio-irq;
>         status = "okay";
>  };
>
> --
> 2.3.1
