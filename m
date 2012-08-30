From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 30 Aug 2012 15:47:06 -0400
Subject: [PATCH] ARM: Make sure dtc is built before running it
In-Reply-To: <1346180398-8079-1-git-send-email-davidb@codeaurora.org>
References: <1346180398-8079-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20120830194706.GB19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 11:59:58AM -0700, David Brown wrote:
> 'make dtbs' in a clean tree will try running the dtc before actually
> building it.  Make these rules depend upon the scripts to build it.

David,

Could you please send this into rmk's queue? [1]  This fix has been
cropping up by various submitters for the past 6 months or so, it would
be nice to finally get it in.

thx,

Jason.

[1] http://www.arm.linux.org.uk/developer/patches/

> ---
>  arch/arm/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 0298b00..926d840 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -279,10 +279,10 @@ zImage Image xipImage bootpImage uImage: vmlinux
>  zinstall uinstall install: vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
>  
> -%.dtb:
> +%.dtb: scripts
>  	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
>  
> -dtbs:
> +dtbs: scripts
>  	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
>  
>  # We use MRPROPER_FILES and CLEAN_FILES now
> -- 
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
