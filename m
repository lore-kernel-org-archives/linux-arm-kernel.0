From: gsi@denx.de (Gerhard Sittig)
Date: Wed, 26 Mar 2014 23:12:25 +0100
Subject: [PATCH 2/3] dts: socfpga: Fix ethernet entries for the stmmac
In-Reply-To: <1395790482-3957-3-git-send-email-dinguyen@altera.com>
References: <1395790482-3957-1-git-send-email-dinguyen@altera.com>
 <1395790482-3957-3-git-send-email-dinguyen@altera.com>
Message-ID: <20140326221225.GP3998@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-03-25 at 18:34 -0500, dinguyen at altera.com wrote:
> 
> -			#size-cells = <1>;
> -			compatible = "altr,socfpga-stmmac";
> -			altr,sysmgr-syscon = <&sysmgr 0x60>;
> +		gmac0: ethernet at ff700000 {
> +			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
>  			status = "disabled";
> -			ranges;
> -
> -			gmac0: gmac0 at ff700000 {
> -				compatible = "snps,dwmac-3.70a", "snps,dwmac";
> -				reg = <0xff700000 0x2000>;
> -				interrupts = <0 115 4>;
> -				interrupt-names = "macirq";
> -				mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
> -				clocks = <&emac0_clk>;
> -				clock-names = "stmmaceth";
> -			};
> +			altr,sysmgr-syscon = <&sysmgr 0x60>;
> +			reg = <0xff700000 0x2000>;
> +			interrupts = <0 115 4>;
> +			interrupt-names = "macirq";
> +			mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
> +			clocks = <&emac0_clk>;
> +			clock-names = "stmmaceth";
>  		};

not strictly related to this patch, but noticed in bypassing:

is the 'clocks' spec correct?  ISTR that 'emac0_clk' is the PLL
output, while the gated clock for the EMAC IP block is named
'emac_0_clk' (note the extra underscore)


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
