From: khilman@ti.com (Kevin Hilman)
Date: Thu, 22 Mar 2012 16:12:21 -0700
Subject: [PATCH] ARM: OMAP3+: fix oops triggered in
 omap_prcm_register_chain_handler(v1)
In-Reply-To: <1332379417-7408-1-git-send-email-tom.leiming@gmail.com> (Ming
 Lei's message of "Thu, 22 Mar 2012 09:23:37 +0800")
References: <1332379417-7408-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <87mx7844dm.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ming Lei <tom.leiming@gmail.com> writes:

> This patch fixes the oops below[1].
>
> Obviously, the count of "struct irq_chip_generic" instances to be
> allocated and setup should be irq_setup->nr_regs instead of
> irq_setup->nr_regs plus one, so just fix the iterator to avoid
> the oops. 

[...]

> ---
> v1:
> 	-add a bit more description to the changelog as suggested by
> 	Tero and Kevin.

Thanks for the updated version.

Queuing as a fix for v3.4-rc (branch: for_3.4/fixes/pm)

Kevin
