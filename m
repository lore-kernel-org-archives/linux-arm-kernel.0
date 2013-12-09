From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Dec 2013 02:13:27 +0100
Subject: [PATCH 6/9] ARM: dts: pxa3xx: move declaration to header
In-Reply-To: <1386543229-1542-7-git-send-email-ynvich@gmail.com>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386543229-1542-7-git-send-email-ynvich@gmail.com>
Message-ID: <201312090213.27395.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 08 December 2013, Sergei Ianovich wrote:
> +#ifdef CONFIG_OF
> +extern void __init pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int));
> +#endif /* CONFIG_OF */
> +

In general, don't put declarations like this into #ifdef, unless you need
an #else clause like

static inline void pxa_dt_irq_init(int (*fn)(struct irq_data *, unsigned int) {}

Same in patch 8.

	Arnd
