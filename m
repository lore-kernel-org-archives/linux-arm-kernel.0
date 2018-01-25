From: dongas86@gmail.com (Dong Aisheng)
Date: Thu, 25 Jan 2018 18:33:16 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sx: add ARM power domain support
In-Reply-To: <1516725734-32745-2-git-send-email-Anson.Huang@nxp.com>
References: <1516725734-32745-1-git-send-email-Anson.Huang@nxp.com>
 <1516725734-32745-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180125103316.GB24622@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 24, 2018 at 12:42:14AM +0800, Anson Huang wrote:
> Add ARM power domain in PGC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> this patch should be based on 0001-ARM-dts-imx6sx-add-pu-power-domain-support.patch
>  arch/arm/boot/dts/imx6sx.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 42ef4c6..aa29ca6 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -768,6 +768,11 @@
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  
> +					power-domain at 0 {

Nitpick: probably an 'arm' prefix is better:
arm: power-domain at 0

Anyway, it's minor depends on maintainer's perference.

Otherwise, looks fine

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> +						reg = <0>;
> +						#power-domain-cells = <0>;
> +					};
> +
>  					pd_pu: power-domain at 1 {
>  						reg = <1>;
>  						#power-domain-cells = <0>;
> -- 
> 2.7.4
> 
