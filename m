From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 13 Feb 2012 18:05:20 -0500
Subject: [PATCH v2 3/4] ARM: architected timers: add DT support
In-Reply-To: <1328115575-24866-4-git-send-email-marc.zyngier@arm.com>
References: <1328115575-24866-1-git-send-email-marc.zyngier@arm.com>
 <1328115575-24866-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <4F399730.2070104@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 02/01/2012 11:59 AM, Marc Zyngier wrote:
> Add runtime DT support and documentation for the Cortex A7/A15
> architected timers.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  .../devicetree/bindings/arm/arch_timer.txt         |   23 +++++++++
>  arch/arm/kernel/arch_timer.c                       |   53 +++++++++++++++++---
>  2 files changed, 69 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/arch_timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
> new file mode 100644
> index 0000000..84e93f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
> @@ -0,0 +1,23 @@
> +* ARM architected timer
> +
> +ARM Cortex-A7 and Cortex-A15 have a per-core architected timer, which
> +provides a per-cpu local timer.
> +
> +The timer is attached to a GIC to deliver its two per-processor
> +interrupts (one for the secure mode, one for the non-secure mode).
> +
> +** Timer node properties:
> +
> +- compatible : Should be "arm,armv7-timer"
> +
> +- interrupts : One or two interrupts for secure and non-secure mode
> +
> +- clock-frequency : The frequency of the main counter, in Hz. Optionnal.

Spelling.

[snip]

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
