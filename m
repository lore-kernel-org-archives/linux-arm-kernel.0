From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Jul 2014 15:22:32 +0100
Subject: [PATCH v4 7/7] arm/arm64: Unexport restart handlers
In-Reply-To: <1405265431-4561-8-git-send-email-linux@roeck-us.net>
References: <1405265431-4561-1-git-send-email-linux@roeck-us.net>
 <1405265431-4561-8-git-send-email-linux@roeck-us.net>
Message-ID: <20140714142232.GB1112@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 13, 2014 at 04:30:31PM +0100, Guenter Roeck wrote:
> Implementing a restart handler in a module don't make sense
> as there would be no guarantee that the module is loaded when
> a restart is needed. Unexport arm_pm_restart to ensure that
> no one gets the idea to do it anyway.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v4: No change
> v3: No change
> v2: No change
> 
>  arch/arm/kernel/process.c   | 1 -
>  arch/arm64/kernel/process.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 5d191e3..25c7f00 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -125,7 +125,6 @@ void (*pm_power_off)(void);
>  EXPORT_SYMBOL(pm_power_off);
>  
>  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd) = null_restart;
> -EXPORT_SYMBOL_GPL(arm_pm_restart);

Unless I miss something, how is this different from registering a
restart notifier from a module (blocking_notifier_chain_register is
exported)?

-- 
Catalin
