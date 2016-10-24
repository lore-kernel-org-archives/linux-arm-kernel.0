From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 24 Oct 2016 09:36:20 +0100
Subject: [PATCH 1/3] arm64: arch_timer: Add device tree binding for
 hisilicon-161x01 erratum
In-Reply-To: <962ea92f-870b-e1d0-5bb7-1a6d66c35122@huawei.com>
References: <962ea92f-870b-e1d0-5bb7-1a6d66c35122@huawei.com>
Message-ID: <3a29c03a-2da1-7bfe-28ff-21dada50ee8d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/10/16 04:21, Ding Tianhong wrote:
> This erratum describes a bug in logic outside the core, so MIDR can't be
> used to identify its presence, and reading an SoC-specific revision
> register from common arch timer code would be awkward.  So, describe it
> in the device tree.
> 
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> ---
>  Documentation/devicetree/bindings/arm/arch_timer.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
> index ef5fbe9..26bc837 100644
> --- a/Documentation/devicetree/bindings/arm/arch_timer.txt
> +++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
> @@ -31,6 +31,12 @@ to deliver its interrupts via SPIs.
>    This also affects writes to the tval register, due to the implicit
>    counter read.
> 
> +- hisilicon,erratum-161x01 : A boolean property. Indicates the presence of
> +  QorIQ erratum 161201, which says that reading the counter is

Other than the copy/paste of the FSL erratum, please document the actual
erratum number. Is that 161x01 or 161201?

> +  unreliable unless the small range of value is returned by back-to-back reads.

That's a detail that doesn't belong in the DT, but that would be much
better next to the code doing the actual handling.

> +  This also affects writes to the tval register, due to the implicit
> +  counter read.
> +
>  ** Optional properties:
> 
>  - arm,cpu-registers-not-fw-configured : Firmware does not initialize
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
