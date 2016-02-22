From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 22 Feb 2016 23:38:56 +0100
Subject: [PATCH 9/9] ARM: mmp: mark usb_dma_mask as __maybe_unused
In-Reply-To: <1454076396-3563101-10-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Fri, 29 Jan 2016 15:06:33 +0100")
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
 <1454076396-3563101-10-git-send-email-arnd@arndb.de>
Message-ID: <87bn78wetb.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> This variable may be used by some devices that each have their
> on Kconfig symbol, or by none of them, and that causes a build
> warning:
>
> arch/arm/mach-mmp/devices.c:241:12: error: 'usb_dma_mask' defined but not used [-Werror=unused-variable]
>
> Marking it __maybe_unused avoids the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-mmp/devices.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Haojian,

I still didn't get an ack on this one, do you want to carry it through your
tree, or let Arnd carry it or let me carry it ?

Cheers.

--
Robert

[1] The patch
> diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
> index 3330ac7cfbef..671c7a09ab3d 100644
> --- a/arch/arm/mach-mmp/devices.c
> +++ b/arch/arm/mach-mmp/devices.c
> @@ -238,7 +238,7 @@ void pxa_usb_phy_deinit(void __iomem *phy_reg)
>  #endif
>  
>  #if IS_ENABLED(CONFIG_USB_SUPPORT)
> -static u64 usb_dma_mask = ~(u32)0;
> +static u64 __maybe_unused usb_dma_mask = ~(u32)0;
>  
>  #if IS_ENABLED(CONFIG_USB_MV_UDC)
>  struct resource pxa168_u2o_resources[] = {

-- 
Robert
