From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Mar 2013 13:11:41 +0100
Subject: [PATCH 3/6] mfd: prcmu: pass a base and size with the early
 initcall
In-Reply-To: <1363866553-15054-4-git-send-email-linus.walleij@stericsson.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363866553-15054-4-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1612996.3qBAFpdrG9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013 12:49:10 Linus Walleij wrote:
> 
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This patch will make an early remapping of the PRCMU, to be
> used when setting up the clocks, that will call down into parts
> of the PRCMU driver before it is probed.
> 
> Going forward this will be removed like this:
> 
> - The mailbox subsystem need to be merged.
>   http://marc.info/?l=linux-kernel&m=136314559201983&w=2
> 
> - At this point the PRCMU clock code can be moved over to the
>   ux500 clock driver in drivers/clk/ux500/* and maintained
>   there in a decentralized manner.
> 
> - This early initcall and PRCMU base parameters become part of
>   the ux500_clk_init() call instead.
> 
> Cc: Suman Anna <s-anna@ti.com>
> Cc: Loic Pallardy <loic.pallardy@st.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
