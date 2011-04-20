From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 20 Apr 2011 16:32:59 +0800
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <20110420083258.GB1517@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Mon, Apr 18, 2011 at 01:19:36PM +0800, Eric Miao wrote:
> If AUTO_ZRELADDR is selected and target is not uImage, the existence
> of Makefile.boot could be optional.
> 
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
>  arch/arm/boot/Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index 9128fdd..277368f 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -14,7 +14,7 @@
>  MKIMAGE         := $(srctree)/scripts/mkuboot.sh
>  
>  ifneq ($(MACHINE),)
> -include $(srctree)/$(MACHINE)/Makefile.boot
> +-include $(srctree)/$(MACHINE)/Makefile.boot
   ^ Makefile grammar?
>  endif
>  
I do not understand the patch.  But looking at the patch below, the
dtb rule uses Makefile.boot too.

[PATCH v2] arm/dt: Add a make rule to build dtb for enabled boards
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/047129.html

-- 
Regards,
Shawn
