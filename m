From: csd@broadcom.com (Christian Daudt)
Date: Mon, 19 Aug 2013 15:38:51 -0700
Subject: [PATCH] ARM: bcm: Rename board_bcm
In-Reply-To: <1375989863-17144-1-git-send-email-csd@broadcom.com>
References: <1375989863-17144-1-git-send-email-csd@broadcom.com>
Message-ID: <52129E7B.9060708@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-08 12:24 PM, Christian Daudt wrote:
> In order to support multiple SoC models in the mach-bcm
> directory, board_bcm.c is being renamed board_bcm281xx.c
>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Signed-off-by: Christian Daudt <csd@broadcom.com>
>
> diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
> index 6adb6aec..873817e 100644
> --- a/arch/arm/mach-bcm/Makefile
> +++ b/arch/arm/mach-bcm/Makefile
> @@ -10,6 +10,6 @@
>   # of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   # GNU General Public License for more details.
>   
> -obj-$(CONFIG_ARCH_BCM)		:= board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o
> +obj-$(CONFIG_ARCH_BCM)		:= board_bcm281xx.o bcm_kona_smc.o bcm_kona_smc_asm.o
>   plus_sec := $(call as-instr,.arch_extension sec,+sec)
>   AFLAGS_bcm_kona_smc_asm.o	:=-Wa,-march=armv7-a$(plus_sec)
> diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm281xx.c
> similarity index 100%
> rename from arch/arm/mach-bcm/board_bcm.c
> rename to arch/arm/mach-bcm/board_bcm281xx.c
Applied to bcm/for-3.12/soc

  thanks,
    csd
