From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 17 Aug 2010 16:56:38 +0100
Subject: [PATCH v5] OpenRD: Enable SD/UART selection for serial port 1
References: <1282037263-3038-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <m2oqj7-ih8.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tanmay Upadhyay <tanmay.upadhyay@einfochips.com> wrote:
>
> This patch enables user to use serial port 1 of the OpenRD device for SDIO
> or UART(RS232/RS485). The selection can be done through kernel parameter.
> 
> By default the port would be used for SDIO. To select RS232 or RS485 mode,
> pass string "uart=232" or "uart=485" respectively in the kernel parameters.
> "uart=485" is ignored on OpenRD-Base as it doesn't have RS485 port.
> 
> v2 - use gpio* functions instead of read/write to set/reset GPIO
> v3 - notify user when wrong kernel paramter is passed
> v4 - use linux/gpio.h instead of mach/gpio.h
> v5 - changed uart1_mpp_config to be static, global & __initdata
> 
> +/* Parse boot_command_line string uart=232/485 */
> +__setup("uart=", sd_uart_selection);
>
I really think 'uart=' should be changed to something like 
'kirkwood_openrd_init_uart=' instead; this sort of thing is surely 
otherwise going to clash and annoy someone?

iop13xx chooses a different name:
----
alex at berk:/usr/src/linux-2.6-stable$ grep '__setup(' -r arch/arm/ | grep uart
arch/arm/mach-iop13xx/setup.c:__setup("iop13xx_init_uart", iop13xx_init_uart_setup);
----

Cheers

-- 
Alexander Clouter
.sigmonster says: If you want to be ruined, marry a rich woman.
                  		-- Michelet
