From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Dec 2012 08:59:09 -0800
Subject: [PATCH 1/9] mailbox: OMAP: introduce mailbox framework
In-Reply-To: <1355836212-17956-2-git-send-email-loic.pallardy-ext@stericsson.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1355836212-17956-2-git-send-email-loic.pallardy-ext@stericsson.com>
Message-ID: <20121218165909.GF4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Loic Pallardy <loic.pallardy-ext@stericsson.com> [121218 05:15]:
> Actually moving it from plat-omap, as this framework/driver code is
> supposed to be under drivers/ folder. The framework should work with
> the current supported OMAP processors (OMAP1+) that have mailbox and
> can be used as a method of interprocessor communication.
> 
> The mailbox hardware (in OMAP) uses a queued mailbox-interrupt mechanism
> that provides a communication channel between processors through a set of
> registers and their associated interrupt signals by sending and receiving
> messages.
> 
> As part of the migration from plat and mach code:
> - Kconfig symbols have been renamed to build OMAP1 or OMAP2+ drivers.
> - mailbox.h has been changed from plat to a dedicated drivers/ folder.
> - soc.h has been changed for plat/cpu.h, since there are dependencies in
>   the cpu_is_XXXX() macro.
> 
> Module names have changed too, instead of mailbox_mach:
> - OMAP1: mailbox-omap1.ko
> - OMAP2+: mailbox-omap2.ko
> 
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>

AFAIK the first two patches should have:
From: Omar Ramirez Luna <omar.luna@linaro.org>

Once that's fixed, for arch/arm/*omap*/* parts:

Acked-by: Tony Lindgren <tony@atomide.com>
