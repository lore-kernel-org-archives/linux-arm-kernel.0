From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 13:15:50 +0100
Subject: [PATCH 4/6] mfd: db8500-prcmu: get base address from resource
In-Reply-To: <1363866553-15054-5-git-send-email-linus.walleij@stericsson.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363866553-15054-5-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1669538.W5XG4BgH9e@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013 12:49:11 Linus Walleij wrote:
> -#define PRCM_PLLARM_LOCKP       (_PRCMU_BASE + 0x0a8)
> +#define PRCM_PLLARM_LOCKP       (prcmu_base + 0x0a8)
>  #define PRCM_PLLARM_LOCKP_PRCM_PLLARM_LOCKP3   0x2

While this is certainly the least invasive way to get rid of _PRCMU_BASE,
it sucks to refer to local variables in macros. How hard would it
be to find all users of these macros and put the prcmu_base addition
there?

The rest of this patch looks fine to me.

	Arnd
