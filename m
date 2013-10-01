From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 1 Oct 2013 08:57:28 +0200
Subject: [PATCH 2/3] nohz: Drop generic vtime obsolete dependency on
 CONFIG_64BIT
In-Reply-To: <1380550012-7321-3-git-send-email-fweisbec@gmail.com>
References: <1380550012-7321-1-git-send-email-fweisbec@gmail.com>
 <1380550012-7321-3-git-send-email-fweisbec@gmail.com>
Message-ID: <20131001065728.GB19718@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Frederic Weisbecker <fweisbec@gmail.com> wrote:

>  config VIRT_CPU_ACCOUNTING_GEN
>  	bool "Full dynticks CPU time accounting"
> -	depends on HAVE_CONTEXT_TRACKING && 64BIT
> +	depends on HAVE_CONTEXT_TRACKING
>  	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
>  	select VIRT_CPU_ACCOUNTING
>  	select CONTEXT_TRACKING

> @@ -100,7 +100,6 @@ config NO_HZ_FULL
>  	# RCU_USER_QS dependency
>  	depends on HAVE_CONTEXT_TRACKING
>  	# VIRT_CPU_ACCOUNTING_GEN dependency
> -	depends on 64BIT
>  	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN

Yay!

Thanks,

	Ingo
