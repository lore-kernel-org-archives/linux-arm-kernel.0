From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 11:46:18 +0100
Subject: [PATCH] ARM: pxa: add defconfig covering all the boards
In-Reply-To: <1451764857-18248-1-git-send-email-robert.jarzmik@free.fr>
References: <1451764857-18248-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <5674174.3M49lNincT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 January 2016 21:00:57 Robert Jarzmik wrote:
> Add a defconfig covering all known pxa board, ie. all selectable machine
> files in arch/arm/mach-pxa/*.c.
> 
> This defconfig was built by doing :
>  - aggregation of all known defconfigs by cat
>         am200epdkit_defconfig
>         cm_x2xx_defconfig
>         cm_x300_defconfig
>         colibri_pxa270_defconfig
>         colibri_pxa300_defconfig
>         corgi_defconfig
>         em_x270_defconfig
>         eseries_pxa_defconfig
>         ezx_defconfig
>         h5000_defconfig
>         imote2_defconfig
>         lpd270_defconfig
>         lubbock_defconfig
>         magician_defconfig
>         mainstone_defconfig
>         multi_v7_defconfig
>         palmz72_defconfig
>         pcm027_defconfig
>         pxa255-idp_defconfig
>         pxa3xx_defconfig
>         raumfeld_defconfig
>         spitz_defconfig
>         trizeps4_defconfig
>         viper_defconfig
>         xcep_defconfig
>         zeus_defconfig
>  - manual make menuconfig to ensure :
>    - all pxa implementation were selected
>    - all drivers were transformed into modules rather than builtin
>      => as a consequence this single kernel will rely on an initramfs
>      => as kernel size matters on pxa, each machine can take the subset
>         of modules required for it to work
>    - all missed configurations are selected verified by :
>      => grep -i pxa .config | grep "is not set"
>      => this should only show the left on purpose options (either not
>         selectable or sharpsl exception below)
>  - CONFIG_PXA_SHARPSL was disabled
>    This breaks the boot very early on any non Sharp platform, see
>    head-sharpsl.S
> 
> This defconfig was tested as booting up to the login phase on :
>  - lubbock (pxa25x)
>  - mainstone (pxa27x)
>  - zylonite (pxa3xx)
> 
> The completion of this work will require to :
>  - parse manually all the arch/arm/mach-pxa/*c files, look for all
>    platform devices added, and verify they are all in pxa_defconfig
>  - do the same to ensure all pxa specific drivers (leds, gpio, ...) are
>    included
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 

Merged into next/defconfig, thanks!

	Arnd
