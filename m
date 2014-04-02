From: monstr@monstr.eu (Michal Simek)
Date: Wed, 02 Apr 2014 11:30:10 +0200
Subject: [PATCH 06/75] ARM: outer cache: add documentation of outer cache
 functions
In-Reply-To: <E1WTYUc-0004WH-16@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYUc-0004WH-16@rmk-PC.arm.linux.org.uk>
Message-ID: <533BD8A2.5070808@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2014 04:14 PM, Russell King wrote:
> Add some documentation to cover the outer cache functions so that their
> requirements can be better understood.  Of particular note are the
> flush_all() and disable() methods which must not be called except in
> very specific circumstances.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/outercache.h | 48 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
> index 0e4420858990..bd80540fe8b9 100644
> --- a/arch/arm/include/asm/outercache.h
> +++ b/arch/arm/include/asm/outercache.h
> @@ -39,35 +39,75 @@ struct outer_cache_fns {
>  extern struct outer_cache_fns outer_cache;
>  
>  #ifdef CONFIG_OUTER_CACHE
> -
> +/**
> + * outer_inv_range: invalidate range of outer cache lines

This is not proper kernel-doc format.

It should be like this:
 /**
- * outer_inv_range: invalidate range of outer cache lines
+ * outer_inv_range - invalidate range of outer cache lines

The same change should be done below too.

[linux]$ ./scripts/kernel-doc -man -v arch/arm/include/asm/outercache.h >/dev/null
Warning(arch/arm/include/asm/outercache.h:43): missing initial short description on line:
 * outer_inv_range: invalidate range of outer cache lines
Info(arch/arm/include/asm/outercache.h:43): Scanning doc for outer_inv_range
Warning(arch/arm/include/asm/outercache.h:54): missing initial short description on line:
 * outer_clean_range: clean dirty outer cache lines
Info(arch/arm/include/asm/outercache.h:54): Scanning doc for outer_clean_range
Warning(arch/arm/include/asm/outercache.h:65): missing initial short description on line:
 * outer_flush_range: clean and invalidate outer cache lines
Info(arch/arm/include/asm/outercache.h:65): Scanning doc for outer_flush_range
Warning(arch/arm/include/asm/outercache.h:76): missing initial short description on line:
 * outer_flush_all: clean and invalidate all cache lines in the outer cache
Info(arch/arm/include/asm/outercache.h:76): Scanning doc for outer_flush_all
Warning(arch/arm/include/asm/outercache.h:93): missing initial short description on line:
 * outer_disable: clean, invalidate and disable the outer cache
Info(arch/arm/include/asm/outercache.h:93): Scanning doc for outer_disable
Info(arch/arm/include/asm/outercache.h:106): Scanning doc for restore the cache configuration and re
Warning(arch/arm/include/asm/outercache.h:133): missing initial short description on line:
 * outer_sync: perform a sync point for outer cache
Info(arch/arm/include/asm/outercache.h:133): Scanning doc for outer_sync

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140402/fd84ac0b/attachment.sig>
