From: vapier.adi@gmail.com (Mike Frysinger)
Date: Tue, 24 May 2011 00:43:21 -0400
Subject: [PATCH v5 1/8] MTD: Add integrator-flash feature to physmap
In-Reply-To: <1305557977-16871-2-git-send-email-marc.zyngier@arm.com>
References: <1305557977-16871-1-git-send-email-marc.zyngier@arm.com>
	<1305557977-16871-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <BANLkTi=sd-Xhm8yXXbHk_VfMWwdaez_LhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 10:59, Marc Zyngier wrote:
> --- a/include/linux/mtd/physmap.h
> +++ b/include/linux/mtd/physmap.h
> @@ -22,6 +22,8 @@ struct map_info;
>
> ?struct physmap_flash_data {
> ? ? ? ?unsigned int ? ? ? ? ? ?width;
> + ? ? ? int ? ? ? ? ? ? ? ? ? ? (*init)(struct platform_device *);
> + ? ? ? void ? ? ? ? ? ? ? ? ? ?(*exit)(struct platform_device *);
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*set_vpp)(struct map_info *, int);
> ? ? ? ?unsigned int ? ? ? ? ? ?nr_parts;
> ? ? ? ?unsigned int ? ? ? ? ? ?pfow_base;

you use the platform_device structure but never include any header for
it.  please add "struct platform_device;" to the top of this file
after the #includes.

include/linux/mtd/physmap.h:25: warning: ?struct platform_device?
declared inside parameter list
include/linux/mtd/physmap.h:25: warning: its scope is only this
definition or declaration, which is probably not what you want
include/linux/mtd/physmap.h:26: warning: ?struct platform_device?
declared inside parameter list
include/linux/mtd/physmap.h:27: warning: ?struct platform_device?
declared inside parameter list
-mike
