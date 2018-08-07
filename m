From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 7 Aug 2018 12:50:57 +0100
Subject: [PATCH 1/1] arm64: dts: Stingray: Adjust SMMU non-secure context
 interrupt
In-Reply-To: <1533632824-17436-1-git-send-email-jitendra.bhivare@broadcom.com>
References: <1533632824-17436-1-git-send-email-jitendra.bhivare@broadcom.com>
Message-ID: <1780aecd-f81d-02fe-086c-a32506c013b7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/18 10:07, Jitendra Bhivare wrote:
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> 
> One context bank has been reserved for secure master, CRMU.
> hence need to remove context interrupt accordingly. Doing
> the same in this patch.

FWIW, if the motivation here is that the SMMU driver inadvertently 
treats the extra context interrupt as an error, then do note that we 
have a patch queued to fix that already (see commit d1e20222d537 in 
linux-next). However if this context is always going to be reserved and 
you don't expect secure software or firmware to ever consume this DT, 
then removing the interrupt specifier doesn't do any harm.

Robin.

> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
> ---
>   arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> index b203152..7fcaf38 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> @@ -244,8 +244,7 @@
>   				     <GIC_SPI 770 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 771 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 772 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 774 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>;
>   			#iommu-cells = <2>;
>   		};
>   	};
> 
