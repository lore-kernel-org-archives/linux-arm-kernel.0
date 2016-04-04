From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Mon, 4 Apr 2016 13:52:00 +0900
Subject: [PATCH v4 5/5] printk/nmi: flush NMI messages on the system panic
In-Reply-To: <20160331123657.GN5522@pathway.suse.cz>
References: <1459353210-20260-6-git-send-email-pmladek@suse.com>
 <201603310000.dKufp7mg%fengguang.wu@intel.com>
 <20160331123657.GN5522@pathway.suse.cz>
Message-ID: <20160404045200.GE6164@swordfish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On (03/31/16 14:36), Petr Mladek wrote:
[..]
>  #ifdef CONFIG_PRINTK_NMI
> +#define deferred_console_in_nmi() in_nmi()
>  #else
> +#define deferred_console_in_nmi() 0
[..]
> +	if (!in_sched && !deferred_console_in_nmi()) {
>  		lockdep_off();
>  		/*
>  		 * Try to acquire and then immediately release the console

or use SCHED level for nmi messages instead of defining deferred_console_in_nmi()?
so !in_sched will work for both SCHED and NMI messages.

	-ss
