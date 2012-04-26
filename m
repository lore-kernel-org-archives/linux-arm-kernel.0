From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 26 Apr 2012 23:51:16 +0530
Subject: [PATCH] ARM: davinci/da850-evm: fix section mismatch
In-Reply-To: <1333139360-6791-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1333139360-6791-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4F99921C.9030008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 3/31/2012 1:59 AM, Uwe Kleine-K?nig wrote:
> This fixes:
> 	WARNING: arch/arm/mach-davinci/built-in.o(.text+0x2d84): Section mismatch in reference from the function da850_evm_ui_expander_setup() to the (unknown reference) .init.data:(unknown)
> 	The function da850_evm_ui_expander_setup() references
> 	the (unknown reference) __initdata (unknown).
> 	This is often because da850_evm_ui_expander_setup lacks a __initdata
> 	annotation or the annotation of (unknown) is wrong.
> 
> Note this is a real issue because if the tca6416 driver only binds when
> the init sections are already discarded da850_evm_ui_expander_setup is
> called when da850_evm_devices might already be overwritten.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks for the patch. I am queuing this for v3.5 since the tca6416
driver is set to Y by default when DA850 EVM is selected. So I suspect
users will mostly remain unaffected by the bug.

Thanks,
Sekhar
