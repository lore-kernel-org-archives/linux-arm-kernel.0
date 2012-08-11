From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 11 Aug 2012 08:21:11 +0200
Subject: [PATCH 3/3] ARM: Kirkwood: add DT boards to defconfig
In-Reply-To: <a0e20df2d8ad6dbcf66fa9a14482a305c4a109fe.1344651264.git.jason@lakedaemon.net>
References: <cover.1344651264.git.jason@lakedaemon.net>
 <a0e20df2d8ad6dbcf66fa9a14482a305c4a109fe.1344651264.git.jason@lakedaemon.net>
Message-ID: <20120811062111.GA30947@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 02:39:47AM +0000, Jason Cooper wrote:
> Also, disable DEBUG_KERNEL, enable SERIAL_OF_PLATFORM, and enable EMBEDDED

Hi Jason

Why disable DEBUG_KERNEL. Most of the other defconfig files have it
enabled.



> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> ---
>  arch/arm/configs/kirkwood_defconfig |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
> index 5a494a3..0865d2e 100644
> --- a/arch/arm/configs/kirkwood_defconfig
> +++ b/arch/arm/configs/kirkwood_defconfig
> @@ -3,6 +3,9 @@ CONFIG_SYSVIPC=y
>  CONFIG_NO_HZ=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_LOG_BUF_SHIFT=19
> +CONFIG_NAMESPACES=y
> +CONFIG_BLK_DEV_INITRD=y

Do we need these two as well? Namespaces seems a bit unusual for a
tiny embedded device.

     Andrew
