From: rdunlap@infradead.org (Randy Dunlap)
Date: Tue, 6 Nov 2018 09:03:23 -0800
Subject: [PATCHv10 3/8] firmware: add Intel Stratix10 service layer driver
In-Reply-To: <1541523172-5171-4-git-send-email-richard.gong@linux.intel.com>
References: <1541523172-5171-1-git-send-email-richard.gong@linux.intel.com>
 <1541523172-5171-4-git-send-email-richard.gong@linux.intel.com>
Message-ID: <595b853f-6a8c-d608-e716-95ef1c84d0b9@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/6/18 8:52 AM, richard.gong at linux.intel.com wrote:
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 7273e50..b6813bc 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -216,6 +216,18 @@ config FW_CFG_SYSFS_CMDLINE
>  	  WARNING: Using incorrect parameters (base address in particular)
>  	  may crash your system.
>  
> +config INTEL_STRATIX10_SERVICE
> +       tristate "Intel Stratix10 Service Layer"
> +       depends on HAVE_ARM_SMCCC
> +       default n
> +       help
> +        Intel Stratix10 service layer runs at privileged exception level,
> +	interfaces with the service providers (FPGA manager is one of them) and
> +	manages secure monitor call to communicate with secure monitor software
> +	at secure monitor exception level.
> +
> +        Say Y here if you want Stratix10 service layer support.

from Documentation/process/coding-style.rst:

Lines under a ``config`` definition are indented with one tab,
while help text is indented an additional two spaces.


thanks.
-- 
~Randy
