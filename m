From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 6 Nov 2011 11:38:02 -0700
Subject: [PATCH] distclean: Remove generated .dtb files
In-Reply-To: <1320473955-4500-1-git-send-email-dirk.behme@de.bosch.com>
References: <1320473955-4500-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20111106183802.GB2546@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 05, 2011 at 07:19:15AM +0100, Dirk Behme wrote:
> The patch 'arm/dt: Add dtb make rule' adds support to
> create a .dtb file. But this is never removed afterwards.
> Remove the generated .dtb file if 'distclean' is called.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> CC: Rob Herring <rob.herring@calxeda.com>
> CC: Shawn Guo <shawn.guo@freescale.com>
> CC: Jason Liu <jason.hui@linaro.org>
> CC: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/boot/Makefile |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index 1cd9b0a..08f0d35 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -71,6 +71,8 @@ $(obj)/%.dtb: $(src)/dts/%.dts
>  
>  $(obj)/dtbs: $(addprefix $(obj)/, $(dtb-y))
>  
> +clean-files := *.dtb
> +
>  quiet_cmd_uimage = UIMAGE  $@
>        cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A arm -O linux -T kernel \
>  		   -C none -a $(LOADADDR) -e $(STARTADDR) \
> -- 
> 1.7.0.4
> 
