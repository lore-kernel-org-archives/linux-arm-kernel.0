From: csd_b@daudt.org (Christian Daudt)
Date: Thu, 28 Mar 2013 09:07:41 -0700
Subject: [PATCH V7 2/2] ARM: bcm281xx: Add timer driver (DT portion)
In-Reply-To: <1363210048-3334-2-git-send-email-csd@broadcom.com>
References: <1363210048-3334-1-git-send-email-csd@broadcom.com>
 <1363210048-3334-2-git-send-email-csd@broadcom.com>
Message-ID: <CAGFynZ_YEHbUQxGFgp_SA__4xRge64oQ-y5ypXhV5mhtM2k4+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 2:27 PM, Christian Daudt <csd@broadcom.com> wrote:
> This adds support for the Broadcom timer, used in the following SoCs:
> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
>
> Updates from V6:
> - Split DT portion into a separate patch
>
> Updates from V5:
> - Rebase to latest arm-soc/for-next
>
> Updates from V4:
> - Switch code to use CLOCKSOURCE_OF_DECLARE
>
> Updates from V3:
> - Migrate to 3.9 timer framework updates
>
> Updates from V2:
> - prepend static fns + fields with kona_
>
> Updates from V1:
> - Rename bcm_timer.c to bcm_kona_timer.c
> - Pull .h into bcm_kona_timer.c
> - Make timers static
> - Clean up comment block
> - Switched to using clockevents_config_and_register
> - Added an error to the get_timer loop if it repeats too much
> - Added to Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt
> - Added missing readl to timer_disable_and_clear
>
> Note: bcm,kona-timer was kept as the 'compatible' field to make it
> specific enough for when there are multiple bcm timers (bcm,timer is
> too generic).
>
> Signed-off-by: Christian Daudt <csd@broadcom.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: John Stultz <john.stultz@linaro.org>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>
> diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt b/Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt
> new file mode 100644
> index 0000000..59fa6e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/bcm,kona-timer.txt
> @@ -0,0 +1,19 @@
> +Broadcom Kona Family timer
> +-----------------------------------------------------
> +This timer is used in the following Broadcom SoCs:
> + BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> +
> +Required properties:
> +- compatible : "bcm,kona-timer"
> +- reg : Register range for the timer
> +- interrupts : interrupt for the timer
> +- clock-frequency: frequency that the clock operates
> +
> +Example:
> +       timer at 35006000 {
> +               compatible = "bcm,kona-timer";
> +               reg = <0x35006000 0x1000>;
> +               interrupts = <0x0 7 0x4>;
> +               clock-frequency = <32768>;
> +       };
> +
> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index ad13588..8f71f40 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -47,4 +47,12 @@
>                     cache-unified;
>                     cache-level = <2>;
>         };
> +
> +       timer at 35006000 {
> +               compatible = "bcm,kona-timer";
> +               reg = <0x35006000 0x1000>;
> +               interrupts = <0x0 7 0x4>;
> +               clock-frequency = <32768>;
> +       };
> +
>  };
> --
> 1.7.10.4
>
>
Hi Grant,
 In discussion with Olof @ Connect, he suggested that it would be best
to send dt changes as a standalone patch to devicetree-discuss list to
get it applied on its own. Can you pls apply this patch ?

 Thanks,
   csd
