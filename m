From: drjones@redhat.com (Andrew Jones)
Date: Mon, 8 Jan 2018 10:28:49 +0100
Subject: [PATCH] arm64: Implement branch predictor hardening for Falkor
In-Reply-To: <1515184139-23743-1-git-send-email-shankerd@codeaurora.org>
References: <1515184139-23743-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <20180108092849.alfqtsmaf2dqakkr@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

On Fri, Jan 05, 2018 at 02:28:59PM -0600, Shanker Donthineni wrote:
...
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index cb0fb37..daf53a5 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -54,6 +54,8 @@ static int cpu_enable_trap_ctr_access(void *__unused)
>  
>  #ifdef CONFIG_KVM
>  extern char __psci_hyp_bp_inval_start[], __psci_hyp_bp_inval_end[];
> +extern char __qcom_hyp_sanitize_link_stack_start[];
> +extern char __qcom_hyp_sanitize_link_stack_end[];
>  
>  static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
>  				const char *hyp_vecs_end)
> @@ -96,8 +98,10 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
>  	spin_unlock(&bp_lock);
>  }
>  #else
> -#define __psci_hyp_bp_inval_start	NULL
> -#define __psci_hyp_bp_inval_end		NULL
> +#define __psci_hyp_bp_inval_start	   	NULL
> +#define __psci_hyp_bp_inval_end			NULL
> +#define __qcom_hyp_sanitize_link_stack_start	NULL
> +#define __qcom_hyp_sanitize_link_stack_start	NULL
                                          ^^ copy+paste error here

Thanks,
drew
