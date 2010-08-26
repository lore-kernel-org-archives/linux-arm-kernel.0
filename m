From: alex@digriz.org.uk (Alexander Clouter)
Date: Thu, 26 Aug 2010 09:25:28 +0100
Subject: [PATCH v7] OpenRD: Enable SD/UART selection for serial port 1
In-Reply-To: <1282801318-2291-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <1282801318-2291-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <20100826082528.GM9915@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tanmay Upadhyay <tanmay.upadhyay@einfochips.com> [2010-08-26 11:11:58+0530]:
>
> This patch enables users to choose either the SDIO interface or UART1
> (RS232/RS485). The selection can be done through kernel parameter.
> 
> By default the port would be used for SDIO interface. Passing the string
> "kw_openrd_init_uart1=232" or "kw_openrd_init_uart1=485" enables either
> the RS-232 or RS-485 port respectively; disabling the SDIO interface.
> Anything else selects the default SDIO interface.
> 
> "kw_openrd_init_uart1=485" is ignored on OpenRD-Base as it doesn't
> have RS485 port.
> 
> v2 - use gpio* functions instead of read/write to set/reset GPIO
> v3 - notify user when wrong kernel paramter is passed
> v4 - use linux/gpio.h instead of mach/gpio.h
> v5 - changed uart1_mpp_config to be static, global & __initdata
> v6 - changed kernel parameter to 'kw_openrd_init_uart1=...' from 'uart=...'
> v7 - remove compilation error due to same name used for variable & function
> 
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
>
Acked-by: Alexander Clouter <alex@digriz.org.uk>

Cheers

-- 
Alexander Clouter
.sigmonster says: Experience varies directly with equipment ruined.
