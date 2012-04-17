From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 17 Apr 2012 10:22:31 +0100
Subject: [PATCH v3 6/6] ARM: vexpress: plug local timers into the DT code
In-Reply-To: <1334592810-4382-7-git-send-email-marc.zyngier@arm.com>
References: <1334592810-4382-1-git-send-email-marc.zyngier@arm.com>
 <1334592810-4382-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <1334654551.3361.9.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-04-16 at 17:13 +0100, Marc Zyngier wrote:
> @@ -643,6 +644,11 @@ static void __init v2m_dt_timer_init(void)
>  		return;
>  	node = of_find_node_by_path(path);
>  	v2m_sp804_init(of_iomap(node, 0), irq_of_parse_and_map(node, 0));
> +	if (arch_timer_of_register())
> +		twd_local_timer_of_register();
> +
> +	if (arch_timer_sched_clock_init())
> +		versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
>  }

My personal preference would be "if (arch_timer*() != 0)" here -
obviously makes no difference, but clearly states the idea, but anyway
looks good to me.

Acked-by: Pawel Moll <pawel.moll@arm.com>

Cheers!

Pawe?
