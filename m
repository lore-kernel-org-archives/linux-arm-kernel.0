From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 16 Feb 2015 21:07:02 +0530
Subject: [PATCH 04/11] ARM: davinci: davinci_cfg_reg cannot be init
In-Reply-To: <1423770163-583064-5-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-5-git-send-email-arnd@arndb.de>
Message-ID: <54E20E9E.2050401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 February 2015 01:12 AM, Arnd Bergmann wrote:
> davinci_cfg_reg gets called from a lot of locations that
> might get called after the init section has been discarded,
> so the function itself must not be marked __init either.
> 
> The kernel build currently warns about this with lots of
> messages like:
> 
> WARNING: vmlinux.o(.text.unlikely+0x24c): Section mismatch in reference from the function dm365evm_mmc_configure() to the function .init.text:davinci_cfg_reg()
> The function dm365evm_mmc_configure() references
> the function __init davinci_cfg_reg().
> This is often because dm365evm_mmc_configure lacks a __init
> annotation or the annotation of davinci_cfg_reg is wrong.
> 
> This removes the extraneous __init_or_module annotation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
