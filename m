From: russ.dill@gmail.com (Russ Dill)
Date: Fri, 11 Jan 2013 00:08:28 -0800
Subject: [PATCH v4 2/4] ARM: dts: AM33XX: Set pmic-shutdown-controller for
 BeagleBone
In-Reply-To: <1355464997-19367-3-git-send-email-anilkumar@ti.com>
References: <1355464997-19367-1-git-send-email-anilkumar@ti.com>
 <1355464997-19367-3-git-send-email-anilkumar@ti.com>
Message-ID: <CA+Bv8XZ_B-yKnmFNaUw3Xp3pss3WmcN+WxZ7YYZ4-TPgc2dGMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 10:03 PM, AnilKumar Ch <anilkumar@ti.com> wrote:
> Set ti,pmic-shutdown-controller for BeagleBone in am335x-bone.dts
> file, this flag is used by the driver to set tps65217 PMIC status
> to OFF when PWR_EN toggle.
>
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Looks good

Reviewed-by: Russ Dill <russ.dill@ti.com>
Acked-by: Russ Dill <russ.dill@ti.com>

> ---
>  arch/arm/boot/dts/am335x-bone.dts |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index 5302f79..e7dff9d 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -88,6 +88,8 @@
>  /include/ "tps65217.dtsi"
>
>  &tps {
> +       ti,pmic-shutdown-controller;
> +
>         regulators {
>                 dcdc1_reg: regulator at 0 {
>                         regulator-always-on;
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
