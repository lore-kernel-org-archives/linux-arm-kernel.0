From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jun 2013 00:28:53 +0200
Subject: [PATCH v3 04/11] ARM: mmp: avoid to include head file in mach-mmp
In-Reply-To: <1370251845-31373-5-git-send-email-haojian.zhuang@gmail.com>
References: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
 <1370251845-31373-5-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <201306040028.53499.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 June 2013, Haojian Zhuang wrote:
> +extern struct irq_chip icu_irq_chip;
>  void __init mmp2_init_irq(void)
>  {
>         mmp2_init_icu();
> +       icu_irq_chip.irq_set_wake = mmp2_set_wake;
>  }
>  

I think it's better to put the declaration into a header file in
include/linux/irqchip/. Extern declarations in .c files are always
fragile.

	Arnd
