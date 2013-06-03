From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jun 2013 00:31:31 +0200
Subject: [PATCH v3 07/11] ARM: mmp: move timer registers into driver
In-Reply-To: <1370251845-31373-8-git-send-email-haojian.zhuang@gmail.com>
References: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
 <1370251845-31373-8-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <201306040031.32043.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013, Haojian Zhuang wrote:
>  void __init timer_init(int irq)
>  {
> +       mmp_timer_base = ioremap(TIMERS_PHY_BASE, PAGE_SIZE);
> +       BUG_ON(!mmp_timer_base);
> +

Here I would pass TIMERS_PHY_BASE as another argument, and move the
definition of that macro back into platform code. Device drivers should
be written not to care about physical addresses.

	Arnd
