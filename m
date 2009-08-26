From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Wed, 26 Aug 2009 15:57:08 +0200
Subject: [PATCH] ARM: OpenRD base: Initialize PCI express, i2c and UART 1
In-Reply-To: <20090826094230.574eda24@marrow.netinsight.se>
References: <20090826094230.574eda24@marrow.netinsight.se>
Message-ID: <20090826155708.3dfe4ad2@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Aug 2009 09:42:30 +0200
Simon Kagstrom <simon.kagstrom@netinsight.net> wrote:

> ARM: OpenRD base: Initialize PCI express, i2c and UART 1

> diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
> index f9a2166..003db06 100644
> --- a/arch/arm/mach-kirkwood/openrd_base-setup.c
> +++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
> @@ -64,6 +64,7 @@ static void __init openrd_base_init(void)
>  	kirkwood_mpp_conf(openrd_base_mpp_config);
>  
>  	kirkwood_uart0_init();
> +	kirkwood_uart1_init();

After looking at the openrd design I realised that this might not be
such a hot idea. The UART1 pins are multiplexed with the SD card, so
I'm not sure what happens if you have both of these initialized at the
same time.

Anyone knows how Kirkwood behaves when on-board devices use pins which
are multiplexed for something else?

// Simon
