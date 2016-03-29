From: bp@alien8.de (Borislav Petkov)
Date: Tue, 29 Mar 2016 10:45:49 +0200
Subject: [PATCHv3 9/9] ARM: dts: Add Altera Arria10 L2 Cache EDAC
 devicetree entry
In-Reply-To: <1458576106-24505-10-git-send-email-tthayer@opensource.altera.com>
References: <1458576106-24505-1-git-send-email-tthayer@opensource.altera.com>
 <1458576106-24505-10-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160329084549.GC3705@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 11:01:46AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Add the device tree entries needed to support the Altera L2
> cache EDAC on the Arria10 chip.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2 Match register value (l2-ecc at ffd06010)
> v3 Set ecc_manager to beginning of system_manager. Add sysman
>    phandle. Move IRQs into ecc_manager from children.
> ---
>  arch/arm/boot/dts/socfpga_arria10.dtsi |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
> index cce9e50..345ea97 100644
> --- a/arch/arm/boot/dts/socfpga_arria10.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
> @@ -599,6 +599,21 @@
>  			reg = <0xffe00000 0x40000>;
>  		};
>  
> +		eccmgr: eccmgr at ffd06000 {
> +			compatible = "altr,socfpga-a10-ecc-manager";
> +			altr,sysmgr-syscon = <&sysmgr>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>,
> +				     <0 0 IRQ_TYPE_LEVEL_HIGH>;
> +			ranges;
> +
> +			l2-ecc at ffd06010 {
> +				compatible = "altr,socfpga-a10-l2-ecc";
> +				reg = <0xffd06010 0x4>;
> +			};
> +		};
> +
>  		rst: rstmgr at ffd05000 {
>  			#reset-cells = <1>;
>  			compatible = "altr,rst-mgr";
> -- 

I've picked up all except this one: need an ACK for it too. Dinh, DT-people?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
