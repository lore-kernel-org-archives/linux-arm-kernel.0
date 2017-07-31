From: nm@ti.com (Nishanth Menon)
Date: Mon, 31 Jul 2017 07:34:43 -0500
Subject: [PATCH] psci: add CPU_IDLE dependency
In-Reply-To: <20170731085523.320244-1-arnd@arndb.de>
References: <20170731085523.320244-1-arnd@arndb.de>
Message-ID: <ab4a0f46-6b8a-9198-8a4f-898834685b16@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2017 03:55 AM, Arnd Bergmann wrote:
> I ran into a build error for the psci_checker:
> 
> drivers/firmware/psci_checker.o: In function `psci_checker':
> psci_checker.c:(.init.text+0x528): undefined reference to `cpuidle_devices'
> 
> As far as I can tell, this is simply a very rare combination of options,
> but the problem has existed since the code was initially added.
> Adding a Kconfig dependency makes it build properly.
> 
> Fixes: ea8b1c4a6019 ("drivers: psci: PSCI checker module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/firmware/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 6e4ed5a9c6fd..1983e6e0106f 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -10,7 +10,7 @@ config ARM_PSCI_FW
>   
>   config ARM_PSCI_CHECKER
>   	bool "ARM PSCI checker"
> -	depends on ARM_PSCI_FW && HOTPLUG_CPU && !TORTURE_TEST
> +	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
>   	help
>   	  Run the PSCI checker during startup. This checks that hotplug and
>   	  suspend operations work correctly when using PSCI.
> 
Ccying linux-arm and linux-pm

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
