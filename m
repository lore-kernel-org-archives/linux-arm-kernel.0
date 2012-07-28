From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 28 Jul 2012 13:12:37 +0200
Subject: [PATCH] ixp4xx: Declare MODULE_FIRMWARE usage
In-Reply-To: <1343241186-103293-1-git-send-email-tim.gardner@canonical.com>
 (Tim Gardner's message of "Wed, 25 Jul 2012 12:33:06 -0600")
References: <1343241186-103293-1-git-send-email-tim.gardner@canonical.com>
Message-ID: <m34nosi1ga.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tim Gardner <tim.gardner@canonical.com> writes:

> +++ b/arch/arm/mach-ixp4xx/ixp4xx_npe.c
> @@ -116,7 +116,11 @@
>  /* NPE mailbox_status value for reset */
>  #define RESET_MBOX_STAT			0x0000F0F0
>  
> -const char *npe_names[] = { "NPE-A", "NPE-B", "NPE-C" };
> +#define NPE_A_FIRMWARE "NPE-A"
> +#define NPE_B_FIRMWARE "NPE-B"
> +#define NPE_C_FIRMWARE "NPE-C"
> +
> +const char *npe_names[] = { NPE_A_FIRMWARE, NPE_B_FIRMWARE, NPE_C_FIRMWARE };
>  
>  #define print_npe(pri, npe, fmt, ...)					\
>  	printk(pri "%s: " fmt, npe_name(npe), ## __VA_ARGS__)
> @@ -724,6 +728,9 @@ module_exit(npe_cleanup_module);
>  
>  MODULE_AUTHOR("Krzysztof Halasa");
>  MODULE_LICENSE("GPL v2");
> +MODULE_FIRMWARE(NPE_A_FIRMWARE);
> +MODULE_FIRMWARE(NPE_B_FIRMWARE);
> +MODULE_FIRMWARE(NPE_C_FIRMWARE);
>  
>  EXPORT_SYMBOL(npe_names);
>  EXPORT_SYMBOL(npe_running);

This looks like a good idea, thanks.
-- 
Krzysztof Halasa
