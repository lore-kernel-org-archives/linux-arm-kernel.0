From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Jan 2017 11:57:40 +0000
Subject: [PATCH 2/2] ARM: DTS: Fix register map for virt-capable GIC
In-Reply-To: <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
References: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
 <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <aa0cb86e-ede2-432b-6248-92679fc06578@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/17 10:53, Marc Zyngier wrote:
> Since everybody copied my own mistake from the DT binding example,
> let's address all the offenders in one swift go.
> 
> Most of them got the CPU interface size wrong (4kB, while it should
> be 8kB), except for both keystone platforms which got the control
> interface wrong (4kB instead of 8kB).
> 
> In the couple of cases were I knew for sure what implementation

                         where

> was used, I've added the "arm,gic-400" compatible string. I'm 99%
> sure that this is what everyong is using, but short of having the

                         everyone

> TRM for all the other SoCs, I've let them alone.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
[...]
> diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
> index 63c7cf0..07bf300 100644
> --- a/arch/arm/boot/dts/keystone-k2g.dtsi
> +++ b/arch/arm/boot/dts/keystone-k2g.dtsi
> @@ -45,7 +45,7 @@
>  		interrupt-controller;
>  		reg = <0x0 0x02561000 0x0 0x1000>,
>  		      <0x0 0x02562000 0x0 0x2000>,
> -		      <0x0 0x02564000 0x0 0x1000>,
> +		      <0x0 0x02564000 0x0 0x2000>,
>  		      <0x0 0x02566000 0x0 0x2000>;
>  		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
>  				IRQ_TYPE_LEVEL_HIGH)>;
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index 02708ba..aaff6816 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -35,7 +35,7 @@
>  		interrupt-controller;
>  		reg = <0x0 0x02561000 0x0 0x1000>,
>  		      <0x0 0x02562000 0x0 0x2000>,
> -		      <0x0 0x02564000 0x0 0x1000>,
> +		      <0x0 0x02564000 0x0 0x2000>,
>  		      <0x0 0x02566000 0x0 0x2000>;
>  		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
>  				IRQ_TYPE_LEVEL_HIGH)>;

FWIW I happen to have some public Keystone TRMs handy from my DMA offset
investigations, and both K2G and K2H explicitly say it's a GIC-400 too.

Robin.
