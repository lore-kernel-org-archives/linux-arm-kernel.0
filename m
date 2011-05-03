From: simon@sequanux.org (Simon Guinot)
Date: Tue, 3 May 2011 21:14:35 +0000
Subject: [PATCH] kirkwood: add dir-665 support
In-Reply-To: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
Message-ID: <20110503211435.GW19806@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hirundo,

On Thu, Apr 28, 2011 at 12:34:46AM +0800, Hirundo Cam wrote:
> This patch is a hack to dir-665 by referencing mv88f6281gtw_ge board.
> LEDs, GPIO, Buttons remains unknown.

You could use the GPIO sysfs API to discover the LEDs and buttons GPIOs.

> 
> To use this patch, u-boot must also be modified.

What kind of modifications ?

> 
> Signed-off-by: Hirundo Cam <camhirundo@gmail.com>
> ---
>  arch/arm/mach-kirkwood/Kconfig            |    6 ++
>  arch/arm/mach-kirkwood/Makefile           |    1 +
>  arch/arm/mach-kirkwood/mv88f6281_dir665.c |  107 +++++++++++++++++++++++++++++
>  arch/arm/tools/mach-types                 |    1 +
>  4 files changed, 115 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-kirkwood/mv88f6281_dir665.c
> 
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 7fc603b..296d97f 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -26,6 +26,12 @@ config MACH_MV88F6281GTW_GE
>  	  Say 'Y' here if you want your kernel to support the
>  	  Marvell 88F6281 GTW GE Board.
>  
> +config MACH_MV88F6281_DIR665
> +	bool "Marvell 88F6281 DIR665 Board"
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  88F6281 DIR665 Board.
> +

Probably than 'MV88F6281' should not be a part of the D-Link DIR665
machine name.

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110503/71ffc192/attachment.sig>
