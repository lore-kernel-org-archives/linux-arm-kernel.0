From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 23 Aug 2013 14:58:52 +0530
Subject: [PATCH v2 5/5] ARM: dts: am33xx: adopt to cpsw changes
In-Reply-To: <1377247417-27386-6-git-send-email-zonque@gmail.com>
References: <1377247417-27386-1-git-send-email-zonque@gmail.com>
 <1377247417-27386-6-git-send-email-zonque@gmail.com>
Message-ID: <52172B54.8020201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 August 2013 02:13 PM, Daniel Mack wrote:
> This third memory region just denotes one single register in the CONTROL
> module block. The driver uses that in order to set the correct physical
> ethernet interface modes.
> 
> Also update the compatible string to make use of the am335x specific
> features of the cpsw driver.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index a785b95..1a1e9dd 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -446,7 +446,7 @@
>  		};
>  
>  		mac: ethernet at 4a100000 {
> -			compatible = "ti,cpsw";
> +			compatible = "ti,am3352-cpsw";

Please keep this as

	compatible = "ti,am3352-cpsw", "ti,cpsw";

so users can upgrade the DTB or kernel independently. Apart from this
the series looks good to me.

Thanks,
Sekhar
