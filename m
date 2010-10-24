From: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 25 Oct 2010 00:28:20 +0100
Subject: [PATCH 1/2] MTD: generic FSMC NAND MTD driver
In-Reply-To: <1284330922-3569-1-git-send-email-linus.walleij@stericsson.com>
References: <1284330922-3569-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1287962900.5674.21.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-09-13 at 00:35 +0200, Linus Walleij wrote:
> 
> +#define PARTITION(n, off, sz)  {.name = n, .offset = off, .size = sz}
> +
> +/*
> + * Default partition layout for small page(= 512 bytes) devices
> + * Size for "Root file system" is updated in driver based on actual device size
> + */
> +static struct mtd_partition partition_info_16KB_blk[] = {
> +       PARTITION("X-loader", 0, 4 * 0x4000),
> +       PARTITION("U-Boot", 0x10000, 20 * 0x4000),
> +       PARTITION("Kernel", 0x60000, 256 * 0x4000),
> +       PARTITION("Root File System", 0x460000, 0),
> +}; 

Er, you use a macro just so that you can use order-dependent non-C99
structure initialisation? You realise that this would do the same thing:
 #define PARTITION(a,b,c) {a,c,b}

And no, I don't think *that* would be a good idea either :)

Please fix.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
