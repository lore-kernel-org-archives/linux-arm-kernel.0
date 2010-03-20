From: vapier.adi@gmail.com (Mike Frysinger)
Date: Sat, 20 Mar 2010 16:46:03 -0400
Subject: [PATCH] uImage: Allow to specify MKIMAGE
In-Reply-To: <20100320184907.8036.82488.stgit@localhost.localdomain>
References: <20100320184907.8036.82488.stgit@localhost.localdomain>
Message-ID: <8bd0f97a1003201346xc927340r39f33b9a6b599792@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 20, 2010 at 14:49, Paulius Zaleckas wrote:
> --- a/arch/blackfin/boot/Makefile
> +++ b/arch/blackfin/boot/Makefile
> @@ -6,7 +6,7 @@
> ?# for more details.
> ?#
>
> -MKIMAGE := $(srctree)/scripts/mkuboot.sh
> +MKIMAGE := $(CONFIG_SHELL) $(srctree)/scripts/mkuboot.sh
>
> ?targets := vmImage vmImage.bin vmImage.bz2 vmImage.gz vmImage.lzma vmImage.xip
> ?extra-y += vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma vmlinux.bin.xip
> @@ -16,7 +16,7 @@ UIMAGE_OPTS-$(CONFIG_RAMKERNEL) += -a $(CONFIG_BOOT_LOAD)
> ?UIMAGE_OPTS-$(CONFIG_ROMKERNEL) += -a $(CONFIG_ROM_BASE) -x
>
> ?quiet_cmd_uimage = UIMAGE ?$@
> - ? ? ?cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A $(ARCH) -O linux -T kernel \
> + ? ? ?cmd_uimage = $(MKIMAGE) -A $(ARCH) -O linux -T kernel \
> ? ? ? ? ? ? ? ? ? ?-C $(2) -n '$(MACHINE)-$(KERNELRELEASE)' \
> ? ? ? ? ? ? ? ? ? ?-e $(shell $(NM) vmlinux | awk '$$NF == "__start" {print $$1}') \
> ? ? ? ? ? ? ? ? ? ?$(UIMAGE_OPTS-y) -d $< $@

looks straightforward, and doesnt matter to me, so
Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
