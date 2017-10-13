From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Oct 2017 09:55:04 +0100
Subject: [PATCH/RFC 1/5] dt-bindings: mfd: bd9571mwv: Document
 rohm,ddr-backup-power
In-Reply-To: <1507649178-31473-2-git-send-email-geert+renesas@glider.be>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20171013085504.i65ohil6dqdzrd2q@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Oct 2017, Geert Uytterhoeven wrote:

> Document the new optional "rohm,ddr-backup-power" property.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/mfd/bd9571mwv.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/bd9571mwv.txt b/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
> index 9ab216a851d5619b..7ea3f2db41d4e501 100644
> --- a/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
> +++ b/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
> @@ -25,6 +25,12 @@ Required properties:
>  			    Each child node is defined using the standard
>  			    binding for regulators.
>  
> +Optional properties:
> +  - rohm,ddr-backup-power : Value to use for DDR-Backup Power.  This controls
> +			    which DDR rails need to be kept powered when backup
> +			    mode is enabled, cfr. the KEEPON_DDR* bits in the

Perhaps it's just me, but I'm confused by this line.

Can you word it another way?

> +			    documentation for the "BKUP Mode Cnt" register.
> +
>  Example:
>  
>  	pmic: pmic at 30 {
> @@ -36,6 +42,7 @@ Example:
>  		#interrupt-cells = <2>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		rohm,ddr-backup-power = <15>;

Can you explain what this means?  Is it a mask, or does line 15 need
to be kept on?  What is the range?  Is 0 acceptable?  Clarification
required please.

>  		regulators {
>  			dvfs: dvfs {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
