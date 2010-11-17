From: alexis.rodet@bvs-tech.com (Alexis RODET)
Date: Wed, 17 Nov 2010 16:40:06 +0100
Subject: Devel error: redefinition of 'struct flash_platform_data'
Message-ID: <4CE3F756.6040700@bvs-tech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm making an arm machine with both mtd flash and m25p spi flash and try
to define partitions for both chips in my code.

But there are 2 definitions of 'struct flash_platform_data' and both
definition are incompatible:

in <asm/mach/flash.h>:
struct flash_platform_data {
    const char    *map_name;
    const char    *name;
    unsigned int    width;
    int        (*init)(void);
    void        (*exit)(void);
    void        (*set_vpp)(int on);
    void        (*mmcontrol)(struct mtd_info *mtd, int sync_read);
    struct mtd_partition *parts;
    unsigned int    nr_parts;
};

in <linux/spi/flash.h>:
struct flash_platform_data {
    char        *name;
    struct mtd_partition *parts;
    unsigned int    nr_parts;

    char        *type;

    /* we'll likely add more ... use JEDEC IDs, etc */
};

Both are included in a lot of machines or driver.

I don't know what to do.
Which one should I jeopardize or rename ?

Thank for your help,
Alexis RODET
-------------- next part --------------
A non-text attachment was scrubbed...
Name: alexis_rodet.vcf
Type: text/x-vcard
Size: 315 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101117/80bb9b43/attachment-0001.vcf>
