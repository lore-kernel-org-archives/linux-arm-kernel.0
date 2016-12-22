From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 22 Dec 2016 08:35:19 +0100
Subject: [PATCH] ARM64: zynqmp: Fix i2c node's compatible string
In-Reply-To: <1482385788-7187-1-git-send-email-moritz.fischer@ettus.com>
References: <1482385788-7187-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <d1e69302-8367-7c57-ecd7-f72861c3a49e@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.12.2016 06:49, Moritz Fischer wrote:
> From: Moritz Fischer <mdf@kernel.org>
> 
> The Zynq Ultrascale MP uses version 1.4 of the Cadence IP core
> which fixes some silicon bugs that needed software workarounds
> in Version 1.0 that was used on Zynq systems.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Cc: U-Boot List <u-boot@lists.denx.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
> 
> Hi Michal,
> 
> I think this is a slip up and should be r1p14 for
> Ultrascale ZynqMP. drivers/i2c/i2c-cadence.c already uses this.
> I Cc'd the u-boot list, because the same change would be required there.
> 
> Cheers,
> 
> Moritz
> 
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 68a90833..a5a5f91 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -175,7 +175,7 @@
>  		};
>  
>  		i2c0: i2c at ff020000 {
> -			compatible = "cdns,i2c-r1p10";
> +			compatible = "cdns,i2c-r1p14";

I was checking this internally and p10 is doing something what p14
doesn't need to do. That's why this should be

compatible = "cdns,i2c-r1p14", "cdns,i2c-r1p10";

The same of course for u-boot where also p14 should be added to the driver.

Thanks,
Michal
