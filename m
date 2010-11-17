From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Nov 2010 16:05:14 +0000
Subject: Devel error: redefinition of 'struct flash_platform_data'
In-Reply-To: <4CE3F756.6040700@bvs-tech.com>
References: <4CE3F756.6040700@bvs-tech.com>
Message-ID: <20101117160514.GA5308@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 04:40:06PM +0100, Alexis RODET wrote:
> Hello,
> 
> I'm making an arm machine with both mtd flash and m25p spi flash and try
> to define partitions for both chips in my code.
> 
> But there are 2 definitions of 'struct flash_platform_data' and both
> definition are incompatible:
> 
> in <asm/mach/flash.h>:
> struct flash_platform_data {
>     const char    *map_name;
>     const char    *name;
>     unsigned int    width;
>     int        (*init)(void);
>     void        (*exit)(void);
>     void        (*set_vpp)(int on);
>     void        (*mmcontrol)(struct mtd_info *mtd, int sync_read);
>     struct mtd_partition *parts;
>     unsigned int    nr_parts;
> };
> 
> in <linux/spi/flash.h>:
> struct flash_platform_data {
>     char        *name;
>     struct mtd_partition *parts;
>     unsigned int    nr_parts;
> 
>     char        *type;
> 
>     /* we'll likely add more ... use JEDEC IDs, etc */
> };
> 
> Both are included in a lot of machines or driver.
> 
> I don't know what to do.

Shoot the person who decided to duplicate the structure, rather than
renaming the header file.

I think this issue is one which keeps turning up, but no one ever does
anything about it... I think therefore it's a lost cause.  Maybe the
SPI folk just don't give a damn about it...  I've no idea.

It would, however, be nice if _someone_ out there could produce a patch
for it...
