From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Tue, 07 Jan 2014 12:41:42 +0000
Subject: [PATCH] ARM: cache-l2x0: Parse properties from DT for PL310 cache
 controller
In-Reply-To: <1389094888-24348-1-git-send-email-tushar.behera@linaro.org>
References: <1389094888-24348-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <52CBF606.5080209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/14 11:41, Tushar Behera wrote:
> Parsed auxiliary control properties for PL310 cache controller.
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
> These properties are set for Exynos4 platform. If we can pass these properties
> through device tree for Exynos4, then we can remove the hard-coded L2_AUX_VAL.
> 
>  Documentation/devicetree/bindings/arm/l2cc.txt |   10 ++++++++++
>  arch/arm/include/asm/hardware/cache-l2x0.h     |    1 +
>  arch/arm/mm/cache-l2x0.c                       |   25 ++++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> index b513cb8..213546d 100644
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -44,6 +44,16 @@ Optional properties:
>  - cache-id-part: cache id part number to be used if it is not present
>    on hardware
>  - wt-override: If present then L2 is forced to Write through mode
> +- arm,early-write: If present then BRSEP mode (early write response) is enabled.
> +- arm,data-prefetch: If present then data prefetching is enabled.
> +- arm,instruction-prefetch: If present then instruction prefetching is enabled.
> +- arm,ns-interrupt-access: If present then interrupt mask and interrupt clear
> +  registers can be read or modified in both secure or non-secure accesses.
> +- arm,ns-lockdown: If present then non-secure accesses can write to lockdown
> +  register.
> +- arm,share-override: If present then shared attribute is ignored internally.
> +- arm,full-line-of-zero: If present then 'full line of write zero' behaviour is
> +  enabled.
>  
Hi Tushar,

This has been discussed couple of times in past[1][2], and the opinion was not
to have these in DT as they are more configuration data than the actual hardware
description.

Regards,
Sudeep

[1] https://lkml.org/lkml/2013/11/7/8
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185610.html
