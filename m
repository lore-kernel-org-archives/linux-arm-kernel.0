From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 30 Jan 2013 11:59:49 +0530
Subject: [PATCH] ARM: dts: remove generated .dtb files on clean
In-Reply-To: <1358890049-26981-1-git-send-email-nm@ti.com>
References: <1358890049-26981-1-git-send-email-nm@ti.com>
Message-ID: <5108BDDD.60307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looping RMK, Arnd

On Wednesday 23 January 2013 02:57 AM, Nishanth Menon wrote:
> commit 5f300acd8ae9f3d4585154370012ffc5c665330f
> (ARM: 7152/1: distclean: Remove generated .dtb files)
> ensured that dtbs were cleaned up when they were in
> arch/arm/boot.
> However, with the following commit:
> commit 499cd8298628eeabf0eb5eb6525d4faa0eec80d8
> (ARM: dt: change .dtb build rules to build in dts directory)
>
> make clean now leaves dtbs in arch/arm/boot/dts/
> untouched. Include dts directory so that clean-files rule
> from arch/arm/boot/dts/Makefile is invoked when make
> clean is done.
>
> Cc: Dirk Behme <dirk.behme@de.bosch.com>
> CC: Grant Likely <grant.likely@secretlab.ca>
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm/boot/Makefile |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> index abfce28..3837f97 100644
> --- a/arch/arm/boot/Makefile
> +++ b/arch/arm/boot/Makefile
> @@ -115,4 +115,4 @@ i:
>   	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
>   	$(obj)/Image System.map "$(INSTALL_PATH)"
>
> -subdir-	    := bootp compressed
> +subdir-	    := bootp compressed dts
>
Seems to be the valid fix for me.

Regards,
Santosh
