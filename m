From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Jul 2014 15:55:04 +0100
Subject: [PATCH v4 2/7] arm64: Support restart through restart notifier
 call chain
In-Reply-To: <1405265431-4561-3-git-send-email-linux@roeck-us.net>
References: <1405265431-4561-1-git-send-email-linux@roeck-us.net>
 <1405265431-4561-3-git-send-email-linux@roeck-us.net>
Message-ID: <20140714145504.GD1112@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 13, 2014 at 04:30:26PM +0100, Guenter Roeck wrote:
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 43b7c34..b2da6d5 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -174,6 +174,8 @@ void machine_restart(char *cmd)
>  	/* Now call the architecture specific reboot code. */
>  	if (arm_pm_restart)
>  		arm_pm_restart(reboot_mode, cmd);
> +	else
> +		kernel_restart_notify(cmd);

There are couple of drivers specific to arm64, once they are converted
we can get rid of arm_pm_restart entirely here.

-- 
Catalin
