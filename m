From: greg@kroah.com (Greg KH)
Date: Fri, 21 Jan 2011 11:15:07 -0800
Subject: [stable] [PATCH] ARM: SMDK6410: Fix build with WM1190 disabled
	and WM1192 enabled
In-Reply-To: <1295630829-13812-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1295630829-13812-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20110121191507.GA16210@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 05:27:09PM +0000, Mark Brown wrote:
> Avoid relying on implicit inclusion of machine.h
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: stable at kernel.org
> ---
>  arch/arm/mach-s3c64xx/mach-smdk6410.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> index c8a84be..e7b40ba 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -28,6 +28,7 @@
>  #include <linux/delay.h>
>  #include <linux/smsc911x.h>
>  #include <linux/regulator/fixed.h>
> +#include <linux/regulator/machine.h>

Why is this a -stable patch?  Is the build broken somehow right now in a
released kernel without this patch?

confused,

greg k-h
