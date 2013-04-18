From: horms@verge.net.au (Simon Horman)
Date: Thu, 18 Apr 2013 22:27:24 +0900
Subject: [PATCH 2/2] ARM: shmobile: BOCK-W: enable I2C in defconfig
In-Reply-To: <201304172247.28311.sergei.shtylyov@cogentembedded.com>
References: <201304172242.27671.sergei.shtylyov@cogentembedded.com>
 <201304172247.28311.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130418132724.GC20929@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 10:47:27PM +0400, Sergei Shtylyov wrote:
> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Enable I2C driver in 'bockw_defconfig'.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm/configs/bockw_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: renesas/arch/arm/configs/bockw_defconfig
> ===================================================================
> --- renesas.orig/arch/arm/configs/bockw_defconfig
> +++ renesas/arch/arm/configs/bockw_defconfig
> @@ -73,6 +73,8 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=6
>  CONFIG_SERIAL_SH_SCI_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
>  # CONFIG_HWMON is not set
> +CONFIG_I2C=y
> +CONFIG_I2C_RCAR=y
>  CONFIG_USB=y
>  CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_EHCI_HCD=y

I have applied the following after resolving conflicts
(I don't see CONFIG_USB=y in my tree). Please let me
know if I made an error.

I have queued-up the change for v3.11 in the defconfig-bockw branch
and will push is shortly.


commit 6a3fbcf1ced08f9f423944fefcbc372ec72fa4e7
Author: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Date:   Wed Apr 17 22:47:27 2013 +0400

    ARM: shmobile: BOCK-W: enable I2C in defconfig
    
    Enable I2C driver in 'bockw_defconfig'.
    
    Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
    Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    [ horms+renesas at verge.net.au: resolved trivial conflicts ]
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index b74a4d4..2c3f34e 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -71,6 +71,8 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=6
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
+CONFIG_I2C=y
+CONFIG_I2C_RCAR=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
