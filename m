From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 1 Jul 2018 17:34:04 +0800
Subject: [PATCH v1] ARM: dts: imx6sl-evk: keep sw4 always on
In-Reply-To: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
References: <1529930051-14122-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <20180701093402.GN4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 08:34:11PM +0800, Robin Gong wrote:
> SW4 is one power rail for LPDDR2 on i.mx6sl-evk, so it should
> be kept always on. But it's disabled after switch disabled
> interface implemented in pfuze driver
> 'commit 5fe156f1cab4
> ("regulator: pfuze100: add enable/disable for switch")'.Thus,
> it breaks kernel bootup. Add 'regulator-always-on' for SW4.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Does that mean boards with existing DTB installed will stop working with
new kernel?  That's bad, and the kernel commit should probably be
reverted.

Shawn

> ---
>  arch/arm/boot/dts/imx6sl-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
> index 37e792f..798df66 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -199,6 +199,7 @@
>  			sw4_reg: sw4 {
>  				regulator-min-microvolt = <800000>;
>  				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
>  			};
>  
>  			swbst_reg: swbst {
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
