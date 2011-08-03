From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 03 Aug 2011 15:30:43 +0400
Subject: [PATCH 07/17] mach-integrator: introduce cm_read function helper
	to read CM_CTRL register
In-Reply-To: <1312364089-32380-8-git-send-email-bryan.wu@canonical.com>
References: <1312364089-32380-1-git-send-email-bryan.wu@canonical.com>
	<1312364089-32380-8-git-send-email-bryan.wu@canonical.com>
Message-ID: <4E393163.1050800@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03-08-2011 13:34, Bryan Wu wrote:

> Signed-off-by: Bryan Wu<bryan.wu@canonical.com>
> ---
>   arch/arm/mach-integrator/core.c            |   17 +++++++++++++++++
>   arch/arm/mach-integrator/include/mach/cm.h |    1 +
>   2 files changed, 18 insertions(+), 0 deletions(-)

> diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
> index 77315b9..0ee6af6 100644
> --- a/arch/arm/mach-integrator/core.c
> +++ b/arch/arm/mach-integrator/core.c
> @@ -225,6 +225,23 @@ void cm_control(u32 mask, u32 set)
>
>   EXPORT_SYMBOL(cm_control);
>
> +/**
> + * cm_read - read the CM_CTRL register.
> + */
> +u32 cm_read(void)
> +{
> +	unsigned long flags;
> +	u32 val = 0;

    Intialization not needed.

> +
> +	spin_lock_irqsave(&cm_lock, flags);
> +	val = readl(CM_CTRL);
> +	spin_unlock_irqrestore(&cm_lock, flags);
> +
> +	return val;
> +}
> +
> +EXPORT_SYMBOL(cm_read);
> +
>   /*
>    * We need to stop things allocating the low memory; ideally we need a
>    * better implementation of GFP_DMA which does not assume that DMA-able

WBR, Sergei
