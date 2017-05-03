From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Wed, 3 May 2017 19:48:44 +0000
Subject: [PATCH] ARM: Fix rd_size declaration
In-Reply-To: <20170503194600.16089-1-bart.vanassche@sandisk.com>
References: <20170503194600.16089-1-bart.vanassche@sandisk.com>
Message-ID: <1493840922.3901.33.camel@sandisk.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-05-03 at 12:46 -0700, Bart Van Assche wrote:
> The global variable 'rd_size' is declared as 'int' in source file
> arch/arm/kernel/atags_parse.c and as 'unsigned long' in
> drivers/block/brd.c. Fix this inconsistency. Additionally, remove
> the declarations of rd_image_start, rd_prompt and rd_doload from
> parse_tag_ramdisk() since these duplicate existing declarations
> in <linux/initrd.h>.

This is version 2 of the patch for removing the rd_size declaration.
Compared to v1, the new header file <linux/brd.h> has been dropped.

Bart.
