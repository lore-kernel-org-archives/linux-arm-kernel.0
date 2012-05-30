From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 15:15:52 +0800
Subject: [PATCH 18/22] mfd: Remove redundant Kconfig entry
In-Reply-To: <1338353260-10097-19-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-19-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYpCMRurpDgz5X-Qsv5qUgzeVX3S8trWHByTaw6R35_jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> During ab8500-core clean-up the Kconfig entry for AB8500_I2C_CORE
> was left remnant. This patch simply removes it.
>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> ?drivers/mfd/Kconfig | ? 10 ----------
> ?1 file changed, 10 deletions(-)
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 11a1b65..b697136 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -660,16 +660,6 @@ config AB8500_CORE
> ? ? ? ? ?the irq_chip parts for handling the Mixed Signal chip events.
> ? ? ? ? ?This chip embeds various other multimedia funtionalities as well.
>
> -config AB8500_I2C_CORE
> - ? ? ? bool "AB8500 register access via PRCMU I2C"
> - ? ? ? depends on AB8500_CORE && MFD_DB8500_PRCMU

You need to move these dependencies under the AB8500_CORE config
entry instead.

> - ? ? ? default y

I wonder if in  arch/arm/mach-ux500/Kconfig MACH_MOP500 should
select this instead, all MOP500 children have this an *won't* work
without it.

Yours,
Linus Walleij
