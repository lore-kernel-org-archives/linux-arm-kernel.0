From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 13 Mar 2013 09:35:23 +0100
Subject: [PATCH] mfd: Fix AB8500 build failure if POWER_SUPPLY is not
 configured
In-Reply-To: <1362080229-27334-1-git-send-email-linux@roeck-us.net>
References: <1362080229-27334-1-git-send-email-linux@roeck-us.net>
Message-ID: <20130313083523.GC21994@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Thu, Feb 28, 2013 at 11:37:09AM -0800, Guenter Roeck wrote:
> ab8500-sysctrl.c fails to build if POWER_SUPPLY is not configured.
> 
> drivers/built-in.o: In function `ab8500_power_off':
> drivers/mfd/ab8500-sysctrl.c:37: undefined reference to `power_supply_get_by_name'
> drivers/mfd/ab8500-sysctrl.c:53: undefined reference to `power_supply_get_by_name'
> 
> Select POWER_SUPPLY in Kconfig if AB8500_CORE is configured to fix the problem.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/mfd/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
I applied Axel's patch to my mfd-fixes tree now.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
