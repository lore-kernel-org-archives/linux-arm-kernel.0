From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 23 May 2011 22:08:20 +0530
Subject: [PATCH v18 07/13] davinci: move DM64XX_VDD3P3V_PWDN to devices.c
In-Reply-To: <1301737380-4288-1-git-send-email-manjunath.hadli@ti.com>
References: <1301737380-4288-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D09B416@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 02, 2011 at 15:13:00, Hadli, Manjunath wrote:
> Move the definition of DM64XX_VDD3P3V_PWDN from hardware.h
> to devices.c since it is used only there.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Applying this after updating the patch description to
point out that this also helps rid hardware.h of platform
private stuff..

> ---
>  arch/arm/mach-davinci/devices.c               |    1 +
>  arch/arm/mach-davinci/include/mach/hardware.h |    3 ---
>  2 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
> index 22ebc64..4e1b663 100644
> --- a/arch/arm/mach-davinci/devices.c
> +++ b/arch/arm/mach-davinci/devices.c
> @@ -182,6 +182,7 @@ static struct platform_device davinci_mmcsd1_device = {
>  	.resource = mmcsd1_resources,
>  };
>  
> +#define DM64XX_VDD3P3V_PWDN	0x48

.. and moving this to the top of the file.

Thanks,
Sekhar
