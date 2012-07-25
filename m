From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 17:34:50 +0000
Subject: [PATCH 6/7] ARM: pxa3xx: add generic DT machine code
In-Reply-To: <1343233066-15397-7-git-send-email-zonque@gmail.com>
References: <1343233066-15397-1-git-send-email-zonque@gmail.com>
 <1343233066-15397-7-git-send-email-zonque@gmail.com>
Message-ID: <201207251734.50946.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, Daniel Mack wrote:
> Add a DT_MACHINE_START entry for PXA3xx machines and a auxdata table for
> some of the devices. This file can be extended to also support pxa2xx
> boards.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  arch/arm/mach-pxa/Kconfig  |   12 +++++++++
>  arch/arm/mach-pxa/Makefile |    3 +++
>  arch/arm/mach-pxa/pxa-dt.c |   61 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+)

The code looks good, but I wonder if it would be better to add it to the pxa3xx.c
file instead. One more comment:


> +static const char *pxa3xx_dt_board_compat[] __initdata = {
> +       "mrvl,pxa3xx",
> +};

We should try to avoid wildcards in compatible properties but rather be
more specific. I would use separate values for pxa300/310/320/920/930/935
that you could all list here if they have the same auxdata lookup table.

	Arnd
