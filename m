From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 22:35:00 +0000
Subject: [GIT PULL] Ux500 pin changes
In-Reply-To: <CACRpkdYjEmQRU530N3sP7t_RfM_NLhEcMf6YCBdf4LC7M7fQDQ@mail.gmail.com>
References: <CACRpkdYjEmQRU530N3sP7t_RfM_NLhEcMf6YCBdf4LC7M7fQDQ@mail.gmail.com>
Message-ID: <201211122235.00973.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 November 2012, Linus Walleij wrote:
-----------------------------------------------------
> Jean-Nicolas Graux (1):
>       ARM: ux500: add STM pin configuration
> 
> Jorgen Jonsson (1):
>       ARM: ux500: fixup magnetometer pins
> 
> Linus Walleij (1):
>       ARM: ux500: delete duplicate macro
> 
> Patrice Chotard (6):
>       ARM: ux500: 8500: register LCD VSI pinctrl table
>       ARM: ux500: 8500: add IDLE pin configuration for SPI
>       ARM: ux500: 8500: update SKE keypad pinctrl table
>       ARM: ux500: 8500: define SDI sleep states
>       ARM: ux500: cosmetic fixups for uart0
>       ARM: ux500: 8500: add pinctrl support for uart1 and uart2
> 
>  arch/arm/mach-ux500/board-mop500-pins.c | 427 +++++++++++++++++++++++++++-----
>  1 file changed, 362 insertions(+), 65 deletions(-)
> 

u8500_defconfig now gives me two new errors in arm-soc/for-next when building with
-Werror:

arch/arm/mach-ux500/board-mop500-pins.c:73:22: error: 'out_hi_wkup_pdis' defined but not used [-Werror=unused-variable]

and the existing:

ERROR (phandle_references): Reference to non-existent node or label "tc3589x_gpio"

Can you provide patches to fix these up?

	arnd
