From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 15:43:13 +0000
Subject: [PATCH 5/5] ARM: ux500: Do not supply DMA platform data when
 booting u8540 platform
In-Reply-To: <1363966065-2478-5-git-send-email-lee.jones@linaro.org>
References: <1363966065-2478-1-git-send-email-lee.jones@linaro.org>
 <1363966065-2478-5-git-send-email-lee.jones@linaro.org>
Message-ID: <201303221543.14165.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Lee Jones wrote:
>         /* automatically probe child nodes of db8500 device */
>         of_platform_populate(NULL, u8500_local_bus_nodes, u8500_auxdata_lookup, parent);
> +
> +       if (of_machine_is_compatible("st-ericsson,u8540"))
> +               of_platform_populate(NULL, u8500_local_bus_nodes,
> +                                    u8540_auxdata_uart_lookup, parent);
> +       else
> +               of_platform_populate(NULL, u8500_local_bus_nodes,
> +                                    u8500_auxdata_uart_lookup, parent);
>  }
>  

Does this still work on u8500? I did not think you could call 
of_platform_populate twice on the root node and still get the result
you want.

	Arnd
