From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Dec 2015 16:06:52 +0100
Subject: [RFC PATCH] ARM: pxa: add defconfig covering all the boards
In-Reply-To: <1450630483-28037-1-git-send-email-robert.jarzmik@free.fr>
References: <1450630483-28037-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <22731126.qdCRlGzc5c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 20 December 2015 17:54:43 Robert Jarzmik wrote:
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
>         pxa168_defconfig
>         pxa255-idp_defconfig
>         pxa3xx_defconfig
>         pxa910_defconfig
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

Sorry for the late reply. I think this is great and I'd like to just apply it.
Can you re-send to arm at kernel.org if you're happy with that?

Looking at your description above, I see that you included pxa168_defconfig
and pxa910_defconfig as well, but they are mach-mmp rather than mach-pxa.
Can you check if that has added in anything we don't want?

	Arnd
