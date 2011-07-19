From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 19 Jul 2011 16:44:29 -0700
Subject: [PATCH v2 1/3] fault-inject: make fault injection available for
	modules
In-Reply-To: <1311111106-26814-2-git-send-email-per.forlin@linaro.org>
References: <1311111106-26814-1-git-send-email-per.forlin@linaro.org>
	<1311111106-26814-2-git-send-email-per.forlin@linaro.org>
Message-ID: <4E2616DD.3010607@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2011 02:31 PM, Per Forlin wrote:
> export symbols should_fail() and init_fault_attr_dentries() in order
> to make modules use the fault injection functionality
>
> Signed-off-by: Per Forlin<per.forlin@linaro.org>
> ---
>   lib/fault-inject.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> index 7e65af7..cd28364 100644
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -131,6 +131,7 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
>
>   	return true;
>   }
> +EXPORT_SYMBOL(should_fail);

Should this be EXPORT_SYMBOL_GPL()?

>
>   #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>
> @@ -311,5 +312,6 @@ fail:
>   	cleanup_fault_attr_dentries(attr);
>   	return -ENOMEM;
>   }
> +EXPORT_SYMBOL(init_fault_attr_dentries);

and here too?

>
>   #endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
