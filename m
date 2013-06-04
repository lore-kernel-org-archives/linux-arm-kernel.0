From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Jun 2013 17:55:31 +0200
Subject: [PATCH 1/2] ARM: ux500: Silence compiler warnings due to missing
 ux500_read_asicid() __init
In-Reply-To: <1370360208-6500-1-git-send-email-lee.jones@linaro.org>
References: <1370360208-6500-1-git-send-email-lee.jones@linaro.org>
Message-ID: <2771350.uHLSSD79no@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013 16:36:47 Lee Jones wrote:
> WARNING: vmlinux.o(.text.unlikely+0x1e8): Section mismatch in reference from\
>  the function ux500_read_asicid() to the function .init.text:iotable_init()
> The function ux500_read_asicid() references
> the function __init iotable_init().
> This is often because ux500_read_asicid lacks a __init
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

This is also part of my other patch to ux500_read_asicid that
Linus just applied, but we could take yours for 3.10 if he thinks
it's important.

	Arnd
