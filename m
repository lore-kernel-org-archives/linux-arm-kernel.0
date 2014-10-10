From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Oct 2014 20:22:07 +0200
Subject: [PATCH] ARM: keystone: add bus notifier to set dma_pfn_offset for
 pci devices
In-Reply-To: <1412954137-4567-1-git-send-email-m-karicheri2@ti.com>
References: <1412954137-4567-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <7733803.LRHUrkheId@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 October 2014 11:15:37 Murali Karicheri wrote:
> @@ -54,6 +55,8 @@ static void __init keystone_init(void)
>         keystone_pm_runtime_init();
>         if (platform_nb.notifier_call)
>                 bus_register_notifier(&platform_bus_type, &platform_nb);
> +       if (platform_nb.notifier_call)
> +               bus_register_notifier(&pci_bus_type, &platform_nb);
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> 

No, this looks very wrong. Santosh spent an enormous effort on obsoleting
the platform notifier block by adding the range parser to the platform
device probe path.

You should really remove platform_nb and all associated code rather than
adding more code to it.

NAK

	Arnd
