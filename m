From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 12 Feb 2014 13:42:49 +0100
Subject: [PATCH] ARM: mm: cache-l2x0: Check for status property of DT node
In-Reply-To: <1392206478-11530-1-git-send-email-tushar.behera@linaro.org>
References: <1392206478-11530-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <52FB6C49.6010401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[making Cc list a bit more comprehensive]

On 12.02.2014 13:01, Tushar Behera wrote:
> Currently only the DT node is checked during l2x0 cache initialization,
> but it doesn't check the status of the DT node. Thus it gets called
> even if the status of DT node for L2 controller is disabled.
>
> Add explicit check to ensure that L2 cache is initialized only for
> desired boards.
>
> Reported-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
>   arch/arm/mm/cache-l2x0.c |    3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 7abde2c..f075cb1 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -978,6 +978,9 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
>   	if (!np)
>   		return -ENODEV;
>
> +	if (!of_device_is_available(np))
> +		return -ENODEV;
> +
>   	if (of_address_to_resource(np, 0, &res))
>   		return -ENODEV;
>
>

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
