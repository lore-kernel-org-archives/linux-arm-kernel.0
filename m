From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 04 Jul 2018 15:29:37 +0200
Subject: [PATCH v2] ARM: dts: armada-38x: use the new thermal binding
In-Reply-To: <fa45caea9ab04a515805e80b8c02a74a00a908e0.1530588260.git.baruch@tkos.co.il>
 (Baruch Siach's message of "Tue, 3 Jul 2018 06:24:20 +0300")
References: <fa45caea9ab04a515805e80b8c02a74a00a908e0.1530588260.git.baruch@tkos.co.il>
Message-ID: <87muv72kou.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,
 
 On mar., juil. 03 2018, Baruch Siach <baruch@tkos.co.il> wrote:

> Commit 2f28e4c24b10e (thermal: armada: Clarify control registers
> accesses) introduced the new thermal binding. The new binding extends
> the second registers field size to 8. Switch to the new binding to fix
> thermal reading values. Without this change the fix for errata #132698
> introduced in commit 8c0b888f661 (thermal: armada: Change sensors trim
> default value) has no effect.
>
> Cc: stable at vger.kernel.org # v4.16+
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>


Applied on mvebu/fixes

Thanks,

Gregory


> ---
> v2:
>   * Typo fixes (Andreas F?rber)
>   * Add Miquel's review tag
>   * Minor wording changes
>   * Cc stable
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 18edc9bc7927..929459c42760 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -547,7 +547,7 @@
>  
>  			thermal: thermal at e8078 {
>  				compatible = "marvell,armada380-thermal";
> -				reg = <0xe4078 0x4>, <0xe4074 0x4>;
> +				reg = <0xe4078 0x4>, <0xe4070 0x8>;
>  				status = "okay";
>  			};
>  
> -- 
> 2.18.0
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
