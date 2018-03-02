From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 2 Mar 2018 12:00:26 -0500
Subject: [PATCH v2 2/2] ARM: ftrace: Add MODULE_PLTS support
In-Reply-To: <20180301164343.5794-3-alexander.sverdlin@nokia.com>
References: <20180301164343.5794-1-alexander.sverdlin@nokia.com>
 <20180301164343.5794-3-alexander.sverdlin@nokia.com>
Message-ID: <20180302120026.52f34ad2@vmware.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  1 Mar 2018 17:43:43 +0100
Alexander Sverdlin <alexander.sverdlin@nokia.com> wrote:

> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> index 9e842ff..3e663f9 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -19,6 +19,7 @@ struct dyn_arch_ftrace {
>  #ifdef CONFIG_OLD_MCOUNT
>  	bool	old_mcount;
>  #endif

I think you want to add:

#ifdef CONFIG_ARM_MODULE_PLTS
> +	struct module *mod;
#endif

This will add more memory overhead, and we don't want to add that if it
is not needed.

-- Steve
