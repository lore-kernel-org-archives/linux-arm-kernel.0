From: ashcharles@gmail.com (Ash Charles)
Date: Tue, 9 Jun 2015 08:45:04 -0700
Subject: [PATCH 3/3] ARM: dts: Fix frequency scaling on Gumstix Pepper.
In-Reply-To: <1433441299-18887-4-git-send-email-arun@gumstix.com>
References: <1433441299-18887-1-git-send-email-arun@gumstix.com>
 <1433441299-18887-4-git-send-email-arun@gumstix.com>
Message-ID: <CAK8F28kxuk0zPetCBPLmU5skQcOb2E47veZe5s7YaeE-ZJNMew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This works well for me--cpufreq seems much happier.

Tested-by: Ash Charles <ashcharles@gmail.com>

On Thu, Jun 4, 2015 at 11:08 AM, Arun Bharadwaj <arun@gumstix.com> wrote:
> The device tree for Gumstix Pepper has DCDC2 and
> DCDC3 correctly labelled but the upper limit values
> are wrong. The confusion is due to the hardware
> quirk where the DCDC2 and DCDC3 wires are flipped
> in Pepper.
>
> Signed-off-by: Arun Bharadwaj <arun@gumstix.com>
> ---
>  arch/arm/boot/dts/am335x-pepper.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
> index 99f855d..37b95f6 100644
> --- a/arch/arm/boot/dts/am335x-pepper.dts
> +++ b/arch/arm/boot/dts/am335x-pepper.dts
> @@ -448,7 +448,7 @@
>                         /* VDD_CORE voltage limits 0.95V - 1.26V with +/-4% tolerance */
>                         regulator-name = "vdd_core";
>                         regulator-min-microvolt = <925000>;
> -                       regulator-max-microvolt = <1325000>;
> +                       regulator-max-microvolt = <1150000>;
>                         regulator-boot-on;
>                         regulator-always-on;
>                 };
> @@ -457,7 +457,7 @@
>                         /* VDD_MPU voltage limits 0.95V - 1.1V with +/-4% tolerance */
>                         regulator-name = "vdd_mpu";
>                         regulator-min-microvolt = <925000>;
> -                       regulator-max-microvolt = <1150000>;
> +                       regulator-max-microvolt = <1325000>;
>                         regulator-boot-on;
>                         regulator-always-on;
>                 };
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
