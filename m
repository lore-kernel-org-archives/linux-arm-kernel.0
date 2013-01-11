From: russ.dill@gmail.com (Russ Dill)
Date: Fri, 11 Jan 2013 00:08:34 -0800
Subject: [PATCH v4 3/4] ARM: dts: AM33XX: Enable system power off control
 in am335x-bone
In-Reply-To: <1355464997-19367-4-git-send-email-anilkumar@ti.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
 <1355464997-19367-4-git-send-email-anilkumar@ti.com>
Message-ID: <CA+Bv8XavP5qtp1QjGQ3uYuO6Rax7MdZ9YwoRG2fEvZb-DrvTvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 10:03 PM, AnilKumar Ch <anilkumar@ti.com> wrote:
> Enable system power off control for BeagleBone in am335x-bone.dts file
> under rtc node. RTC is the incharge of controlling the system power.
> This flag is used by the driver to hook up the pm_power_off system call.
>
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Looks good

Reviewed-by: Russ Dill <russ.dill@ti.com>
Acked-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone.dts |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index e7dff9d..febbe2f 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -52,6 +52,10 @@
>                         };
>
>                 };
> +
> +               rtc at 44e3e000 {
> +                       ti,system-power-controller;
> +               };
>         };
>
>         leds {
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
