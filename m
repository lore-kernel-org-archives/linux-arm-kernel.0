From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 May 2014 11:09:38 +0200
Subject: [PATCH 1/3] Documentation: Update Arasan SDHC documentation for
 the APM X-Gene SoC SDHC DTS binding
In-Reply-To: <1400398918-1502-2-git-send-email-lho@apm.com>
References: <1400398918-1502-1-git-send-email-lho@apm.com>
 <1400398918-1502-2-git-send-email-lho@apm.com>
Message-ID: <7213964.4Qu0G1nWOL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 May 2014 01:41:56 Loc Ho wrote:
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -8,14 +8,17 @@ Device Tree Bindings for the Arasan SDHCI Controller
>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  
>  Required Properties:
> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> +                'xgene,arasan,sdhci-8.9a'
>    - reg: From mmc bindings: Register location and length.
> -  - clocks: From clock bindings: Handles to clock inputs.
> -  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> 

The driver as you patch is in this version actually requires a second set
of registers. As I commented there, it's probably not the best way to do
things, but you also forgot to update the binding here.

Always make sure that the binding document actually documents what you
implement!

	Arnd
